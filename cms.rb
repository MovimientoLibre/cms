#!/usr/bin/env ruby

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

# --------------------------
# INDIQUE EL DIRECTORIO BASE
# --------------------------

# Directorio base donde están los archivos del sitio, NO debe tener al final /
Dir.chdir('/home/guivaloz/www/ml-cms')

# -----------------------
# NO MODIFIQUE ESTA PARTE
# -----------------------

# Cargamos las librerías, NO MODIFIQUE ESTA PARTE
require 'src/clasificado.rb'
require 'src/imprenta.rb'
require 'src/menu.rb'
require 'src/menu_cantidades.rb'
require 'src/multipagina.rb'
require 'src/plantilla.rb'
require 'src/publicacion.rb'
require 'src/principal.rb'

# Inicializamos la imprenta, NO MODIFIQUE ESTE COMANDO
imprenta = Imprenta.new

# --------------------------------------------
# CONTINUE AJUSTANDO LOS SIGUIENTES PARAMETROS
# --------------------------------------------

# URL del sitio, necesario para la sindicalización, NO debe tener al final /
imprenta.url_sitio = 'http://cms.movimientolibre.com'

# Nombre del sitio web
imprenta.titulo_sitio = 'CMS de Movimiento Libre'

# Frase del sitio web
imprenta.frase_sitio = 'Script en Ruby para elaborar un sitio web'

# Descripción del sitio web
DESCRIPCION_SITIO = 'Script en Ruby para elaborar un sitio web.'

# El anuncio sirve para mostrar un evento, reunión o acontecimiento próximo
# en la parte superior de la página inicial, por defecto está vacio
# imprenta.anuncio = ''

# Arreglo con los nombres de los directorios donde se encuentran las publicaciones
imprenta.publicaciones_directorios = %w{ a_cerca descargar screenshots documentacion licencias contacto }

# Arreglo con las etiquetas de los directorios donde se encuentran las publicaciones
# Por ejemplo, un directorio llamado guia_inicio debe aparecer como "Guía de inicio"
# No hay necesidad de definir una etiqueta si el nombre del directorio es igual a la etiqueta
imprenta.publicaciones_etiquetas = { 'a_cerca' => 'A cerca', 'documentacion' => "Documentación" }

# Nombre del archivo para la página incial
PAGINA_INICIAL = 'index.html'

# Nombre del archivo para la sindicalización
ARCHIVO_RSS = 'rss.xml'

# El menu principal, use URLs absolutos
# No necesariamente tienen que ser los mismos que defina en publicaciones_directorios
# Puede agregar sus propios vínculos a otros sitios u omitir los directorios que prefiera
menu_principal = Menu.new
menu_principal.agregar('Página inicial', '/' + PAGINA_INICIAL)
menu_principal.agregar('A cerca',        '/a_cerca/')
menu_principal.agregar('Descargar',      '/descargar/')
menu_principal.agregar('Screenshots',    '/screenshots/')
menu_principal.agregar('Documentación',  '/documentacion/')
menu_principal.agregar('Licencias',      '/licencias/')
menu_principal.agregar('Contacto',       '/contacto/')
imprenta.menu_principal = menu_principal.to_html

# Opcionalmente puede mostrar la descripción en la tercer columna
# imprenta.contenido_secundario = '<p style="background: #CCC; padding: 4px; border: solid 1px gray; font-style: italic;">' + DESCRIPCION_SITIO + '</p>'

# Cantidad máxima de publicaciones que aparecerán en las páginas
imprenta.publicaciones_por_pagina_maximo = 5

# Autor por defecto, se aplica a las publicaciones que no lo tengan definido
imprenta.autor_por_defecto = 'guivaloz'

# Nombre del directorio donde se crearán los índices de cada categoría, por defecto 'categorias'
# imprenta.categorias_directorio = 'categorias'

# Nombre del directorio donde aparecerán las publicaciones por autor, por defecto 'autores'
# imprenta.autores_directorio = 'autores'

# Nombre del directorio donde se encuentran los menús extras que se cargarán, por defecto 'menus'
# imprenta.menus_directorio = 'menus'

# Si el diseño del sitio tiene 3 columnas ponga esta propiedad en verdadero, si tiene 2 en falso, por defecto true
imprenta.usar_contenido_secundario = false

# Le recomiendo ampliamente que el diseño del encabezado sea un gráfico controlable en el CSS
# esto junto con el nombre (imprenta.titulo_sitio) y la frase del sitio (imprenta.frase_sitio).
# Si necesita un gráfico más elaborado o una animación flash, entonces defínalo en la siguiente
# propiedad, al hacer esto no aparecerán el nombre y frase del sitio en el HTML de las páginas.
# imprenta.grafico_encabezado = ""

# El pie, como adivinará, es lo que aparecerá en la parte inferior de todas las páginas
imprenta.pie_html = <<FIN_PIE_HTML
<p style="font-size: smaller;">Copyright (c) 2008 Guillermo Valdez Lozano. Se otorga permiso para copiar, distribuir y/o modificar este documento<br />
El programa está protegido por la licencia <a href="/licencias/gpl-2.html">GPL versión 2</a><br />
La documentación está protegida por la licencia <a href="/licencias/gfdl.html">GFDL</a></p>
FIN_PIE_HTML

# ----------------------------------------------------------
# FIN DE LA CONFIGURACION, NO MODIFIQUE NADA DE LO QUE SIGUE
# ----------------------------------------------------------

# Pasamos estas constantes a la imprenta
imprenta.descripcion_sitio = DESCRIPCION_SITIO
imprenta.archivo_rss       = ARCHIVO_RSS

# La clase principal dirige todos el trabajo para elaborar el sitio
principal = Principal.new(imprenta, PAGINA_INICIAL, ARCHIVO_RSS)
principal.elaborar

# ---------------
# FIN DEL ARCHIVO
# ---------------
