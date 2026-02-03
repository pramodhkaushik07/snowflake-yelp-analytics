use database yelp_reviews_analysis;


create or replace table yelp_reviews (
  review_text variant
);

copy into yelp_reviews
from 's3://yelp-reviews-analysis/yelp_reviews/'
credentials = (
  aws_key_id = '<aws_key_id>'
  aws_secret_key = '<aws_secret_key>'
)
file_format = (type = json);

select count(*) as review_rows from yelp_reviews;



create or replace table yelp_user (
  user_text variant
);

copy into yelp_user
from 's3://yelp-reviews-analysis/yelp_academic_dataset_user.json'
credentials = (
  aws_key_id = '<aws_key_id>'
  aws_secret_key = '<aws_secret_key>'
)
file_format = (type = json);

select count(*) as user_rows from yelp_user;



create or replace table yelp_businesses (
  business_text variant
);

copy into yelp_businesses
from 's3://yelp-reviews-analysis/yelp_academic_dataset_business.json'
credentials = (
  aws_key_id = '<aws_key_id>'
  aws_secret_key = '<aws_secret_key>'
)
file_format = (type = json);

select count(*) as business_rows from yelp_businesses;
