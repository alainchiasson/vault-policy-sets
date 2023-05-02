#!/usr/bin/env bash
#

test_cap () {
    echo "Testing : $1"
    echo -n "Result  : "
    vault token capabilities $1
}

echo "Loop through test users"

for x in $(vault list -format=json auth/userpass/users  | jq -r '.[]')
do

echo "Login as $x"
# Login as User 1 - Note VAULT TOKEN gets stored in helper (~/.vault-token)
vault login -method=userpass username=$x password=$x

# Test capabilities - identity
test_cap /identity/entity
test_cap /identity/entity/id
test_cap /identity/entity/name
test_cap /identity/entity/id/01
test_cap /identity/entity/name/01
test_cap /identity/entity/batch-delete
test_cap /identity/entity/merge

# Test capabilities - entity-alias
test_cap /identity/entity-alias
test_cap /identity/entity-alias/id
test_cap /identity/entity-alias/id/01

done