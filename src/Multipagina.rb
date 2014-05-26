# encoding: utf-8
#
#  Multipagina.rb
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
# Multipagina
#
# Prepara un gran conjunto de publicaciones para que ocupen muchas páginas con sus breves.
# * titulo                          Título de la página
# * publicaciones_por_pagina_maximo Es la cantidad de publicaciones por página, por defecto es cinco.
# * directorio                      Directorio donde será guardado el archivo, por defecto es '.'.
# * nombre                          Nombre común del archivo, sin la extensión, por defecto es 'index'.
# * en_raiz                         Verdadero si el archivo va a la raiz del sitio web. Debe ser verdadero cuando se hacen las páginas de inicio.
# * en_otro                         Verdadero si el archivo va a OTRO lugar como al directorio autores, categorias, etc.

class Multipagina

    attr_writer :titulo, :publicaciones_por_pagina_maximo, :directorio, :nombre, :en_raiz, :en_otro

    def initialize
        @publicaciones_por_pagina_maximo = 5
        @directorio                      = '.'
        @nombre                          = 'index'
        @publicaciones                   = Array.new
        @en_raiz                         = false
        @en_otro                         = false
    end

    ##
    # Agregar una publicación

    def agregar(pub)
        @publicaciones.push(pub)
    end

    ##
    # Páginas
    #
    # Entrega un hash con los contenidos de la forma 'ruta' => { 'contenido' => '...', 'javascript' => '...' }
    # Como se nota, separa el contenido del javascript para que se ponga al final de la página.

    def paginas
        # No hace nada si no hay publicaciones
        return if @publicaciones.length == 0
        # Iniciamos las variables que irán acumulando la información
        paginas    = Array.new
        contador   = 0
        contenido  = Array.new
        javascript = Array.new
        # Bucle por las publicaciones
        @publicaciones.each do |pub|
            # Pasamos las banderas
            pub.en_raiz = @en_raiz
            pub.en_otro = @en_otro
            # Acumularemos los breves de las publicaciones
            contenido.push(pub.breve_html)
            javascript.push(pub.javascript) if pub.javascript != ''
            # Cada vez que se alcanze el maximo, cambiamos de página
            if contenido.length >= @publicaciones_por_pagina_maximo
                # Determinar el nombre del archivo
                contador += 1
                if contador == 1
                    vinculo = "#{@nombre}.html"             # Es la primer página
                else
                    vinculo = "#{@nombre}-#{contador}.html" # A partir de la segunda página se anexa su número
                end
                # Acumular página
                paginas[contador] = {
                    'ruta'       => "#{@directorio}/#{vinculo}",
                    'contenido'  => contenido.join("\n"),
                    'javascript' => javascript.join("\n"),
                    'vinculo'    => vinculo}
                # Reiniciamos los arreglos acumuladores
                contenido  = Array.new
                javascript = Array.new
            end
        end
        # Si quedan contenidos, elaboramos la última página
        if contenido.length > 0
            # Determinar el nombre del archivo
            contador += 1
            if contador == 1
                vinculo = "#{@nombre}.html"             # Es la primer página
            else
                vinculo = "#{@nombre}-#{contador}.html" # Es la segunda o posterior página
            end
            # Agregar página
            paginas[contador] = {
                'ruta'       => "#{@directorio}/#{vinculo}",
                'contenido'  => contenido.join("\n"),
                'javascript' => javascript.join("\n"),
                'vinculo'    => vinculo}
        end
        # En este hash vamos a acumular lo que se va a entregar
        salida = Hash.new
        # Al final del contenido de cada página, pondremos el paginador, si hay dos o más páginas
        if contador > 1
            # Hay dos o más paginas
            (1..contador).each do |i|
                # En este arreglo acumularemos el código del paginador
                paginador = Array.new
                paginador.push('<ul class="pagination">')
                paginador.push("  <li><a href=\"#{paginas[i-1]['vinculo']}\">&laquo;</a></li>") if i > 1
                (1..contador).each do |j|
                    if i == j
                        # Pagina actual, no tiene vinculo
                        paginador.push("  <li class=\"active\"><a href=\"#\">#{j} <span class=\"sr-only\">(current)</span></a></li>")
                    else
                        # Vínculos a las otras páginas, están en el mismo directorio
                        paginador.push("  <li><a href=\"#{paginas[j]['vinculo']}\">#{j}</a></li>")
                    end
                end
                paginador.push("  <li><a href=\"#{paginas[i+1]['vinculo']}\">&raquo;</a></li>") if i < contador
                paginador.push('</ul>')
                # En las páginas va el título, el contenido y el paginador
                # Acumular, note que al contenido se le agrega el paginador
                salida[paginas[i]['ruta']] = {
                    'contenido'  => "<header><h1>#@titulo</h1></header>\n" + paginas[i]['contenido'] + "\n" + paginador.join("\n"),
                    'javascript' => paginas[1]['javascript']}
            end
        else
            # En la página va el título y el contenido
            # Solo es una página, entonces NO habrá paginador
            salida[paginas[1]['ruta']] = {
                'contenido'  => "<header><h1>#@titulo</h1></header>\n" + paginas[1]['contenido'],
                'javascript' => paginas[1]['javascript']}
        end
        # Entregar
        salida
    end

end
