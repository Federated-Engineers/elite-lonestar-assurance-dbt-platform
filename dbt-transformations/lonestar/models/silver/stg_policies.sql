{{ config(materialized='view') }}

select
    src.loaded_at::timestamp as loaded_at,
    src.file_last_modified::timestamp as file_last_modified,
    pol.value:policy_id::varchar as policy_id,
    pol.value:customer_id::varchar as customer_id,
    pol.value:agent_id::varchar as agent_id,
    pol.value:policy_type::varchar as policy_type,
    pol.value:premium_amount::number(18, 2) as premium_amount,
    pol.value:deductible::number(18, 2) as deductible,
    pol.value:coverage_limit::number(18, 2) as coverage_limit,
    pol.value:effective_date::date as effective_date,
    pol.value:expiration_date::date as expiration_date,
    pol.value:policy_status::varchar as policy_status
from {{ source('bronze', 'daily_extract_json') }} as src,
    lateral flatten(input => src.json_data:policies) as pol
