select
    src.loaded_at::timestamp as loaded_at,
    src.file_last_modified::timestamp as file_last_modified,
    ag.value:agent_id::varchar as agent_id,
    ag.value:agency_name::varchar as agency_name,
    ag.value:agent_full_name::varchar as agent_name,
    ag.value:commission_rate::number(18, 2) as commission_rate,
    ag.value:license_no::varchar as license_no,
    ag.value:sales_region::varchar as sales_region
from {{ source('bronze', 'daily_extract_json') }} as src,
    lateral flatten(input => src.json_data:agents) as ag
