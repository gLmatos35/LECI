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
