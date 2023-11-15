-- №1
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;
DROP FUNCTION  IF EXISTS fnc_trg_person_delete_audit();
SET timezone TO 'Etc/GMT-6';

--  №2
CREATE FUNCTION fnc_trg_person_delete_audit() RETURNS TRIGGER AS $person_audit$
    BEGIN
        IF (tg_op = 'DELETE')
        THEN
            INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
            VALUES(now(), 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        END IF;
        RETURN NULL;
    END;
$person_audit$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_delete_audit
    AFTER DELETE
    ON person
    FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_delete_audit();

SELECT *
FROM person;

SELECT *
FROM person_audit;

-- №3
DELETE FROM person WHERE id = 10;

SELECT *
FROM person;

SELECT *
FROM person_audit;

