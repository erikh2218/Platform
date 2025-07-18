# Arquitectura de la Plataforma

## Resumen General

La plataforma está diseñada bajo una arquitectura de microservicios, utilizando contenedores Docker para aislar y orquestar cada uno de los componentes principales. El objetivo es lograr escalabilidad, mantenibilidad y facilidad de despliegue tanto en entornos de desarrollo como de producción.

## Componentes Principales

1. **Frontend (`app_container/platform_app`)**
   - Framework: Node.js (por ejemplo, Vue, React, etc.)
   - Función: Provee la interfaz de usuario y consume los servicios expuestos por el backend.
   - Despliegue: Se ejecuta en un contenedor Docker independiente.

2. **Backend/Core (`core_container/platform_core`)**
   - Framework: PHP (Laravel u otro framework moderno)
   - Función: Expone una API RESTful para la lógica de negocio, autenticación, autorización y acceso a datos.
   - Base de datos: Conectividad a SQL Server u otro motor relacional.
   - Despliegue: Se ejecuta en un contenedor Docker independiente.

3. **Servidor Web/Proxy (`nginx_container`)**
   - Software: Nginx
   - Función: Sirve archivos estáticos del frontend y actúa como proxy inverso para enrutar las peticiones API al backend.
   - Seguridad: Puede gestionar HTTPS y balanceo de carga si es necesario.
   - Despliegue: Se ejecuta en un contenedor Docker independiente.

4. **Red de Docker (`platform-network`)**
   - Todos los contenedores se comunican a través de una red bridge personalizada, lo que permite el descubrimiento de servicios por nombre y el aislamiento del entorno.

## Flujo de Datos

1. El usuario accede a la plataforma a través del navegador, conectándose al contenedor de Nginx.
2. Nginx sirve los archivos estáticos del frontend (SPA) y enruta las peticiones API (por ejemplo, `/core/api/...`) al backend PHP.
3. El backend procesa la lógica de negocio, accede a la base de datos y responde a las solicitudes del frontend.
4. Las respuestas del backend viajan de vuelta a través de Nginx hasta el frontend, que las presenta al usuario.

## Seguridad y Buenas Prácticas

- Uso de variables de entorno para credenciales y configuraciones sensibles.
- Separación de entornos (desarrollo, producción) mediante archivos de configuración específicos (`compose.yml`, `compose.prod.yml`).
- Recomendación de habilitar HTTPS en Nginx para entornos productivos.
- Los submódulos Git permiten mantener el frontend y backend desacoplados y actualizables de forma independiente.

## Escalabilidad

- Cada componente puede escalarse de manera independiente (por ejemplo, múltiples instancias del backend o frontend).
- Nginx puede configurarse para balancear la carga entre varias instancias de backend.

## Diagrama de Arquitectura

```
[ Usuario ]
     |
 [ Nginx (nginx_container) ]
     |                |
[Frontend]        [Backend/Core]
(app_container)   (core_container)
                      |
                [Base de datos]
```
