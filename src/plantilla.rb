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
        #~ a << '  <meta name="description" content="">'
        #~ a << '  <meta name="author" content="">'
        a << '  <link rel="shortcut icon" href="/favicon.ico">'
        a << "  <link rel=\"alternate\" type=\"application/rss+xml\" title=\"#@titulo_sitio\" href=\"/#@archivo_rss\" />" if @archivo_rss != nil
        a << "  <title>#@titulo_sitio - #{titulo}</title>"
        a << '  <!-- TWITTER BOOTSTRAP INICIA -->'
        a << '  <link href="/css/bootstrap.min.css" rel="stylesheet">'
        a << '  <!-- ESTILOS CSS PROPIOS DE ESTE CMS -->'
        a << '  <link href="/css/cms.css" rel="stylesheet">'
        a << '  <!-- SOPORTE PARA IE8 -->'
        a << '  <!--[if lt IE 9]>'
        a << '  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>'
        a << '  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>'
        a << '  <![endif]-->'
        a << '  <!-- TWITTER BOOTSTRAP TERMINA -->'
        a << '</head>'
        a << '<body>'
        a << '  <!-- MENU PRINCIPAL -->'
        if @menu_principal != nil
            a << '  <div class="navbar navbar-default navbar-fixed-top menu-principal" role="navigation">'
            a << '    <div class="container">'
            a << '      <div class="navbar-header">'
            a << '        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">'
            a << '          <span class="sr-only">Toggle navigation</span>'
            a << '          <span class="icon-bar"></span>'
            a << '          <span class="icon-bar"></span>'
            a << '          <span class="icon-bar"></span>'
            a << '        </button>'
            a << "        <a class=\"navbar-brand\" href=\"/index.html\">#@titulo_sitio</a>"
            a << '      </div>'
            a << '    <div class="navbar-collapse collapse">'
            a << @menu_principal
            a << '    </div>'
            a << '    </div>'
            a << '  </div>'
        end
        a << '  <div class="container">'
        a << '    <!-- JUMBOTRON -->'
        if @grafico_encabezado != nil
            a << @grafico_encabezado
        else
            a << '    <div class="jumbotron">'
            a << "      <h2>#@titulo_sitio</h2>"
            a << "      <p>#@frase_sitio</p>"
            a << '    </div>'
        end
        a << '    <!-- CONTENIDO -->'
        a << "    <h1>#{titulo}</h1>"
        a << contenido
        if @contenido_secundario != nil
            a << '    <!-- CONTENIDO SECUNDARIO -->'
            a << '    <div class="panel panel-default">'
            a << '      <div class="panel-body">'
            a << @contenido_secundario
            a << '      </div>'
            a << '    </div>'
        end
        if @menu_secundario != nil
            a << '    <!-- MENU SECUNDARIO -->'
            a << '    <div class="panel panel-default menu-secundario">'
            a << '      <div class="panel-body">'
            a << @menu_secundario
            a << '      </div>'
            a << '    </div>'
        end
        if @pie_html != nil
            a << '    <!-- PIE -->'
            a << '    <div class="well">'
            a << @pie_html
            a << '    </div>'
        end
        a << '  </div>'
        a << '  <!-- CODIGO JAVASCRIPT DE BOOTSTRAP PUESTO AL FINAL PARA QUE SE CARGUE MAS RAPIDO LA PAGINA -->'
        a << '  <script src="/js/jquery-1.10.2.min.js"></script>'
        a << '  <script src="/js/bootstrap.min.js"></script>'
        a << '</body>'
        a << '</html>'
        a.join("\n")
    end

end