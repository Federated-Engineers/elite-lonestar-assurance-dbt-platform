select *
from {{ ref('stg_policies') }}
qualify count(*) over (partition by policy_id) = 1
