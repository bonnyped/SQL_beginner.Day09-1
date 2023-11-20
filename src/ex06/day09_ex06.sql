DROP FUNCTION IF EXISTS fnc_person_visits_and_eats_on_date(pperson varchar, pprice numeric, pdate date);

CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(pperson varchar DEFAULT 'Dmitriy', pprice numeric DEFAULT 500, pdate date DEFAULT '2022-01-08')
    RETURNS TABLE (pizzeria_name varchar)
    LANGUAGE plpgsql
AS
$body$
BEGIN
    RETURN QUERY
    SELECT zz.name pizzeria_name
    FROM menu mn
             JOIN pizzeria zz ON zz.id = mn.pizzeria_id
             JOIN person_visits pv on zz.id = pv.pizzeria_id
             JOIN person p on pv.person_id = p.id
    WHERE pperson = p.name
      AND mn.price < pprice
      AND pdate IN (pv.visit_date);
END;
$body$;

select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');

-- INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
-- SELECT (SELECT max(pv.id) + 1
--         FROM person_visits pv),
--        (SELECT p.id
--         FROM person p
--         WHERE p.name = 'Dmitriy'),
--        (SELECT mn.pizzeria_id
--         FROM menu mn
--         WHERE mn.price < 800
--         LIMIT 1),
--         '2022-01-08'::date;