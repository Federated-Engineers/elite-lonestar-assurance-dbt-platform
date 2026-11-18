-- select * from (
--     select * from {{ ref('stg_claims') }}
--     qualify row_number() over (
--         partition by claim_id
--         order by file_last_modified desc
--     ) = 1
-- )
-- where asset_id is not null


select c.*
from {{ ref('stg_claims') }} as c
where not exists (
    select 1
    from {{ ref('isolated_claims') }} as i
    where i.claim_id = c.claim_id
)
