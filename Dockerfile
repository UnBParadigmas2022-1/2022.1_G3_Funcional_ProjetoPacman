FROM haskell

MAINTAINER Antonio Aldisio <aldisiofilho@gmail.com>

COPY . pacman

WORKDIR /pacman

RUN apt-get update -y && \
    apt-get install -y libghc-openglraw-dev  && \
    apt-get install -y libghc-gluraw-dev && \
    cabal update && \
    cabal install

ENTRYPOINT ["cabal run"]