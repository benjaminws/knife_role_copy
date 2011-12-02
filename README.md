ROLE COPY
=========

Get data from one role, setup a new role with that data and a new name.

This plugin will actively refuse to create a role with a name that already exists.

EXAMPLE
=======

Take a look at this role.

    $ knife role show -Fj test_role
    knife role show -Fj test_role
    {
      "name": "test_role",
      "default_attributes": {
        "your": "mom"
      },
      "json_class": "Chef::Role",
      "env_run_lists": {
      },
      "run_list": [
        "recipe[fun_recipe]"
      ],
      "description": "THIS IS A TEST ROLE, LOL",
      "chef_type": "role",
      "override_attributes": {
      }
    }

Now copy it.

    $ knife role copy test_role test_role_copy
    # EDIT TO YOUR HEARTS CONTENT

Magic happens.

    $ knife role show -Fj test_role_copy
    {
      "name": "test_role_copy",
      "default_attributes": {
        "your": "mom"
      },
      "json_class": "Chef::Role",
      "env_run_lists": {
      },
      "run_list": [
        "recipe[fun_recipe]"
      ],
      "description": "THIS IS A TEST ROLE, LOL (Copy from test_role)",
      "chef_type": "role",
      "override_attributes": {
      }
    }

USAGE
=====

    $ knife role copy original_role new_role
    # drops you into $EDITOR to make any quick changes

NOTE
====

LOLJK
