FROM ubuntu:vivid
MAINTAINER "ceh@ceh.bz"

# magit needs emacs 24.4 or later, ubuntu14.04 only includes emacs 24.3...
ENV HOME=/root
WORKDIR "${HOME}"

# gcc is only needed for cgo (needed by go oracle?)
RUN \
    apt-get update &&\
    apt-get install -y \
        curl \
        emacs24-nox \
        gcc \
        git \
        python

RUN \
    curl https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz \
    | tar -xzf - -C /usr/local

ENV PATH="/usr/local/go/bin:${PATH}" GOPATH="${HOME}/go"

# golang.org tools
RUN \
    go get -u \
       golang.org/x/tools/cmd/godoc \
       golang.org/x/tools/cmd/goimports \
       golang.org/x/tools/cmd/oracle

# third party tools
RUN \
    go get -u \
       github.com/golang/lint/golint \
       github.com/kisielk/errcheck \
       github.com/nsf/gocode \
       github.com/rogpeppe/godef

ENV PATH="${GOPATH}/bin:${PATH}"

RUN \
    git clone https://github.com/cask/cask.git .cask

RUN \
    git clone https://github.com/dominikh/yasnippet-go .emacs.d/yasnippet-go

ENV PATH="${HOME}/.cask/bin:${PATH}"

COPY .emacs.d/Cask  .emacs.d/Cask

WORKDIR .emacs.d

RUN \
    cask install

COPY .emacs.d  ./

WORKDIR "${HOME}"
