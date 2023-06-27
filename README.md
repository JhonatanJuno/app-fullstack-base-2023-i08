<a href="https://www.gotoiot.com/">
    <img src="doc/gotoiot-logo.png" alt="logo" title="Goto IoT" align="right" width="60" height="60" />
</a>

Web App Full Stack Base
=======================

*Ayudaría mucho si apoyaras este proyecto con una ⭐ en Github!*

Este proyecto es una aplicación web fullstack que se ejecuta sobre el ecosistema `Docker`. Está compuesta por un compilador de `TypeScript` que te permite utilizar este superset de JavaScript para poder programar un `cliente web`. También tiene un servicio en `NodeJS` que te permite ejecutar código en backend y al mismo tiempo disponibilizar el código del cliente web para interactar con el servicio. Además tiene una `base de datos` MySQL que puede interactuar con el backend para guardar y consultar datos, y de manera adicional trae un `administrador` de base de datos para poder administrar la base en caso que lo necesites.

La aplicación IoT de base que viene con este proyecto se encarga de crear una tabla llamada `Devices` en la base de datos, y la idea es que vos puedas desarrollar el código de backend y frontend que te permita controlar desde el navegador el estado de los devices de un hogar inteligente - *como pueden ser luces, TVs, ventiladores, persianas, enchufes y otros* - y almacenar los estados de cada uno en la base de datos. 

Realizando estas tareas vas a a tener una aplicación fullstack IoT del mundo real que utiliza tecnologías actuales en la que un backend es capaz de interactuar con una DB para cumplir con las peticiones de control que se le mandan desde el cliente web.

En esta imagen podés ver una posible implementación del cliente web que controla los artefactos del hogar.

![architecture](doc/webapp-example-1.png)

## Comenzando 🚀

Esta sección es una guía con los pasos escenciales para que puedas poner en marcha la aplicación.

<details><summary><b>Mira los pasos necesarios</b></summary><br>

### Instalar las dependencias

Para correr este proyecto es necesario que instales `Docker` y `Docker Compose`. 

En [este artículo](https://www.gotoiot.com/pages/articles/docker_installation_linux/) publicado en nuestra web están los detalles para instalar Docker y Docker Compose en una máquina Linux. Si querés instalar ambas herramientas en una Raspberry Pi podés seguir [este artículo](https://www.gotoiot.com/pages/articles/rpi_docker_installation) de nuestra web que te muestra todos los pasos necesarios.

En caso que quieras instalar las herramientas en otra plataforma o tengas algún incoveniente, podes leer la documentación oficial de [Docker](https://docs.docker.com/get-docker/) y también la de [Docker Compose](https://docs.docker.com/compose/install/).

Continua con la descarga del código cuando tengas las dependencias instaladas y funcionando.

### Descargar el código

Para descargar el código, lo más conveniente es que realices un `fork` de este proyecto a tu cuenta personal haciendo click en [este link](https://github.com/gotoiot/app-fullstack-base/fork). Una vez que ya tengas el fork a tu cuenta, descargalo con este comando (acordate de poner tu usuario en el link):

```
git clone https://github.com/USER/app-fullstack-base.git
```

> En caso que no tengas una cuenta en Github podes clonar directamente este repo.

### Ejecutar la aplicación

Para ejecutar la aplicación tenes que correr el comando `docker-compose up` desde la raíz del proyecto. Este comando va a descargar las imágenes de Docker de node, de typescript, de la base datos y del admin de la DB, y luego ponerlas en funcionamiento. 

Para acceder al cliente web ingresa a a la URL [http://localhost:8000/](http://localhost:8000/) y para acceder al admin de la DB accedé a [localhost:8001/](http://localhost:8001/). 

Si pudiste acceder al cliente web y al administrador significa que la aplicación se encuentra corriendo bien. 

> Si te aparece un error la primera vez que corres la app, deteńe el proceso y volvé a iniciarla. Esto es debido a que el backend espera que la DB esté creada al iniciar, y en la primera ejecución puede no alcanzar a crearse. A partir de la segunda vez el problema queda solucionado.

</details>

Continuá explorando el proyecto una vez que lo tengas funcionando.

## Configuraciones de funcionamiento 🔩

Al crearse la aplicación se ejecutan los contenedores de Docker de cada servicio, se crea la base de datos y sus tablas. A continuación podés encontrar info si querés cambiar la estructura de la DB o bien sus configuraciones de acceso.

<details><summary><b>Lee cómo configurar la aplicación</b></summary><br>

### Configuración de la DB

Como ya comprobaste, para acceder PHPMyAdmin tenés que ingresar en la URL [localhost:8001/](http://localhost:8001/). En el login del administrador, el usuario para acceder a la db es `root` y contraseña es la variable `MYSQL_ROOT_PASSWORD` del archivo `docker-compose.yml`.

Para el caso del servicio de NodeJS que se comunica con la DB fijate que en el archivo `src/backend/mysql-connector.js` están los datos de acceso para ingresar a la base.

Si quisieras cambiar la contraseña, puertos, hostname u otras configuraciones de la DB deberías primero modificar el servicio de la DB en el archivo `docker-compose.yml` y luego actualizar las configuraciones para acceder desde PHPMyAdmin y el servicio de NodeJS.

### Estructura de la DB

Al iniciar el servicio de la base de datos, si esta no está creada toma el archivo que se encuentra en `db/dumps/smart_home.sql` para crear la base de datos automáticamente.

En ese archivo está la configuración de la tabla `Devices` y otras configuraciones más. Si quisieras cambiar algunas configuraciones deberías modificar este archivo y crear nuevamente la base de datos para que se tomen en cuenta los cambios.

Tené en cuenta que la base de datos se crea con permisos de superusuario por lo que no podrías borrar el directorio con tu usuario de sistema, para eso debés hacerlo con permisos de administrador. En ese caso podés ejecutar el comando `sudo rm -r db/data` para borrar el directorio completo.

</details>


## Detalles principales 🔍

En esta sección vas a encontrar las características más relevantes del proyecto.

<details><summary><b>Mira los detalles más importantes de la aplicación</b></summary><br>
<br>

### Arquitectura de la aplicación

Como ya pudiste ver, la aplicación se ejecuta sobre el ecosistema Docker, y en esta imagen podés ver el diagrama de arquitectura.

![architecture](doc/architecture.png)

### El cliente web

El cliente web es una Single Page Application que se comunica con el servicio en NodeJS mediante JSON a través de requests HTTP. Puede consultar el estado de dispositivos en la base de datos (por medio del servicio en NodeJS) y también cambiar el estado de los mismos. Los estilos del código están basados en **Material Design**.

### El servicio web

El servicio en **NodeJS** posee distintos endpoints para comunicarse con el cliente web mediante requests HTTP enviando **JSON** en cada transacción. Procesando estos requests es capaz de comunicarse con la base de datos para consultar y controlar el estado de los dispositivos, y devolverle una respuesta al cliente web también en formato JSON. Así mismo el servicio es capaz de servir el código del cliente web.

### La base de datos

La base de datos se comunica con el servicio de NodeJS y permite almacenar el estado de los dispositivos en la tabla **Devices**. Ejecuta un motor **MySQL versión 5.7** y permite que la comunicación con sus clientes pueda realizarse usando usuario y contraseña en texto plano. En versiones posteriores es necesario brindar claves de acceso, por este motivo la versión 5.7 es bastante utilizada para fases de desarrollo.

### El administrador de la DB

Para esta aplicación se usa **PHPMyAdmin**, que es un administrador de base de datos web muy utilizado y que podés utilizar en caso que quieras realizar operaciones con la base, como crear tablas, modificar columnas, hacer consultas y otras cosas más.

### El compilador de TypeScript

**TypeScript** es un lenguaje de programación libre y de código abierto desarrollado y mantenido por Microsoft. Es un superconjunto de JavaScript, que esencialmente añade tipos estáticos y objetos basados en clases. Para esta aplicación se usa un compilador de TypeScript basado en una imagen de [Harmish](https://hub.docker.com/r/harmish) en Dockerhub, y está configurado para monitorear en tiempo real los cambios que se realizan sobre el directorio **src/frontend/ts** y automáticamente generar código compilado a JavaScript en el directorio  **src/frontend/js**. Los mensajes del compilador aparecen automáticamente en la terminal al ejecutar el comando **docker-compose up**.

### Ejecución de servicios

Los servicios de la aplicación se ejecutan sobre **contenedores de Docker**, así se pueden desplegar de igual manera en diferentes plataformas. Los detalles sobre cómo funcionan los servicios los podés ver directamente en el archivo **docker-compose.yml**.

### Organización del proyecto

En la siguiente ilustración podés ver cómo está organizado el proyecto para que tengas en claro qué cosas hay en cada lugar.

```sh
├── db                          # directorio de la DB
│   ├── data                    # estructura y datos de la DB
│   └── dumps                   # directorio de estructuras de la DB
│       └── smart_home.sql      # estructura con la base de datos "smart_home"
├── doc                         # documentacion general del proyecto
└── src                         # directorio codigo fuente
│   ├── backend                 # directorio para el backend de la aplicacion
│   │   ├── index.js            # codigo principal del backend
│   │   ├── mysql-connector.js  # codigo de conexion a la base de datos
│   │   ├── package.json        # configuracion de proyecto NodeJS
│   │   └── package-lock.json   # configuracion de proyecto NodeJS
│   └── frontend                # directorio para el frontend de la aplicacion
│       ├── js                  # codigo javascript que se compila automáticamente
│       ├── static              # donde alojan archivos de estilos, imagenes, fuentes, etc.
│       ├── ts                  # donde se encuentra el codigo TypeScript a desarrollar
│       └── index.html          # archivo principal del cliente HTML
├── docker-compose.yml          # archivo donde se aloja la configuracion completa
├── README.md                   # este archivo
├── CHANGELOG.md                # archivo para guardar los cambios del proyecto
├── LICENSE.md                  # licencia del proyecto
```

> No olvides ir poniendo tus cambios en el archivo `CHANGELOG.md` a medida que avanzas en el proyecto.

</details>

## Detalles de implementación 💻

En esta sección podés ver los detalles específicos de funcionamiento del código y que son los siguientes.

<details><summary><b>Mira los detalles de implementación</b></summary><br>

### Login de Usuario
Se puede hacer login de usuario en la primera parte de la aplicación web. 

![Implementacion](doc/login1.png)

Al ingresar los datos de usuario y contraseña se validará con los usuarios previamente cargados en la base de datos. De momento solo hacemos la validación de usuario y mostramos un mensaje si la contraseña es correcta o no. Luego la vista de login desaparece para dar mayor espacio a la visualizacion de los dispositivos.

![Implementacion](doc/login2.png)

### Agregar un dispositivo

Para agregar un dispositivo debemos hacer clic en el boton de "AGREGAR EQUIPOS" que se encuentra en la parte inferior.
![Implementacion](doc/add1.png)

Debemos llenar los campos marcados y hacer clic en "AÑADIR DISPOSITIVO".
![Implementacion](doc/add2.png)

Verificamos que el dispositivo fue añadido al final con exito.
![Implementacion](doc/add3.png)

### Actualizar/Eliminar  un dispositivo

Seleccionamos el dispositivo, haciendo clic sobre el nombre, para deslizar las opciones:
![Implementacion](doc/upd1.png)

Podemos editar cualquier de los campos, o si lo preferimos eliminar el dispositivo.

### Frontend

El archivo principal es el "index.html. En este archivo definimos la secciones del login de usuario. Asimismo,  declaramos los botones y la caja de dispositivos que contiene el resultado de la consulta al backend y lo muestra en forma de lista.

Otro de los archivos importantes es "framework.ts", que mediante la tecnologia Ajax pemite definir las peticiones asíncronas al servidor backend. Aqui tambien definimos el metodo "recoverElement" para recuperar un elemento de la pagina HTML.

El archivo "httpResponde.ts" crea la interfaz HttpResponse que permite manejar las respuestas del servidor para los metodos HTTP.

En el archivo "device.ts" tenemos la clase que define los parametros que tendra el dispositivo, esto se usará para elaborar las consultas a la base de datos.

El archivo principal del frontend es main.ts. Lo primero que hacemos es consultar la lista de disositivos, que se muestra por defecto al momento de entrar en la aplicación. 
Cuando es la primera vez que se corre la aplicacion y la base no haya cargado, se mostrara un mensaje de "Failed to load devices". Tambien mostramos el panel de login inicial. Luego que un usuario hace clic en login, se ejecuta una consulta con un POST al backend. Se devuelve un mensaje de bienvenida y se oculta la vista.

Luego tenemos la lista de dispositivos, segun sea el caso, tendremos un boton para "on" "off" o un deslizable con valores de 0 a 10. Tenemos un "sumary" al que acedemos al hacer clic para poder visualizar las opciones de "ACTUALIZAR" y "ELIMINAR".  Cuando actualizamos podemos editar los campos del dispositivos, y ademas elegir si es "dimmable" o no. Si elegimos la opcion de eleminar, se quita el registro de la lista.

Finalmente en la ultima parte, tenemos el boton para añadir dispositivos.

### Backend

Se trabaja con el framework "express" con el que creamos la API de conexion con las rutas de acceso y los metodos necesarios. el paquete "utils" tambien fue necesario para poder interecturar con la base de datos mediante "querys".

El primer método implementado es el metodo POST para la validacion del login de usuario. Se recibe los datos del formulario de login, se genera una consulta SQL y ve verifica en la tabla si el usuario existe y si tiene la contraseña indicada. Devolvemos el mensaje "Inicio de sesión correcto" para el frontend.

El siguiente método implementado es un GET para la lista de dispositivos. Este metodo es accedido por el frontend para recuperar y mostrar en pantalla los dispositivos.

Luego tenemos un método POST para crear nuevos dispositivos en la base de datos. Esto en base al formulario de ingreso de nuevo dispositivo. Todos los campos deben venir con datos, de lo contrario devolvemos un "Error creating device"

Tenemos dos metodos POST adiconales para actualizar el estado del dispotivo. Y Finalmente un POST para eliminar un dispositivo seleccionado.

<details><summary><b>Ver los endpoints disponibles</b></summary><br>

1) Verificar el login de un usuario
```json
{
    "url": "http://localhost:8000/usuarios/",
    "method": "post",
    "request_headers": "application/json",
    "request_body": 
        {   
            "usuario": "Jhonatan Juno",
            "contraseña": "123456"
        },
    "response_code": 200,
    "response_body": {
        "message": "Inicio de sesión correcto"
    },
}
```  

2)Obtener lista de los dispositivos.

```json
{
    "url": "http://localhost:8000/listDevices/",
    "method": "get",
    "request_headers": "application/json",
    "request_body": "",
    "response_code": 200,
    "request_body": {
        "devices": [
                        {
                            "id":1,
                            "name":"Lampara 1",
                            "description":"Luz living",
                            "state":1,
                            "type":0,
                            "dimmable":1
                        },
                        {
                            "id":2,
                            "name":"Lampara 2",
                            "description":"Luz cocina",
                            "state":0,
                            "type":0,
                            "dimmable":0
                        },
                        {
                            "id":3,
                            "name":"Velador",
                            "description":"Velador living",
                            "state":1,
                            "type":0,
                            "dimmable":1
                        }
                    ]
    },
}
``` 
3) Crear un nuevo dispositivo
```json
{
    "url": "http://localhost:8000/insertDevice/",
    "method": "post",
    "request_headers": "application/json",
    "request_body": 
        {   
            "name": "Lampara 5", 
            "description": "Lampara de prueba", 
            "state": 0, 
            "type": 0, 
            "dimmable": 0 
        },
    "response_code": 200,
    "response_body": 
        {
            "fieldCount":0,
            "affectedRows":1,
            "insertId":8,
            "serverStatus":2,
            "warningCount":0,
            "message":"",
            "protocol41":true,
            "changedRows":0
        },
}
``` 
4) Actualizar el estado on/off del dispositivo creado
```json
{
    "url": "http://localhost:8000/updateState/",
    "method": "post",
    "request_headers": "application/json",
    "request_body": 
        {
                "id": 1, //Id dispositivo
                "state":0 //Estado off=0, Estado on = 10
        },
    "response_code": 200,
    "response_body": 
        {
            "fieldCount":0,
            "affectedRows":1,
            "insertId":0,
            "serverStatus":2,
            "warningCount":0,
            "message":"(Rows matched: 1 Changed: 1 Warnings: 0",
            "protocol41":true,
            "changedRows":1
        }
}
``` 
5) Modificar un dispositivo en la Base de datos
```json
{
    "url": "http://localhost:8000/updateDevice/",
    "method": "post",
    "request_headers": "application/json",
    "request_body": 
               {
                    "id": 1,
                    "name": "Lampara 1",
                    "description": "Luz de la Sala",
                    "state":1,
                    "type":0,
                    "dimmable":1            
                },
    "response_code": 200,
    "response_body": 
        {
            "fieldCount":0,
            "affectedRows":1,
            "insertId":0,
            "serverStatus":2,
            "warningCount":0,
            "message":"(Rows matched: 1 Changed: 1 Warnings: 0",
            "protocol41":true,
            "changedRows":1
        }
}
``` 
6) Eliminar un dispositivo en la Base de datos
```json
{
    "url": "http://localhost:8000/deleteDevice/",
    "method": "post",
    "request_headers": "application/json",
    "request_body": 
               {
                    "id": 8 //Id del dispositivo a borrar           
                },
    "response_code": 200,
    "response_body": 
        {
            "fieldCount":0,
            "affectedRows":1,
            "insertId":0,
            "serverStatus":2,
            "warningCount":0,
            "message":"",
            "protocol41":true,
            "changedRows":0
        }
}
``` 
</details>

</details>


## Tecnologías utilizadas 🛠️

En esta sección podés ver las tecnologías más importantes utilizadas.

<details><summary><b>Mira la lista completa de tecnologías</b></summary><br>

* [Docker](https://www.docker.com/) - Ecosistema que permite la ejecución de contenedores de software.
* [Docker Compose](https://docs.docker.com/compose/) - Herramienta que permite administrar múltiples contenedores de Docker.
* [Node JS](https://nodejs.org/es/) - Motor de ejecución de código JavaScript en backend.
* [MySQL](https://www.mysql.com/) - Base de datos para consultar y almacenar datos.
* [PHPMyAdmin](https://www.phpmyadmin.net/) - Administrador web de base de datos.
* [Material Design](https://material.io/design) - Bibliotecas de estilo responsive para aplicaciones web.
* [TypeScript](https://www.typescriptlang.org/) - Superset de JavaScript tipado y con clases.

</details>

## Contribuir 🖇️

Si estás interesado en el proyecto y te gustaría sumar fuerzas para que siga creciendo y mejorando, podés abrir un hilo de discusión para charlar tus propuestas en [este link](https://github.com/gotoiot/app-fullstack-base/issues/new). Así mismo podés leer el archivo [Contribuir.md](https://github.com/gotoiot/gotoiot-doc/wiki/Contribuir) de nuestra Wiki donde están bien explicados los pasos para que puedas enviarnos pull requests.

## Sobre Goto IoT 📖

Goto IoT es una plataforma que publica material y proyectos de código abierto bien documentados junto a una comunidad libre que colabora y promueve el conocimiento sobre IoT entre sus miembros. Acá podés ver los links más importantes:

* **[Sitio web](https://www.gotoiot.com/):** Donde se publican los artículos y proyectos sobre IoT. 
* **[Github de Goto IoT:](https://github.com/gotoiot)** Donde están alojados los proyectos para descargar y utilizar. 
* **[Comunidad de Goto IoT:](https://groups.google.com/g/gotoiot)** Donde los miembros de la comunidad intercambian información e ideas, realizan consultas, solucionan problemas y comparten novedades.
* **[Twitter de Goto IoT:](https://twitter.com/gotoiot)** Donde se publican las novedades del sitio y temas relacionados con IoT.
* **[Wiki de Goto IoT:](https://github.com/gotoiot/doc/wiki)** Donde hay información de desarrollo complementaria para ampliar el contexto.

## Muestas de agradecimiento 🎁

Si te gustó este proyecto y quisieras apoyarlo, cualquiera de estas acciones estaría más que bien para nosotros:

* Apoyar este proyecto con una ⭐ en Github para llegar a más personas.
* Sumarte a [nuestra comunidad](https://groups.google.com/g/gotoiot) abierta y dejar un feedback sobre qué te pareció el proyecto.
* [Seguirnos en twitter](https://github.com/gotoiot/doc/wiki) y dejar algún comentario o like.
* Compartir este proyecto con otras personas.

## Autores 👥

Las colaboraciones principales fueron realizadas por:

* **[Agustin Bassi](https://github.com/agustinBassi)**: Ideación, puesta en marcha y mantenimiento del proyecto.
* **[Ernesto Giggliotti](https://github.com/ernesto-g)**: Creación inicial del frontend, elección de Material Design.
* **[Brian Ducca](https://github.com/brianducca)**: Ayuda para conectar el backend a la base de datos, puesta a punto de imagen de Docker.

También podés mirar todas las personas que han participado en la [lista completa de contribuyentes](https://github.com/###/contributors).

## Licencia 📄

Este proyecto está bajo Licencia ([MIT](https://choosealicense.com/licenses/mit/)). Podés ver el archivo [LICENSE.md](LICENSE.md) para más detalles sobre el uso de este material.

---

**Copyright © Goto IoT 2021** ⌨️ [**Website**](https://www.gotoiot.com) ⌨️ [**Group**](https://groups.google.com/g/gotoiot) ⌨️ [**Github**](https://www.github.com/gotoiot) ⌨️ [**Twitter**](https://www.twitter.com/gotoiot) ⌨️ [**Wiki**](https://github.com/gotoiot/doc/wiki)
