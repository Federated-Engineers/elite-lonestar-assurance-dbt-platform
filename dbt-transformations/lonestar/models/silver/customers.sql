with deduped_customers as (
    select
        src.loaded_at::timestamp as loaded_at,
        src.file_last_modified::timestamp as file_last_modified,
        cus.value:customer_id::varchar as customer_id,
        cus.value:first_name::varchar as "first_name",
        cus.value:last_name::varchar as "last_name",
        cus.value:dob::date as date_of_birth,
        cus.value:email::varchar as "email",
        cus.value:home_address::varchar as home_address,
        cus.value:city::varchar as city,
        cus.value:zip_code::varchar as zip_code,
        cus.value:risk_segment::varchar as risk_segment,
        cus.value:created_at::date as created_at
    from {{ source('bronze', 'daily_extract_json') }} as src,
        lateral flatten(input => src.json_data:customers) as cus
)

select * from deduped_customers
qualify row_number() over (
    partition by customer_id
    order by file_last_modified desc
) = 1
