{{ config(materialized = 'view') }}

select
    src.loaded_at::timestamp as loaded_at,
    src.file_last_modified::timestamp as file_last_modified,
    cl.value:claim_id::varchar as claim_id,
    cl.value:asset_id::varchar as asset_id,
    cl.value:policy_id::varchar as policy_id,
    cl.value:amount_claimed::number(18, 2) as amount_claimed,
    cl.value:amount_paid::number(18, 2) as amount_paid,
    cl.value:claim_status::varchar as claim_status,
    cl.value:file_date::date as file_date,
    cl.value:incident_date::date as incident_date
from {{ source('bronze', 'daily_extract_json') }} as src,
    lateral flatten(input => src.json_data:claims) as cl
qualify row_number() over (
    partition by claim_id
    order by file_last_modified desc
) = 1
