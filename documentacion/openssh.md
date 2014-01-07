Uso del OpenSSH para este CMS
=============================

Fecha: 2008-05-13 08:00
Categorías: OpenSSH

#### Para subir las últimas publicaciones a su servidor

<pre>
$ rsync -avz /home/guivaloz/www/ml-cms/ -e ssh guivaloz@movimientolibre.com:/home/guivaloz/www/ml-cms/
</pre>

#### Para ejecutar el script en su servidor

<pre>
$ ssh guivaloz@movimientolibre.com /home/guivaloz/www/ml-cms/cms.rb
</pre>
