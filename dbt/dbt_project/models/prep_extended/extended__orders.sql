{% if target.type == 'postgres' %}
    {{ config(materialized='table', alias='orders', grants = {'select': ['lecteur']}) }}
{% else %}
    {{ config(materialized='table', alias='orders') }}
{% endif %}

with
source as (
    select * from {{ ref('orders') }}
)

select * from source
