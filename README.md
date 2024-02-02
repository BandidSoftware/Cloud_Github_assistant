# Git-Radar

## Introducción

Git-Radar es una plataforma diseñada para proporcionar análisis y predicciones sobre el código fuente, mejorando la productividad y la calidad del desarrollo de software. Este README detalla la arquitectura, módulos y cómo utilizar esta plataforma.

## Utilización

### Despliegue con LocalStack

1. Navega a la carpeta `infrastructure`.
2. Ejecuta `tflocal init` para inicializar Terraform.
3. Ejecuta `tflocal plan -out "plan"` para planificar los recursos.
4. Ejecuta `tflocal apply "plan"` para desplegar los recursos en LocalStack.

### API URL

La URL de la API tendrá el siguiente formato (sin endpoint):
- http://<apiId>.execute-api.localhost.localstack.cloud:4566/test/
Obtén el `apiId` con:
- awslocal apigateway get-rest-apis


## Future Work

Áreas de mejora:

- Diferenciación de Usuarios
- Ampliación de Funcionalidades de Análisis
- Funciones de Colaboración
- Investigación en Modelos de Predicción Avanzados
- Optimización de recursos y configuraciones.

## Conclusión

Git-Radar ofrece análisis y predicciones sobre código fuente. Se ha aplicado principios de desarrollo de software y se han explorado herramientas como Terraform y LocalStack. Se delinean áreas de mejora para futuras versiones.

Se puede ver el papper con mas información en https://github.com/BandidSoftware/Git-Radar/blob/develop/TSCD_Trabajo.pdf
El codigo actualmenete se encuentra en la rama de develop 
