#!/usr/bin/env bash
#

# Using a preset Vault Root Token 
vault login root

vault auth disable userpass

for x in $(vault policy list | grep -v default | grep -v root)
do
  vault policy delete $x
done
