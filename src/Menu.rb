# encoding: utf-8
#
#  Menu.rb
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
# Menu
#
# Es la base para construir menús. Las clases MenuPrincipal, MenuSecundario y MenuSecundarioContandoson sus herederas.
#
# Pueden definirse las siguientes propiedades:
# * en_raiz
# * div_clase
# * heading_clase
# * ul_clase
# * li_clase

class Menu

    attr_writer :en_raiz, :div_clase, :heading_clase, :ul_clase, :li_clase

    ##
    # Inicializar

    def initialize
        @en_raiz           = false
        @elementos         = Array.new
        @encabezados       = Array.new
        @encabezado_actual = nil
    end

    protected

    ##
    # Elaborar el encabezado

    def elaborar_encabezado(encabezado)
        # En este arreglo acumularemos la salida
        a =  Array.new
        a << "<div class=\"#@heading_clase\">" if not @heading_clase.nil?
        if encabezado['url'] == ''
            a << "  #{encabezado['etiqueta']}"
        else
            if @en_raiz
                a << "  <a href=\"#{encabezado['url']}\">#{encabezado['etiqueta']}</a>"
            else
                # Si el URL comienza con http://, ftp:// no le pone ../ antes
                if encabezado['url'] =~ /^\w+:\/\//i
                    a << "  <a href=\"#{encabezado['url']}\">#{encabezado['etiqueta']}</a>"
                else
                    a << "  <a href=\"../#{encabezado['url']}\">#{encabezado['etiqueta']}</a>"
                end
            end
        end
        a << "</div>" if not @heading_clase.nil?
        # Entregar
        a.join("\n")
    end

    ##
    # Elaborar elementos
    #
    # Crea la parte <ul>...</ul>

    def elaborar_elementos(encabezado=nil)
        # Armar los tags ul y li con sus clases
        if @ul_clase.nil?
            ul = '<ul>'
        else
            ul = "<ul class=\"#@ul_clase\">"
        end
        if @li_clase.nil?
            li = "<li>"
        else
            li = "<li class=\"#@li_clase\">"
        end
        # En este arreglo acumularemos la salida
        a = Array.new
        # Comienza la lista
        a << ul
        # Bucle para cada elemento
        @elementos.each do |e|
            # Si se va a filtrar por un encabezado, se salta si no lo es
            next if (encabezado != nil) && (e['encabezado'] != encabezado)
            # Determinar lo que se va a mostrar
            if e['url'].nil?
                visible = e['etiqueta']
            else
                if @en_raiz
                    visible = "<a href=\"#{e['url']}\">#{e['etiqueta']}</a>"
                else
                    # Si el URL comienza con http://, ftp:// no le pone ../ antes
                    if e['url'] =~ /^\w+:\/\//i
                        visible = "<a href=\"#{e['url']}\">#{e['etiqueta']}</a>"
                    else
                        visible = "<a href=\"../#{e['url']}\">#{e['etiqueta']}</a>"
                    end
                end
            end
            visible += "<span class=\"badge\">#{e['cantidad']}</span>" if not e['cantidad'].nil?
            # Acumular
            a << "  #{li}#{visible}</li>"
        end
        # Termina la lista
        a << '</ul>'
        # Entregar
        a.join("\n")
    end

    public

    ##
    # Agregar un encabezado

    def encabezado(etiqueta, url='')
        @encabezados.push({'etiqueta' => etiqueta, 'url' => url})
        @encabezado_actual = etiqueta
    end

    ##
    # Agregar una opción al menú

    def agregar(etiqueta, url=nil, cantidad=nil)
        @elementos.push({
            'etiqueta'   => etiqueta,
            'url'        => url,
            'cantidad'   => cantidad,
            'encabezado' => @encabezado_actual})
    end

    ##
    # Elaborar el código HTML
    #
    # Su único parámetro es boleano y es para saber si es para un archivo en la raíz del sitio.
    # Por defecto es falso, es decir, se crea el menú para una página que NO esté en la raiz.

    def to_html(sera_para_la_raiz=nil)
        # Si se da el parámetro
        @en_raiz = sera_para_la_raiz if not sera_para_la_raiz.nil?
        # En este arreglo acumularemos la salida
        a = Array.new
        # Sólo si se define una clase para el div se usa
        a << "<div class=\"#@div_clase\">" if not @div_clase.nil?
        # Si no hay encabezados, entonces sólo se elaboran los elementos
        if @encabezado_actual.nil?
            a << elaborar_elementos
        # Si solo es un encabezado
        elsif @encabezados.length == 1
            # Acumular el único encabezado
            a << elaborar_encabezado(@encabezados[0])
            # Acumular los elementos
            a << elaborar_elementos
        else
            # Hay dos o más encabezados, bucle por los mismos
            @encabezados.each do |encabezado|
                # Acumular el encabezado en turno
                a << elaborar_encabezado(encabezado)
                # Acumular los elementos de ese encabezado
                a << elaborar_elementos(encabezado)
            end
        end
        # Sólo si se define una clase para el div se usa
        a << "</div>" if not @div_clase.nil?
        # Entregar
        a.join("\n")
    end

end

##
# Testing
#
# Ejecute $ ruby Menu.rb para mostrar en la terminal una prueba de esta clase.

if __FILE__ == $0
    simple = Menu.new
    simple.encabezado('Gurús')
    simple.agregar('Linus Tordvals',   'gurus/linus.html')
    simple.agregar('Erick Raymond',    'gurus/raymond.html')
    simple.agregar('Richard Stallman', 'gurus/rms.html')
    puts
    puts simple.to_html
    puts
end
