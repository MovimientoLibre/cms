
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'requerimientos'
    p.nombre      = 'Requerimientos'
    p.nombre_menu = 'Requerimientos'
    p.fecha       = "2008-05-16 17:50"
    p.categorias  = ['Instalación']
    p.contenido   = <<FIN_CONTENIDO
Para usar el CMS de Movimiento Libre necesita tener instalado:

* GNU/Linux
* Servidor "Apache HTTP":http://httpd.apache.org/ previamente configurado y probado.
* Intérprete del leguaje "Ruby":http://www.ruby-lang.org/
* La gema "RedCloth":http://whytheluckystiff.net/ruby/redcloth/

En las instrucciones de instalación se explica cómo instalar Ruby y RedCloth:

* Para "Debian Linux":/documentacion/instalacion-debian.html
* Para "Gentoo Linux":/documentacion/instalacion-gentoo.html

FIN_CONTENIDO

    # Entregar la publicacion
    p

end
