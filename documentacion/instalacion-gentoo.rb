
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'instalacion-gentoo'
    p.nombre      = 'Instalación en Gentoo'
    p.nombre_menu = 'Instal. en Gentoo'
    p.fecha       = "2008-05-14 09:00"
    p.categorias  = ['Instalación', 'Gentoo']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
