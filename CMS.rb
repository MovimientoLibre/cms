# encoding: utf-8
#
#  CMS.rb
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
# Si gusta, puede descomentar el cambio al directorio donde va a tener este sitio web.
# Dir.chdir('/home/usuario/Documentos/GitHub/cms')

##
# Cargar los archivos con las clases necesarias

require './src/Imprenta.rb'
require './src/Menu.rb'
require './src/MenuPrincipal.rb'
require './src/MenuSecundario.rb'
require './src/MenuSecundarioContando.rb'
require './src/Multipagina.rb'
require './src/Plantilla.rb'
require './src/Publicacion.rb'

##
# CMS es una extensión de Imprenta.
#
# Haga las modificaciones necesarias para personalizar su sitio web.

class CMS < Imprenta

    ##
    # Inicializar

    def initialize
        super
        # Modifique estas propiedades
        @sitio_titulo                    = "CMS de Movimiento Libre"
        @sitio_descripcion               = "Administrador de contenidos programado con Ruby para crear un sitio web con páginas estáticas."
        @sitio_url                       = "http://cms.movimientolibre.com"        # No use diagonal al final
        @autor_por_defecto               = "guivaloz"                              # El autor por defecto para las publicaciones que no lo tengan definido
        @publicaciones_directorios       = %w{ contacto documentacion licencias }  # Los directorios que contenen las publicaciones
        @publicaciones_etiquetas         = { 'documentacion' => 'Documentación' }  # Si hay que usar una etiqueta diferente para el directorio
        @publicaciones_por_pagina_maximo = 8                                       # Por defecto se ponen 5 publicaciones por página, aquí lo cambiamos a 8
        # Prepare el menu principal
        @menu_principal              = MenuPrincipal.new
        @menu_principal.sitio_titulo = @sitio_titulo
        @menu_principal.agregar('Documentación',  'documentacion/index.html')
        @menu_principal.agregar('Licencias',      'licencias/index.html')
        @menu_principal.agregar('Contacto',       'contacto/index.html')
        @menu_principal.agregar_derecha('GitHub', 'https://github.com/MovimientoLibre/cms')
        @menu_principal.agregar_derecha('RSS',    'rss.xml')
        # Preparar plantilla
        @plantilla              = Plantilla.new
        @plantilla.sitio_titulo = @sitio_titulo
        @plantilla.sitio_url    = @sitio_url
        @plantilla.encabezado   = <<FINAL
            <div class="jumbotron">
                <h1>#@sitio_titulo</h1>
                <p>#@sitio_descripcion</p>
            </div>
FINAL
        @plantilla.pie          = <<FINAL
            <p>
                Copyright (c) 2006-2014 Guillermo Valdés Lozano. Se otorga permiso para copiar, distribuir y/o modificar este documento.<br>
                El programa está protegido por la licencia <a href="http://cms.movimientolibre.com/licencias/gpl-2.html">GPL versión 2</a>.<br>
                La documentación está protegida por la licencia <a href="http://cms.movimientolibre.com/licencias/gfdl.html">GFDL</a>.
            </p>
FINAL
    end

    ##
    # Construir sitio

    def construir
        # Construir
        puts "Alimentándose..."
        puts alimentarse
        puts clasificar_autores
        puts clasificar_categorias
        puts preparar_menu_ultimas_publicaciones
        # Preparar plantilla para archivos que NO estarán en la raíz
        @plantilla.contenido_secundario = leer_archivo('inc/descargar.html') + @menu_categorias.to_html + @menu_autores.to_html + @menu_ultimas_publicaciones.to_html
        @plantilla.menu_principal       = @menu_principal.to_html
        # Crear archivos que NO estarán en la raíz
        puts "Creando publicaciones..."
        paginas_publicaciones.each { |archivo, contenido| puts crear_archivo(archivo, contenido) }
        puts "Creando páginas de los directorios..."
        paginas_directorios.each   { |archivo, contenido| puts crear_archivo(archivo, contenido) }
        puts "Creando páginas de los autores..."
        paginas_autores.each       { |archivo, contenido| puts crear_archivo(archivo, contenido) }
        puts "Creando páginas de las categorías..."
        paginas_categorias.each    { |archivo, contenido| puts crear_archivo(archivo, contenido) }
        # Preparar la plantilla para archivos que SI van a estar en la raíz
        @plantilla.contenido_secundario = leer_archivo('inc/descargar.html') + @menu_categorias.to_html(true) + @menu_autores.to_html(true) + @menu_ultimas_publicaciones.to_html(true)
        @plantilla.menu_principal       = @menu_principal.to_html(true)
        # Crear archivos para la raíz
        puts "Creando páginas iniciales..."
        paginas_iniciales.each     { |archivo, contenido| puts crear_archivo(archivo, contenido) }
        puts "Creando sindicalización..."
        puts crear_archivo('rss.xml', sindicalizacion)
    end

end

##
# Ejecutar construir

cms = CMS.new
cms.construir
puts "Su sitio web está listo :-)"
