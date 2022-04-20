docker build -t karthiksgd/multi-client:latest -t karthiksgd/mult-client:$SHA -f ./client/Dockerfile ./client
docker build -t karthiksgd/multi-server:latest -t karthiksgd/mult-server:$SHA -f ./server/Dockerfile ./server
docker build -t karthiksgd/multi-worker:latest -t karthiksgd/mult-worker:$SHA -f ./worker/Dockerfile ./worker

docker push karthiksgd/multi-client:latest
docker push karthiksgd/multi-server:latest
docker push karthiksgd/multi-worker:latest

docker push karthiksgd/multi-client:$SHA
docker push karthiksgd/multi-server:$SHA
docker push karthiksgd/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=karthiksgd/multi-server:$SHA
kubectl set image deployments/client-deployment client=karthiksgd/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=karthiksgd/multi-worker:$SHA
