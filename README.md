# Docker

Here do we have a simply manual to how to run docker containers thought your machine and a little bit more as well.

### Are you ready ?

Well, our first step is the run `Dockerfile` located in the root at this project.
Throught it you can create your very first container (I'm supposing do you 
already have docker installed in your machine at all) so let's do it !

## The first script
Well, do we have it crazy `Dockerfile` file but, what exactly it does ?
```Dockerfile
FROM alpine:latest

RUN apk add curl bash
RUN echo "Oi, Solvis !"

WORKDIR /app
COPY ./execme.sh /bin/execme.sh
RUN chmod +x /bin/execme.sh

CMD [ "execme.sh" ]
```

As you can see, we have two files at this root directory, the `Dockerfile` and the `execme.sh` file. This second one is a Linux shell script I wrote using bash.

`FROM` is the base image I'm using for this container.
`RUN` Whenever I want to run any command.
`WORKDIR` Is the directory when I'll put my files.
`COPY` I'm copying a file from my project to the container.
`CMD` Is the command the container will run when I start it.

So, to run our fisrt container based on a Dockerfile do we have two steps, as I show you below.

```bash
$ docker build -t solvis-test:v1 .
```

Where the command `docker build` will create my image and the `-t` (that means TAG) is the tag of my container. You can create with only the name or put a version separated for colon (`my-container:1.0`).

And finally, run it.

You can use the command `docker images` to get the right name of the image, as I'm showing you below.
```bash
$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
solvis-test   v1        b3b020d92c5a   1 minute ago     11.8MB
```

So, let's run it
```bash
$ docker run solvis-test:v1
E ai solver, aprendendo um pouco de docker ?
```

And congratulations, you did it !

## Docker Compose
The `docker-compose` give you a possibility to run a "stack" of containers. For example, suppose do you have a wordpress application. As a pre- requisite do you need to connect it application on a database right ? The `docker-compose` enables you to use it kind of resources.

Below an example of an application up and running.
```yaml
version: '3.1'
services:
  wp:
    image: wordpress
    restart: always
    ports:
      - 8080:80
    environment: 
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wp_user
      WORDPRESS_DB_PASSWORD: wp_pass
      WORDPRESS_DB_NAME: wp
    volumes: 
      - wordpress:/var/www/html
  db:
    image: mysql:5.7
    restart: always
    environment: 
      MYSQL_DATABASE: wp
      MYSQL_USER: wp_user
      MYSQL_PASSWORD: wp_pass
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - db:/var/lib/mysql

volumes: 
  wordpress:
  db:
```

It is a content of the `docker-compose.yml` file.
`version` Is the docker-compose version.
`services` Are the services we can deliver (in this case, mysql and wordpress)
`wp` Is the name of our service.
`image` Is the base image we will use.
`ports` Port we deliver the service (in our case 8080).
`environment` Environment variables we can set on container.
`volumes` Container area we can share with our machine.

### To run it
```bash
docker-compose up
```

And voilá !