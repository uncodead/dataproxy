build:
	docker build -t dataproxy .

run:
	docker run -it --name dataproxy -d -p 80:80 dataproxy

drop:
	docker stop dataproxy && docker rm dataproxy