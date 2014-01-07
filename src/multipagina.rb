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
# Clase Multipagina
#
class Multipagina

    #
    # Propiedades modificables
    #
    attr_writer :publicaciones_por_pagina_maximo

    #
    # Valores por defecto de las propiedades
    #
    def initialize(directorio, nombre)
        # Propiedades modificables
        @publicaciones_por_pagina_maximo = 5
        # Propiedades no modificables
        @directorio    = directorio
        @nombre        = nombre
        @publicaciones = Array.new
    end

    #
    # Agregar
    #
    def agregar(pub)
        @publicaciones.push(pub)
    end

    #
    # Páginas
    #
    # Entrega un hash con los contenidos de la forma Ruta_Archivo => Contenido
    #
    def paginas
        # No hace nada si no hay publicaciones
        return if @publicaciones.length == 0
        # Iniciamos las variables
        paginas   = Array.new
        num_pag   = 0
        contenido = Array.new
        # Bucle
        @publicaciones.each do |pub|
            # Juntaremos los breves de las publicaciones
            contenido.push(pub.breve)
            # Cada vez que se alcanze el maximo, cambiamos de página
            if contenido.length >= @publicaciones_por_pagina_maximo
                # Almacenamos la página
                num_pag += 1
                if num_pag == 1
                    vinculo = "#{@nombre}.html"                # Es el vínculo relativo para los números de páginas
                else
                    vinculo = "#{@nombre}-#{num_pag}.html"     # Es el vínculo relativo para los números de páginas
                end
                ruta             = "#{@directorio}/#{vinculo}" # Es donde este script va crear el archivo HTML
                paginas[num_pag] = { 'ruta' => ruta, 'contenido' => contenido.join("\n"), 'vinculo' => vinculo}
                # Comenzamos una nueva paǵina
                contenido = Array.new
            end
        end
        # Si quedan contenidos, terminamos la última página
        if contenido.length > 0
            num_pag += 1
            if num_pag == 1
                vinculo = "#{@nombre}.html"                # Es el vínculo relativo para los números de páginas
            else
                vinculo = "#{@nombre}-#{num_pag}.html"     # Es el vínculo relativo para los números de páginas
            end
            ruta             = "#{@directorio}/#{vinculo}" # Es donde este script va crear el archivo HTML
            paginas[num_pag] = { 'ruta' => ruta, 'contenido' => contenido.join("\n"), 'vinculo' => vinculo}
        end
        # Necesitamos entregar un hash de la forma Ruta => Contenido
        resultado = Hash.new
        # Al final de cada página, pondremos los vínculos a las páginas
        if num_pag > 1
            (1..num_pag).each do |i|
                # Hay dos o más paginas. Elaboramos los vínculos a las páginas
                paginador = Array.new
                paginador.push('<ul class="pagination">')
                paginador.push("  <li><a href=\"#{paginas[i-1]['vinculo']}\">&laquo;</a></li>") if i > 1
                (1..num_pag).each do |j|
                    if i == j
                        paginador.push("  <li class=\"active\"><a href=\"#\">#{j} <span class=\"sr-only\">(current)</span></a></li>") # Pagina actual, no tiene vinculo
                    else
                        paginador.push("  <li><a href=\"#{paginas[j]['vinculo']}\">#{j}</a></li>") # Vínculos a las otras páginas, están en el mismo directorio
                    end
                end
                paginador.push("  <li><a href=\"#{paginas[i+1]['vinculo']}\">&raquo;</a></li>") if i < num_pag
                paginador.push('</ul>')
                # Agregamos los vínculos de las páginas después del contenido
                resultado[paginas[i]['ruta']] = "#{paginas[i]['contenido']}\n#{paginador.join("\n")}"
            end
        else
            # Solo hay una página
            resultado[paginas[1]['ruta']] = paginas[1]['contenido']
        end
        # Entregamos
        resultado
    end

end
