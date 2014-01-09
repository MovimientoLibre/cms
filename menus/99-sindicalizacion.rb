# encoding: utf-8
def menu

    m = Menu.new()
    m.encabezado('Sindicalización')
    m.agregar('<img src="/imagenes/rss.png" alt="RSS 2.0"> RSS 2.0', 'rss.xml')

    # Entregar el menu
    m.to_secundario_html

end
