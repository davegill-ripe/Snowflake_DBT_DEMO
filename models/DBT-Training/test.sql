select *
from {{ source('demo', 'BIKE_RAW') }}


limit 10