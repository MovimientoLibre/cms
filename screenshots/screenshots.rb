
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'screenshots'
    p.nombre      = 'Screenshots'
    p.nombre_menu = 'Screenshots'
    p.fecha       = "2008-05-16 18:15"
    p.categorias  = ['Screenshots']
    p.contenido   = <<FIN_CONTENIDO
!/screenshots/screenshots/gulag-small.jpg(GULAG)!:/screenshots/screenshots/gulag.jpg

!/screenshots/screenshots/institutodeciencia-small.jpg(Instituto de Ciencia)!:/screenshots/screenshots/institutodeciencia.jpg

!/screenshots/screenshots/movimientolibre-small.jpg(Movimiento Libre)!:/screenshots/screenshots/movimientolibre.jpg

!/screenshots/screenshots/rayasyrayas-small.jpg(Rayas y Rayas)!:/screenshots/screenshots/rayasyrayas.jpg
FIN_CONTENIDO

    # Entregar la publicacion
    p

end
