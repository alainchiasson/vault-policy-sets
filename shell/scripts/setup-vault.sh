#!/usr/bin/env bash
#

# Using a preset Vault Root Token 
vault login root

# Enable audit log to console
vault audit enable file file_path=stdout

# Enable vault user-pass 
vault auth enable userpass

# Add User Policies
vault policy write view_identity_01 - <<EOF
path "identity/entity/*" {
    capabilities = ["list","read"]
}

EOF

# Add User Policies
vault policy write view_identity_02 - <<EOF
path "identity/entity/id" {
    capabilities = ["list"]
}

path "identity/entity/name" {
    capabilities = ["list"]
}

path "identity/entity/id/*" {
    capabilities = ["read"]
}

path "identity/entity/name/*" {
    capabilities = ["read"]
}
EOF

# Add User Policies
vault policy write view_entity-alias_01 - <<EOF
path "identity/entity-alias/id" {
    capabilities = ["list"]
}

path "identity/entity-alias/id/*" {
    capabilities = ["read"]
}
EOF


# Add users 
vault write auth/userpass/users/user01 password=user01 token_policies=default,view_identity_01
vault write auth/userpass/users/user02 password=user02 token_policies=default,view_identity_02
vault write auth/userpass/users/user03 password=user03 token_policies=default,view_entity-alias_01

# combo user
vault write auth/userpass/users/user04 password=user04 token_policies=default,view_entity-alias_01,view_identity_02


