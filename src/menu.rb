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
	# Valores por defecto de las propiedades
	#
	def initialize
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
	# Para XHTML strict debemos de respetar el correcto encestamiento...
	# <ul>
	# <li>Coffee</li>
	# <li>Tea
	#   <ul>
	#     <li>Black tea</li>
	#     <li>Green tea</li>
	#   </ul>
	# </li>
	# <li>Milk</li>
	# </ul>
	#
	def to_html
		if @encabezado_actual == ''
			a = Array.new
			a << '<ul>'
			@elementos.each do |e|
				if e['url'] == ''
					a << "	<li>#{e['etiqueta']}</li>"
				else
					a << "	<li><a href=\"#{e['url']}\">#{e['etiqueta']}</a></li>"
				end
			end
			a << '</ul>'
			a.join("\n")
		else
			a = Array.new
			a << '<ul>'
			@encabezados.each do |encabezado|
				b = Array.new
				@elementos.each do |e|
					if e['encabezado'] == encabezado['etiqueta']
						if e['url'] == ''
							b << "		<li>#{e['etiqueta']}</li>"
						else
							b << "		<li><a href=\"#{e['url']}\">#{e['etiqueta']}</a></li>"
						end
					end
				end
				if b.length > 0
					if encabezado['url'] == ''
						a << "	<li>#{encabezado['etiqueta']}"
					else
						a << "	<li><a href=\"#{encabezado['url']}\">#{encabezado['etiqueta']}</a>"
					end
					a << '	<ul>'
					b.each { |c| a << c }
					a << '	</ul>'
					a << '	</li>'
				elsif encabezado['url'] == ''
					a << "	<li>#{encabezado['etiqueta']}</li>"
				else
					a << "	<li><a href=\"#{encabezado['url']}\">#{encabezado['etiqueta']}</a></li>"
				end
			end
			a << '</ul>'
			a.join("\n")
		end
	end

end
