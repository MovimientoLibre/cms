CMS de Movimiento Libre
=========================

#### Versión 2.0
 
#### Novedades de esta versión:
 * Soporte para la creación de publicaciones por medio de Markdown.
 * Integración a la capacidad de actualizacíon tanto por archivos .rb como archivos .md.
 * Capacidad de inyectar codigo HTML y/o Javascript en las publicaciones.
 * Soporte para rutas relativas, esto ayuda al soporte del sitio en un subdirectorio dentro del servidor.
 ___________________________________________________
 
Es un script hecho en Ruby para que con apoyo de [TwitterBootstrap](http://getbootstrap.com) se construya el sitio web de [movimientolibre.com](http://movimientolibre.com) sin necesidad de una base de datos ni páginas dinámicas.

Cabe destacar que el uso del CMS no se limita a el uso del framework de TwitterBootstrap, este puede ser acoplado con gran facilidad ante otros frameworks.

**Instrucciones:**

1) Deberá tener instalado y configurado el Apache HTTP, Ruby y  las gemas de RedCloth y Kramdown para ejecutar este script.

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

5) Cree sus propios directorios para las publicaciones y agregue en éstos las publicaciones como archivos .rb o .md. Tome de base los existentes.

6) Ejecute el script escribiendo ./cms.rb no deje de leer los mensajes en la consola.

7) Verifique su sitio en su navegador.

8) Si necesita cambiar o agregar algo, cambie el archivo .rb correspondiente y vuelva al paso 6.

## Preguntas frecuentes.

1) ¿Que tipo de etiquetas HTML admite Markdown?.

>*Aunque es cierto que Markdown permite la incorporación de HTML dentro de los archivos .md, tambíen es cierto que no todas las etiquetas HTML sirven dentro del mismo.*

>*Las etiquetas que a continuación se muestran, son las etiquetas que se pueden utilizar dentro de los archivos .md*    
>*La etiqueta table aunque no es una etiqueta permitida por Markdown, Kramdown sutituye el uso de esta por  el uso de | (pipas) para delimitar el inicio y final de una columna.*

>      <a>            
>      <b>            
>      <blockquote>     
>      <code>           
>      <del>            
>      <dd>             
>      <dl>             
>      <dt>             
>      <em>             
>      <h1> 
>      <h2> 
>      <h3> 
>      <h4> 
>      <h5> 
>      <h6> 
>      <i>              
>      <img>            
>      <kbd>            
>      <li>             
>      <ul>
>      <ol>             
>      <p>              
>      <pre>            
>      <s>              
>      <sup>            
>      <sub>            
>      <strong>         
>      <strike>         
>      <del>
>      <ul>             
>      <br>             
>      <hr>             

>**Ejemplo:**

>|Nombre  | Sexo |
 
>|Javier |Hombre| 
    
2) ¿Que atributos son permitidos?
>*Debido  a que markdown busca conservar esa simplicidad y minimalismo a la hora de estructurar los archivos, los atributos aceptados a la hora de utilizar codigo HTML tambien es afectada.*

>*La etiqueta **img**  permite el uso de  los siguientes atributos:*

>* src=""

>* width=""

>* height=""

>* alt=""

>* titile= ""

>*De igual manera la etiqueta **a** permite:*

>* href=""

>* title="" 
 
 
[**Como anexo final, se incluye un enlace a la pagina oficial de Markdown donde podras conocer mas sobre su sintaxis**](http://daringfireball.net/projects/markdown/syntax) 