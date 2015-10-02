FROM ubuntu
MAINTAINER "ceh@ceh.bz"

RUN apt-get update

RUN apt-get install -y \
    curl \
    emacs24-nox \
    git \
    python

RUN mkdir -p /usr/local && curl https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz | tar -xzf - -C /usr/local

ENV PATH="/usr/local/go/bin:$PATH" GOPATH=/root/go

RUN go get \
    golang.org/x/tools/cmd/godoc \
    golang.org/x/tools/cmd/goimports \
    golang.org/x/tools/cmd/oracle

RUN go get \
    github.com/golang/lint/golint \
    github.com/kisielk/errcheck \
    github.com/nsf/gocode \
    github.com/rogpeppe/godef

RUN curl -fsSkL https://raw.github.com/cask/cask/master/go | python

ENV PATH="${HOME}/.cask/bin:$PATH"
