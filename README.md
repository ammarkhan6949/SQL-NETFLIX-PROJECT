# SQL-NETFLIX-PROJECT

![](https://github.com/ammarkhan6949/SQL-NETFLIX-PROJECT/blob/main/NETFLIX%20LOGO%20.png)

🎬 Netflix Data Analysis Using SQL
🧾 Overview

This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL.
The goal is to extract valuable insights and answer various business questions based on the dataset.
This README includes the project’s objectives, schema, business problems with SQL solutions, findings, and conclusion.

🎯 Objectives

Analyze the distribution of content types (Movies vs TV Shows).

Identify the most common ratings for both Movies and TV Shows.

Retrieve and analyze content based on release years, countries, and duration.

Categorize and explore data using specific criteria and keywords.

📊 Dataset

The dataset used in this project is the Netflix dataset containing details about movies and TV shows available on the platform.

🧱 Schema
```sql
create database netflix;
use netflix;

CREATE TABLE netflix (
    show_id VARCHAR(20),
    type VARCHAR(20),
    title TEXT CHARACTER SET utf8mb4,
    director TEXT CHARACTER SET utf8mb4,
    cast TEXT CHARACTER SET utf8mb4,
    country TEXT CHARACTER SET utf8mb4,
    date_added TEXT,
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in TEXT CHARACTER SET utf8mb4,
    description TEXT CHARACTER SET utf8mb4
) CHARACTER SET=utf8mb4;
  select * from  netflix_titles;
  drop database  netflix_db;
  rename table netflix_titles to netflix_data;
  ```

## Business Problems and SQL Solutions
 ### Q1: Count the number of Movies vs TV Shows
```sql
  SELECT 
    TYPE, COUNT(*) AS TOTAL
FROM
    NETFLIX_DATA
GROUP BY TYPE;
```


### Q2: Find the most common rating for movies and TV shows

select 
type,
rating
from
(select 
    type,
    rating,
    count(*) as totle,
    rank() over(partition by type order by count(*) desc ) as ranking
from netflix_data
group by type, rating) as a1
where ranking =1;



### Q3: List all movies released in a specific year (e.g., 2020)


 select * from netflix_data;
SELECT 
    title, type
FROM
    netflix_data
WHERE
    type = 'movie' AND release_year = 2020;
     use netflix;
     
     
  ### Q4: Find the top 5 countries with the most content on Netflix
   
     
SELECT 
    c.country,
    COUNT(*) AS total_shows
FROM netflix_data n
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(n.country, ',', '","'), '"]'),
    '$[*]' COLUMNS (country VARCHAR(100) PATH '$')
) AS c
WHERE c.country IS NOT NULL AND c.country != ''
GROUP BY c.country
ORDER BY total_shows DESC
LIMIT 5;


### Q5: Identify the longest movie


SELECT 
    title, MAX(duration)
FROM
    netflix_data
WHERE
    type = 'movie'
GROUP BY title
ORDER BY MAX(duration) DESC;



### Q6: Find content added in the last 5 years

SELECT 
    title, date_added
FROM
    netflix_data
WHERE
    STR_TO_DATE(date_added, '%M %d, %Y') >= CURDATE() - INTERVAL 5 YEAR;
    
    

### Q7: Find all the movies/TV shows by director 'Rajiv Chilaka'

    
    SELECT 
    *
FROM
    netflix_data
WHERE
    director LIKE '%rajiv chilaka%';
    
   
   
   
### Q8: List all TV shows with more than 5 seasons

    
    SELECT 
    *
FROM
    netflix_data
WHERE
    type = 'TV Show'
        AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;
        
        
  
  
  -- Q9: Count the number of content items in each genre

        
SELECT
    g.genre,
    COUNT(n.show_id) AS total_content
FROM netflix_data n
JOIN JSON_TABLE(
    CONCAT('["', REPLACE(n.listed_in, ',', '","'), '"]'),
    '$[*]' COLUMNS (genre VARCHAR(100) PATH '$')
) AS g
GROUP BY g.genre
ORDER BY total_content DESC;




### Q10: Find each year and the average number of content releases in India on Netflix.Return the top 5 years with the highest average content releases


SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year,
    COUNT(*) AS year_count,
    (COUNT(*) * 100.0 / (SELECT 
            COUNT(*)
        FROM
            netflix_data
        WHERE
            country = 'India')) AS percentage
FROM
    netflix_data
WHERE
    country = 'India'
GROUP BY year
ORDER BY year;
 
 
 
 
 ### Q11: List all movies that are documentaries

 
SELECT 
    *
FROM
    netflix_data
WHERE
    listed_in LIKE '%documentaries%';
    
    
### Q12: Find all content without a director
   
    
  SELECT 
    *
FROM
    netflix_data
WHERE
    director IS NULL OR director = '';
    


-- Q13: Find how many movies actor 'Salman Khan' appeared in over the last 10 years
    
 SELECT 
    *
FROM
    netflix_data
WHERE
    cast LIKE '%salman khan%'
        AND release_year >=  year(CURRENT_DATE)-10;   
        
        
  
  
### Q14: Categorize the content based on the presence of the keywords 'kill' and 'violence'in the description field. Label content containing these keywords as 'Bad'and all other content as 'Good.' Count how many items fall into each category

        
WITH new_table AS (
    SELECT 
        *,
        CASE
            WHEN description LIKE '%kill%' OR description LIKE '%violence%'
            THEN 'bad_content'
            ELSE 'good_content'
        END AS category
    FROM netflix_data
)
SELECT category, COUNT(*) AS total_content
FROM new_table
GROUP BY category;
        
    



Objective: Categorize content as Bad or Good based on specific keywords in the description.

📈 Findings and Conclusion

The dataset shows Movies are more frequent than TV Shows on Netflix.

TV-MA and TV-14 ratings dominate Netflix’s catalog.

India and United States are among the countries producing the most content.

A small portion of titles include violent or dark keywords, marked as Bad Content.

The SQL analysis demonstrates effective data querying, filtering, aggregation, and categorization techniques.
