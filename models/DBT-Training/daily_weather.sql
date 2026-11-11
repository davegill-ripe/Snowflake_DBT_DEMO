WITH DAILY_WEATHER AS (

SELECT 
DATE(TIME) AS DATE,
weather,
temp,
pressure,
humidity,
clouds

FROM {{ source('demo', 'WEATHER') }}

),

DAILY_WEATHER_AGG AS(

SELECT DATE,
weather,
round(AVG(temp),2) AS temp,
round(AVG(pressure),2) as pressure,
round(AVG(humidity),2) as humidity,
round(AVG(clouds),2) as clouds

from DAILY_WEATHER

group by 
DATE,
weather

qualify row_number() over (partition by date order by count(weather) desc)=1

)

select *
from DAILY_WEATHER_AGG