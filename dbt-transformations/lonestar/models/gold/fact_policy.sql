select
    {{ dbt_utils.generate_surrogate_key(['p.policy_id']) }} as policy_key,
    {{ dbt_utils.generate_surrogate_key(['p.customer_id']) }} as customer_key,
    {{ dbt_utils.generate_surrogate_key(['p.agent_id']) }} as agent_key,
    {{ dbt_utils.generate_surrogate_key(['a.asset_id']) }} as asset_key,
    p.policy_id,
    p.policy_type,
    p.policy_status,
    p.premium_amount,
    p.deductible,
    p.coverage_limit,
    p.effective_date,
    p.expiration_date
from {{ ref('policies') }} as p
left join {{ ref('assets') }} as a
    on p.policy_id = a.policy_id
