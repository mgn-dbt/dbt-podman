{% if target.type == 'postgres' %}
    {{ config(materialized='table', alias='items', grants = {'select': ['lecteur']}) }}
{% else %}
    {{ config(materialized='table', alias='items') }}
{% endif %}

with
source as (
    select * from {{ ref('items') }}
)

select * from source
