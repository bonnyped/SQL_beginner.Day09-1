CREATE OR REPLACE FUNCTION fnc_fibonacci (pstop integer DEFAULT 10)
  RETURNS SETOF int
  LANGUAGE plpgsql IMMUTABLE STRICT AS
$func$
DECLARE
    a int := 0;
    b int := 1;
BEGIN
    RETURN NEXT a;
    RETURN NEXT b;
    LOOP
        a := a + b;
        EXIT WHEN a >= pstop;
        RETURN NEXT a;

        b := b + a;
        EXIT WHEN b >= pstop;
        RETURN NEXT b;
    END LOOP;
END;
$func$;

select * from fnc_fibonacci();

select * from fnc_fibonacci(100);