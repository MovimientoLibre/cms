Markdown: la forma fácil de escribir para web
=============================================

Corto: Guía de Markdown
Fecha: 2014-05-03
Categorías: Markdown, Referencias
Descripción: Markdown es una forma fácil de escribir y de leer para crear archivos HTML. Un archivo escrito en makdown es de texto plano, esto significa que puede ser elaborado en cualquier editor de texto.
Claves: Manual,Markdown

Este artículo es una traducción de [Markdown Syntax Documentation](http://daringfireball.net/projects/markdown/syntax).

Markdown es una forma fácil de escribir y de leer para crear archivos HTML. Un archivo escrito en makdown es de texto plano, esto significa que puede ser elaborado en cualquier editor de texto. Cabe recalcar que mientras el HTML es un formato para _publicar_ en la web, el markdown es un formato para _escribir_ en la web. En ese concpeto, entonces markdown no pretende ser un sustituto del HTML, sino una forma cómoda para escribir contenidos.

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

Bloques de código fuente los cuales son limitados por los _tags_ &gt;pre&lt; y &gt;code&lt; deben tener cuatro espacios o un tabulador al principio de cada línea:

    Este es un párrafo común. Enseguida viene código fuente:

        #!/usr/bin/env ruby
        n = 3
        print "Con #{n} lados, "
        a = 360 / n
        print "el ángulo central es #{a} "
        t = 180 * (n - 2) / n
        puts "y el ángulo interno es #{t}"

    Y continuamos escribiendo.

Una bondad del bloque _código fuente_ en markdown es que no hay necesidad de codificar los amperson, mayor que o menor que. Al convertir a HTML hace la conversión automática de éstos a las claves necesarias. Así que, para nosotros, sólo copiamos, pegamos e indentamos el código.

#### Referencias

* [Markdown Syntax Documentation](http://daringfireball.net/projects/markdown/syntax)
