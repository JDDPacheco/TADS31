-- 1
alter table salaries drop index idx_salaries_emp_date;
alter table dept_emp drop index idx_dept_emp_date;
alter table departments drop index idx_depto;

-- 2
with latest_dept_manager as (
    select emp_no, dept_no, from_date
    from dept_manager
    where to_date = (select max(to_date) 
                     from dept_manager d_int 
                     where d_int.emp_no = dept_manager.emp_no)
),
latest_salary as (
    select emp_no, salary
    from salaries
    where to_date = (select max(to_date) 
                     from salaries s_int 
                     where s_int.emp_no = salaries.emp_no)
),
latest_title as (
    select emp_no, title
    from titles
    where to_date = (select max(to_date) 
                     from titles t_int 
                     where t_int.emp_no = titles.emp_no)
)
select concat(e.first_name, ' ', e.last_name) as nome, 
       s_ext.salary as sal, 
       de_ext.dept_name as dept, 
       t_ext.title as car, 
       min(d_ext.from_date) as admss
from employees e 
inner join latest_dept_manager d_ext on d_ext.emp_no = e.emp_no
inner join departments de_ext on d_ext.dept_no = de_ext.dept_no
inner join latest_salary s_ext on s_ext.emp_no = e.emp_no
inner join latest_title t_ext on t_ext.emp_no = e.emp_no
group by dept
;

-- 3
WITH latest_dept AS (
    SELECT emp_no, 
           MAX(to_date) AS mx_dt_dept
    FROM dept_manager 
    GROUP BY emp_no
),
latest_salary AS (
    SELECT emp_no, 
           MAX(to_date) AS mx_dt_sal 
    FROM salaries 
    GROUP BY emp_no
),
latest_title AS (
    SELECT emp_no, 
           MAX(to_date) AS mx_dt_cargo
    FROM titles 
    GROUP BY emp_no
)
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS nome, 
    s.salary AS sal, 
    de.dept_name AS dept, 
    t.title AS car, 
    MIN(d.from_date) AS admss
FROM 
    employees e 
INNER JOIN 
    latest_dept ud ON e.emp_no = ud.emp_no
INNER JOIN 
    dept_manager d ON e.emp_no = d.emp_no AND d.to_date = ud.mx_dt_dept
INNER JOIN 
    latest_salary us ON e.emp_no = us.emp_no
INNER JOIN 
    salaries s ON e.emp_no = s.emp_no AND s.to_date = us.mx_dt_sal
INNER JOIN 
    latest_title uc ON e.emp_no = uc.emp_no
INNER JOIN 
    titles t ON e.emp_no = t.emp_no AND t.to_date = uc.mx_dt_car
INNER JOIN 
    departments de ON de.dept_no = d.dept_no
GROUP BY 
    de.dept_name
;

-- 4
create index idx_salaries_emp_date on salaries(emp_no, to_date);
create index idx_dept_mag_date on dept_manager(emp_no, to_date);
create index idx_depto on departments(dept_no);
create index idx_titles_emp_date on titles(emp_no, to_date);

-- 5

-- 6
USE bd2020;
SELECT * FROM departamento;
CREATE USER 'mkt_user'@'localhost' IDENTIFIED BY 'mkt_pwd123';
CREATE USER 'fnc_user'@'localhost' IDENTIFIED BY 'fnc_pwd456';
CREATE USER 'rhs_user'@'localhost' IDENTIFIED BY 'rhs_pwd789';
CREATE USER 'prod_user'@'localhost' IDENTIFIED BY 'prod_pwd321';
CREATE USER 'dev_user'@'localhost' IDENTIFIED BY 'dev_pwd654';
CREATE USER 'qmg_user'@'localhost' IDENTIFIED BY 'qmg_pwd987';
CREATE USER 'sls_user'@'localhost' IDENTIFIED BY 'sls_pwd147';
CREATE USER 'rsh_user'@'localhost' IDENTIFIED BY 'rsh_pwd258';
CREATE USER 'csv_user'@'localhost' IDENTIFIED BY 'csv_pwd369';


-- 7
CREATE VIEW vw_recursos_humanos AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd003';

CREATE VIEW vw_vendas AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd007';

CREATE VIEW vw_producao AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd004';

CREATE VIEW vw_qualidade AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd006';

CREATE VIEW vw_desenvolvimento AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd005';

CREATE VIEW vw_pesquisa AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd008';

CREATE VIEW vw_marketing AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd001';

CREATE VIEW vw_financeiro AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd002';

CREATE VIEW vw_atendimento_cliente AS 
SELECT depnome AS Departamento, funnome AS Nome, funsexo AS Sexo, funsalario AS Salário, estdescricao AS Estado_Civil,
       CASE
           WHEN fundtdem IS NULL THEN 'Trabalhando'
           ELSE CONCAT('Demitido em: ', fundtdem)
       END AS Situação
FROM departamento 
INNER JOIN funcionario ON fundepnum = depnum
INNER JOIN estadocivil ON estcodigo = funestcodigo 
WHERE depnum = 'd009';

-- 8
-- Permissões de SELECT para as views correspondentes
GRANT SELECT ON bd2020.vw_marketing TO 'mkt_user'@'localhost';
GRANT SELECT ON bd2020.vw_financeiro TO 'fnc_user'@'localhost';
GRANT SELECT ON bd2020.vw_recursos_humanos TO 'rhs_user'@'localhost';
GRANT SELECT ON bd2020.vw_producao TO 'prod_user'@'localhost';
GRANT SELECT ON bd2020.vw_desenvolvimento TO 'dev_user'@'localhost';
GRANT SELECT ON bd2020.vw_qualidade TO 'qmg_user'@'localhost';
GRANT SELECT ON bd2020.vw_vendas TO 'sls_user'@'localhost';
GRANT SELECT ON bd2020.vw_pesquisa TO 'rsh_user'@'localhost';
GRANT SELECT ON bd2020.vw_atendimento_cliente TO 'csv_user'@'localhost';
-- 10
-- mysqldump -u [root] -p [bd2020] > backupbd2020_01-07-2024.sql