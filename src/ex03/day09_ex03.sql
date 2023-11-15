-- №1
DROP TRIGGER IF EXISTS trg_person_audit ON person;
DROP FUNCTION  IF EXISTS fnc_trg_person_audit();
SET timezone TO 'Etc/GMT-6';

--  №2
CREATE FUNCTION fnc_trg_person_audit() RETURNS TRIGGER AS $person_audit$
    BEGIN
        IF (tg_op = 'INSERT')
        THEN
            INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
            VALUES(now(), 'I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
        ELSEIF (tg_op = 'UPDATE')
        THEN
            INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
            VALUES(now(), 'U', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        ELSEIF (tg_op = 'DELETE')
        THEN
            INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
            VALUES(now(), 'D', OLD.id, OLD.name, OLD.age, OLD.gender, OLD.address);
        END IF;
        RETURN NULL;
    END;
$person_audit$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_audit
    AFTER INSERT OR UPDATE OR DELETE
    ON person
    FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_audit();

DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit();
DROP FUNCTION IF EXISTS  fnc_trg_person_update_audit();
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit();
TRUNCATE person_audit;
SELECT *
FROM person;

-- №3
SELECT *
FROM person_audit;

-- 4
INSERT INTO person(id, name, age, gender, address)
VALUES (10, 'Damir', 22, 'male', 'Irkutsk');
UPDATE person
SET name = 'Bulat'
WHERE id = 10;
UPDATE person
SET name = 'Damir'
WHERE id = 10;
DELETE
FROM person
WHERE id = 10;

-- №5
SELECT *
FROM person;

-- №6
SELECT *
FROM person_audit;