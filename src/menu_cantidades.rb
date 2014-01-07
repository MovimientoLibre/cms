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
# Menu Cantidades
#
class Menu_Cantidades < Menu

    #
    # Propiedad leible
    #
    attr_reader :urls

    #
    # Valores por defecto de las propiedades
    #
    def initialize
        super
        @urls       = Hash.new
        @cantidades = Hash.new
    end

    #
    # Agregar un elemento e ir contando la cantidad de elementos
    #
    def agregar(etiqueta, url)
        if @urls[etiqueta] == nil
            @urls[etiqueta]       = url
            @cantidades[etiqueta] = 1
        else
            @cantidades[etiqueta] += 1
        end
    end

    #
    # Entrega el menu en HTML
    #
    def to_html
        arreglo = Array.new
        @cantidades.each do | etiqueta, cantidad |
            arreglo.push({'etiqueta' => "#{etiqueta} (#{cantidad})", 'url' => @urls[etiqueta], 'encabezado' => @encabezado_actual})
        end
        @elementos = arreglo.sort_by { |i| i['etiqueta'] }
        super
    end

    #
    # List group de Twitter Bootstrap
    #
    def to_list_group_html
        arreglo = Array.new
        @cantidades.each do | etiqueta, cantidad |
            arreglo.push({'etiqueta' => "#{etiqueta} (#{cantidad})", 'url' => @urls[etiqueta], 'encabezado' => @encabezado_actual})
        end
        @elementos = arreglo.sort_by { |i| i['etiqueta'] }
        super
    end

end
