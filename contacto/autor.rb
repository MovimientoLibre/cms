
def publicacion(dir)

    p                           = Publicacion.new
    p.directorio                = dir
    p.archivo                   = 'autor'
    p.nombre                    = 'Autor de este programa'
    p.nombre_menu               = 'Autor'
    p.fecha                     = "2006-08-01 00:00"
    p.aparece_en_pagina_inicial = false
    p.contenido                 = <<FIN_CONTENIDO
Este programa fue elaborado por *Guillermo Valdez Lozano*. Visite el sitio personal del autor en "Movimiento Libre":http://movimientolibre.com.

Puede contactarme vía correo electrónico en *guivaloz( en )movimientolibre.com*, por supuesto, sustituya "( en )" por una arroba.

Los mensajes que reciba de parte mía por correo electónico pueden estar firmados por GnuPG. Si su cliente de correo soporta la firma de mensajes (como Mozilla Thunderbird con Enigmail) podrá validar que los mensajes sean realmente enviados por mí.

Si usa GNU/Linux y tiene instalado _GnuPG_ puede bajar mi *llave pública* de los servidores de llaves por medio del comando:

<pre>
gpg --keyserver pgp.mit.edu --recv-keys 6D37A115
</pre>
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
