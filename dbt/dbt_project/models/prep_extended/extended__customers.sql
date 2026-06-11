{% if target.type == 'postgres' %}
    {{ config(materialized='table', alias='customers', grants = {'select': ['lecteur']}) }}
{% else %}
    {{ config(materialized='table', alias='customers') }}
{% endif %}

with
source as (
    select * from {{ ref('customers') }}
)

select * from source
