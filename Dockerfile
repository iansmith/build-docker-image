FROM golang:1.3.1-cross

MAINTAINER k@igneous.io

RUN apt-get update
RUN apt-get install -y protobuf-compiler
RUN bash -c 'go get code.google.com/p/goprotobuf/{proto,protoc-gen-go}'

## jre for ec2 tools
## zip and wget for manipulating cruft from inet
## procps for process grep and kill functions
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y default-jre-headless zip wget procps

##
## EC2 Commands are needed, plus they are written in java
##
WORKDIR /tmp
RUN curl -O http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
RUN mkdir -p /usr/local/ec2/
WORKDIR /usr/local/ec2/
RUN unzip /tmp/ec2-api-tools.zip
ENV EC2_HOME /usr/local/ec2/ec2-api-tools-1.7.1.3
ENV JAVA_HOME /usr/lib/jvm/java-6-openjdk-amd64/jre/
ENV PATH $PATH:$EC2_HOME/bin

##
## JQ is a command line jquery processor
##
WORKDIR /bin
RUN curl -O http://stedolan.github.io/jq/download/linux64/jq
RUN chmod +x /bin/jq
