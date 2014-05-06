# encoding: utf-8
#
#  MenuSecundario.rb
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
# Menú Secundario
#
# Construye un menú secundario.
# Se usa para crear los menús adicionales y de últimas publicaciones.

class MenuSecundario < Menu

    ##
    # Inicializar con las propiedades para un menú secundario
    #
    # Usa las clases para Panel with list groups http://getbootstrap.com/components/#panels-list-group

    def initialize
        super
        @div_clase     = 'panel panel-default menu-secundario'
        @heading_clase = 'panel-heading'
        @ul_clase      = 'list-group'
        @li_clase      = 'list-group-item'
    end

end

##
# Testing
#
# Ejecute $ ruby MenuSecundario.rb para mostrar en la terminal una prueba de esta clase.

if __FILE__ == $0
    secundario = MenuSecundario.new
    secundario.encabezado('Enlaces')
    secundario.agregar('Gnome',      'http://gnome.org/')
    secundario.agregar('KDE',        'http://kde.org/')
    secundario.agregar('MySQL',      'http://mysql.org/')
    secundario.agregar('PostgreSQL', 'http://postgresql.org/')
    puts
    puts secundario.to_html
    puts
end
