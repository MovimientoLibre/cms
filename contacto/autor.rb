
def publicacion(dir)

    p                           = Publicacion.new
    p.directorio                = dir
    p.archivo                   = 'autor'
    p.nombre                    = 'Autor de este programa'
    p.nombre_menu               = 'Autor'
    p.fecha                     = "2006-08-01 00:00"
    p.aparece_en_pagina_inicial = false
    p.contenido                 = <<FIN_CONTENIDO
Este programa fue elaborado por *Guillermo Valdés Lozano*. Visite el sitio personal del autor en "Movimiento Libre":http://movimientolibre.com.

Puede contactarme vía correo electrónico en *guivaloz( en )movimientolibre.com*, por supuesto, sustituya "( en )" por una arroba.
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
