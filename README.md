# snowflake-yelp-intelligence

## Overview
This project demonstrates an **end-to-end analytics and intelligence workflow built on Snowflake** using Yelp’s semi-structured review data. The pipeline ingests raw JSON files from Amazon S3, models them relationally, enriches review text with sentiment using a Python UDF, and answers business-driven analytical questions using advanced SQL and window functions.

The focus is on **working with large-scale semi-structured data in Snowflake**, applying sound data modeling practices, and deriving meaningful insights rather than isolated queries.

---

## Objective
The objective of this project is to transform raw Yelp JSON data into an analytics-ready structure and generate **actionable insights** about businesses, users, reviews, and sentiment by leveraging Snowflake’s native support for semi-structured data and SQL analytics.

---

## Analytical Focus
The core focus of this project is to understand **what drives business visibility and customer engagement on Yelp**, and how user behavior, review volume, ratings, and sentiment collectively shape business performance.

The analysis is designed to move beyond surface-level metrics and answer questions such as:

- **Market Structure and Exposure**  
  Analyze how businesses are distributed across categories and geographies to understand where competition is concentrated and which segments attract the most attention.

- **User Contribution and Influence**  
  Identify highly active reviewers and assess how a small subset of users contributes disproportionately to overall review volume and business visibility.

- **Engagement-Driven Popularity**  
  Evaluate which businesses and categories receive the highest review activity, using review volume as a proxy for customer engagement rather than relying solely on ratings.

- **Temporal Behavior Patterns**  
  Examine how review activity evolves over time to uncover periods of heightened engagement and shifts in user behavior.

- **Ratings vs. Sentiment Dynamics**  
  Compare numerical star ratings with sentiment derived from review text to capture qualitative signals that ratings alone fail to explain.


Together, these analyses provide a holistic view of business performance and customer behavior, demonstrating how semi-structured data can be transformed into **decision-ready insights** using Snowflake as the analytical backbone.

---

## Data Source
The dataset used in this project is the official Yelp Open Dataset.

**Note:** Due to size constraints, the dataset is not included in this repository.  
You can download the raw JSON files directly from Yelp here:  
https://business.yelp.com/external-assets/files/Yelp-JSON.zip

---

## Architecture
1. Yelp JSON files are downloaded and split using Python  
2. Files are uploaded to Amazon S3  
3. Snowflake ingests JSON data from S3 using `COPY INTO`  
4. Raw data is stored in `VARIANT` tables  
5. Curated relational tables are created for reviews, users, and businesses  
6. Review text is enriched with sentiment using a Python UDF  
7. Analytical SQL queries are executed to generate insights  

---

## Data Modeling
The project follows a **raw → curated** modeling approach.

### Raw Tables
- `yelp_reviews` (VARIANT)  
- `yelp_user` (VARIANT)  
- `yelp_businesses` (VARIANT)  

### Curated Tables
- `review_tbl`  
- `user_tbl`  
- `businesses_tbl`  

This separation ensures that raw data remains unchanged while curated tables are optimized for analytics and querying.

---

## Sentiment Analysis
Review text is enriched using a **Python UDF in Snowflake** based on the VADER sentiment analyzer.  
Each review is assigned a normalized sentiment score between `-1` (negative) and `+1` (positive), enabling sentiment-based analysis alongside structured star ratings.

---

## Technologies Used
- Snowflake (SQL, VARIANT, window functions, Python UDFs)  
- Amazon S3  
- Python  
- Yelp Open Dataset (JSON)  

---

## Key Takeaways
- Demonstrates a true end-to-end analytics workflow on Snowflake  
- Handles large-scale semi-structured JSON data from Amazon S3  
- Applies relational modeling for analytics-ready datasets  
- Enriches unstructured text with sentiment using Python UDFs  
- Focuses on business-driven insights rather than simple reporting  

---

## License
MIT License

