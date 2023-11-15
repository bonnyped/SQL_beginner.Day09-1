-- №1
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP FUNCTION  IF EXISTS fnc_trg_person_update_audit();
DELETE FROM person WHERE id > 9;
DELETE from person_audit WHERE name IN ('Damir');
SET timezone TO 'Etc/GMT-6';

--  №2
CREATE FUNCTION fnc_trg_person_update_audit() RETURNS TRIGGER AS $person_audit$
    BEGIN
        IF (tg_op = 'UPDATE')
        THEN
            INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
            VALUES(now(), 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        END IF;
        RETURN NULL;
    END;
$person_audit$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_update_audit
    AFTER UPDATE
    ON person
    FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_update_audit();

SELECT *
FROM person;

SELECT *
FROM person_audit;

-- №3
UPDATE person SET name = 'Bulat' WHERE id = 10;

SELECT *
FROM person;

SELECT *
FROM person_audit;

--№4
UPDATE person SET name = 'Damir' WHERE id = 10;

SELECT *
FROM person;

SELECT *
FROM person_audit;