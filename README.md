# Deploy AWS/Terraform (VPC, EC2 y ELB)

## Desafio

Usar como base este repositorio Terraform para crear:
- 3 Maquinas Virtuales en EC2 usando Terraform, en mas de una AZ. Puedes hacerlo
usando Terraform resources o modulos publicos.
- Instalar [docker-ce](https://docs.docker.com/engine/install/) en cada maquina.
Puedes usar [EC2 user data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)
, [local-exec](https://www.terraform.io/language/resources/provisioners/local-exec)
, ansible, una AMI publica/propia,... lo que mas te acomode.
- Ejecutar las siguientes imagenes docker (una en cada maquina) exponiendo el
puerto `80` en cada container:
  - `errm/cheese:wensleydale`
  - `errm/cheese:cheddar`
  - `errm/cheese:stilton`
- El paso anterior debe estar automatizado, sea cual sea la forma de hacerlo
(usando Terraform, docker-compose, docker-stack, Ansible, GitlabCI, ...).
- Configurar el firewall de cada maquina EC2 para aceptar conexiones en el
puerto `80` desde cualquier direccion IP.
- Crear un Balanceador de Carga en AWS (de cualquier tipo) usando Terraform, y
adjuntarle las 3 maquinas creadas antes como _targets_. Este LB tambien debe
aceptar conexiones en el puerto `80` desde cualquier direccion IP.
- Entregar una forma de validar el stack funcionando correctamente (usando
Shell script(s), GitlabCI, Terraform, instrucciones manuales, ...). Una forma de
ejemplo es agregando un script/job para validar que se logra hacer conexion con
el Balanceador de Carga.

Intenta documentar tu implementacion de la mejor forma que puedas, para
auto-explicar tu codigo fuente y asi disminuir la dependencia de otros hacia ti
😎 Algunas formas (no excluyentes) de lograrlo son:
- Comentando tu codigo fuente,
- Creando archivos `.md` en cada subcarpeta que estimes conveniente,
- Creando un pipeline como codigo, con nombres de jobs/stages auto-explicativos
y comentados en el mismo codigo,
- Usando commit messages descriptivos ([referencia](https://www.conventionalcommits.org/es/v1.0.0-beta.2/)),
- Describiendo Pull/Merge requests usando su descripcion en notacion Markdown,
- Indicando cualquier dependencia externa, como variables de entorno, CLIs o
instrucciones de uso.

## TO DO

✋ Si te ves bloqueado en alguno de los pasos, no te frustres! Busca una forma de
saltarlo, una implementacion alternativa o simplemente dejarlo pendiente para
continuar con las siguientes tareas. Recuerda que en el mundo real las
implementaciones son iterativas y SIEMPRE mejorables.

## EOF

*Nota: los tildes han sido omitidos intencionalmente para facilitar la escritura
en teclados en ingles* 😬
