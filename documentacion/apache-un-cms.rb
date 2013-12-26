
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'apache-un-cms'
    p.nombre      = 'Configuración del HTTP Apache 2 para un CMS'
    p.nombre_menu = 'Conf. Apache para un CMS'
    p.fecha       = "2008-05-13 07:00"
    p.categorias  = ['Apache']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
