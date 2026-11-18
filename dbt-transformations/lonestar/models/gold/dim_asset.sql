select
    {{ dbt_utils.generate_surrogate_key(['asset_id']) }} as asset_key,
    asset_id,
    asset_category,
    asset_description,
    estimated_value,
    location_zip
from {{ ref('assets') }}
