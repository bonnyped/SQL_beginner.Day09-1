DROP FUNCTION IF EXISTS fnc_persons_female();
DROP FUNCTION IF EXISTS fnc_persons_male();

CREATE FUNCTION fnc_persons_female()
    RETURNS TABLE
            (
                id      bigint,
                name    varchar,
                age     int,
                gender  varchar,
                address varchar
            )
AS
$$
SELECT *
FROM v_persons_female;
$$ LANGUAGE SQL;

CREATE FUNCTION fnc_persons_male()
    RETURNS TABLE
            (
                id      bigint,
                name    varchar,
                age     int,
                gender  varchar,
                address varchar
            )
AS
$$
SELECT *
FROM v_persons_male;
$$ LANGUAGE SQL;

SELECT *
FROM fnc_persons_female();

SELECT *
FROM fnc_persons_male();