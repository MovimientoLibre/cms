
def menu

	m = Menu.new()
	m.encabezado('Validación del sitio')
	m.agregar('<img src="/imagenes/link-valid-xhtml10.png" alt="Valid XHTML 1.0 Strict" height="31" width="88" />', 'http://validator.w3.org/check?uri=referer')
	m.agregar('<img src="/imagenes/link-valid-css.png" alt="Valid CSS!" height="31" width="88" />', 'http://jigsaw.w3.org/css-validator/')

	# Entregar el menu
	m.to_html

end
