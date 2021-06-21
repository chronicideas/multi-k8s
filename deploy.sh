docker build -t chronicideas/multi-client:latest -t chronicideas/multi-client:$GIT_SHA  -f ./client/Dockerfile ./client
docker build -t chronicideas/multi-server:latest -t chronicideas/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t chronicideas/multi-worker:latest -t chronicideas/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push chronicideas/multi-client:latest
docker push chronicideas/multi-server:latest
docker push chronicideas/multi-worker:latest

docker push chronicideas/multi-client:$GIT_SHA
docker push chronicideas/multi-server:$GIT_SHA
docker push chronicideas/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=chronicideas/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=chronicideas/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=chronicideas/multi-worker:$GIT_SHA