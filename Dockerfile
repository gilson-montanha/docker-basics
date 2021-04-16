FROM alpine:latest

RUN apk add curl bash

RUN echo "Oi, Solvis !"

WORKDIR /app
COPY ./execme.sh /bin/execme.sh
RUN chmod +x /bin/execme.sh

CMD [ "execme.sh" ]
