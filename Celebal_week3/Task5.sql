USE celebal_week3

CREATE TABLE Hackers (
    hacker_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO Hackers (hacker_id, name) VALUES
(15758, 'Rose'),
(20703, 'Angela'),
(36396, 'Frank'),
(38289, 'Patrick'),
(44065, 'Lisa'),
(53473, 'Kimberly'),
(62529, 'Bonnie'),
(79722, 'Michael');

CREATE TABLE Submissions (
    submission_date DATE,
    submission_id INT PRIMARY KEY,
    hacker_id INT,
    score INT
);

INSERT INTO Submissions (submission_date, submission_id, hacker_id, score) VALUES
('2016-03-01', 8494, 20703, 0),
('2016-03-01', 22403, 53473, 15),
('2016-03-01', 23965, 79722, 60),
('2016-03-01', 30173, 36396, 70),
('2016-03-02', 34928, 20703, 0),
('2016-03-02', 38740, 15758, 60),
('2016-03-02', 42769, 79722, 25),
('2016-03-02', 44364, 79722, 60),
('2016-03-03', 45440, 20703, 0),
('2016-03-03', 49050, 36396, 70),
('2016-03-03', 50273, 79722, 5),
('2016-03-04', 50344, 20703, 0),
('2016-03-04', 51360, 44065, 90),
('2016-03-04', 54404, 53473, 65),
('2016-03-04', 61533, 79722, 45),
('2016-03-05', 72852, 20703, 0),
('2016-03-05', 74546, 38289, 0),
('2016-03-05', 76487, 62529, 0),
('2016-03-05', 82439, 36396, 10),
('2016-03-05', 90006, 36396, 40),
('2016-03-06', 90404, 20703, 0);
SELECT h.hacker_id, h.name, s.submission_date, s.submission_id, s.score
FROM Hackers h
JOIN Submissions s
ON h.hacker_id = s.hacker_id;


WITH DateRange AS (
    SELECT DATEADD(day, n, '2016-03-01') AS contest_date
    FROM (SELECT ROW_NUMBER() OVER (ORDER BY a.object_id) - 1 AS n
          FROM sys.objects AS a
          CROSS JOIN sys.objects AS b) AS x
    WHERE DATEADD(day, n, '2016-03-01') <= '2016-03-15'
),
DailySubmissions AS (
    SELECT 
        s.submission_date,
        s.hacker_id,
        COUNT(s.submission_id) AS submissions
    FROM 
        Submissions s
    GROUP BY 
        s.submission_date, s.hacker_id
),
MaxDailySubmissions AS (
    SELECT 
        ds.submission_date,
        MIN(ds.hacker_id) AS hacker_id,
        ds.submissions
    FROM 
        DailySubmissions ds
    JOIN (
        SELECT 
            submission_date,
            MAX(submissions) AS max_submissions
        FROM 
            DailySubmissions
        GROUP BY 
            submission_date
    ) max_ds ON ds.submission_date = max_ds.submission_date AND ds.submissions = max_ds.max_submissions
    GROUP BY 
        ds.submission_date, ds.submissions
),
UniqueDailyHackers AS (
    SELECT
        dr.contest_date,
        COUNT(DISTINCT s.hacker_id) AS unique_hackers
    FROM
        DateRange dr
    LEFT JOIN
        Submissions s ON dr.contest_date = s.submission_date
    GROUP BY
        dr.contest_date
)
SELECT
    udh.contest_date,
    udh.unique_hackers,
    mds.hacker_id,
    h.name,
    mds.submissions
FROM
    UniqueDailyHackers udh
JOIN
    MaxDailySubmissions mds ON udh.contest_date = mds.submission_date
JOIN
    Hackers h ON mds.hacker_id = h.hacker_id
ORDER BY
    udh.contest_date;

