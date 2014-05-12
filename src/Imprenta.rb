# encoding: utf-8
#
#  Imprenta.rb
#
#  Copyright 2014 Guillermo Valdés Lozano <guivaloz@movimientolibre.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#
#

##
# Imprenta
#
# Defina estas propiedades:
#
# * publicaciones_directorios  Arreglo con los nombres de los directorios donde están las publicaciones.
# * publicaciones_etiquetas    Hash con las etiquetas a usar para cada directorio
# * autor_por_defecto          Autor por defecto a aplicar a las publicaciones que no lo tengan.
# * plantilla                  Instancia de Plantilla

class Imprenta

    ##
    # Inicializar

    def initialize
        # Estas propiedades deben/pueden definirse en CMS.rb
        @publicaciones_directorios       = Array.new
        @publicaciones_etiquetas         = Hash.new
        @autor_por_defecto               = 'Autor'
        @publicaciones_por_pagina_maximo = 10
        # Estas propiedades definen los directorios
        @autores_directorio    = 'autores'
        @categorias_directorio = 'categorias'
        @menus_directorio      = 'menus'
        # Estas propiedades son de uso interno
        @cantidad      = 0
        @publicaciones = Array.new
        @autores       = Hash.new
        @categorias    = Hash.new
    end

    protected

    ##
    # Sustiuir caracteres
    #
    # Cada categoría tendrá su página, el problema es cuando haya acentos en la misma.
    # Por ejemplo "Política" deberá tener una página "politica.html"
    # Esta función es para sustitituir las vocales acentuadas, la eñe,
    # la diéresis por su caracter no acentuado y los espacios por guiones bajos
    # Rubí puede trabajar con caracteres unicode, los caracteres especiales son multibyte.
    # Previamente obtuve los códigos hexadecimal de lo que se quiere sustituir.
    # En la consola, por medio de irb se probaron estos comandos:
    #    "pájaro".gsub(/\xC3\xA1/, 'a')       => "pajaro"
    #    "pétalo".gsub(/\xC3\xA9/, 'e')       => "petalo"
    # "categoría".gsub(/\xC3\xAD/, 'i')       => "categoria"
    #    "zócalo".gsub(/\xC3\xB3/, 'o')       => "zocalo"
    #   "púlpito".gsub(/\xC3\xBA/, 'u')       => "pulpito"
    #  "pingüino".gsub(/\xC3\xBC/, "u")       => "pinguino"
    #      "niño".gsub(/\xC3\xB1/, 'n')       => "nino"
    # "GNU/Linux".gsub(/\x2F/, '_')           => "GNU_Linux"
    # "GNU/Linux es lo mejor".gsub(/\s/, '_') => "GNU/Linux_es_lo_mejor"
    # Por último se cambia el texto a minúsculas.
    # Esperemos que no se le den mayúsculas acentuadas :)

    def sustituir_caracteres(texto)
        t = texto.dup
        t.gsub!(/\xC3\xA1/, 'a')  # á
        t.gsub!(/\xC3\xA9/, 'e')  # é
        t.gsub!(/\xC3\xAD/, 'i')  # í
        t.gsub!(/\xC3\xB3/, 'o')  # ó
        t.gsub!(/\xC3\xBA/, 'u')  # ú
        t.gsub!(/\xC3\xBC/, 'u')  # ü
        t.gsub!(/\xC3\xB1/, 'n')  # ñ
        t.gsub!(/\x2F/, '_')      # /
        t.gsub!(/\s/, '_')        # espacio
        t.downcase
    end

    ##
    # Cargar publicaciones guardadas como archivos ruby *.rb

    def cargar_publicaciones_rb
        # En este arreglo acumularemos las publicaciones de archivos ruby
        pubs = Array.new
        # Bucle para cada directorio
        @publicaciones_directorios.each do |directorio|
            next if FileTest.directory?(directorio) == false  # Si no existe el directorio se salta
            archivos = Dir.glob(directorio + '/*.rb')         # Obtener los archivos *.rb en el directorio
            next if archivos.size == 0                 # Si no hay archivos, brincarse al siguiente directorio
            # Bucle para cada archivo
            archivos.sort.each do |ruta|
                load ruta
                pubs.push(publicacion(directorio))
                @cantidad += 1
            end
        end
        # Asignar el tipo 'rb' y el autor por defecto en las publicaciones que no lo tengan
        pubs.each do |pub|
            pub.tipo  = 'rb'
            pub.autor = @autor_por_defecto if pub.autor.nil?
            # Buscar las lineas que empiecen con un espacio
            nuevo   = String.new
            bandera = false
            pub.contenido.each_line do |linea|
                if bandera == false and linea[0] == " "
                    nuevo  += "<pre><code>\n"
                    bandera = true
                end
                if bandera == true and linea.chomp != "" and linea[0] != " "
                    nuevo  += "</code></pre>"
                    bandera = false
                end
                nuevo += linea
            end
            pub.contenido = nuevo
        end
        # Acumular en la propiedad
        @publicaciones.concat(pubs)
    end

    ##
    # Cargar publicaciones guardadas como archivos markdown *.md

    def cargar_publicaciones_md
        # En este arreglo acumularemos las publicaciones de archivos markdown
        pubs = Array.new
        # Bucle para cada directorio
        @publicaciones_directorios.each do |directorio|
            next if FileTest.directory?(directorio) == false  # Si no existe el directorio se salta
            archivos = Dir.glob(directorio + '/*.md')         # Obtener los archivos *.md en el directorio
            next if archivos.size == 0                        # Si no hay archivos, brincarse al siguiente directorio
            # Bucle para cada archivo
            archivos.sort.each do |ruta|
                pub             = Publicacion.new             # Nueva publicación
                pub.tipo        = 'md'                        # Tipo de contenido: md = markdown
                pub.directorio  = directorio                  # Pasamos el directorio en el que vamos
                pub.archivo     = ruta[/([\w._-]+)\.md/,1]    # Viene como "directorio/nombre.md" nos quedamos sólo con el nombre
                renglon         = 0                           # Para saber en qué renglón andamos
                contenido       = Array.new                   # No se puede acumular en una propiedad, así que juntaremos el contenido en esta variable local
                javascript      = Array.new                   # Del mismo modo, si hay javascript lo separamos
                javascript_on   = false                       # Bandera
                # Bucle para abrir, leer linea por linea y cerrar
                IO.foreach(ruta) do |linea|
                    renglon += 1
                    if renglon == 1
                        pub.nombre      = linea.chomp  # Se espera que el primer renglón sea el título de la publicación
                        pub.nombre_menu = linea.chomp  # Por defecto igual al nombre
                    elsif renglon == 2 and linea =~ /[=]+/
                        next                           # Se espera que el segundo renglón sea el subrayado del título
                    elsif javascript_on == false and linea =~ /<script/
                        javascript_on  = true
                        javascript.push(linea.chomp)
                    elsif javascript_on == true and linea =~ /<\/script>/
                        javascript.push(linea.chomp)
                        javascript_on  = false
                    elsif javascript_on == true
                        javascript.push(linea.chomp)
                    elsif linea.chomp  =~ /^Corto: /
                        pub.nombre_menu  = $'          # Sobreescribe al nombre si está definido Corto
                    elsif linea.chomp  =~ /^Autor: /
                        pub.autor = $'
                    elsif linea.chomp  =~ /^Fecha: /
                        pub.fecha = $'
                    elsif linea.chomp  =~ /^Categorías: /
                        pub.categorias   = $'.split(/, /)
                    else
                        contenido.push(linea.chomp)
                    end
                end
                pub.contenido  = contenido.join("\n")                  # Pasamos el contenido
                pub.javascript = javascript.join("\n")                 # Pasamos el javascript
                pub.autor      = @autor_por_defecto if pub.autor.nil?  # Si no hay autor en el archivo markdown, le asignamos el autor por defecto
                pubs.push(pub)                                         # Acumular la publicación
                @cantidad += 1                                         # Incrementar la cantidad de las mismas
            end
        end
        # Almacenar en @publicaciones
        @publicaciones.concat(pubs)
    end

    ##
    # Crear un archivo

    def crear_archivo(archivo, contenido)
        File.delete(archivo) if File.file?(archivo)
        f = File.new(archivo, "w")
        f.puts contenido
        f.close
        "  Listo #{archivo}"
    end

    public

    ##
    # Alimentarse

    def alimentarse
        # Cargar las publicaciones
        self.cargar_publicaciones_rb
        self.cargar_publicaciones_md
        # Ordenar las publicaciones por fecha, los más recientes primero
        ordenadas      = @publicaciones.sort_by { |pub| pub.fecha }
        @publicaciones = ordenadas.reverse
        # Entregar mensaje para la terminal
        salida = Array.new
        salida.push("  Hay #@cantidad publicaciones...")
        @publicaciones.each { |pub| salida.push("    #{pub.sencillo}") }
        salida.join("\n")
    end

    ##
    # Clasificar autores

    def clasificar_autores
        # Si no existe el directorio, intentará crearlo
        if not FileTest.exist?(@autores_directorio)
            begin
                Dir.mkdir(@autores_directorio)
            rescue SystemCallError
                puts "ERROR: No se pudo crear el directorio #@autores_directorio"
                raise
            end
        end
        # Este hash tendrá las multipáginas de cada autor, lo usará paginas_autores
        @autores = Hash.new
        # Se entregará un menú secundario con conteo
        @menu_autores = MenuSecundarioContando.new
        @menu_autores.encabezado("Autores")
        # Bucle para cada publicación
        @publicaciones.each do |pub|
            next if pub.autor.nil?
            # Determinar el URL a la página del autor
            url = @autores_directorio + '/' + sustituir_caracteres(pub.autor) + '.html'
            # Acumular en el menú
            @menu_autores.agregar(pub.autor, url)
            # Si es la primera aparición del autor se inicializa la instancia
            if @autores[pub.autor].nil?
                multipagina                                 = Multipagina.new
                multipagina.titulo                          = "Autor #{pub.autor}"
                multipagina.publicaciones_por_pagina_maximo = @publicaciones_por_pagina_maximo
                multipagina.directorio                      = @autores_directorio
                multipagina.nombre                          = sustituir_caracteres(pub.autor)
                @autores[pub.autor]                         = multipagina
            end
            # Acumular en el hash autores
            @autores[pub.autor].agregar(pub)
        end
        # Entregar mensaje para la terminal
        salida = Array.new
        salida.push("  Hay estos autores...")
        @autores.each { |nombre, multipagina| salida.push("    #{nombre}") }
        salida.join("\n")
    end

    ##
    # Clasificar categorías

    def clasificar_categorias
        # Si no existe el directorio, intentará crearlo
        if not FileTest.exist?(@categorias_directorio)
            begin
                Dir.mkdir(@categorias_directorio)
            rescue SystemCallError
                puts "ERROR: No se pudo crear el directorio #@categorias_directorio"
                raise
            end
        end
        # Este hash tendrá las multipáginas de cada categoría, lo usará paginas_categorias
        @categorias = Hash.new
        # Se entregará un menú secundario con conteo
        @menu_categorias = MenuSecundarioContando.new
        @menu_categorias.encabezado("Categorías")
        # Bucle para cada publicación
        @publicaciones.each do |pub|
            next if pub.categorias.nil?
            # Bucle para cada categoría de la publicación
            pub.categorias.each do |nombre|
                # Determinar el URL a la página de la categoría
                url = @categorias_directorio + '/' + sustituir_caracteres(nombre) + '.html'
                # Acumular en el menú
                @menu_categorias.agregar(nombre, url)
                # Si es la primera aparición de la categoría se inicializa la instancia
                if @categorias[nombre].nil?
                    multipagina                                 = Multipagina.new
                    multipagina.titulo                          = "Categoría #{nombre}"
                    multipagina.publicaciones_por_pagina_maximo = @publicaciones_por_pagina_maximo
                    multipagina.directorio                      = @categorias_directorio
                    multipagina.nombre                          = sustituir_caracteres(nombre)
                    @categorias[nombre]                         = multipagina
                end
                # Acumular en el hash categorias
                @categorias[nombre].agregar(pub)
            end
        end
        # Enviamos los vínculos de las categorías a todas las publicaciones
        @publicaciones.each { |pub| pub.vincular_categorias(@menu_categorias.urls) }
        # Entregar mensaje para la terminal
        salida = Array.new
        salida.push("  Hay estas categorías...")
        @categorias.each { |nombre, multipagina| salida.push("    #{nombre}") }
        salida.join("\n")
    end

    ##
    # Cargar menús adicionales

    def cargar_menus_adicionales
        # Definir
        # @menus_adicionales
    end

    ##
    # Preparar menú últimas publicaciones

    def preparar_menu_ultimas_publicaciones
        # Se entregará un menú secundario
        @menu_ultimas_publicaciones = MenuSecundario.new
        @menu_ultimas_publicaciones.encabezado('Últimas publicaciones')
        c = 0
        # Bucle para cada publicación
        @publicaciones.each do |pub|
            @menu_ultimas_publicaciones.agregar(pub.nombre_menu, pub.ruta) if pub.aparece_en_pagina_inicial
            c += 1
            break if c >= @publicaciones_por_pagina_maximo
        end
        # Entregar mensaje para la terminal
        "  Listo el menú con las últimas #{c} publicaciones."
    end

    ##
    # Elaborar las páginas iniciales

    def paginas_iniciales
        # Multipaǵinas por defecto creará index.html, index-2.html, etc.
        multipagina                                 = Multipagina.new
        multipagina.titulo                          = "Inicio"
        multipagina.publicaciones_por_pagina_maximo = @publicaciones_por_pagina_maximo
        # Bucle para agregar cada publicación a multipágina
        @publicaciones.each do |pub|
            pub.en_raiz = true
            pub.en_otro = false
            multipagina.agregar(pub)
        end
        # Las paǵinas iniciales están en la raíz del sitio web. Usan el título "Inicio" y el autor por defecto.
        @plantilla.en_raiz = true
        @plantilla.titulo  = "Inicio"
        @plantilla.autor   = @autor_por_defecto
        # En este arreglo juntaremos el hash que se va entregar
        paginas = Hash.new
        # Bucle para cada página en la multipágina
        multipagina.paginas.each do |ruta, paquetes|
            # Pasar las propiedades de la publicación a la plantilla
            @plantilla.contenido  = paquetes['contenido']
            @plantilla.javascript = paquetes['javascript']
            # Acumular el código HTML
            paginas[ruta] = @plantilla.to_html
        end
        # Entregar
        paginas
    end

    ##
    # Elaborar las páginas de las publicaciones

    def paginas_publicaciones
        # Estas paǵinas NO están en la raíz del sitio web
        @plantilla.en_raiz = false
        # En este arreglo acumularemos el hash que se va entregar
        paginas = Hash.new
        # Bluce para cada una de las publicaciones
        @publicaciones.each do |pub|
            # Pasar las propiedades de la publicación a la plantilla
            @plantilla.titulo     = pub.nombre
            @plantilla.autor      = pub.autor
            @plantilla.contenido  = pub.completo_html
            @plantilla.javascript = pub.javascript
            # Acumular el código HTML
            paginas[pub.ruta] = @plantilla.to_html
        end
        # Entregar
        paginas
    end

    ##
    # Elaborar las páginas de los directorios

    def paginas_directorios
        # Estas páginas NO están en la raíz del sitio web
        @plantilla.en_raiz = false
        @plantilla.autor   = @autor_por_defecto
        # En este arreglo juntaremos el hash que se va entregar
        paginas = Hash.new
        # Bucle para cada directorio
        @publicaciones_directorios.each do |dir|
            # Si no existe el directorio se brinca
            next if FileTest.directory?(dir) == false
            # Si NO hay etiqueta definida para el directorio se toma el directorio mismo, de lo contrario la etiqueta
            if @publicaciones_etiquetas[dir].nil?
                @plantilla.titulo = dir.capitalize  # La primer letra del directorio a mayúscula
            else
                @plantilla.titulo = @publicaciones_etiquetas[dir]
            end
            # Multipaǵinas definirá index.html, index-2.html, etc.
            multipagina                                 = Multipagina.new
            multipagina.titulo                          = @plantilla.titulo
            multipagina.publicaciones_por_pagina_maximo = @publicaciones_por_pagina_maximo
            multipagina.directorio                      = dir
            # Bucle para cada publicación
            @publicaciones.each do |pub|
                pub.en_raiz = false
                pub.en_otro = false
                multipagina.agregar(pub) if pub.directorio == dir # Sólo si la publicación está en el directorio se agrega
            end
            # Para cada página acumulada en la multipágina del directorio en procesamiento
            multipagina.paginas.each do |ruta, paquetes|
                # Pasar las propiedades de la publicación a la plantilla
                @plantilla.contenido  = paquetes['contenido']
                @plantilla.javascript = paquetes['javascript']
                # Acumular el código HTML
                paginas[ruta] = @plantilla.to_html
            end
        end
        # Entregar hash con las rutas y contenidos
        paginas
    end

    ##
    # Elaborar las páginas de los autores

    def paginas_autores
        # Estas páginas NO están en la raíz del sitio web
        @plantilla.en_raiz = false
        @plantilla.autor   = @autor_por_defecto
        # En este arreglo juntaremos el hash que se va entregar
        paginas = Hash.new
        # Bucle para cada autor
        @autores.each do |nombre, multipagina|
            # El nombre será el título
            @plantilla.titulo = "Autor #{nombre}"
            # Para cada página acumulada en la multipágina
            multipagina.paginas.each do |ruta, paquetes|
                # Pasar las propiedades de la publicación a la plantilla
                @plantilla.contenido  = paquetes['contenido']
                @plantilla.javascript = paquetes['javascript']
                # Acumular el código HTML
                paginas[ruta] = @plantilla.to_html
            end
        end
        # Entregar hash con las rutas y contenidos
        paginas
    end

    ##
    # Elaborar las páginas de las categorías

    def paginas_categorias
        # Estas páginas NO están en la raíz del sitio web
        @plantilla.en_raiz = false
        @plantilla.autor   = @autor_por_defecto
        # En este arreglo juntaremos el hash que se va entregar
        paginas = Hash.new
        # Bucle para cada categoría
        @categorias.each do |nombre, multipagina|
            # El nombre será el título
            @plantilla.titulo = "Categoría #{nombre}"
            # Para cada página acumulada en la multipágina
            multipagina.paginas.each do |ruta, paquetes|
                # Pasar las propiedades de la publicación a la plantilla
                @plantilla.contenido  = paquetes['contenido']
                @plantilla.javascript = paquetes['javascript']
                # Acumular el código HTML
                paginas[ruta] = @plantilla.to_html
            end
        end
        # Entregar hash con las rutas y contenidos
        paginas
    end

    ##
    # Elaborar sindicalización

    def sindicalizacion
        require 'rss/maker'
        contenido = RSS::Maker.make("2.0") do |m|
            m.channel.title       = @sitio_titulo
            m.channel.description = @sitio_descripcion
            m.channel.link        = @sitio_url
            m.items.do_sort       = true
            contador              = 0
            @publicaciones.each do |pub|
                pub.en_raiz = true
                if pub.aparece_en_pagina_inicial
                    i             = m.items.new_item
                    i.title       = pub.nombre
                    i.author      = pub.autor
                    i.link        = @sitio_url + '/' + pub.ruta
                    i.description = pub.rss
                    i.date        = Time.parse(pub.fecha)
                    contador     += 1
                    break if contador >= @publicaciones_por_pagina_maximo
                end
            end
        end
        # Entregar el XML para el archivo de sindicalización
        contenido
    end

    ##
    # Leer archivo para incluir su contenido
    #
    # Entrega el contenido del mismo

    def leer_archivo(ruta)
        salida = String.new
        if File.exists?(ruta)
            if File.directory?(ruta)
                raise "ERROR en leer_archivo: Aun no puedo leer directorios."
            elsif File.readable?(ruta)
                File.open(ruta, 'r') do |puntero|
                    while linea = puntero.gets
                        salida += linea
                    end
                end
            else
                raise "ERROR en leer_archivo: No pude leer #{ruta}"
            end
        else
            raise "ERROR en leer_archivo: No existe #{ruta}"
        end
        salida
    rescue Exception => mensaje
        puts mensaje
    end

end
