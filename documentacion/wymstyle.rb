
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'wymstyle'
    p.nombre      = 'El diseño del sitio con WymStyle'
    p.nombre_menu = 'WymStyle'
    p.fecha       = "2008-05-13 09:00"
    p.categorias  = ['CSS']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
