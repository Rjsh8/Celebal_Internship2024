CREATE FUNCTION dbo.FormatDateYYYYMMDD (@InputDate DATETIME)
RETURNS VARCHAR(8)
AS
BEGIN
    RETURN (CAST(YEAR(@InputDate) AS VARCHAR(4)) +
            RIGHT('0' + CAST(MONTH(@InputDate) AS VARCHAR(2)), 2) +
            RIGHT('0' + CAST(DAY(@InputDate) AS VARCHAR(2)), 2));
END;
