with anchor as (
    select dateadd(month, -6, max(file_date)) as window_start
    from {{ ref('fact_claim') }}
),

hv_claims as (
    select
        c.claim_key,
        c.policy_key,
        c.amount_claimed
    from {{ ref('fact_claim') }} as c
    inner join {{ ref('dim_asset') }} as a
        on c.asset_key = a.asset_key
    where
        a.estimated_value > 100000
        and c.file_date >= (select anchor.window_start from anchor)
),

hv_policies as (
    select distinct
        h.policy_key,
        p.deductible
    from hv_claims as h
    inner join {{ ref('fact_policy') }} as p
        on h.policy_key = p.policy_key
)

select
    (select count(*) from hv_claims) as claim_count,
    (select sum(amount_claimed) from hv_claims) as total_amount_claimed,
    (select sum(deductible) from hv_policies) as total_deductibles,
    (select sum(amount_claimed) from hv_claims)
    / nullif((select sum(deductible) from hv_policies), 0)
        as claimed_to_deductible_ratio
