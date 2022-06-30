build:
	docker build . -t pacman

run:
	docker run -it --name pacman pacman

stop:
	docker rm -f pacman