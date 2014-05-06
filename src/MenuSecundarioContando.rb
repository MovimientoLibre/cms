# encoding: utf-8
#
#  MenuSecundarioContando.rb
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
# Testing

if __FILE__ == $0
    require './Menu.rb'
    require './MenuSecundario.rb'
end

##
# Menú Secundario Contando
#
# Construye un menú secundario con cantidades.
# Se usa para crear los menús de autores y categorías.

class MenuSecundarioContando < MenuSecundario

    attr_reader :urls

    ##
    # Inicializar, agrega otras propiedades

    def initialize
        super
        @urls       = Hash.new
        @cantidades = Hash.new
    end

    ##
    # Agregar un elemento al menú e ir contando la cantidad de cada uno

    def agregar(etiqueta, url)
        if @urls[etiqueta] == nil
            @urls[etiqueta]       = url
            @cantidades[etiqueta] = 1
        else
            @cantidades[etiqueta] += 1
        end
    end

    ##
    # Elaborar el código HTML
    #
    # Su único parámetro es boleano y es para saber si es para un archivo en la raíz del sitio.
    # Por defecto es falso, es decir, se crea el menú para una página que NO esté en la raiz.

    def to_html(sera_para_la_raiz=nil)
        arreglo = Array.new
        @cantidades.each do | etiqueta, cantidad |
            arreglo.push({
                'etiqueta'   => etiqueta,
                'url'        => @urls[etiqueta],
                'cantidad'   => cantidad,
                'encabezado' => @encabezado_actual})
        end
        @elementos = arreglo.sort_by { |i| i['etiqueta'] }
        super(sera_para_la_raiz)
    end

end

##
# Testing
#
# Ejecute $ ruby MenuSecundario.rb para mostrar en la terminal una prueba de esta clase.

if __FILE__ == $0
    menu = MenuSecundarioContando.new
    menu.encabezado('Lenguajes')
    menu.agregar('PHP', 'categorias/php.html')
    menu.agregar('PHP', 'categorias/php.html')
    menu.agregar('PHP', 'categorias/php.html')
    menu.agregar('PHP', 'categorias/php.html')
    menu.agregar('Python', 'categorias/python.html')
    menu.agregar('Python', 'categorias/python.html')
    menu.agregar('Ruby', 'categorias/ruby.html')
    menu.agregar('Ruby', 'categorias/ruby.html')
    menu.agregar('Ruby', 'categorias/ruby.html')
    menu.agregar('Ruby', 'categorias/ruby.html')
    menu.agregar('Ruby', 'categorias/ruby.html')
    menu.agregar('Ruby', 'categorias/ruby.html')
    puts
    puts menu.to_html
    puts
end
