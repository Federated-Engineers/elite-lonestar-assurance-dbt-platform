select
    c.claim_status,
    a.asset_category,
    count(*) as claim_count,
    avg(c.days_to_file) as avg_days_to_file
from {{ ref('fact_claim') }} as c
inner join {{ ref('dim_asset') }} as a
    on c.asset_key = a.asset_key
group by 1, 2
