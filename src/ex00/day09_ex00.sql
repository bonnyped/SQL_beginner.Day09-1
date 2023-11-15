-- №1
DROP TABLE IF EXISTS person_audit;
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
DROP FUNCTION  IF EXISTS fnc_trg_person_insert_audit();
DELETE FROM person WHERE id > 9;
SET timezone TO 'Etc/GMT-6';

SELECT *
FROM person;

--№2
CREATE TABLE person_audit
(
    created timestamptz(0) DEFAULT 'now' NOT NULL,
    type_event char(1)             DEFAULT 'I'   NOT NULL,
    row_id bigint NOT NULL,
    name varchar,
    age integer,
    gender varchar,
    address varchar
    CONSTRAINT ch_type_event CHECK ( type_event = 'I' OR type_event = 'U' OR type_event = 'D' )
);

SELECT *
FROM person_audit;

-- №3
CREATE FUNCTION fnc_trg_person_insert_audit() RETURNS TRIGGER AS $person_audit$
BEGIN
    INSERT INTO person_audit(created, type_event, row_id, name, age, gender, address)
    VALUES (now(), 'I', NEW.id, NEW.name, NEW.age, NEW.gender, NEW.address);
    RETURN NULL;
END;
    
$person_audit$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_insert_audit
    AFTER INSERT
    ON person
    FOR EACH ROW
EXECUTE FUNCTION fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');

SELECT *
FROM person_audit;