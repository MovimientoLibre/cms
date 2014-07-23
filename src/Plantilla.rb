# encoding: utf-8
#
#  Plantilla.rb
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
# Plantilla
#
# Es la estructura básica para todas las páginas del sitio. Estas propiedades definen su contenido:
#
# * sitio_titulo          El nombre del sitio web
# * titulo                Título de la página
# * autor                 Persona que sea la autora
# * descripcion           Descripción del sitio o la página
# * claves                Claves que ayuden a los buscadores
# * rss                   Ruta relativa desde la raíz al archivo RSS, por defecto es rss.xml
# * favicon               Ruta relativa desde la raiz al archivo de imagen con el favicon
# * ruta                  Ruta relativa a la pagina HTML con la publicación para_compartir
# * imagen_previa         Ruta relativa a la imagen a usar para_compartir
# * sitio_url             URL base del sitio web
# * menu_principal        Menú principal creado por la clase del mismo nombre
# * encabezado            Código HTML que va en la parte superior
# * contenido             Código HTML con el contenido
# * contenido_secundario  Código HTML que crea una segunda columna más delgada del lado derecho
# * pie                   Código HTML que va en la parte inferior
# * javascript            Código Javascript
# * en_raiz               Si es verdadero los vínculos serán para un archivo en la raíz del sitio
# * para_compartir        Si es verdadero pondrá los metas para tajetas en Twitter/Facebook

class Plantilla

    attr_writer :sitio_titulo, :titulo, :autor, :descripcion, :claves, :rss, :favicon, :ruta, :imagen_previa, :sitio_url, :menu_principal, :encabezado, :contenido, :contenido_secundario, :pie, :javascript, :en_raiz, :para_compartir
    attr_reader :titulo

    ##
    # Inicializar

    def initialize
        @rss     = 'rss.xml'
        @en_raiz = true
    end

    ##
    # Entregar el código HTML

    def to_html
        # Si no se han definido, usar valores por defecto
        @sitio_titulo = "Sin título" if @sitio_titulo.nil?
        @titulo       = "Sin título" if @titulo.nil?
        # Acumularemos la salida en este arreglo
        a = Array.new
        a << '<!DOCTYPE html>'
        a << '<html lang="es">'
        # Tag head
        a << '<head>'
        a << '  <meta charset="utf-8">'
        a << "  <title>#@sitio_titulo - #@titulo</title>"
        a << '  <meta http-equiv="X-UA-Compatible" content="IE=edge">'
        a << '  <meta name="viewport" content="width=device-width, initial-scale=1.0">'
        a << "  <meta name=\"description\" content=\"#@descripcion\">" if not @descripcion.nil?
        a << "  <meta name=\"author\" content=\"#@autor\">" if not @autor.nil?
        a << "  <meta name=\"keywords\" content=\"#@claves\">" if not @claves.nil?
        if @para_compartir
            a << "  <meta name=\"twitter:card\" content=\"summary\">"
            a << "  <meta name=\"twitter:title\" content=\"#@titulo\">"
            a << "  <meta name=\"twitter:description\" content=\"#@descripcion\">" if not @descripcion.nil?
            a << "  <meta name=\"twitter:image\" content=\"#{@sitio_url + '/' + @imagen_previa}\">" if not @imagen_previa.nil?
            a << "  <meta name=\"twitter:url\" content=\"#{@sitio_url + '/' + @ruta}\">" if not @ruta.nil?
            a << "  <meta name=\"og:title\" content=\"#@titulo\">"
            a << "  <meta name=\"og:description\" content=\"#@descripcion\">" if not @descripcion.nil?
            a << "  <meta name=\"og:image\" content=\"#{@sitio_url + '/' + @imagen_previa}\">" if not @imagen_previa.nil?
            a << "  <meta name=\"og:url\" content=\"#{@sitio_url + '/' + @ruta}\">" if not @ruta.nil?
        end
        if @en_raiz
            a << "  <link href=\"#@favicon\" rel=\"shortcut icon\" type=\"image/x-icon\">" if not @favicon.nil?
            a << "  <link href=\"#@rss\" rel=\"alternate\" type=\"application/rss+xml\" title=\"#@sitio_titulo\" />" if not @rss.nil?
            a << '  <link href="css/bootstrap.min.css" rel="stylesheet">'
            a << '  <link href="css/morris.css" rel="stylesheet">'
            a << '  <link href="css/cms.css" rel="stylesheet">'
        else
            a << "  <link href=\"../#@favicon\" rel=\"shortcut icon\" type=\"image/x-icon\">" if not @favicon.nil?
            a << "  <link href=\"../#@rss\" rel=\"alternate\" type=\"application/rss+xml\" title=\"#@sitio_titulo\" />" if not @rss.nil?
            a << '  <link href="../css/bootstrap.min.css" rel="stylesheet">'
            a << '  <link href="../css/morris.css" rel="stylesheet">'
            a << '  <link href="../css/cms.css" rel="stylesheet">'
        end
       #a << "  <base href=\"#@sitio_url\" target=\"_blank\">" if not @sitio_url.nil?
        a << '  <!-- SOPORTE PARA IE8 -->'
        a << '  <!--[if lt IE 9]>'
        a << '  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>'
        a << '  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>'
        a << '  <![endif]-->'
        a << '</head>'
        # Tag body
        a << '<body>'
        a << @menu_principal if not @menu_principal.nil?
        a << '<div id="contenido">'
        a << '  <div class="container">'
        # Si NO hay contenido secundario
        if @contenido_secundario.nil?
            # El contenido usa todo el ancho de la página
            a << @encabezado if not @encabezado.nil?
            a << @contenido
        else
            # Sí hay contenido secundario, se usan dos columnas
            a << '    <div class="row">'
            a << '      <div class="col-md-9">'
            a << @encabezado if not @encabezado.nil?
            a << @contenido
            a << '      </div>'
            a << '      <div class="col-md-3">'
            a << '        <aside>'
            a << @contenido_secundario
            a << '        </aside>'
            a << '      </div>'
            a << '    </div>'
        end
        a << '  </div>'
        a << '</div>'
        if not @pie.nil?
            a << '<div id="pie">'
            a << ' <div class="container">'
            a << @pie
            a << '  </div>'
            a << '</div>'
        end
        a << '  <!-- CODIGO JAVASCRIPT PUESTO AL FINAL PARA QUE SE CARGUE MAS RAPIDO LA PAGINA -->'
        if @en_raiz
            a << '  <script src="js/jquery.min.js"></script>'
            a << '  <script src="js/bootstrap.min.js"></script>'
            a << '  <script src="js/raphael-min.js"></script>'
            a << '  <script src="js/morris.min.js"></script>'
        else
            a << '  <script src="../js/jquery.min.js"></script>'
            a << '  <script src="../js/bootstrap.min.js"></script>'
            a << '  <script src="../js/raphael-min.js"></script>'
            a << '  <script src="../js/morris.min.js"></script>'
        end
        a << @javascript if not @javascript.nil?
        a << '</body>'
        a << '</html>'
        # Entregar
        a.join("\n")
    end

end

##
# Testing
#
# Ejecute $ ruby Plantilla.rb para mostrar en la terminal una prueba de esta clase.

if __FILE__ == $0
    pagina             = Plantilla.new
    pagina.en_raiz     = true
    pagina.titulo      = "Página de prueba"
    pagina.descripcion = "Esta es una prueba simple"
    pagina.autor       = "Su nombre completo"
    pagina.claves      = "GNU, Software Libre, GPL"
    pagina.favicon     = "imagenes/favicon.png"
    pagina.contenido   = <<FINAL
<h4>Preámbulo</h4>
<p>Las licencias de la mayoría de los programas de cómputo están diseñadas para coartar la libertad de compartirlos y cambiarlos. Por el contrario, la Licencia Pública General <span class="caps">GNU</span> pretende garantizar esa libertad de compartir y cambiar Software Libre a fin de asegurar que el software sea libre para todos sus usuarios. Esta Licencia Pública General se aplica a la mayor parte del software de la Free Software Foundation y a cualquier otro programa cuyos autores se comprometan a usarla. (Algunos otros paquetes de software de la Free Software Foundation están protegidos bajo la Licencia Pública General de Librería <span class="caps">GNU</span>.) Esta última licencia también puede aplicarse a nuevos paquetes de software.</p>
<p>Cuando se hable de Software Libre, se hace referencia a libertad, no a precio. Las Licencias Públicas Generales <span class="caps">GNU</span> están diseñadas para asegurar que el usuario tenga libertad de distribuir copias de Software Libre (y de recibir una remuneración por este servicio, si así se desea), que ese mismo usuario reciba el código fuente o que tenga la posibilidad de recibirlo, si así lo desea, que pueda cambiar o modificar el software o utilice sólo partes del mismo en nuevos paquetes de Software Libre; y que dicho usuario tenga pleno conocimiento de estas facultades.</p>
<p>Con la finalidad de proteger los derechos antes mencionados, es necesario establecer restricciones que prohíban a cualquiera negar esos derechos o pedir la renuncia a los mismos. Estas restricciones se traducen en ciertas responsabilidades para el usuario que distribuye o modifica copias de software protegido bajo estas licencias.</p>
<p>Por ejemplo, si una persona distribuye copias de un paquete de Software Libre protegido bajo esta licencia, ya sea de manera gratuita o a cambio de una contraprestación, esa persona debe dar a los receptores de esa distribución todos y cada uno de los derechos que él o ella misma tenga. Asimismo, esa persona debe asegurarse que dichos receptores reciban o tengan la posibilidad de recibir el código fuente. De igual manera, debe mostrarles esta licencia a fin de que tengan conocimiento de los derechos de los que son titulares.</p>
<p>La protección que otorga la presente licencia se hace de dos maneras simultáneas: (1) se otorga protección al software bajo la ley de copyright, y (2) se ofrece la protección bajo esta licencia, la cual otorga permiso legal para copiar, distribuir y/o modificar el software.</p>
FINAL
    pagina.contenido_secundario = <<FINAL
<p>Esta es una traducción no oficial al español de la <span class="caps">GNU</span> General Public License. No ha sido publicada por la Free Software Foundation, y no establece legalmente las condiciones de distribución para el software que usa la <span class="caps">GNU</span> <span class="caps">GPL</span>. Estas condiciones se establecen solamente por el texto original, en inglés, de la <span class="caps">GNU</span> <span class="caps">GPL</span>. Sin embargo, esperamos que esta traducción ayude a los hispanoparlantes a entender mejor la <span class="caps">GNU</span> <span class="caps">GPL</span>.</p>
FINAL
    puts
    puts pagina.to_html
    puts
end
