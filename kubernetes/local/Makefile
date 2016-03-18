start:
	kubectl create -f volume.json
	kubectl create -f claim.json
	kubectl create -f service.json
	kubectl create -f pod.json
stop:
	kubectl delete -f pod.json
	kubectl delete -f service.json
purge: stop
	kubectl delete -f claim.json
	kubectl delete -f volume.json


