
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'openssh'
    p.nombre      = 'Uso del OpenSSH para este CMS'
    p.nombre_menu = 'OpenSSH'
    p.fecha       = "2008-05-13 08:00"
    p.categorias  = ['OpenSSH']
    p.contenido   = <<FIN_CONTENIDO
h4. Para subir las últimas publicaciones a su servidor

<pre>
$ rsync -avz /home/guivaloz/www/ml-cms/ -e ssh guivaloz@movimientolibre.com:/home/guivaloz/www/ml-cms/
</pre>

h4. Para ejecutar el script en su servidor

<pre>
$ ssh guivaloz@movimientolibre.com /home/guivaloz/www/ml-cms/cms.rb
</pre>
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
