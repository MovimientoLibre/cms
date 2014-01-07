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
# Clase Menu
#
class Menu

    #
    # Propiedades modificables
    #
    attr_writer :panel_clase, :encabezado_clase, :lista_clase, :opcion_clase, :en_raiz

    #
    # Valores por defecto de las propiedades
    #
    def initialize
        # Propiedades modificables
        @panel_clase       = ''
        @encabezado_clase  = ''
        @lista_clase       = ''
        @opcion_clase      = ''
        @en_raiz           = false
        # Propiedades no modificables
        @elementos         = Array.new
        @encabezados       = Array.new
        @encabezado_actual = ''
    end

    #
    # Encabezado del menu
    #
    public
    def encabezado(etiqueta, url='')
        @encabezados.push({'etiqueta' => etiqueta, 'url' => url})
        @encabezado_actual = etiqueta
    end

    #
    # Agregar un elemento al menu
    #
    def agregar(etiqueta, url='')
        @elementos.push({'etiqueta' => etiqueta, 'url' => url, 'encabezado' => @encabezado_actual})
    end

    #
    # Entrega el menu en HTML
    #
    def to_html
        if @lista_clase != ''
            ul = "<ul class=\"#@lista_clase\">"
        else
            ul = '<ul>'
        end
        if @opcion_clase != ''
            li = "<li class=\"#@opcion_clase\">"
        else
            li = "<li>"
        end
        a =  Array.new
        a << "<div class=\"#@panel_clase\">" if @panel_clase != ''
        if @encabezado_actual == ''
            a << ul
            @elementos.each do |e|
                if e['url'] == ''
                    a << "  #{li}#{e['etiqueta']}</li>"
                else
                    if @en_raiz
                        a << "  #{li}<a href=\"#{e['url']}\">#{e['etiqueta']}</a></li>"
                    else
                        a << "  #{li}<a href=\"../#{e['url']}\">#{e['etiqueta']}</a></li>"
                    end
                end
            end
            a << '</ul>'
        else
            @encabezados.each do |encabezado|
                a << "  <div class=\"#@encabezado_clase\">#@encabezado_actual</div>" if @encabezado_clase != ''
                a << ul
                b = Array.new
                @elementos.each do |e|
                    if e['encabezado'] == encabezado['etiqueta']
                        if e['url'] == ''
                            b << "      #{li}#{e['etiqueta']}</li>"
                        else
                            if @en_raiz
                                b << "      #{li}<a href=\"#{e['url']}\">#{e['etiqueta']}</a></li>"
                            else
                                b << "      #{li}<a href=\"../#{e['url']}\">#{e['etiqueta']}</a></li>"
                            end
                        end
                    end
                end
                if b.length > 0
                    b.each { |c| a << c }
                elsif encabezado['url'] == ''
                    a << "  #{li}#{encabezado['etiqueta']}</li>"
                else
                    if @en_raiz
                        a << "  #{li}<a href=\"#{encabezado['url']}\">#{encabezado['etiqueta']}</a></li>"
                    else
                        a << "  #{li}<a href=\"../#{encabezado['url']}\">#{encabezado['etiqueta']}</a></li>"
                    end
                end
                a << '</ul>'
            end
        end
        a << "</div>" if @panel_clase != ''
        a.join("\n")
    end

    #
    # Menu primario, usa Twitter Bootstrap
    #
    def to_primario_html
        @lista_clase = 'nav navbar-nav'
        to_html
    end

    #
    # Menu secundario, usa Twitter Bootstrap
    #
    def to_secundario_html
        @panel_clase      = 'panel panel-default col-md-4 menu-secundario'
        @encabezado_clase = 'panel-heading'
        @lista_clase      = 'list-group'
        @opcion_clase     = 'list-group-item'
        to_html
    end

end
