# postgre-backup-cronjob-k8s

These files in this repo are to use to backup separated database in PostgreSQL. The backup files will be stored in Azure Storage Account with retention of 30 days

First we need to build the Docker Image and push to Docker Hub or the other repo
`docker build -t cuongtnh/postgres-back-up:latest .`

`docker push cuongtnh/postgres-back-up:latest`

Then, we create the CronJob in k8s cluster

`kubectl apply -f Backup-Cronjob.yml`
