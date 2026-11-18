select
    {{ dbt_utils.generate_surrogate_key(['agent_id']) }} as agent_key,
    agent_id,
    agent_name,
    agency_name,
    license_no,
    commission_rate,
    sales_region
from {{ ref('agents') }}
