select *
from {{ ref('stg_policies') }}
qualify count(*) over (partition by policy_id) > 1
order by policy_id asc, file_last_modified desc
