
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'textile'
    p.nombre      = 'Los contenidos se escriben en Textile'
    p.nombre_menu = 'Textile'
    p.fecha       = "2008-05-13 08:00"
    p.categorias  = ['Textile']
    p.contenido   = <<FIN_CONTENIDO
h4. A cerca de Textile

"Textile":http://en.wikipedia.org/wiki/Textile_%28markup_language%29 es un lenguaje de marcado ligero originalmente desarrollado por Dean Allen como "generador de texto web humano".

Textile convierte el texto marcado como tal en XHTML válido. También convierte algunos caracteres a su código HTML y les hace mejoras; como las comillas dobles a comillas dobles que abren al inicio y comillas dobles que cierran al final.

Textile es distribuido bajo la "Licencia BSD":http://en.wikipedia.org/wiki/BSD_licenses

<!-- break -->

h4. Textile en este CMS

Este script espera que el contenido de cada publicación esté hecho en Textile.

h4. Referencia de Textile

Le recomiendo la página "A Textile Reference":http://hobix.com/textile/ es muy útil.

En "Textism: Tools: Textile":http://www.textism.com/tools/textile/ encontrará un convertidor de Textile a HTML para probar sus textos.
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
