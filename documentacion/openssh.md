Uso del OpenSSH para este CMS
=============================

Fecha: 2008-05-13 08:00
Categorías: OpenSSH

OpenSSH permite establecer comunicaciones cifradas entre su equipo y su servidor. Aquí muestro algunos comandos tanto para copiar como para ejecutar remotamente el script.

<!-- break -->

#### Subir las últimas publicaciones a su servidor

Si tiene comunicación con su servidor web vía OpenSSH puede usar este comando para sólo copiar los nuevos archivos y los que haya modificado.

    $ cd ~/www
    $ rsync -avz -e ssh * suusuario@suservidor.com:/home/suusuario/www/

#### Para ejecutar remotamente el script del CMS en su servidor

Debe tener instalado Ruby con Redcloth y Kramdown para que funcione:

    $ ssh suusuario@suservidor.com /home/suusuario/www/cms.rb
