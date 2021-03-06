docker build -t gorbar/multi-client:latest -t gorbar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gorbar/multi-server:latest -t gorbar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gorbar/multi-worker:latest -t gorbar/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gorbar/multi-client:latest
docker push gorbar/multi-server:latest
docker push gorbar/multi-worker:latest
docker push gorbar/multi-client:$SHA
docker push gorbar/multi-server:$SHA
docker push gorbar/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=gorbar/multi-client:$SHA
kubectl set image deployments/server-deployment server=gorbar/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=gorbar/multi-worker:$SHA
