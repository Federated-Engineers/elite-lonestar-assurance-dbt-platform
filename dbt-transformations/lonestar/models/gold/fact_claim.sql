select
    {{ dbt_utils.generate_surrogate_key(['c.claim_id']) }} as claim_key,
    {{ dbt_utils.generate_surrogate_key(['c.policy_id']) }} as policy_key,
    {{ dbt_utils.generate_surrogate_key(['c.asset_id']) }} as asset_key,
    {{ dbt_utils.generate_surrogate_key(['p.customer_id']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['p.agent_id']) }} as agent_key,
    c.claim_id,
    c.claim_status,
    c.amount_claimed,
    c.amount_paid,
    c.incident_date,
    c.file_date,
    datediff('day', c.incident_date, c.file_date) as days_to_file
from {{ ref('claims') }} as c
inner join {{ ref('policies') }} as p
    on c.policy_id = p.policy_id
