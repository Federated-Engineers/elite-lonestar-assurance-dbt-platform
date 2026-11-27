with anchor as (
    select dateadd(month, -12, max(file_date)) as window_start
    from {{ ref('fact_claim') }}
),

premiums as (
    select
        agent_key,
        sum(premium_amount) as premiums_earned
    from {{ ref('fact_policy') }}
    where effective_date >= (select anchor.window_start from anchor)
    group by 1
),

payouts as (
    select
        agent_key,
        sum(amount_paid) as total_payouts
    from {{ ref('fact_claim') }}
    where file_date >= (select anchor.window_start from anchor)
    group by 1
)

select
    g.agent_id,
    g.agency_name,
    pr.premiums_earned,
    coalesce(po.total_payouts, 0) as total_payouts,
    coalesce(po.total_payouts, 0) / nullif(pr.premiums_earned, 0) as loss_ratio,
    coalesce(po.total_payouts, 0) / nullif(pr.premiums_earned, 0)
    > 0.6 as above_60_pct
from premiums as pr
inner join {{ ref('dim_agent') }} as g
    on pr.agent_key = g.agent_key
left join payouts as po
    on pr.agent_key = po.agent_key
