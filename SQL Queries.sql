--how many movies did i watch

SELECT COUNT(*) total
FROM `iron-gantry-342917.movies_2021.movies`

--how many minutes did i spend watching movies

SELECT SUM(runtime) total_minutes
FROM `iron-gantry-342917.movies_2021.movies`

--how many were rewatched vs first watch

SELECT rewatch,
       COUNT(*) total
FROM `iron-gantry-342917.movies_2021.movies`
GROUP BY rewatch

--count movies per genre and find percentage

SELECT genre,
       COUNT(*) total,
       ROUND((COUNT(*)/SUM(COUNT(*)) OVER())*100, 2) percent
FROM `iron-gantry-342917.movies_2021.movies`
GROUP BY genre
ORDER BY total DESC

--make categories for runtimes, count them, average my ratings

SELECT CASE WHEN runtime < 90 THEN 'less than 90 minutes'
            WHEN runtime >= 90 AND runtime <= 110 THEN '90 - 110 minutes'
            WHEN runtime > 110 AND runtime <= 130 THEN '111 - 130 minutes'
            WHEN runtime > 130 THEN 'more than 130 minutes'
            END runtimes,
       COUNT(*) total,
       ROUND(AVG(my_rating), 2) avg_rating
FROM `iron-gantry-342917.movies_2021.movies`
GROUP BY 1

--creating column for decades, count decades, find my avg rating

SELECT CASE WHEN release_year >= 2000 THEN CONCAT('20', SUBSTR((CAST(release_year AS STRING)), 3, 1), '0s')
       ELSE CONCAT(SUBSTR((CAST(release_year AS STRING)), 3, 1), '0s')
       END decades,
       COUNT(*) total,
       ROUND(AVG(my_rating), 2) avg_rating
FROM `iron-gantry-342917.movies_2021.movies`
GROUP BY 1
ORDER BY total

--my total avg rating vs avg rating of letterboxd users

SELECT ROUND(AVG(my_rating), 2) my_avg,
       ROUND(AVG(average_rating), 2) letterboxd_avg
FROM `iron-gantry-342917.movies_2021.movies`

--count movies by watch platform

SELECT platform,
       COUNT(platform) total
FROM `iron-gantry-342917.movies_2021.movies`
GROUP BY platform
