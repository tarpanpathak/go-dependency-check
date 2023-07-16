# Build - Start a golang base image
FROM golang:1.19.1-alpine

LABEL maintainer "Tarpan Pathak <tarpanpathak720@gmail.com>"

ARG APP

WORKDIR /src

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /src/${APP}

# Deploy - Start with a scratch image (no layers)
FROM scratch

ARG APP
ARG PORT

WORKDIR /

COPY --from=0 /src/${APP} /${APP}

EXPOSE ${PORT}

# TODO: Make this a variable as well
# ENTRYPOINT ["/go-dependency-check"]
ENV MYAPP=${APP}
ENTRYPOINT [ "/${MYAPP}" ]