CREATE TABLE occupations (
    name VARCHAR(50),
    occupation VARCHAR(50)
);

INSERT INTO occupations (name, occupation) VALUES
('Samantha', 'Doctor'),
('Julia', 'Actor'),
('Maria', 'Actor'),
('Meera', 'Singer'),
('Ashely', 'Professor'),
('Ketty', 'Professor'),
('Christeen', 'Professor'),
('Jane', 'Actor'),
('Jenny', 'Doctor'),
('Priya', 'Singer');

SELECT
    MAX(CASE WHEN occupation = 'Doctor' THEN name END) AS Doctor,
    MAX(CASE WHEN occupation = 'Professor' THEN name END) AS Professor,
    MAX(CASE WHEN occupation = 'Singer' THEN name END) AS Singer,
    MAX(CASE WHEN occupation = 'Actor' THEN name END) AS Actor
FROM (
    SELECT name, occupation,
           ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS rn
    FROM occupations
) AS sub
GROUP BY rn
ORDER BY rn;
