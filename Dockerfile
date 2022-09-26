From python:3.8-alpine
Label MAINTAINER='Muhammad Hassan Python Developer'
ENV PYTHONUNBUFFERED 1
RUN pip install --upgrade pip
COPY ./requirements.txt /requirements.txt
RUN pip install --upgrade pip && \
    apk add --update --no-cache --virtual .build-deps \
    build-base \
    gcc \
    linux-headers && \
    pip install -r /requirements.txt && \
    apk del .build-deps && \
    adduser --disabled-password --no-create-home rsecuser && \
    mkdir -p /vol/web/static && \
    chown -R rsecuser:rsecuser /vol && \
    chmod -R 755 /vol
RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user

