CREATE OR REPLACE PACKAGE cities_shortest_way IS
    TYPE city_name IS
        TABLE OF VARCHAR2(40) INDEX BY PLS_INTEGER;
    TYPE row_type IS
        TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
    TYPE record_type IS RECORD (
        distance NUMBER DEFAULT -1,
        path     row_type
    );
    TYPE matrix_type IS
        TABLE OF row_type INDEX BY PLS_INTEGER;

    PROCEDURE find_way (
        start_vers NUMBER
    );
END cities_shortest_way;
/
CREATE OR REPLACE PACKAGE BODY cities_shortest_way IS

    PROCEDURE visit_vers (
        v_result   IN OUT record_type,
        v_path     IN OUT row_type,
        v_matrix   IN matrix_type,
        v_start    IN NUMBER,
        v_finish   IN NUMBER,
        v_visit    IN row_type,
        v_distance IN NUMBER,
        v_count    IN NUMBER
    ) IS
        new_visit row_type := v_visit;
        new_path  row_type := v_path;
        vers      NUMBER;
    BEGIN
        new_path(v_count) := v_start;
        IF ( v_count <> 0 ) THEN
            new_visit(v_start) := 0;
        END IF;

        IF (
            v_start = v_finish
            AND new_visit.count = v_matrix.count
            AND ( v_result.distance = -1 OR v_distance < v_result.distance )
        ) THEN
            v_result.distance := v_distance;
            v_result.path := new_path;
        END IF;

        FOR i IN 0..v_matrix.count - 1 LOOP
            vers := v_matrix(v_start)(i);
            IF ( NOT ( new_visit.EXISTS(i) OR vers = -1 ) ) THEN
                visit_vers(v_result, new_path, v_matrix, i, v_finish,
                          new_visit, v_distance + vers, v_count + 1);

            END IF;

        END LOOP;

    END visit_vers;

    PROCEDURE find_way (
        start_vers NUMBER
    ) IS

        CURSOR cur_info IS
        SELECT
            *
        FROM
            cities;

        all_cities  city_name;
        matrix      matrix_type;
        v_result    record_type;
        v_path      row_type;
        result_path VARCHAR2(100);
        visit       row_type;
        max_count   NUMBER;
    BEGIN
        FOR city IN cur_info LOOP
            matrix(city.aid - 1)(city.bid - 1) := city.dist;
            matrix(city.bid - 1)(city.aid - 1) := city.dist;
            IF ( NOT all_cities.EXISTS(city.aid) ) THEN
                all_cities(city.aid) := city.acity;
            END IF;

            IF ( NOT all_cities.EXISTS(city.bid) ) THEN
                all_cities(city.bid) := city.bcity;
            END IF;

        END LOOP;
        FOR i IN 0..matrix.COUNT-1 LOOP
        FOR j IN i..matrix.COUNT-1 LOOP
            IF NOT(matrix(i).EXISTS(j)) THEN
            matrix(i)(j):=-1;
            END IF;
            IF NOT(matrix(j).EXISTS(i)) THEN
            matrix(j)(i):=-1;
            END IF;
            END LOOP;
            END LOOP;

        visit_vers(v_result, v_path, matrix, start_vers - 1, start_vers - 1,
                  visit, 0, 0);

        FOR i IN 0..v_result.path.count - 2 LOOP
            result_path := result_path
                           || all_cities(v_result.path(i) + 1)
                           || '--';
        END LOOP;

        result_path := result_path
                       || all_cities(v_result.path(v_result.path.count - 1) + 1)
                       || ': '
                       || v_result.distance;

        dbms_output.put_line(result_path);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE (' Нет такого города, ты дурачок');
        WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE ('Пути нет, сиди дома');
    END find_way;

END cities_shortest_way;
