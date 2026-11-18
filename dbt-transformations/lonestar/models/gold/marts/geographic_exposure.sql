select
    a.location_zip,
    p.policy_type,
    count(*) as policy_count,
    sum(p.coverage_limit) as sum_at_risk,
    sum(p.premium_amount) as net_premiums,
    sum(p.coverage_limit)
    / nullif(sum(p.premium_amount), 0) as exposure_to_premium_ratio
from {{ ref('fact_policy') }} as p
left join {{ ref('dim_asset') }} as a
    on p.asset_key = a.asset_key
group by 1, 2
