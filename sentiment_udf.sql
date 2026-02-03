use database yelp_reviews_analysis;

create or replace function vader_sentiment(text string)
returns float
language python
runtime_version = '3.11'
packages = ('vadersentiment')
handler = 'score'
as $$
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer

analyzer = SentimentIntensityAnalyzer()

def score(text):
    if text is None:
        return None
    return float(analyzer.polarity_scores(text)["compound"])
$$;

alter table review_tbl add column if not exists sentiment_score float;

update review_tbl
set sentiment_score = vader_sentiment(review_text)
where sentiment_score is null;

select
  count(*) as scored_rows
from review_tbl
where sentiment_score is not null;

select
  review_text,
  sentiment_score
from review_tbl
where sentiment_score < 0
order by sentiment_score
limit 5;
