{% if target.type == 'postgres' %}
    {{ config(materialized='table', alias='supplies', grants = {'select': ['lecteur']}) }}
{% else %}
    {{ config(materialized='table', alias='supplies' ) }}
{% endif %}

with
source as (
    select * from {{ ref('supplies') }}
)

select * from source
