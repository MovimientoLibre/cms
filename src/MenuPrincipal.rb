# encoding: utf-8
#
#  MenuPrincipal.rb
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

require './Menu.rb' if __FILE__ == $0

##
# Menú Principal
#
# Construye el menú principal, el que va en la parte superior de todas las páginas.

class MenuPrincipal < Menu

    attr_writer :sitio_titulo

    ##
    # Inicializar

    def initialize
        super
        @elementos_derecha = Array.new
    end

    ##
    # Agregar una opción al lado derecho del menú principal

    def agregar_derecha(etiqueta, url=nil)
        @elementos_derecha.push({
            'etiqueta' => etiqueta,
            'url'      => url})
    end

    ##
    # Elaborar el código HTML
    #
    # Su único parámetro es boleano y es para saber si es para un archivo en la raíz del sitio.
    # Por defecto es falso, es decir, se crea el menú para una página que NO esté en la raiz.

    def to_html(sera_para_la_raiz=nil)
        # Si se da el parámetro
        @en_raiz = sera_para_la_raiz if not sera_para_la_raiz.nil?
        # En caso de no tener definido el título del sitio por defecto se usa Inicio
        @sitio_titulo = 'Inicio' if @sitio_titulo.nil?
        # Acumular la salida en este arreglo
        a = Array.new
        a << '<nav class="navbar navbar-default navbar-fixed-top" role="navigation" id="menu-principal">'
        a << '  <div class="container">'
        a << '    <div class="navbar-header">'
        a << '      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#menu-principal-collapse">'
        a << '        <span class="sr-only">Toggle navigation</span>'
        a << '        <span class="icon-bar"></span>'
        a << '        <span class="icon-bar"></span>'
        a << '        <span class="icon-bar"></span>'
        a << '      </button>'
        if @en_raiz
            a << "      <a class=\"navbar-brand\" href=\"index.html\">#@sitio_titulo</a>"
        else
            a << "      <a class=\"navbar-brand\" href=\"../index.html\">#@sitio_titulo</a>"
        end
        a << '    </div>'
        a << '    <div class="navbar-collapse collapse" id="menu-principal-collapse">'
        # Para el lado izquierdo los tags ul deben tener esta clase
        @ul_clase = 'nav navbar-nav'
        a << super
        if @elementos_derecha.size > 0
            # Para el lado derecho los tags ul deben tener esta clase
            @ul_clase = 'nav navbar-nav navbar-right'
            # Se intercambian los arreglos y se llama al padre
            @elementos,@elementos_derecha = @elementos_derecha,@elementos
            a << super
            @elementos,@elementos_derecha = @elementos_derecha,@elementos
        end
        a << '    </div>'
        a << '  </div>'
        a << '</nav>'
        # Entregar
        a.join("\n")
    end

end

##
# Testing
#
# Ejecute $ ruby MenuPrincipal.rb para mostrar en la terminal una prueba de esta clase.

if __FILE__ == $0
    principal = MenuPrincipal.new
    principal.agregar('Artículos',      'articulos/index.html')
    principal.agregar('Presentaciones', 'presentaciones/index.html')
    principal.agregar('Licencias',      'licencias/index.html')
    principal.agregar('Contacto',       'contacto/index.html')
    principal.agregar_derecha('GitHub', 'http://github.com/')
    principal.agregar_derecha('RSS',    'rss.xml')
    puts
    puts principal.to_html
    puts
end
