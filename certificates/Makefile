.PHONY: initialize-ca

initialize-ca:
	mutagen-compose up -d
	sleep 1
	mutagen-compose exec step-ca step ca provisioner add acme --type ACME
	mutagen-compose restart step-ca

