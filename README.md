# Migration

Script que te ayuda a migrar desde SVN a GIT sin perder el historial, los autores, los branches y los tags.

## Requirements

```
apt-get install git git-svn subversion direnv
```

## Configuration

Requiere las siguientes variables de ambiente configuradas en el sistema

Se provee un ejemplo de configuracion con direnv.

* PROJECT_NAME : El nombre de tu proyecto
* EMAIL : El dominio de tu organizacion, por ejemplo google.com.ar
* BASE_SVN : La URL del repositorio a migrar desde SVN
* BRANCHES : La URI raiz de tus branches (por defecto /branches)
* TAGS : La URI raiz de tus tags (por defecto /tags)
* TRUNK : La URI raiz de tu trunk (por defecto /trunk)
* ABSOLUTE_PATH : El directorio en donde se ubicara la copia local del repositorio de GIT
* GIT_PAT : Personal access token de Github o [Gitlab](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html).
* GIT_URL : La URL de git del repositorio destino

## Ejecución

#### Migracion

Primero ejecutamos la migracion. Este comando genera el repositorio de git de forma local y comienza la migracion. 

```bash
./migrate.sh
```

#### Push a git remoto

Una vez finalizada la migracion podemos empujar los cambios al nuevo repositorio remoto de git. El repositorio debe haber sido creado previamente y debe encontrarse vacío.

```bash
./push-to-remote.sh
```
