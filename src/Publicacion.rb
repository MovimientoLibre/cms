# encoding: utf-8
#
#  Publicacion.rb
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
# Cargar Gemas, RedCloth y Kramdown

require 'rubygems'
require 'redcloth'
require 'kramdown'

##
# Publicación
#
# Se usa como contenedor de TODA la información de UNA publicación. Estas son las descripciones de sus propiedades:
# * nombre
# * nombre_menu
# * directorio
# * archivo
# * fecha
# * autor
# * contenido                  Contenido. Puede tener una línea con <!-- break --> para separar la parte breve.
# * javascript                 Código Javascript. Debe estar aparte para ponerlo al final de la página.
# * categorias
# * aparece_en_pagina_inicial  Verdadero si va aparecer en la página de inicio
# * en_raiz                    Verdadero si el archivo va a la raiz del sitio web.
# * en_otro                    Verdadero si el archivo va a OTRO lugar como al directorio autores, categorias, etc.
# * tipo                       Extensión del archivo de origen, puede ser "md" para markdown o "rb" para rubí.

class Publicacion

    attr_writer :nombre, :nombre_menu, :directorio, :archivo, :fecha, :autor, :contenido, :javascript, :categorias, :aparece_en_pagina_inicial, :en_raiz, :en_otro, :tipo
    attr_reader :nombre, :nombre_menu, :directorio, :archivo, :fecha, :autor, :contenido, :javascript, :categorias, :aparece_en_pagina_inicial, :en_raiz, :en_otro, :tipo

    ##
    # Inicializar

    def initialize
        @fecha                     = '1980-01-01' # La fecha por defecto es del pasado.
        @aparece_en_pagina_inicial = true
        @en_raiz                   = false
        @en_otro                   = false
        @categorias                = Array.new
        @vinculos_categorias       = Hash.new
    end

    protected

    ##
    # Ajustar los URLs cuando el archivo va a la raíz del sitio

    def urls_en_raiz(html)
        t = html.dup
        # Buscar <a href="algo:// o <a href="algo
        t.gsub!(/href="(\w+:\/\/|\w+)/i) {
            s = $1.dup
            case s
                when /\w+:\/\//i then "href=\"#{s}"
                when /\w+/i      then "href=\"#@directorio/#{s}"
            end
        }
        # Buscar <img src="../algo o <img src="algo:// o <img src="algo
        t.gsub!(/src="(\.\.\/\w+|\w+:\/\/|\w+)/i) {
            s = $1.dup
            case s
                when /\.\.\/(\w+)/ then "src=\"" + $1
                when /\w+:\/\//i   then "src=\"#{s}"
                when /\w+/i        then "src=\"#@directorio/#{s}"
            end
        }
        # Entregar
        t
    end

    ##
    # Ajustar los URLs cuando el archivo va a otro directorio que NO es el de la publicación ni la raíz

    def urls_en_otro(html)
        t = html.dup
        # Buscar href="algo:// o href="algo
        t.gsub!(/href="(\w+:\/\/|\w+)/i) {
            s = $1.dup
            case s
                when /\w+:\/\//i then "href=\"#{s}"
                when /\w+/i      then "href=\"../#@directorio/#{s}"
            end
        }
        # Buscar src="algo:// o src="algo
        t.gsub!(/src="(\w+:\/\/|\w+)/i) {
            s = $1.dup
            case s
                when /\w+:\/\//i   then "src=\"#{s}"
                when /\w+/i        then "src=\"../#@directorio/#{s}"
            end
        }
        # Entregar
        t
    end

    public

    ##
    # Ruta donde se creará el archivo

    def ruta
        @directorio + '/' + @archivo + '.html'
    end

    ##
    # Vincular categorias
    #
    # La publicación necesita saber el vínculo de cada categoría.
    # Recibe todos los vínculos, pero conserva sólo los de sus propias categorías.

    def vincular_categorias(todas)
        @categorias.each { |etiqueta| @vinculos_categorias[etiqueta] = todas[etiqueta] }
    end

    ##
    # Sencillo manda un sólo renglón con la fecha y título de la publicación

    def sencillo
        if @aparece_en_pagina_inicial
            "#@fecha - #{self.nombre}"
        else
            "#@fecha X #{self.nombre}"
        end
    end

    ##
    # Contenido completo de la publicación

    def completo_html
        # Si aparece el break, es retirado
        if @contenido =~ /<!-- break -->/
            mostrar = $` + $'
        else
            mostrar = @contenido
        end
        # De acuerdo al tipo, el contenido se procesará
        texto = RedCloth.new(mostrar)           if @tipo == 'rb'
        texto = Kramdown::Document.new(mostrar) if @tipo == 'md'
        # En este arreglo acumularemos la salida
        a = Array.new
        a << '<article>'
        a << '  <header>'
        a << "    <h1>#@nombre</h1>"
        a << "    <p class=\"autor-fecha\">Por #@autor, #@fecha</p>" if @aparece_en_pagina_inicial
        a << '  </header>'
        a << texto.to_html
        if @vinculos_categorias.length > 0
            a << '  <footer>'
            a << '    <div class="btn-group">'
            @vinculos_categorias.each do |etiqueta, vinculo|
                if @en_raiz
                    a << "<button class=\"btn btn-default btn-group-sm btn-categoria\" type=\"buttom\" onclick=\"location.href='#{vinculo}'\">#{etiqueta}</button>"
                else
                    a << "<button class=\"btn btn-default btn-group-sm btn-categoria\" type=\"buttom\" onclick=\"location.href='../#{vinculo}'\">#{etiqueta}</button>"
                end
            end
            a << '    </div>'
            a << '  </footer>'
        end
        a << '</article>'
        # Entregar
        a.join("\n")
    end

    ##
    # Contenido breve de la publicación
    #
    # Se usa en las paǵinas de inicio, categorías y autores

    def breve_html
        # Si aparece el break en el contenido, se entregará lo que está antes de éste
        if @contenido =~ /<!-- break -->/
            mostrar    = $`
            incompleto = true
        else
            mostrar    = @contenido
            incompleto = false
        end
        # Determinar el vínculo a esta publicación
        if @en_raiz
            vinculo = @directorio + '/' + @archivo + '.html'
        else
            vinculo = '../' + @directorio + '/' + @archivo + '.html'
        end
        # De acuerdo al tipo, el contenido se procesará
        texto = RedCloth.new(mostrar)           if @tipo == 'rb'
        texto = Kramdown::Document.new(mostrar) if @tipo == 'md'
        # Modificar los vínculos de acuerdo al lugar donde se pondrá
        if @en_raiz
            texto_html = urls_en_raiz(texto.to_html)
        elsif @en_otro
            texto_html = urls_en_otro(texto.to_html)
        else
            texto_html = texto.to_html
        end
        # En este arreglo acumularemos la salida
        a = Array.new
        a << '<section>'
        # En el encabezado se usa el vínculo
        a << "  <h3><a href=\"#{vinculo}\">#@nombre</a></h3>"
        # Si es incompleto
        if incompleto
            # Se usarán blockquote para el breve y el botón "publicación completa"
         #~ a << "  <p><small>#@fecha - #@autor</small></p>" if @aparece_en_pagina_inicial
            a << '  <blockquote>'
            a << texto_html
            a << '  </blockquote>'
            a << "  <button class=\"btn btn-default btn-sm btn-publicacion-completa\" type=\"button\" onclick=\"location.href='#{vinculo}'\">Publicación completa...</button>"
        else
            # La publicación se pone completa
         #~ a << "  <p><small>#@fecha - #@autor</small></p>" if @aparece_en_pagina_inicial
            a << texto_html
        end
        a << '</section>'
        # Entregar
        a.join("\n")
    end

    ##
    # Contenido para las entradas de la sindicalización

    def rss
        # Si aparece el break en el contenido, se entregará lo que está antes de éste
        if @contenido =~ /<!-- break -->/
            mostrar = $`
        else
            mostrar = @contenido
        end
        # De acuerdo al tipo, el contenido se procesará
        texto = RedCloth.new(mostrar)           if @tipo == 'rb'
        texto = Kramdown::Document.new(mostrar) if @tipo == 'md'
        # Entregar
        texto.to_html
    end

end

##
# Testing
#
# Ejecute $ ruby Publicacion.rb para mostrar en la terminal una prueba de esta clase.

if __FILE__ == $0
    pub            = Publicacion.new
    pub.nombre     = "Una publicación de muestra"
    pub.directorio = "presentacion"
    pub.archivo    = "prueba"
    pub.autor      = "Nombre Apellidos"
    pub.fecha      = "2014-05-01"
    pub.tipo       = "md"
    pub.contenido  = <<FINAL
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumyeirmod tempor invidunt ut labore et dolore magna aliquyam erat.

<!-- break -->

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumyeirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diamvoluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sa.

Lorem ipsum dolor sit amet, consetetur sadipscin:

* Lorem ipsum dolor sit amet
* Lorem ipsum dolor sit amet
* Lorem ipsum dolor sit amet
FINAL
    puts "Breve..."
    puts pub.breve_html
    puts
    puts "Completa..."
    puts pub.completo_html
    puts
end
