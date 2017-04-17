FROM alpine:3.2

# ENV PORT="8082" \
ENV	GOROOT=/usr/lib/go \
    GOPATH=/gopath \
    GOBIN=/gopath/bin \
    PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Make the source code path
RUN mkdir -p /gopath/src/go-api

WORKDIR /gopath/src/go-api
ADD . /gopath/src/go-api

RUN apk add -U git go && \
  cd /gopath/src/go-api/app && \
  go get github.com/gorilla/mux &&\
  go install &&\
  	apk del git go && \
  	rm -rf /var/cache/apk/*

# Indicate the binary as our entrypoint
ENTRYPOINT /gopath/bin/app

#Our app runs on port 8080. Expose it!
EXPOSE 8084
