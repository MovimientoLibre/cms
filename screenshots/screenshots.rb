# encoding: utf-8
def publicacion(dir)

    p             = Publicacion.new
    p.directorio  = dir
    p.archivo     = 'screenshots'
    p.nombre      = 'Screenshots'
    p.nombre_menu = 'Screenshots'
    p.fecha       = "2008-05-16 18:15"
    p.categorias  = ['Screenshots']
    p.contenido   = <<FIN_CONTENIDO
<div class="screenshots"> !screenshots/gulag-small.jpg(GULAG)!:screenshots/gulag.jpg !screenshots/institutodeciencia-small.jpg(Instituto de Ciencia)!:screenshots/institutodeciencia.jpg !screenshots/movimientolibre-small.jpg(Movimiento Libre)!:screenshots/movimientolibre.jpg !screenshots/rayasyrayas-small.jpg(Rayas y Rayas)!:screenshots/rayasyrayas.jpg </div>
FIN_CONTENIDO

    # Entregar la publicacion
    p

end

=begin

<div class="screenshots"> !/screenshots/screenshots/gulag-small.jpg(GULAG)!:/screenshots/screenshots/gulag.jpg !/screenshots/screenshots/institutodeciencia-small.jpg(Instituto de Ciencia)!:/screenshots/screenshots/institutodeciencia.jpg !/screenshots/screenshots/movimientolibre-small.jpg(Movimiento Libre)!:/screenshots/screenshots/movimientolibre.jpg !/screenshots/screenshots/rayasyrayas-small.jpg(Rayas y Rayas)!:/screenshots/screenshots/rayasyrayas.jpg </div>

<div class="row">
  <div class="col-md-6">
    <img src="/screenshots/screenshots/gulag-small.jpg" alt="GULAG" class="img-rounded" style="margin:4px;">
  </div>
  <div class="col-md-6">
    <img src="/screenshots/screenshots/institutodeciencia-small.jpg" alt="Instituto de Ciencia" class="img-rounded" style="margin:4px;">
  </div>
</div>
<div class="row">
  <div class="col-md-6">
    <img src="/screenshots/screenshots/movimientolibre-small.jpg" alt="Movimiento Libre" class="img-rounded" style="margin:4px;">
  </div>
  <div class="col-md-6">
    <img src="/screenshots/screenshots/rayasyrayas-small.jpg" alt="Rayas y Rayas" class="img-rounded" style="margin:4px;">
  </div>
</div>

!/screenshots/screenshots/gulag-small.jpg(GULAG)!:/screenshots/screenshots/gulag.jpg !/screenshots/screenshots/institutodeciencia-small.jpg(Instituto de Ciencia)!:/screenshots/screenshots/institutodeciencia.jpg !/screenshots/screenshots/movimientolibre-small.jpg(Movimiento Libre)!:/screenshots/screenshots/movimientolibre.jpg !/screenshots/screenshots/rayasyrayas-small.jpg(Rayas y Rayas)!:/screenshots/screenshots/rayasyrayas.jpg

!/screenshots/screenshots/gulag-small.jpg(GULAG)!:/screenshots/screenshots/gulag.jpg
!/screenshots/screenshots/institutodeciencia-small.jpg(Instituto de Ciencia)!:/screenshots/screenshots/institutodeciencia.jpg
!/screenshots/screenshots/movimientolibre-small.jpg(Movimiento Libre)!:/screenshots/screenshots/movimientolibre.jpg
!/screenshots/screenshots/rayasyrayas-small.jpg(Rayas y Rayas)!:/screenshots/screenshots/rayasyrayas.jpg

=end

