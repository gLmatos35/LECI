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
