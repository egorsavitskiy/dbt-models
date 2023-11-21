

{{
    config(
        materialized='incremental',
        unique_key='date_hour',
    )
}}


select
    date_trunc('minute', time) as date_hour,
    count(distinct issue_id) as issues_touched

from ISSUE_FIELD_HISTORY

{% if is_incremental() %}

  where date_hour >= (select max(date_hour) from {{ this }})

{% endif %}

group by 1
