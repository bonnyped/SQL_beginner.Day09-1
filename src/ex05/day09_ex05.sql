DROP FUNCTION IF EXISTS fnc_persons_female();
DROP FUNCTION IF EXISTS fnc_persons_male();

CREATE OR REPLACE FUNCTION fnc_persons(pgender varchar DEFAULT 'female')
    RETURNS TABLE
            (
                id      bigint,
                name    varchar,
                age     int,
                gender  varchar,
                address varchar
            )
    LANGUAGE SQL
AS
$body$
SELECT *
FROM person p
WHERE p.gender IN (fnc_persons.pgender);
$body$;


select *
from fnc_persons(pgender := 'male');

select *
from fnc_persons();