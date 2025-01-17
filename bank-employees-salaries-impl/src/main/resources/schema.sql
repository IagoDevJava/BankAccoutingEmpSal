CREATE TABLE IF NOT EXISTS DEPARTMENTS
(
    ID      int4 GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NAME    varchar NOT NULL UNIQUE,
    PHONE   varchar,
    EMAIL   varchar NOT NULL,
    ADDRESS varchar,
    HEAD_ID    int4
);

CREATE TABLE IF NOT EXISTS GRADES
(
    ID   int4 GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NAME varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS POSITIONS
(
    ID            int4 GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NAME          varchar NOT NULL,
    DEPARTMENT_ID int4    NOT NULL REFERENCES DEPARTMENTS (ID),
    GRADE_ID      int4 REFERENCES GRADES (ID)
);

CREATE TABLE IF NOT EXISTS SALARIES_DATA
(
    ID          int4 GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    WAGE        real NOT NULL,
    BONUS       real NOT NULL,
    POSITION_ID int4 NOT NULL REFERENCES POSITIONS (ID) UNIQUE
);

CREATE TABLE IF NOT EXISTS WORK_SCHEDULES
(
    id        int4 GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    work_days int4 NOT NULL,
    week_days int4 NOT NULL,
    hours     int4 NOT NULL
);

CREATE TABLE IF NOT EXISTS EMPLOYEES
(
--     //Сотрудник: 1, Иванов, Иван, Иванович, мужчина, бухгалтер, бухгалтерия,
--     зп30000, гр5/2, дп2022-11-28, null, null
    ID                int4 GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    SURNAME           varchar   NOT NULL,
    FIRSTNAME         varchar   NOT NULL,
    LASTNAME          varchar,
    GENDER            varchar   NOT NULL,
    PHONE             varchar,
    EMAIL             varchar   NOT NULL,
    DEPARTMENT_ID     int4 REFERENCES DEPARTMENTS (ID) ON DELETE CASCADE,
    POSITION_ID       int4 REFERENCES POSITIONS (ID) ON DELETE CASCADE,
    WORK_SCHEDULE_ID  int4 REFERENCES WORK_SCHEDULES (ID) ON DELETE CASCADE,
    DATE_OF_ADMISSION timestamp NOT NULL,
    JOB_STATUS        varchar,
    DATE_OF_DISMISSAL timestamp
);

ALTER TABLE DEPARTMENTS
    ADD CONSTRAINT fk_depHead_to_Employee FOREIGN KEY (HEAD_ID) REFERENCES EMPLOYEES (ID);

CREATE TABLE IF NOT EXISTS ATTENDANCE_DATA
(
    ID           BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    DATE_ATT     timestamp    NOT NULL,
    EMPLOYEE_ID int4    NOT NULL REFERENCES EMPLOYEES (id),
    STATUS       varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS KPIS
(
    ID           int4 GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    PERSONAL_KPI float4  NOT NULL,
    TEAM_KPI     float4  NOT NULL,
    COMMON_KPI   float4  NOT NULL,
    EMPLOYEE_ID  int4    NOT NULL REFERENCES EMPLOYEES (id),
    MONTH        varchar NOT NULL,
    YEAR         varchar NOT NULL
);

CREATE TABLE IF NOT EXISTS SALARY
(
    ID            BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    EMPLOYEE_ID   int4    NOT NULL REFERENCES EMPLOYEES (id),
    DEPARTMENT_ID int4    NOT NULL REFERENCES DEPARTMENTS (id),
    MONTH         varchar NOT NULL,
    YEAR          varchar NOT NULL,
    SUM           real    NOT NULL
);

-- INSERT INTO department(name)
-- VALUES ('Управление'),
--        ('Отдел кадров'),
--        ('Бухгалтерия'),
--        ('Разработка');
--
-- INSERT INTO grade(grade)
-- VALUES ('Стажер'),
--        ('Младший специалист'),
--        ('Средний специалист'),
--        ('Старший специалист'),
--        ('Руководитель команды'),
--        ('Руководитель отдела'),
--        ('Руководитель направления'),
--        ('Директор сферы'),
--        ('Генеральный директор');
--
-- INSERT INTO position(post, department_id, grade_id)
-- VALUES ('Генеральный директор', '1', '9'),
--        ('Руководитель ОК', '2', '4'),
--        ('HR-специалист', '2', '3'),
--        ('Старший бухгалтер', '3', '6'),
--        ('Mладший бухгалтер', '3', '2'),
--        ('Team Lead', '4', '5'),
--        ('Middle developer', '4', '3');
--
-- INSERT INTO work_schedule(work_day, week_day, HOURS)
-- VALUES ('5', '2', '8'),
--        ('2', '2', '12');
--
-- INSERT INTO salaries_data(grade_id, wage, personal_kpi, team_kpi, common_kpi)
-- VALUES ('1', '18000', '0', '0', '0'),
--        ('2', '22500', '0.7', '0.2', '0.1'),
--        ('3', '45000', '0.6', '0.25', '0.15'),
--        ('4', '60000', '0.5', '0.4', '0.10'),
--        ('5', '81000', '0.4', '0.5', '0.10'),
--        ('6', '109350', '0.4', '0.5', '0.10'),
--        ('7', '147622', '0.4', '0.5', '0.10'),
--        ('8', '221433', '0.4', '0.5', '0.10'),
--        ('9', '332150', '0.4', '0.5', '0.10');