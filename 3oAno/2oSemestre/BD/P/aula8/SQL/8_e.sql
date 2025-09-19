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
-- Author:		Guilherme Matos
-- Create date: <Create Date,,>
-- Description:	Devolver nome e localizaçao dos projetos em que dado funcionário trabalho
-- =============================================
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
