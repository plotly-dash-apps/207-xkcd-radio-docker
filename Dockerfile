FROM python:3.10-slim
ARG port

USER root
COPY . /207-xkcd-radio-docker
WORKDIR /207-xkcd-radio-docker

ENV PORT=$port

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
    && apt-get -y install curl \
    && apt-get install libgomp1

RUN chgrp -R 0 /207-xkcd-radio-docker \
    && chmod -R g=u /207-xkcd-radio-docker \
    && pip install pip --upgrade \
    && pip install -r requirements.txt
EXPOSE $PORT

CMD gunicorn app:server --bind 0.0.0.0:$PORT --preload
