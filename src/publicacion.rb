# encoding: utf-8
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
require 'kramdown'

#
# Clase Publicacion
#
class Publicacion

    #
    # Propiedades modificables
    #
    attr_writer :nombre, :nombre_menu, :directorio, :archivo, :fecha, :autor, :contenido, :categorias, :aparece_en_pagina_inicial, :en_raiz, :en_otro, :tipo

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
        @en_raiz                   = false     # Verdadero cuando la publicación va para la página inicial
        @en_otro                   = false     # Verdadero cuando la publicación va para el directorio autores o categorias
        @tipo                      = 'rb'      # Dos tipos 'rb' (ruby) o 'md' (markdown), por defecto rb
        # Propiedades no modificables
        @vinculos_categorias       = Hash.new
    end

    #
    # URLs en Raiz
    #
    protected
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

    #
    # URLs en otro directorio
    #
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
        # De acuerdo al tipo, el contenido se procesará
        texto = RedCloth.new(mostrar)           if @tipo == 'rb'
        texto = Kramdown::Document.new(mostrar) if @tipo == 'md'
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
            mostrar    = $`
            incompleto = true
        else
            mostrar    = @contenido
            incompleto = false
        end
        # De acuerdo al tipo, el contenido se procesará
        texto = RedCloth.new(mostrar)           if @tipo == 'rb'
        texto = Kramdown::Document.new(mostrar) if @tipo == 'md'
        # Arreglo
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
            elsif @en_otro
                a << urls_en_otro(texto.to_html)
            else
                a << texto.to_html
            end
            a << "  <p class=\"text-right\"><button type=\"button\" class=\"btn btn-primary publicacion-completa\" onclick=\"location.href='#{vinculo}'\">Publicación completa...</button></p>"
            a << '</blockquote>'
        else
            a << "  <p><small>#@fecha - #@autor</small></p>" if @aparece_en_pagina_inicial
            if @en_raiz
                a << urls_en_raiz(texto.to_html)
            elsif @en_otro
                a << urls_en_otro(texto.to_html)
            else
                a << texto.to_html
            end
        end
        # Entregar
        a.join("\n")
    end

    #
    # Breve para archivo en la raiz
    #
    def breve_en_raiz
        @en_raiz = true
        @en_otro = false
        breve
    end

    #
    # Breve para archivo en otro directorio, como autores o categorias
    #
    def breve_en_otro
        @en_raiz = false
        @en_otro = true
        breve
    end

    #
    # RSS es como el breve pero para la sindicalización
    #
    def rss
        if @contenido =~ /<!-- break -->/
            mostrar    = $`
            incompleto = true
        else
            mostrar    = @contenido
            incompleto = false
        end
        # De acuerdo al tipo, el contenido se procesará
        texto = RedCloth.new(mostrar)           if @tipo == 'rb'
        texto = Kramdown::Document.new(mostrar) if @tipo == 'md'
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
