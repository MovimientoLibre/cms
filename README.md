CMS de Movimiento Libre
===

Es un script hecho en Ruby para que con apoyo de TwitterBootstrap se construya el sitio web de movimientolibre.com sin necesidad de una base de datos ni páginas dinámicas.

Instrucciones:

1) Deberá tener instalado y configurado el Apache HTTP, Ruby y RedCloth (es una gema de Ruby) para ejecutar este script.

2) Coloque los contenidos en la raíz de su sitio web. Por defecto en Apache es /var/www/localhost/htdocs/. Le recomiendo que configure Apache para colocarlos en un directorio dentro su carpeta personal, por ejemplo /home/usuario/www/

3) En este repositorio no están presentes Twitter Bootstrap ni JQuery. Instálelos por separado en estas rutas:

```
+-- css
  +-- bootstrap.min.css
  +-- bootstrap-theme.min.css
+-- fonts
  +-- glyphicons-halflings-regular.eot
  +-- glyphicons-halflings-regular.svg
  +-- glyphicons-halflings-regular.ttf
  +-- glyphicons-halflings-regular.woff
+-- js
  +-- bootstrap.min.js
  +-- jquery-1.10.2.min.js
```

4) Edite la configuración, modificando el archivo cms.rb. Todo está explicado dentro de éste.

5) Cree sus propios directorios para las publicaciones y agregue en éstos las publicaciones como archivos rb. Tome de base los existentes.

6) Ejecute el script escribiendo ./cms.rb no deje de leer los mensajes en la consola.

7) Verifique su sitio en su navegador.

8) Si necesita cambiar o agregar algo, cambie el archivo .rb correspondiente y vuelva al paso 6.
