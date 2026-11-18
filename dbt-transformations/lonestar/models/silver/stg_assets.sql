{{ config(materialized='view') }}

with deduped_assets as (
    select
        src.loaded_at::timestamp as loaded_at,
        src.file_last_modified::timestamp as file_last_modified,
        ast.value:asset_id::varchar as asset_id,
        ast.value:policy_id::varchar as policy_id,
        ast.value:asset_category::varchar as asset_category,
        ast.value:asset_description::varchar as asset_description,
        ast.value:estimated_value::number(18, 2) as estimated_value,
        ast.value:location_zip::varchar as location_zip
    from {{ source('bronze', 'daily_extract_json') }} as src,
        lateral flatten(input => src.json_data:assets) as ast
)


select * from deduped_assets
qualify row_number() over (
    partition by asset_id
    order by file_last_modified desc
) = 1
