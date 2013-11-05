
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'directorios-de-publicaciones'
    p.nombre      = 'Directorios de las publicaciones'
    p.nombre_menu = 'Directorios de las publicaciones'
    p.fecha       = "2008-05-16 03:00"
    p.categorias  = ['Publicaciones']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
