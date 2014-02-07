Markdown: la forma fácil de escribir para web
=============================================

Fecha: 2014-02-07
Categorías: Documentación

Este artículo es una traducción de [Markdown Syntax Documentation](http://daringfireball.net/projects/markdown/syntax).

Markdown es una forma fácil de escribir y de leer para crear archivos HTML. Un archivo escrito en makdown es de texto plano, es to significa que puede ser elaborado en cualquier editor de texto. Cabe recalcar que mientras el HTML es un formato para _publicar_ en la web, el markdown es un formato para _escribir_ en la web. En ese concpeto, entonces markdown no pretende ser un sustituto del HTML, sino una forma cómoda para escribir contenidos.

<!-- break -->

#### Caracteres especiales

Puede usar caracteres especiales en su contenido. Por ejemplo, para el signo de _copyright_ use:

    &copy;

El _menor que_ y _amperson_ son caracteres especiales que si quiere conservarlos en su contenido debe escribirlos codificados

    &lt; &amp;

#### Párrafos

Un párrafo es simplemente una serie de caracteres y líneas de texto, que tienen una línea en blanco antes y otra después. También que no se encuentran _indentados_ por espacios o tabulaciones.

En los casos que requiera de un avance de línea, el que se da por el _tag_ &lt; br &gt;, escriba dos o más espacios al final de la línea.

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

Es posible citar dentro de una cita

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

Un listado sin orden se declara usando asteriscos, signos de más o guines:

    * Rojo
    * Verde
    * Azul

Lo anterior es igual a:

    - Rojo
    - Verde
    - Azul

#### Referencias

* [Markdown Syntax Documentation](http://daringfireball.net/projects/markdown/syntax)
