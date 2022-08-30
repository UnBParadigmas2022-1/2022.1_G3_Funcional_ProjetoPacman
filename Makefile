XORG_CONFIG = --net=host --env="DISPLAY" --volume="${HOME}/.Xauthority:/root/.Xauthority:rw"

build:
	docker build . -t pacman

run:
	docker run ${XORG_CONFIG} --rm --name pacman pacman
