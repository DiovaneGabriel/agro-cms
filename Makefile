NODE_IMAGE = strapi-node-app:1.0
NODE_CONTAINER = node

up:
	docker compose up -d

down:
	docker compose down

bash:
	docker exec -it ${NODE_CONTAINER} /bin/sh

update:
	docker run -it -v ./:/app ${NODE_IMAGE} /bin/sh -c "npm i"

install:
	docker build -f .docker/node/Dockerfile -t ${NODE_IMAGE} . && \
	docker run -it -v ./app:/app ${NODE_IMAGE} /bin/sh -c "npx create-strapi-app@latest . && npm i" && \
	sudo chmod -R 777 . && \
	mv ./app/* . && \
	mv ./app/.editorconfig . && \
	mv ./app/.env . && \
	mv ./app/.env.example . && \
	mv ./app/.gitignore . && \
	docker container prune -f && \
	docker compose up -d