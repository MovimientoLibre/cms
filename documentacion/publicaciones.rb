
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'publicaciones'
    p.nombre      = 'Publicaciones'
    p.nombre_menu = 'Publicaciones'
    p.fecha       = "2008-05-16 01:00"
    p.categorias  = ['Publicaciones']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
