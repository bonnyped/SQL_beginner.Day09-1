CREATE OR REPLACE FUNCTION func_minimum(VARIADIC arr numeric[]) RETURNS numeric
    LANGUAGE PLPGSQL AS
$$
DECLARE
    result numeric;
BEGIN
    SELECT min($1[i])
    INTO result
    FROM generate_subscripts($1, 1) g(i);
    RETURN result;
END;
$$;

SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);