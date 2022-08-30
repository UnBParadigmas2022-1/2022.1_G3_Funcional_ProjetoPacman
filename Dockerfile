FROM ubuntu:latest

COPY . pacman

WORKDIR /pacman

RUN apt-get update -y
RUN apt-get install -y xauth
RUN apt-get install -y haskell-platform cabal-install
RUN cabal update && cabal v2-build

ENTRYPOINT ["cabal", "run"]