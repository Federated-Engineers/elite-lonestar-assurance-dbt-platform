#!/bin/bash

set -e

echo "Running DBT commands"
echo "Run all dependencies to collect the required packages before dbt model execution"
dbt deps --profiles-dir . --project-dir .

echo "Run all model files holding business logic"
dbt run --profiles-dir . --project-dir .

echo "Run all predefined test cases, Test cases can be configured to warn or error"
dbt test --profiles-dir . --project-dir .

echo "Generate documentation files"
dbt docs generate --profiles-dir . --project-dir .
