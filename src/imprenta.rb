############################################################################
#    Copyright (C) 2013 by Guillermo Valdes Lozano                         #
#    guivaloz@movimientolibre.com                                          #
#                                                                          #
#    This program is free software; you can redistribute it and#or modify  #
#    it under the terms of the GNU General Public License as published by  #
#    the Free Software Foundation; either version 2 of the License, or     #
#    (at your option) any later version.                                   #
#                                                                          #
#    This program is distributed in the hope that it will be useful,       #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#    GNU General Public License for more details.                          #
#                                                                          #
#    You should have received a copy of the GNU General Public License     #
#    along with this program; if not, write to the                         #
#    Free Software Foundation, Inc.,                                       #
#    59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
############################################################################

#
# Clase Imprenta
#
class Imprenta

    #
    # Propiedades modificables
    #
    attr_writer :titulo_sitio, :frase_sitio, :anuncio, :grafico_encabezado, :publicaciones_directorios, :publicaciones_etiquetas, :menu_principal, :contenido_secundario, :publicaciones_por_pagina_maximo, :autor_por_defecto, :categorias_directorio, :autores_directorio, :menus_directorio, :usar_contenido_secundario, :url_sitio, :descripcion_sitio, :pie_html, :archivo_rss

    #
    # Valores por defecto de las propiedades
    #
    def initialize
        # Propiedades modificables
        @titulo_sitio                    = 'Título del sitio'
        @frase_sitio                     = 'Descripción del sitio'
        @anuncio                         = ''
        @publicaciones_directorios       = Array.new
        @contenido_secundario            = ''
        @publicaciones_por_pagina_maximo = 5
        @autor_por_defecto               = 'sin_autor'
        @categorias_directorio           = 'categorias'
        @autores_directorio              = 'autores'
        @menus_directorio                = 'menus'
        @usar_contenido_secundario       = true
        # Propiedades no modificables
        @cantidad         = 0
        @se_ha_alimentado = false
        @publicaciones    = Array.new
        @categorias       = Hash.new
        @autores          = Hash.new
    end

    #
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
    #
    protected
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

    #
    # Cargar publicaciones
    #
    def cargar_publicaciones
        # Cargar los archivos .rb de los directorios de las publicaciones
        pubs = Array.new
        @publicaciones_directorios.each do |dir|
            archivos = Dir.glob(dir + '/*.rb')
            next if archivos.size == 0
            archivos.sort.each do |arch|
                load arch
                pubs.push(publicacion(dir))
                @cantidad += 1
            end
        end
        # Asignar el autor por defecto en las publicaciones que no lo tengan
        pubs.each { |pub| pub.autor = @autor_por_defecto if pub.autor == '' }
        # Ordenar las publicaciones por fecha, los más recientes primero
        ordenadas = pubs.sort_by { |pub| pub.fecha }
        # Almacenar en @publicaciones un arreglo de objetos con las publicaciones
        @publicaciones = ordenadas.reverse
    end

    #
    # Menu últimas publicaciones
    #
    def menu_ultimas_publicaciones
        menu = Menu.new
        menu.encabezado('Últimas publicaciones')
        c = 0
        @publicaciones.each do |pub|
            menu.agregar(pub.nombre_menu, '/' + pub.url) if pub.aparece_en_pagina_inicial
            c += 1
            break if c >= @publicaciones_por_pagina_maximo
        end
        # Entregamos el HTML del menú
        menu.to_secundario_html
    end

    #
    # Menu categorias
    #
    def menu_categorias
        menu = Menu_Cantidades.new
        menu.encabezado('Categorías')
        # Procesamos sólo las publicaciones que pueden aparecer en la página principal
        @publicaciones.each do |pub|
            if pub.aparece_en_pagina_inicial
                # Cada publicación puede tener una o más categorías
                pub.categorias.each do |nombre|
                    url = @categorias_directorio + '/' + sustituir_caracteres(nombre) + '.html'
                    menu.agregar(nombre, '/' + url)
                    # Almacenamos las publicaciones de cada categoría, para hacer más adelante las páginas de las categorías
                    @categorias[nombre] = Clasificado.new(nombre, url) if @categorias[nombre] == nil
                    @categorias[nombre].agregar_publicacion(pub)
                end
            end
        end
        # Enviamos los vínculos de las categorías a todas las publicaciones
        @publicaciones.each { |pub| pub.vincular_categorias(menu.urls) }
        # Entregamos el HTML del menú
        menu.to_secundario_html
    end

    #
    # Menu autores
    #
    def menu_autores
        menu = Menu_Cantidades.new
        menu.encabezado('Autores')
        # Procesamos sólo las publicaciones que pueden aparecer en la página principal
        @publicaciones.each do |pub|
            if pub.aparece_en_pagina_inicial
                nombre = pub.autor
                url    = @autores_directorio + '/' + sustituir_caracteres(nombre) + '.html'
                menu.agregar(nombre, '/' + url)
                # Almacenamos las publicaciones de cada autor, para hacer más adelante las páginas de los autores
                @autores[nombre] = Clasificado.new(nombre, url) if @autores[nombre] == nil
                @autores[nombre].agregar_publicacion(pub)
            end
        end
        # Entregamos el HTML del menú
        menu.to_secundario_html
    end

    #
    # Menus adicionales
    #
    def menus_adicionales
        todos    = Array.new
        archivos = Dir.glob(@menus_directorio + '/*.rb')
        archivos.sort.each do |arch|
            load arch
            todos.push(menu)
        end
        todos.join("\n")
    end

    #
    # Alimentarse
    #
    def alimentarse
        # No volver a alimentar si ya se ha hecho
        return if @se_ha_alimentado
        # Cargar las publicaciones
        self.cargar_publicaciones
        # Inicializar la plantilla
        @plantilla                    = Plantilla.new
        @plantilla.titulo_sitio       = @titulo_sitio
        @plantilla.frase_sitio        = @frase_sitio
        @plantilla.grafico_encabezado = @grafico_encabezado
        @plantilla.menu_principal     = @menu_principal
        if @usar_contenido_secundario
            @plantilla.menu_secundario      = self.menu_ultimas_publicaciones + self.menu_categorias + self.menu_autores
            @plantilla.contenido_secundario = @contenido_secundario + self.menus_adicionales
        else
            @plantilla.menu_secundario = self.menu_ultimas_publicaciones + self.menu_categorias + self.menu_autores + @contenido_secundario + self.menus_adicionales
        end
        @plantilla.pie_html    = @pie_html
        @plantilla.archivo_rss = @archivo_rss
        # Al término pone en verdadero el flag @se_ha_alimentado
        @se_ha_alimentado = true
    end

    #
    # Reporte. Genera un informe en texto de las publicaciones
    #
    public
    def reporte
        self.alimentarse  # Para asegurarnos que se alimentado
        listado = Array.new
        @publicaciones.each { |pub| listado.push(pub.sencillo) }
        "Hay #{@cantidad} publicaciones...\n#{listado.join("\n")}"
    end

    #
    # Pagina inicial. Entrega el HTML de la pagina inicial
    #
    def pagina_inicial
        self.alimentarse  # Para asegurarnos que se alimentado
        contador  = 0
        contenido = Array.new
        contenido.push(@anuncio) if @anuncio != ''
        @publicaciones.each do |pub|
            if pub.aparece_en_pagina_inicial
                contenido.push(pub.breve)
                contador += 1
                break if contador >= @publicaciones_por_pagina_maximo
            end
        end
        @plantilla.to_html('Página inicial', contenido.join("\n"))
    end

    #
    # Páginas publicaciones. Entrega un hash con los nombres de los archivos y el contenido HTML de cada publicación
    #
    def paginas_publicaciones
        self.alimentarse  # Para asegurarnos que se alimentado
        paginas = Hash.new
        @publicaciones.each { |pub| paginas[pub.url] = @plantilla.to_html(pub.nombre, pub.completo) }
        paginas
    end

    #
    # Páginas directorios. Entrega un hash con la ruta y el contenido HTML de cada índice
    #
    def paginas_directorios
        self.alimentarse  # Para asegurarnos que se alimentado
        paginas = Hash.new
        @publicaciones_directorios.each do |dir|
            multipagina = Multipagina.new(dir, 'index')
            @publicaciones.each { |pub| multipagina.agregar(pub) if pub.directorio == dir }
            multipagina.paginas.each do |ruta, contenido|
                if @publicaciones_etiquetas.class == Hash and @publicaciones_etiquetas[dir] != nil
                    etiqueta = @publicaciones_etiquetas[dir]
                else
                    etiqueta = dir.capitalize
                end
                paginas[ruta] = @plantilla.to_html(etiqueta, contenido)
            end
        end
        paginas
    end

    #
    # Páginas categorias. Entrega un hash con la ruta y el contenido HTML de cada página
    #
    def paginas_categorias
        self.alimentarse  # Para asegurarnos que se alimentado
        paginas = Hash.new
        @categorias.each do |nombre, cat|
            multipagina = Multipagina.new(@categorias_directorio, sustituir_caracteres(cat.nombre))
            cat.publicaciones.each { |pub| multipagina.agregar(pub) }
            multipagina.paginas.each { |ruta, contenido| paginas[ruta] = @plantilla.to_html(nombre, contenido) }
        end
        paginas
    end

    #
    # Páginas autores
    #
    def paginas_autores
        self.alimentarse  # Para asegurarnos que se alimentado
        paginas = Hash.new
        @autores.each do |nombre, obj|
            multipagina = Multipagina.new(@autores_directorio, sustituir_caracteres(nombre))
            obj.publicaciones.each { |pub| multipagina.agregar(pub) }
            multipagina.paginas.each { |ruta, contenido| paginas[ruta] = @plantilla.to_html("Publicaciones escritas por #{nombre}", contenido) }
        end
        paginas
    end

    #
    # Sindicalización. Entrega el XML para el archivo de sindicalización
    #
    def sindicalizacion
        self.alimentarse  # Para asegurarnos que se alimentado
        require 'rss/maker'
        contenido = RSS::Maker.make("2.0") do |m|
            m.channel.title       = @titulo_sitio
            m.channel.link        = @url_sitio
            m.channel.description = @descripcion_sitio
            m.items.do_sort       = true
            contador              = 0
            @publicaciones.each do |pub|
                if pub.aparece_en_pagina_inicial
                    i             = m.items.new_item
                    i.title       = pub.nombre
                    i.author      = pub.autor
                    i.link        = @url_sitio + '/' + pub.url
                    i.description = pub.rss
                    i.date        = Time.parse(pub.fecha)
                    contador     += 1
                    break if contador >= @publicaciones_por_pagina_maximo
                end
            end
        end
        contenido
    end

end
