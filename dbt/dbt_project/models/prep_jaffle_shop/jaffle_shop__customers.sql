{% if target.type == 'postgres' %}
    {{ config(materialized='table', alias='customers', grants = {'select': ['lecteur']}) }}
{% else %}
    {{ config(materialized='table', alias='customers') }}
{% endif %}

with
source as (
    select * from {{ ref('raw_customers') }}
),

transformed as (
select 
    {{ dbt.cast('id', dbt.type_int()) }} as id,
    first_name,
    last_name
from source
)

select * from transformed
