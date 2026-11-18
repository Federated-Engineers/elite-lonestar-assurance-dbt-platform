with bad_assets as (
    select distinct asset_id from {{ ref('isolated_assets') }}
),

bad_policies as (
    select distinct policy_id from {{ ref('isolated_policies') }}
),

good_assets as (
    select
        asset_id,
        policy_id as asset_policy_id
    from {{ ref('assets') }}
)

select
    c.*,
    case
        when c.asset_id is null then 'null_asset_id'
        when ba.asset_id is not null then 'asset_quarantined'
        when ga.asset_id is null then 'asset_not_found'
        when bp.policy_id is not null then 'policy_quarantined'
        else 'policy_mismatch'
    end as reject_reason
from {{ ref('stg_claims') }} as c
left join bad_assets as ba on c.asset_id = ba.asset_id
left join good_assets as ga on c.asset_id = ga.asset_id
left join bad_policies as bp on c.policy_id = bp.policy_id
where
    c.asset_id is null
    or ba.asset_id is not null
    or ga.asset_id is null
    or bp.policy_id is not null
    or c.policy_id <> ga.asset_policy_id
