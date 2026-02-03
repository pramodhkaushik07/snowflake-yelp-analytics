use database yelp_reviews_analysis;

create or replace table review_tbl as
select
  review_text:business_id::string as business_id,
  review_text:user_id::string as user_id,
  review_text:date::date as review_date,
  review_text:stars::number as review_stars,
  review_text:text::string as review_text
from yelp_reviews;

create or replace table user_tbl as
select
  user_text:user_id::string as user_id,
  user_text:name::string as name,
  user_text:review_count::int as review_count,
  user_text:average_stars::float as average_stars,
  user_text:yelping_since::timestamp_ntz as yelping_since
from yelp_user;

create or replace table businesses_tbl as
select
  business_text:business_id::string as business_id,
  business_text:name::string as name,
  business_text:city::string as city,
  business_text:state::string as state,
  business_text:review_count::int as review_count,
  business_text:stars::float as stars,
  business_text:categories::string as categories
from yelp_businesses;

select count(*) as review_tbl_rows from review_tbl;
select count(*) as user_tbl_rows from user_tbl;
select count(*) as businesses_tbl_rows from businesses_tbl;
