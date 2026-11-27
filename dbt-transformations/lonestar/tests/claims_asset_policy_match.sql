select c.claim_id
from {{ ref('claims') }} as c
inner join {{ ref('assets') }} as a on c.asset_id = a.asset_id
where c.policy_id <> a.policy_id
