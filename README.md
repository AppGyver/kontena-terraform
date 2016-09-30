# Kontena terraform

A bit like https://github.com/kz8s/tack/

`blueprints/` will have different Kontena deployment strategies

## TODO

 - [x] PoC 1 master, 1 mongo, 3 node cluster in aws
 - [ ] fix apply targets and security groups
 - [ ] store tfstate somehow

## setup
```
brew bundle
```

## terraform.tfvars
```
aws_profile = <aws-cli-profile-name>
aws_region = "eu-west-1"
ssh_public_key = "ssh-rsa AAAA...ASDsdasds mpa@diamond"
```

## running
```
bin/setup <blueprint>
bin/setup blueprints/aws/single
```
