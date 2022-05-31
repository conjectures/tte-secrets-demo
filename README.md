# TGE Demo

## Description
Demo for Temporary GCP Environment


## Visuals
Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation
Clone from gitlab

### Requirements
- Terraform
- google account, and credits in gcp
- gcloud cli (optional)

### Steps
Initialise terraform before running
```
terraform init
```
Authorise with google account (using gcloud cli or other methods)
Make project
Edit project name to local vars 
Enable following google APIs:
* secretmanager.googleapis.com
* compute.googleapis.com
* servicenetworking.googleapis.com
Run `terraform plan` to validate, then `terraform apply`
Log in to GCP after the apply command is done and head to the main console. 
Open a cloud shell tab and ssh into the VM:
```
gcloud compute ssh --zone "<zone-id>" "<instance-name>"  --project "<project-name>"
```
Create SSH Keys if required, or enter the passphrase to log in to the machine.
Install the [SQL Server client for ubuntu 20.04](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-2017#connect-locally):
```
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list
sudo apt-get update 
sudo apt-get install mssql-tools unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
```
Finally, connect the VM with the SQL Server instance:
```
sqclcmd -S <SQL Server External IP> -U sqlserver
```
The password should be the sercret value stored in GCP Secrets Manager.

If the  SQL Server prompt appears (`1>`), the connection to SQL Server is established. 
The mssql client will collect all the queries until the command `GO` is given, this will execute all previous queries.


## Usage

## Support

## Notes / Learnings
- GCP instance names should not contain caps.
- In order to use private IP to configure a Cloud SQL resource, a private service access is required. This allows private connections between a VPC and the google service VPC

## Roadmap

## Contributing

## Authors and acknowledgment

## License

## Project status
In dev
