
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'instalacion-debian'
    p.nombre      = 'Instalación en Debian'
    p.nombre_menu = 'Instal. en Debian'
    p.fecha       = "2008-05-14 09:00"
    p.categorias  = ['Instalación', 'Debian']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
