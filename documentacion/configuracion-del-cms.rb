
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'configuracion-del-cms'
    p.nombre      = 'Configuración del CMS'
    p.nombre_menu = 'Configuración del CMS'
    p.fecha       = "2008-05-16 04:00"
    p.categorias  = ['Configuración']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
