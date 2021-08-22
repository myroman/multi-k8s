docker build -t romanpavlushchenko/multi-client:latest -t romanpavlushchenko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t romanpavlushchenko/multi-server:latest -t romanpavlushchenko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t romanpavlushchenko/multi-worker:latest -t romanpavlushchenko/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push romanpavlushchenko/multi-client:latest
docker push romanpavlushchenko/multi-server:latest
docker push romanpavlushchenko/multi-worker:latest

docker push romanpavlushchenko/multi-client:$SHA
docker push romanpavlushchenko/multi-server:$SHA
docker push romanpavlushchenko/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/client-deployment client=romanpavlushchenko/multi-client:$SHA
kubectl set image deployments/server-deployment server=romanpavlushchenko/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=romanpavlushchenko/multi-worker:$SHA