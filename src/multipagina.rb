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
        @directorio                      = directorio
        @nombre                          = nombre
        @publicaciones                   = Array.new
        @publicaciones_por_pagina_maximo = 5
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
                    ruta = "#{@directorio}/#{@nombre}.html"
                else
                    ruta = "#{@directorio}/#{@nombre}-#{num_pag}.html"
                end
                paginas[num_pag] = { 'ruta' => ruta, 'contenido' => contenido.join("\n")}
                # Comenzamos una nueva
                contenido = Array.new
            end
        end
        # Si quedan contenidos, terminamos la última página
        if contenido.length > 0
            num_pag += 1
            if num_pag == 1
                ruta = "#{@directorio}/#{@nombre}.html"
            else
                ruta = "#{@directorio}/#{@nombre}-#{num_pag}.html"
            end
            paginas[num_pag] = { 'ruta' => ruta, 'contenido' => contenido.join("\n")}
        end
        # Necesitamos entregar un hash de la forma Ruta => Contenido
        resultado = Hash.new
        # Al final de cada página, pondremos los vínculos a las páginas
        if num_pag > 1
            (1..num_pag).each do |i|
                vinculos = Array.new
                vinculos.push('<ul class="pagination">')
                vinculos.push("  <li><a href=\"/#{paginas[i-1]['ruta']}\">&laquo;</a></li>") if i > 1
                # vinculos.push("<a href=\"/#{paginas[i-1]['ruta']}\">Anterior</a>") if i > 1
                (1..num_pag).each do |j|
                    if i == j
                        vinculos.push("  <li class=\"active\"><a href=\"#\">#{j} <span class=\"sr-only\">(current)</span></a></li>")
                        #vinculos.push(j)
                    else
                        vinculos.push("  <li><a href=\"/#{paginas[j]['ruta']}\">#{j}</a></li>")
                        #vinculos.push("<a href=\"/#{paginas[j]['ruta']}\">#{j}</a>")
                    end
                end
                vinculos.push("  <li><a href=\"/#{paginas[i+1]['ruta']}\">&raquo;</a></li>") if i < num_pag
                # vinculos.push("<a href=\"/#{paginas[i+1]['ruta']}\">Siguiente</a>") if i < num_pag
                vinculos.push('</ul>')
                resultado[paginas[i]['ruta']] = "#{paginas[i]['contenido']}\n#{vinculos.join("\n")}"
            end
        else
            resultado[paginas[1]['ruta']] = paginas[1]['contenido']
        end
        # Entregamos
        resultado
    end

end

=begin
<ul class="pagination">
  <li><a href="#">&laquo;</a></li>
  <li><a href="#">1</a></li>
  <li><a href="#">2</a></li>
  <li><a href="#">3</a></li>
  <li><a href="#">4</a></li>
  <li><a href="#">5</a></li>
  <li><a href="#">&raquo;</a></li>
</ul>
=end
