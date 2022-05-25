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

## Usage

## Support

## Notes
- gcp instance names should not contain caps.
- 

## Roadmap

## Contributing

## Authors and acknowledgment

## License

## Project status
In dev
