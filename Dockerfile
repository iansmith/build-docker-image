FROM golang:1.3.1-cross

MAINTAINER k@igneous.io

RUN apt-get update
RUN apt-get install -y protobuf-compiler
RUN bash -c 'go get code.google.com/p/goprotobuf/{proto,protoc-gen-go}'
