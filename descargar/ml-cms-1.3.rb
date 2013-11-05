
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'ml-cms-1.3'
    p.nombre      = 'Descargar la versión 1.3'
    p.nombre_menu = 'Descargar Ver. 1.3'
    p.fecha       = "2008-05-16 18:30"
    p.categorias  = ['Versiones']
    p.contenido   = <<FIN_CONTENIDO
Este sitio web es elaborado con este script. Al descargar el archivo comprimido estará bajando todo el contenido de este sitio; esto le ayudará a comprender mejor su funcionamiento.

|=. !/imagenes/icono-tgz.png(Descargar la versión 1.3)!:http://cms.movimientolibre.com/descargar/cms-ml-1.3-2008-05-16.tar.gz |
|=. "Descargar la versión 1.3 al 16/mayo/2008":http://cms.movimientolibre.com/descargar/cms-ml-1.3-2008-05-16.tar.gz |

h3. Novedades de esta versión

* Nuevo _framework_ para los CSS. Elaborado por "WYMstyle":http://www.wymstyle.org/en/ el cual da más versatilidad en el diseño y claridad el archivo CSS.
* Numeración de páginas. Cuando la cantidad de publicaciones excede el máximo configurado, las publicaciones son distribuidas en dos o más páginas y aparecen vínculos (con los números de página) a las páginas en la parte inferior.
* Menú de autores. Que junto con los menús "Últimas publicaciones" y "Categorías" forman el menú secundario.
* Contenido con dos o tres columnas. Gracias al "WYMstyle":http://www.wymstyle.org/en/ puede configurar que el sitio muestre dos columnas (Menú|Principal) o tres (Menú|Principal|Menú).
* Páginas web elaboradas bajo el estándar "XHTML":http://es.wikipedia.org/wiki/XHTML strict.
* Configuración en un único archivo. Las librerías se mantienen iguales para varios sitios.
* Muchas mejoras más que podrá ver en la configuración, dentro del script ejecutable.

h3. Cambios que debe hacer si va a migrar de una versión anterior

* Debe adaptar su diseño (archivo CSS) al nuevo _framework_.
* Debe cambiar los menús personalizados al nuevo formato de instrucciones.

No hay problemas de compatibilidad para las publicaciones, es decir que pueden usarse los mismos archivos.
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
