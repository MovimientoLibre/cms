
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'menus-personalizados'
    p.nombre      = 'Menús personalizados'
    p.nombre_menu = 'Administrar contenido'
    p.fecha       = "2008-05-16 02:00"
    p.categorias  = ['Configuración']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
