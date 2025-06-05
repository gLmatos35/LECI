-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Guilherme Matos, Rafael Dias
-- Create date: <Create Date,,>
-- Description:	Retornar funcionarios com salario acima da media em dado departamento
-- =============================================
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
