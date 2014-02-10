Markdown: la forma fácil de escribir para web
=============================================

Fecha: 2014-02-09 23:30
Categorías: Documentación, Markdown

Este artículo es una traducción de [Markdown Syntax Documentation](http://daringfireball.net/projects/markdown/syntax).

Markdown es una forma fácil de escribir y de leer para crear archivos HTML. Un archivo escrito en makdown es de texto plano, esto significa que puede ser elaborado en cualquier editor de texto. Cabe recalcar que mientras el HTML es un formato para _publicar_ en la web, el markdown es un formato para _escribir_ en la web. En ese concepto, entonces markdown no pretende ser un sustituto del HTML, sino una forma cómoda para escribir contenidos.

<!-- break -->

#### Caracteres especiales

Puede usar caracteres especiales en su contenido. Por ejemplo, para el signo de _copyright_ use:

    &copy;

El _menor que_ y _amperson_ son caracteres especiales que si quiere conservarlos en su contenido debe escribirlos codificados:

    &lt; &amp;

#### Párrafos

Un párrafo es simplemente una serie de caracteres y líneas de texto, que tienen una línea en blanco antes y otra después. También que no se encuentran _indentados_ por espacios o tabulaciones.

En los casos que requiera de un avance de línea, el que se da por el _tag_ `<br>`, escriba dos o más espacios al final de la línea.

#### Encabezados

Hay dos formas de definir encabezados, escribiendo signos de igual o guines medios debajo de la línea que será encabezado.

    Esto será un encabezado H1
    ==========================

    Esto será un encabezado H2
    --------------------------

O usando de uno a seis _gatos_ antes del texto:

    # Esto será un encabezado H1

    ## Esto será un encabezado H2

    ###### Esto será un encabezado H6

#### Citas o _blockquotes_

Del mismo modo que en un mensaje de correo electrónico, en markdown se puede definir un bloque de cita colocando un &gt; en cada línea de los párrafos a citar.

    > En un lugar de la Mancha, de cuyo nombre no quiero acordarme,
    > no ha mucho tiempo que vivía un hidalgo de los de lanza en astillero,
    > adarga antigua, rocín flaco y galgo corredor.
    >
    > Una olla de algo más vaca que carnero,salpicón las más noches,
    > duelos y quebrantos los sábados, lantejas los viernes,
    > algún palomino de añadidura los domingos, consumían las tres partes de su hacienda.

Markdown también permite citar en un modo _perezoso_ sólo poniendo un &gt; al inicio de cada línea de cada párrafo.

    > En un lugar de la Mancha, de cuyo nombre no quiero acordarme,
    no ha mucho tiempo que vivía un hidalgo de los de lanza en astillero,
    adarga antigua, rocín flaco y galgo corredor.
    >
    > Una olla de algo más vaca que carnero,salpicón las más noches,
    duelos y quebrantos los sábados, lantejas los viernes,
    algún palomino de añadidura los domingos, consumían las tres partes de su hacienda.

Es posible citar dentro de una cita.

    > Esto está citado
    >
    > > Esto está dentro de dos citas
    >
    > De regreso a la primer cita

Además, son válidos los demás mecanismos de formato dentro de las citas:

    > ## Esto es un encabezado H2
    >
    > 1. Primer elemento de un listado numerado
    > 2. Segundo elemento de un listado numerado
    >
    > Sigue una muestra de código
    >
    >     echo "Hola Mundo!";

#### Listados

Un listado sin orden se declara usando asteriscos, signos de más o guiones:

    * Rojo
    * Verde
    * Azul

Lo anterior es igual a:

    + Rojo
    + Verde
    + Azul

Y también a:

    - Rojo
    - Verde
    - Azul

Para un listado numerado, use los números seguidos de un punto y espacio:

    1. Primero
    2. Segundo
    3. Tercero

Los listados pueden contener varios párrafos, sólo hay que indentarlos apropiadamente:

    * Este es el primer párrafo de un punto.

      Este es el segundo párrafo del mismo punto.

    * Este es el siguiente punto.

De igual forma para poner una cita dentro de una lista numerada:

    * Este es el párrafo de un punto.

      > Esta cita va dentro del primer punto;
      > con este contenido.

Y en el caso de código dentro de una lista; éste debe estar doblemente indentado, es decir tener ocho espacios antes o dos tabuladores:

    * Este es el párrafo de un punto.

            <echo "Hola mundo!";>

Para que un número seguido de un punto NO sea considerado como un listado numerado:

    1991\. Año en que nace Linux.

#### Código fuente

Bloques de _código fuente_ los cuales serán encerrados por _tags_ `<pre>` y `<code>` deben tener cuatro espacios o un tabulador al principio de cada línea:

    Este es un párrafo común. Enseguida viene código fuente:

        #!/usr/bin/env ruby
        n = 3
        print "Con #{n} lados, "
        a = 360 / n
        print "el ángulo central es #{a} "
        t = 180 * (n - 2) / n
        puts "y el ángulo interno es #{t}"

    Y continuamos escribiendo.

Una bondad del bloque _código fuente_ en markdown es que no hay necesidad de codificar los amperson, _mayor que_ o _menor que_. Al convertir a HTML hace la conversión automática de éstos a las claves necesarias. Así que, para nosotros, sólo copiamos, pegamos e indentamos el código.

#### Código fuente dentro de texto normal

Use el acento invertido para indicar que un fragmento de texto es código dentro de texto normal:

    Use la función `exit` para salir.

En el remoto caso de necesitar un acento invertido dentro de un fragmento de código, deberá usar dos acentos invertidos para indicar el fragmento:

    ``Este es un fragmento de código con un ` acento invertido.``

#### Lineas horizontales

Para poner una línea horizontal `<hr>` coloque tres o más guines medios, asteriscos o guiones bajos.

    * * *
    ***
    *****
    - - -
    -----

#### Vínculos _inline_

En markdown hay dos tipos de vínculos: de tipo _inline_ y _de referencia_. En ambos el texto que tendrá el vínculo va entre corchetes.

Para un vínculo _inline_ ponga el URL dentro de paréntesis, después del texto entre corchetes.

    El buscador [DuckDuck Go](https://www.duckduckgo.com/) no lo rastrea.

Opcionalmente puede usar una etiqueta para el vínculo entre comillas dobles:

    [Wikipedia](http://es.wikipedia.org "Wikipedia en español") es la enciclopedia libre.

Si el vínculo apunta a un destino local en el mismo servidor web, puede omitir este último:

    Lea la [Licencia Pública General GNU v2](/cms/licencias/gpl-2-es.html)

#### Vínculos _de referencia_

En cambio, un vínculo _de referencia_ es el usa dos juegos de corchetes, el primero para el texto a mostrar y el segundo con el _id_ del enlace:

    Vea la sección de [Referencia][referencia] para ver más vínculos sobre el tema.

También es válido que un vínculo _de referencia_ tenga un espacio entre los corchetes:

    No deje de leer la guía de [Markdown] [markdown] para saber cómo redactar artículos.

Luego, debe indicar los destinos de los vínculos escribiendo en cualquier parte del documento la **definición de vínculo**:

    [markdown]: http://movimientolibre.com/cms/documentacion/markdown.html "Markdown: la forma fácil de escribir para web"

Las **definiciones de vínculos** se usan para la elaboración de los enlaces en el contenido y **NO aparecen** en el archivo HTML creado. La sintaxis para éstos es la siguiente:

+ Entre corchetes va el identificador. Los identificadores pueden tener letras, números, espacios y signos de puntación. No son sensibles a las mayúsculas y minúsculas.
+ Dos puntos.
+ Un espacio.
+ El URL del vínculo.
+ Opcionalmente una etiqueta entre comillas dobles, comillas sencillas o paréntesis.

También puede definir vínculos _de referencia_ con el identificador implícito; de esta forma el texto a vincular y el identificador son iguales; por ejemplo:

    [Reddit][] es una gran fuente popular de información y noticias.

Luego declare la _definición del vínculo_ de la forma habitual:

    [Reddit]: http://reddit.com/

Como se mencionó, el texto a vincular e identificador puede tener espacios:

    El sitio web [Movimiento Libre][] trata sobre software y cultura libre.

La _definición del vínculo_ debe coincidir:

    [Movimiento Libre]: http://movimientolibre.com/

Una opción es usar los vínculos _inline_ como si fueran notas al final de su documento:

    Algunos buscadores populares son [Google][1], [Yahoo][2] y [Bing][3].

    [1]: http://google.com/
    [2]: http://yahoo.com/
    [3]: http://bing.com/

Esta alternativa le dará más claridad y una imagen más profesional a su archivo markdown.

#### Énfasis

Encierre el texto entre asteriscos o guines bajos para indicar énfasis (tipografía en itálicas). Éstos se conventirán en el tag `<em>` en HTML.

    *texto especial*
    _deja vu_

Doble asterisco o doble guión bajo serán el tag `<strong>` de HTML (tipografía negrita):

    **Importante**
    __también es importante__

En caso de requerir un asterisco o guión bajo de forma literal, debe usar una diagonal inversa antes:

    Este asterisco \* se conservará como tal.

#### Imágenes

Markdown define las imágenes de una forma bastante similiar a la forma en que se definen los vínculos. Del mismo modos, tiene dos sintaxis: _inline_ y _de referencia_.

Una imagen de la forma _inline_ es como sigue:

    ![Texto alterno](/directorio/archivo.jpg)
    ![Texto alterno](/directorio/archivo.jpg "Etiqueta opcional")

La sintaxis de las imágenes tiene estos elementos:

+ Un signo de admiración.
+ Entre corchetes va el texto `alt` del _tag_ `img`.
+ Entre paréntesis va el URL al archivo de imagen; de manera opcional, puede incluir un `title` entre comillas dobles o sencillas.

En cambio, de la forma _de referencia_ escribirá los enlaces a las imágenes así:

    ![Texto alterno][identificador]

Y defina la ubicación de la imagen para el _identificador_ en otra parte de su documento markdown:

    [identificador]: /directorio/archivo.jpg "Etiqueta opcional"

Hay que aclarar que markdown **NO** define las dimensiones de las imágenes. Así que si necesita hacerlo, deberá recurrir a escribir _tags img_ de HTML tradicional.

#### Vínculos automáticos

Puede escribir una URL entre signos de _menor que_ y _mayor que_, así markdown lo hará un vínculo. Por ejemplo:

    <http://twitter.com/>

Ésto se convertirá en:

    <a href="http://twitter.com/">http://twitter.com/</a>

También funciona con direcciones de correo electrónico, por ejemplo:

    <address@example.com>

El cual aparece como un enlace a esa dirección de correo electrónico; aunque en el código HTML la verá codificada para hacer más difícil que los rastreadores de _spammers_ la obtengan.

#### Referencia

* [Markdown Syntax Documentation](http://daringfireball.net/projects/markdown/syntax)
