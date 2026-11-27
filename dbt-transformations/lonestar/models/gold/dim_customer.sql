select
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
    customer_id,
    "first_name",
    "last_name",
    date_of_birth,
    "email",
    home_address,
    city,
    zip_code,
    risk_segment,
    created_at
from {{ ref('customers') }}
