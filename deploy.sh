docker build -t kazu884/multi-docker-client:latest -t kazu884/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t kazu884/multi-docker-server:latest -t kazu884/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t kazu884/multi-docker-worker:latest -t kazu884/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kazu884/multi-docker-client:latest
docker push kazu884/multi-docker-server:latest
docker push kazu884/multi-docker-worker:latest

docker push kazu884/multi-docker-client:$SHA
docker push kazu884/multi-docker-server:$SHA
docker push kazu884/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kazu884/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=kazu884/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=kazu884/multi-docker-worker:$SHA