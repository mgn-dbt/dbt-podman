{% if target.type == 'postgres' %}
    {{ config(materialized='table', alias='products', grants = {'select': ['lecteur']}) }}
{% else %}
    {{ config(materialized='table', alias='products') }}
{% endif %}

with
source as (
    select * from {{ ref('products') }}
)

select * from source
