{% if target.type == 'postgres' %}
    {{ config(materialized='table', alias='stores', grants = {'select': ['lecteur']}) }}
{% else %}
    {{ config(materialized='table', alias='stores') }}
{% endif %}

with
source as (
    select * from {{ ref('stores') }}
)

select * from source
