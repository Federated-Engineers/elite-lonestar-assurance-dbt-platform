select
    a.*,
    'policy_quarantined' as reject_reason
from {{ ref('stg_assets') }} as a
where exists (
    select 1
    from {{ ref('isolated_policies') }} as r
    where r.policy_id = a.policy_id
)
