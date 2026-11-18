with type_avg as (
    select
        policy_type,
        avg(premium_amount) as avg_premium
    from {{ ref('fact_policy') }}
    group by 1
),

single_policy_customers as (
    select
        p.customer_key,
        max(p.policy_type) as held_policy_type,
        sum(p.premium_amount) as current_premium
    from {{ ref('fact_policy') }} as p
    group by 1
    having count(*) = 1
)

select
    c.customer_id,
    c.risk_segment,
    s.held_policy_type,
    s.current_premium,
    avg(t.avg_premium) as potential_added_premium
from single_policy_customers as s
inner join {{ ref('dim_customer') }} as c
    on s.customer_key = c.customer_key
inner join type_avg as t
    on s.held_policy_type != t.policy_type
where c.risk_segment = 'Preferred'
group by 1, 2, 3, 4
