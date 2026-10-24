# elite-lonestar-assurance-dbt-platform

This dcoument has a walkthrough of how to use this repository to setup the dbt platform.

## Prerepuisites

- ## setup environment variables scripts locally

- ### `test-env.sh`

        ```bash

        PARENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

        export DBT_TARGET=test
        export DBT_SNOWFLAKE_ACCOUNT=<account_name>
        export DBT_USER=<username>
        export DBT_ROLE=<role>
        export WAREHOUSE=<warehouse>
        export DATABASE=<database>
        export SCHEMA=<schema>                               
        export SNOWFLAKE_DBT_PRIVATE_KEY="$(cat "$PARENT_DIR/private_keys/dbt_test_key.pem")"

        ```

- ### `terraform-env.sh`

        ```bash

        export SNOWFLAKE_TERRAFORM_PRIVATE_KEY="$(cat "$PARENT_DIR/private_keys/terraform_test_key.p8")"                                    
        export TF_VAR_dbt_public_key="$(grep -v 'PUBLIC KEY' "$PARENT_DIR/public_keys/dbt_test_key.pub" | tr -d '\n')"

        ```

- ## containerize dbt
        - cd into the dockerfile directory
        - build dbt-docker base image: `docker build -t <image-name:version-tag> .`
        - source the environment variables script: `source <path/to/env.sh>`
        - run container to test connection:

            ```bash
            docker run --rm --name <project-container-name> -e <environment variables> <image-name> <command>

            # sample below
            docker run --rm --name project-container-name \
            -e DBT_SNOWFLAKE_ACOUNT \
            -e <ANOTHER_VARIABLE> \
            image-name debug
            ```
