FROM alpine:3.11
ADD requirements.txt .
RUN apk add --update python python-dev g++ py2-pip libev bind-tools && \
    pip install -r requirements.txt && \
    apk del python-dev g++ py2-pip libev && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*
ADD dockerdns .
EXPOSE 53
ENTRYPOINT ["./dockerdns"]
