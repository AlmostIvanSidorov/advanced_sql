SELECT ROW_NUMBER() OVER(ORDER BY subs  DESC ,avg_likes  DESC,avg_comments DESC) as num,blogger,subs,avg_likes,avg_comments FROM bloggers ORDER BY subs  DESC,avg_likes  DESC,avg_comments  DESC

SELECT ROW_NUMBER() OVER(PARTITION BY blogger ORDER BY likes DESC) as post_popularity, blogger, post, likes FROM bloggers_posts

SELECT blogger, post, likes,SUM(likes) OVER() as total_likes, round(likes*100/sum(likes) over(), 2) as percent FROM (SELECT ROW_NUMBER() OVER(PARTITION BY blogger ORDER BY likes DESC) as post_popularity, blogger, post, likes FROM bloggers_posts) temp_table WHERE post_popularity=1 ORDER BY percent DESC

SELECT blogger, post, likes,total_likes, round(likes*100/total_likes, 2) as percent FROM (SELECT ROW_NUMBER() OVER(PARTITION BY blogger ORDER BY likes DESC) as post_popularity, blogger, post, likes, SUM(likes) OVER() as total_likes FROM bloggers_posts) temp_table WHERE post_popularity=1 ORDER BY percent DESC