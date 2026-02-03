
 -- 1. Find number of businesses in each category 
 
with cte as (
select business_id,  trim(A.value) as category from businesses_tbl
, lateral split_to_table(categories,',') A)
select count(business_id) c, category from cte 
group by category 
order by c desc limit 10; 


-- 2. Find the top 10 users who have reviewwed the most businesses in the "restuarants" category

select user_tbl.name , count(distinct(businesses_tbl.business_id)) total_reviews from review_tbl 
join businesses_tbl on review_tbl.business_id = businesses_tbl.business_id
join user_tbl on review_tbl.user_id = user_tbl.user_id
where businesses_tbl.CATEGORIES ilike '%restaurants%'
group by user_tbl.name
order by total_reviews desc limit 10;


-- 3. Find the most popular categories of businesses based on number of reviews.

with cte as (
select business_id,  trim(A.value) as category from businesses_tbl
, lateral split_to_table(categories,',') A)
select category, count(user_id) total_reviews from cte
join review_tbl on cte.business_id = review_tbl.business_id
group by 1
order by 2 desc limit 10;


-- 4. Find the top 3 most recent reviews for each business

with cte as(
select r.*, b.name, row_number() over( partition by b.business_id order by review_date desc) as recent_reviews from review_tbl r
join businesses_tbl b on r.BUSINESS_ID = b.BUSINESS_ID )
select name,review_date,review_text from cte
where recent_reviews <= 3; 


-- 5. Find the month with the highest number of reviews

select count(*) total_reviews, month(review_date) review_month from review_tbl
group by review_month
order by total_reviews desc; 


-- 6. Find the percentage of 5-star reviews for each business

select r.business_id,b.name, count(*) total_review , count(case when review_stars = 5 then 1 else null end)  five_star, round((five_star/total_review)*100,2) pct_of_5stars from review_tbl r
join businesses_tbl b on r.business_id = b.business_id
group by r.business_id, b.name;


-- 7. Find the top 5 most reviewed businesses in each city 

Select city , name, review_count from businesses_tbl
qualify ROW_NUMBER() OVER ( PARTITION BY city ORDER BY review_count DESC) <= 5;
                      ---------or------
 with cte as(
select city, name , review_count , row_number() over (partition by city order by review_count desc) rn 
from businesses_tbl)
select city, name, review_count from cte where rn <=5;


-- 8. Find the average rating of businesses that have at least 100 reviews

select  b.name , sum(review_stars) total_stars, avg(review_stars) average_rating, count(*) total_reviews from review_tbl r
join businesses_tbl b on r.business_id = b.business_id
group by 1
having total_reviews>100;


-- 9. List the top 10 users who have written the most reviews, along with the businesses they reviewed.

with cte as (
select r.user_id ,u.name,  count(*) total_reviews from review_tbl r 
join user_tbl u on r.user_id=u.user_id
group by 1,2
order by 3 desc  limit 10 )
select c.name, b.name , r.review_stars from businesses_tbl b
join review_tbl r on b.business_id = r.business_id
join cte c  on r.user_id = c.user_id
group by 1,2,3 
order by 1;


-- 10. Find the top 10 businesses with the highest positive sentiment score

select b.name , sentiment_score  from review_tbl r
join businesses_tbl b on r.business_id = b.business_id
order by sentiment_score desc limit 10; 
