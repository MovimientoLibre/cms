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
# Clase Principal
#
class Principal

    #
    # Recibir los parametros
    #
    def initialize(imprenta, pagina_inicial, archivo_rss)
        @imprenta       = imprenta
        @pagina_inicial = pagina_inicial
        @archivo_rss    = archivo_rss
    end

    #
    # Funcion para crear los archivos
    #
    # Si existe previamente el archivo lo elimina
    # Por cada archivo creado se manda una mensaje a la terminal
    #
    def crear_archivo(archivo, contenido)
        File.delete(archivo) if File.file?(archivo)
        f = File.new(archivo, "w")
        f.puts contenido
        f.close
        puts "Listo #{archivo}"
    end

    #
    # Elaborar todo el sitio, enviando mensajes a la terminal
    #
    def elaborar
        puts 'Alimentándose...'
        puts @imprenta.alimentarse
        puts
        puts 'Elaborando el reporte de las publicaciones encontradas...'
        puts @imprenta.reporte
        puts
        puts 'Elaborando las páginas de cada publicación...'
        @imprenta.paginas_publicaciones.each { |archivo, contenido| crear_archivo(archivo, contenido) }
        puts
        puts 'Elaborando los índices de cada uno de los directorios...'
        puts 'ERROR: No hay' if @imprenta.paginas_directorios.length == 0
        @imprenta.paginas_directorios.each { |archivo, contenido| crear_archivo(archivo, contenido) }
        puts
        puts 'Elaborando las páginas de las categorías...'
        @imprenta.paginas_categorias.each { |archivo, contenido| crear_archivo(archivo, contenido) }
        puts
        puts 'Elaborando las páginas de los autores...'
        @imprenta.paginas_autores.each { |archivo, contenido| crear_archivo(archivo, contenido) }
        puts
        puts 'Elaborando el archivo XML para la sindicalización...'
        crear_archivo(@archivo_rss, @imprenta.sindicalizacion)
        puts
        puts 'Elaborando página inicial...'
        crear_archivo(@pagina_inicial, @imprenta.pagina_inicial)
        puts
        puts 'Elaborando el reporte de las publicaciones encontradas...'
        puts @imprenta.reporte
        puts
        puts "Script terminado."
    end

end
