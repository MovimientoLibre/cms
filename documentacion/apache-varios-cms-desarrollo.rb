
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'apache-varios-cms-desarrollo'
    p.nombre      = 'Configuración del HTTP Apache 2 para desarrollar varios CMS'
    p.nombre_menu = 'Conf. Apache para desarrollar varios CMS'
    p.fecha       = "2008-05-13 07:00"
    p.categorias  = ['Apache']
    p.contenido   = <<FIN_CONTENIDO
_Pendiente_
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
