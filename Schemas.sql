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