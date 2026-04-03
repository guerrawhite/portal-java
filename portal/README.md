# portal — Java 1.7 + Spring + Struts2 + Hibernate

## Estructura del proyecto

```
portal/
├── Dockerfile          ← imagen multistage (Maven compila + Tomcat sirve)
├── pom.xml             ← dependencias Maven
└── src/
    └── main/
        ├── java/
        │   └── com/portal/
        │       ├── action/     ← Acciones Struts2
        │       └── service/    ← Servicios Spring
        └── webapp/
            ├── index.jsp
            └── WEB-INF/
                └── web.xml
```

## Comandos

### Construir la imagen
```bash
docker build -t portal:1.0 .
```
La primera vez tarda porque Maven descarga todas las dependencias.
Las siguientes veces es mucho más rápido gracias a la caché.

### Arrancar el contenedor
```bash
docker run -d -p 8080:8080 --name portal portal:1.0
```

### Ver la app en el navegador
```
http://localhost:8080
```

### Ver los logs de Tomcat en tiempo real
```bash
docker logs -f portal
```

### Parar y eliminar el contenedor
```bash
docker stop portal
docker rm portal
```

### Reconstruir tras cambiar código
```bash
docker stop portal && docker rm portal
docker build -t portal:1.0 .
docker run -d -p 8080:8080 --name portal portal:1.0
```

## Próximos pasos
- Añadir applicationContext.xml (Spring)
- Añadir struts.xml (Struts2)
- Añadir hibernate.cfg.xml
- Conectar MySQL (descomentar dependencia en pom.xml)
