############################################################################
#    Copyright (C) 2013 by Guillermo Valdes Lozano                         #
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
# Clase Plantilla
#
class Plantilla

    #
    # Propiedades modificables
    #
    attr_writer :titulo_sitio, :frase_sitio, :grafico_encabezado, :menu_principal, :menu_secundario, :contenido_secundario, :pie_html, :archivo_rss

    #
    # Valores por defecto de las propiedades
    #
    def initialize
        # Propiedades modificables
        @titulo_sitio = 'Título del sitio'
        @frase_sitio  = 'Descripción del sitio'
    end

    #
    # Entrega el HTML de la página web
    #
    public
    def to_html(titulo, contenido)
        a = Array.new
        a << '<!DOCTYPE html>'
        a << '<html lang="en">'
        a << '<head>'
        a << '  <meta charset="utf-8">'
        a << '  <meta http-equiv="X-UA-Compatible" content="IE=edge">'
        a << '  <meta name="viewport" content="width=device-width, initial-scale=1.0">'
        a << '  <meta name="description" content="">'
        a << '  <meta name="author" content="">'
        a << '  <link rel="shortcut icon" href="favicon.ico">'
        a << "  <title>#@titulo_sitio - #{titulo}</title>"
        a << '  <!-- Bootstrap core CSS -->'
        a << '  <link href="css/bootstrap.css" rel="stylesheet">'
        a << '  <!-- Custom styles for this template -->'
        a << '  <link href="css/navbar-fixed-top.css" rel="stylesheet">'
        a << '  <!-- Estilos de cascada del CMS Movimiento Libre -->'
        a << '  <link href="css/cmsmovimientolibre.css" rel="stylesheet">'
        a << '  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->'
        a << '  <!--[if lt IE 9]>'
        a << '  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>'
        a << '  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>'
        a << '  <![endif]-->'
        a << '</head>'
        #~ a << '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'
        #~ a << '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">'
        #~ a << '<head>'
        #~ a << "  <title></title>"
        #~ a << '  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'
        #~ a << '  <link rel="stylesheet" type="text/css" media="print" href="/css/core/print.css" />'
        #~ a << '  <link rel="stylesheet" type="text/css" media="screen" href="/css/screen.css" />'
        #~ a << '  <link rel="shortcut icon" type="image/x-icon" href="favicon.ico" />'
        #~ a << "  <link rel=\"alternate\" type=\"application/rss+xml\" title=\"#@titulo_sitio\" href=\"#@archivo_rss\" />" if @archivo_rss != nil
        #~ a << '</head>'
        a << '<body>'
        a << '<div id="page">'
        a << '  <div id="header">'
        a << '      <div class="wrapper">'
        if @grafico_encabezado != nil
            a << "          #@grafico_encabezado"
        else
            a << "          <h1 class=\"titulo\">#@titulo_sitio</h1>"
            a << "          <p class=\"frase\">#@frase_sitio</p>"
        end
        a << '      </div>'
        a << '  </div>'
        a << '  <div id="content">'
        a << '      <div id="content_wrapper">'
        a << '          <div id="main" class="content">'
        a << '              <div class="wrapper">'
        a << "                  <h2>#{titulo}</h2>"
        a << "                  #{contenido}"
        a << '              </div>'
        a << '          </div>'
        if @contenido_secundario != nil
            a << '          <!-- Contenido secundario -->'
            a << '          <div id="sub" class="nav">'
            a << "              <div class=\"wrapper\">#@contenido_secundario</div>"
            a << '          </div>'
        end
        if @menu_secundario != nil
            a << '          <!-- Menú secundario -->'
            a << '          <div id="nav-sec" class="nav">'
            a << "              <div class=\"wrapper\">#@menu_secundario</div>"
            a << '          </div>'
        end
        a << '      </div>'
        if @menu_principal != nil
            a << '      <!-- Menú principal -->'
            a << '      <div id="nav-pri" class="nav">'
            a << "          <div class=\"wrapper\">#@menu_principal</div>"
            a << '      </div>'
        end
        if @menu_lenguajes != nil
            a << '      <!-- Menú de lenguajes -->'
            a << '      <div id="nav-lang" class="nav">'
            a << "          <div class=\"wrapper\">#@menu_lenguajes</div>"
            a << '      </div>'
        end
        a << '      <div id="extradiv1" class="extradiv"></div>'
        a << '      <div id="extradiv2" class="extradiv"></div>'
        a << '  </div>'
        if @pie_html != nil
            a << '  <div id="footer">'
            a << "      <div class=\"wrapper\">#@pie_html</div>"
            a << '  </div>'
        end
        a << '</div>'
        a << '</body>'
        a << '</html>'
        a.join("\n")
    end

end
