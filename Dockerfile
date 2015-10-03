FROM ubuntu:vivid
MAINTAINER "ceh@ceh.bz"

# magit needs emacs 24.4 or later, ubuntu14.04 only includes emacs 24.3...
ENV HOME=/root
WORKDIR "${HOME}"

RUN \
    apt-get update &&\
    apt-get install -y \
        curl \
        emacs24-nox \
        git \
        python

RUN \
    curl https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz \
    | tar -xzf - -C /usr/local

ENV PATH="/usr/local/go/bin:${PATH}" GOPATH="${HOME}/go"

RUN \
    go get -u \
       golang.org/x/tools/cmd/godoc \
       golang.org/x/tools/cmd/goimports \
       golang.org/x/tools/cmd/oracle

RUN \
    go get -u \
       github.com/golang/lint/golint \
       github.com/kisielk/errcheck \
       github.com/nsf/gocode \
       github.com/rogpeppe/godef

ENV PATH="${GOPATH}/bin:${PATH}"

RUN \
    git clone https://github.com/cask/cask.git .cask

ENV PATH="${HOME}/.cask/bin:${PATH}"

COPY .emacs.d  .emacs.d/

WORKDIR .emacs.d

RUN \
    cask install

WORKDIR "${HOME}"
