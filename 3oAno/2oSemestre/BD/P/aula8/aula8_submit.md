# BD: Guião 8


## ​8.1
 
### *a)*

```
CREATE PROCEDURE RemoveEmployee
    @emp_ssn CHAR(9)
AS
BEGIN
    SET NOCOUNT ON;

    -- É gerente de algum dept?
    IF EXISTS (
        SELECT 1 FROM department WHERE mgr_ssn = @emp_ssn
    )
    BEGIN
        PRINT 'Erro: O funcionário é gerente de um departamento.';
        RETURN 1;
    END

    -- Está sozinho num projeto?
    IF EXISTS (
        SELECT pno
        FROM works_on
        WHERE essn = @emp_ssn
        AND pno IN (
            SELECT pno
            FROM works_on
            GROUP BY pno
            HAVING COUNT(*) = 1
        )
    )
    BEGIN
        PRINT 'Erro: O funcionário está sozinho em um dos projetos.';
        RETURN 2;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM Dependents WHERE essn = @emp_ssn;
        DELETE FROM Works_On WHERE essn = @emp_ssn;
        UPDATE Employee SET super_ssn = NULL WHERE super_ssn = @emp_ssn;
        DELETE FROM Employee WHERE ssn = @emp_ssn;

        COMMIT TRANSACTION;
        PRINT 'Funcionário removido com sucesso.';
        RETURN 0;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Erro inesperado.';
        RETURN -1;
    END CATCH
END
```

### *b)* 

```
CREATE PROCEDURE getDeptManagers
AS
BEGIN
    SET NOCOUNT ON;

    WITH ManagersCTE AS (
        SELECT 
            e.Fname + ' ' + e.Lname AS full_name,
            e.Ssn,
            d.Dname,
            d.Mgr_start_date,
            DATEDIFF(YEAR, d.Mgr_start_date, GETDATE()) AS years_as_manager
        FROM 
            Department d
        INNER JOIN 
            Employee e ON d.Mgr_ssn = e.ssn
    )
    
    -- todos os gestores + o mais antigo
    SELECT 
        m.full_name,
        m.Ssn,
        m.Dname,
        m.Mgr_start_date,
        m.years_as_manager,
        CASE 
            WHEN m.Ssn = (
                SELECT TOP 1 Ssn 
                FROM ManagersCTE 
                ORDER BY Mgr_start_date
            ) THEN 'Mais antigo'
            ELSE ''
        END AS destaque
    FROM ManagersCTE m;
END
```

### *c)* 

```
CREATE TRIGGER managerRestriction
ON Department
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- verificar se já é gestor noutro dept
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN department d ON i.Mgr_ssn = d.Mgr_ssn
        WHERE i.dnumber <> d.dnumber
    )
    BEGIN
        RAISERROR('ERRO: Um funcionário não pode ser gestor de mais de um departamento.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- se não existir conflito
    INSERT INTO department
    SELECT * FROM inserted;
END
```

### *d)* 

```
CREATE TRIGGER Salary
ON Employee
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE e
    SET e.Salary = m.Salary - 1
    FROM Employee e
    JOIN inserted i ON e.Ssn = i.Ssn
    JOIN Department d ON i.Dno = d.Dnumber
    JOIN Employee m ON d.Mgr_ssn = m.Ssn
    WHERE i.Salary > m.Salary;
END;
```

### *e)* 

```
CREATE FUNCTION getProjNameAndLocation (@Ssn CHAR(9))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        E.Fname + ' ' + E.Lname AS Emp_name,
        P.Pname,
        P.Plocation
    FROM Employee E
    JOIN Works_on W ON E.Ssn = W.Essn
    JOIN Project P ON W.Pno = P.Pnumber
    WHERE E.Ssn = @Ssn
);
```

### *f)* 

```
CREATE FUNCTION getHigherAvgSalaryEmployees (@Dno INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        E.Ssn,
        E.Fname,
        E.Lname,
        E.Salary,
        E.Dno
    FROM Employee E
    WHERE E.Dno = @Dno
      AND E.Salary > (
          SELECT AVG(Salary)
          FROM Employee
          WHERE Dno = @Dno
      )
);
```

### *g)* 

```
CREATE FUNCTION EmployeeDeptHighAverage (@DepartId INT)
RETURNS @Table TABLE (
    Pname        VARCHAR(15),
    Pnumber      INT,
    Plocation    VARCHAR(15),
    Dnum         INT,
    Budget       FLOAT,
    Totalbudget  FLOAT
)
AS
BEGIN
    DECLARE C CURSOR FOR
        SELECT 
            P.Pname, 
            P.Pnumber, 
            P.Plocation, 
            P.Dnum, 
            SUM((E.Salary / 160.0) * W.Hours) AS Budget  -- 40h/semana * 4 = 160h/mês
        FROM Project P
        JOIN Works_on W ON P.Pnumber = W.Pno
        JOIN Employee E ON W.Essn = E.Ssn
        WHERE P.Dnum = @DepartId
        GROUP BY P.Pname, P.Pnumber, P.Plocation, P.Dnum;

    DECLARE 
        @Pname       VARCHAR(15),
        @Pnumber     INT,
        @Plocation   VARCHAR(15),
        @Dnum        INT,
        @Budget      FLOAT,
        @Totalbudget FLOAT;

    SET @Totalbudget = 0;

    OPEN C;
    FETCH C INTO @Pname, @Pnumber, @Plocation, @Dnum, @Budget;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Totalbudget += @Budget;

        INSERT INTO @Table
        VALUES (@Pname, @Pnumber, @Plocation, @Dnum, @Budget, @Totalbudget);

        FETCH C INTO @Pname, @Pnumber, @Plocation, @Dnum, @Budget;
    END

    CLOSE C;
    DEALLOCATE C;

    RETURN;
END
```

### *h)* 

```
-- criar tabela de DeptDeleted caso nao exista
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'DeptDeleted')
BEGIN
    CREATE TABLE dbo.DeptDeleted (
        Dname VARCHAR(15) NOT NULL,
        Dnumber INT NOT NULL PRIMARY KEY,
        Mgr_ssn INT NULL,
        Mgr_start_date DATE,
        UNIQUE (Dname),
        FOREIGN KEY (Mgr_ssn) REFERENCES dbo.Employee(Ssn)
    );
END
GO

CREATE TRIGGER trg_DepartmentAfterDelete
ON dbo.Department
AFTER DELETE
AS
BEGIN
    INSERT INTO dbo.DeptDeleted (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
    SELECT Dname, Dnumber, Mgr_ssn, Mgr_start_date
    FROM deleted;
END
GO

CREATE TRIGGER trg_DepartmentInsteadOfDelete
ON dbo.Department
INSTEAD OF DELETE
AS
BEGIN
    INSERT INTO dbo.DeptDeleted (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
    SELECT Dname, Dnumber, Mgr_ssn, Mgr_start_date
    FROM deleted;

    DELETE d
    FROM dbo.Department d
    INNER JOIN deleted del ON d.Dnumber = del.Dnumber;
END
GO
```

### *i)* 

```
# Stored Procedures

- São pré-compiladas e armazenadas em cache, permitindo execução rápida.  
- Podem executar várias operações, incluindo chamar outras stored procedures.  
- Podem retornar múltiplos resultados.  
- Suportam tratamento de erros e transações (commit/rollback).  
- Indicadas para processos complexos que envolvem várias ações numa única operação.

# User Defined Functions (UDFs)

- Também são pré-compiladas e armazenadas em cache.  
- São determinísticas e retornam um único valor (escalar) ou uma tabela.  
- Não podem alterar dados nem controlar transações.  
- Podem ser usadas em consultas SQL como colunas ou views parametrizadas.  
- Ideais para cálculos ou filtros reutilizáveis dentro de queries.
```
