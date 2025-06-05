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
