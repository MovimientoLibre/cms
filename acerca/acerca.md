Acerca del CMS de Movimiento Libre
==================================

Corto: Acerca
Fecha: 2008-05-16 18:00
Categorías: FAQ

El CMS de Movimiento Libre es un sencillo sistema de gestión de contenidos, _Content Management System_ en inglés, abreviado [CMS](http://es.wikipedia.org/wiki/Cms). Es un programa que permite crear una estructura de soporte para la creación y administración de contenidos de un sitio web.

Nace con la intensión de llevar a la práctica algunos conceptos básicos de programación en [Ruby](http://es.wikipedia.org/wiki/Ruby) para administrar los contenidos de [Movimiento Libre](http://movimientolibre.com) y es liberado bajo la [Licencia GPL v2](licencias/gpl-2.html). Ha sido para su servidor un buen ejercicio para aprender este lenguaje de programación.

<!-- break -->

#### ¿Por qué hacer un CMS que genere páginas estáticas?

* Pretende seguir la [Filosofía Unix](http://en.wikipedia.org/wiki/Unix_philosophy), en concreto tratando de ser *un programa que hace una cosa y la hace bien* y también con la idea de que en Unix *todo es un archivo*. En este CMS cada publicación es un archivo de texto plano.
* Si piensa que un CMS debería usar una base de datos, reflexione esto: *una base de datos debería usarse cuando la totalidad de los registros no puedan ser cargados en la memoria*. Si consideramos que un blog personal se incrementa de 50 a 150 publicaciones por año, entonces en un lapso de 5 años habrá acumulado 750 publicaciones a lo mucho. Si ponemos las 750 publicaciones en archivos de texto plano, serán algunos kilobytes de información, muy poco para los varios gigabytes de mememoria RAM de un equipo actual. Por lo que podemos deducir que una base de datos es _mucha maquinara_ para 750 registros.
* Este script genera páginas estáticas en HTML. No son páginas dinámicas las cuales requieren procesamiento en el momento de ser solicitadas. Con lo que se libera de carga al procesador del servidor web.
* Hay procesos que no se pueden hacer en páginas estáticas, como las búsquedas; pero le aseguro que Usted mismo hace más búsquedas en buscadores como [Google](http://www.google.com.mx) que búsquedas en cada sitio web que lo tenga.
* Los buscadores como [Google](http://www.google.com.mx) encuentran _muy atractivo_ indexar páginas HTML estáticas con los [URL](http://es.wikipedia.org/wiki/URL) muy descriptivos. Por ejemplo, no nos dice mucho <http://www.sitioweb.com/?q=node/18> si lo comparamos con <http://www.sitioweb.com/presentaciones/software-libre.html>

#### ¿Qué es lo que hace este CMS?

* Mantiene el mismo diseño en las páginas que hacen el sitio web, por medio de CSS.
* Toma las publicaciones de uno o más directorios definidos en la configuración. Esto permite la adecuada organización de las publicaciones, por ejemplo en 'manuales', 'programas', 'presentaciones', etc.
* Cada publicación tiene una fecha, la cual es usada para ordenar cronológicamente las publicaciones de la más reciente a la más antigua.
* Cada publicación tiene una o más categorías, con lo cual se crea un menú de categorías para acceder a las publicaciones de cada categoría.
* Cada publicación tiene un autor, con lo que se mantiene un menú de autores.
* Crea la sindicalización del sitio, es decir un archivo XML para lectores de orígenes RSS.
* Pueden agregarse menús personalizados con vínculos, gráficos o mensajes.

#### ¿Qué hace el script cuando se ejecuta?

* Carga todas las publicaciones (archivos rb) que encuentra en los directorios configurados.
* Los ordena por fecha, los más recientes primero, los más antiguos al final.
* Elabora los menús de categorías, autores y publicaciones recientes.
* Carga los menús personalizados.
* Crea un archivo HTML por cada publicación.
* Crea los archivos HTML para cada categoría y autor.
* Crea la página de inicio en HTML.

#### ¿Qué ventajas tiene?

* Es relativamente sencillo de montar y mantener.
* Pocos requerimientos (Ruby, RedCoth, Apache y un procesador de textos).
* Bajo consumo del procesador (por que no son páginas dinámicas, como PHP, ni requiere base de datos).
* Es seguro (por que puede ejecutarse via OpenSSH).

#### ¿Qué es lo que NO hace?

* No hay una intefaz web, ni aplicación para escribir los contenidos (ya que puede usar cualquier procesador de texto plano para ello).
* No tiene capacidad para recibir, ni para mostrar comentarios de los visitantes.
