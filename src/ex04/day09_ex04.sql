DROP FUNCTION IF EXISTS fnc_persons_female();
DROP FUNCTION IF EXISTS fnc_persons_male();
DROP FUNCTION fnc_persons(pgender varchar);

CREATE FUNCTION fnc_persons_female()
    RETURNS TABLE
            (
                id      person.id%TYPE,
                name    person.name%TYPE,
                age     person.age%TYPE,
                gender  person.gender%TYPE,
                address person.address%TYPE
            )
AS
$body$
SELECT id, name, age, gender, address
FROM person
WHERE gender = 'female';
$body$ LANGUAGE SQL;

CREATE FUNCTION fnc_persons_male()
    RETURNS TABLE
            (
                id      person.id%TYPE,
                name    person.name%TYPE,
                age     person.age%TYPE,
                gender  person.gender%TYPE,
                address person.address%TYPE
            )
AS
$body$
SELECT id, name, age, gender, address
FROM person
WHERE gender = 'male';
$body$ LANGUAGE SQL;

select * from fnc_persons_male();

select * from fnc_persons_female();