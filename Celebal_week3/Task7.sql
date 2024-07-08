WITH PrimeNumbers AS (
    SELECT 2 AS num
    UNION ALL
    SELECT num + 1
    FROM PrimeNumbers
    WHERE num < 1000
), FilteredPrimes AS (
    SELECT num
    FROM PrimeNumbers p
    WHERE NOT EXISTS (
        SELECT 1
        FROM PrimeNumbers p2
        WHERE p2.num < p.num AND p.num % p2.num = 0
    )
)
SELECT STRING_AGG(CAST(num AS VARCHAR), '&') AS primes
FROM FilteredPrimes
OPTION (MAXRECURSION 0);
