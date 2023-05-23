FROM python:3.9-alpine3.13
LABEL maintainer="SocialIn"

ENV PYTHONUNBUFFERED = 1

COPY ./socialin/requirements.txt /requirements.txt
COPY ./socialin /socialin
COPY ./scripts /scripts

WORKDIR /socialin
EXPOSE 8000

RUN python3.9 -m venv /py

RUN /py/bin/pip install --upgrade pip

RUN echo -e "https://ftp.halifax.rwth-aachen.de/alpine/v3.13/main\nhttps://ftp.halifax.rwth-aachen.de/alpine/v3.13/community" > /etc/apk/repositories    

RUN apk add --update --no-cache postgresql-client 
    
RUN apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers

RUN /py/bin/python3.9 -m pip install -r /requirements.txt

RUN apk del .tmp-deps

RUN adduser --disabled-password --no-create-home app

RUN mkdir -p /vol/web/static
RUN mkdir -p /vol/web/media
RUN chown -R app:app /vol
RUN chmod -R 755 /vol
RUN chmod -R +x /scripts

ENV PATH="/scripts:/py/bin:$PATH"

USER app
WORKDIR /socialin/backend

CMD [ "run.sh" ]