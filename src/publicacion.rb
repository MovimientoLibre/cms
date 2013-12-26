############################################################################
#    Copyright (C) 2008 by Guillermo Valdez Lozano                         #
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
# Librerias
#
require 'rubygems'
require 'redcloth'

#
# Clase Publicacion
#
class Publicacion

    #
    # Propiedades modificables
    #
    attr_writer :nombre, :nombre_menu, :directorio, :archivo, :fecha, :autor, :contenido, :categorias, :aparece_en_pagina_inicial, :en_raiz

    #
    # Propiedades leibles
    #
    attr_reader :nombre, :nombre_menu, :directorio, :fecha, :autor, :categorias, :aparece_en_pagina_inicial

    #
    # Valores por defecto de las propiedades
    #
    def initialize
        # Propiedades modificables
        @nombre                    = ''
        @nombre_menu               = ''
        @directorio                = ''
        @archivo                   = ''
        @fecha                     = ''
        @autor                     = ''
        @contenido                 = ''
        @categorias                = Array.new
        @aparece_en_pagina_inicial = true
        @en_raiz                   = false
        # Propiedades no modificables
        @vinculos_categorias       = Hash.new
    end

    #
    # <a href="
    # <img src="
    #
    protected
    def urls_en_raiz(html)
        t = html.dup
        t.gsub!(/href="(\w+:\/\/|\w+)/i) {
            s = $1.dup
            case s
                when /\w+:\/\//i then "href=\"#{s}"
                when /\w+/i      then "href=\"#@directorio/#{s}"
            end
        }
        t.gsub!(/src="(\.\.\/\w+|\w+:\/\/|\w+)/i) {
            s = $1.dup
            case s
                when /\.\.\/(\w+)/ then "src=\"" + $1
                when /\w+:\/\//i   then "src=\"#{s}"
                when /\w+/i        then "src=\"#@directorio/#{s}"
            end
        }
        t
    end

    #
    # Ruta donde crear el archivo
    #
    public
    def ruta
        @directorio + '/' + @archivo + '.html'
    end

    #
    # Vincular categorias
    #
    # La publicación necesita saber el vínculo de cada categoría
    # Así pues, recibe todas y conserva los vínculos de sus propias categorías
    #
    def vincular_categorias(todas_las_categorias)
        @categorias.each { |etiqueta| @vinculos_categorias[etiqueta] = todas_las_categorias[etiqueta] }
    end

    #
    # Completo entrega toda la publiciación en HTML
    #
    def completo
        if @contenido =~ /<!-- break -->/
            mostrar = $` + $'
        else
            mostrar = @contenido
        end
        texto = RedCloth.new(mostrar)
        # El titulo de la página tendrá el nombre de la publicación, por eso no va aquí
        a = Array.new
        a << "  <p><small>#@fecha - #@autor</small></p>" if @aparece_en_pagina_inicial
        a << texto.to_html
        # Categorías de la publicación
#       c = Array.new
#       @vinculos_categorias.each { |etiqueta, url| c.push("<a href=\"#{url}\">#{etiqueta}</a>") }
#       a << "  <p class=\"text-right\"><em>Categorías: #{c.join(', ')}</em></p>" if c.length > 0
        # Entregar
        a.join("\n")
    end

    #
    # Breve entrega parte de la publicación hasta el <!-- break --> en HTML
    #
    def breve
        if @contenido =~ /<!-- break -->/
            texto      = RedCloth.new($`)
            incompleto = true
        else
            texto      = RedCloth.new(@contenido)
            incompleto = false
        end
        a = Array.new
        if @en_raiz
            vinculo = @directorio + '/' + @archivo + '.html'
        else
            vinculo = '../' + @directorio + '/' + @archivo + '.html'
        end
        a << "<h3><a href=\"#{vinculo}\">#@nombre</a></h3>"
        # Si no es toda la publicacion se usan los blockquote y el boton Ver publicación completa...
        if incompleto
            a << '<blockquote>'
            a << "  <p><small>#@fecha - #@autor</small></p>" if @aparece_en_pagina_inicial
            if @en_raiz
                a << urls_en_raiz(texto.to_html)
            else
                a << texto.to_html
            end
            a << "  <p class=\"text-right\"><button type=\"button\" class=\"btn btn-primary publicacion-completa\" onclick=\"location.href='#{vinculo}'\">Publicación completa...</button></p>"
            a << '</blockquote>'
        else
            a << "  <p><small>#@fecha - #@autor</small></p>" if @aparece_en_pagina_inicial
            if @en_raiz
                a << urls_en_raiz(texto.to_html)
            else
                a << texto.to_html
            end
        end
        # Entregar
        a.join("\n")
    end

    #
    # RSS es como el breve pero para la sindicalización
    #
    def rss
        if @contenido =~ /<!-- break -->/
            texto      = RedCloth.new($`)
            incompleto = true
        else
            texto      = RedCloth.new(@contenido)
            incompleto = false
        end
        texto.to_html
    end

    #
    # Sencillo entrega sólo una línea de texto para mostrar en la terminal
    #
    def sencillo
        if @aparece_en_pagina_inicial
            "#@fecha - #{self.ruta}"
        else
            "#@fecha X #{self.ruta}"
        end
    end

end
