-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Guilherme Matos, Rafael Dias
-- Create date: <Create Date,,>
-- Description:	Remove funcion�rio, suas aloca��es e dependentes
-- =============================================
CREATE PROCEDURE RemoveEmployee
    @emp_ssn CHAR(9)
AS
BEGIN
    SET NOCOUNT ON;

    -- � gerente de algum dept?
    IF EXISTS (
        SELECT 1 FROM department WHERE mgr_ssn = @emp_ssn
    )
    BEGIN
        PRINT 'Erro: O funcion�rio � gerente de um departamento.';
        RETURN 1;
    END

    -- Est� sozinho num projeto?
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
        PRINT 'Erro: O funcion�rio est� sozinho em um dos projetos.';
        RETURN 2;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM Dependents WHERE essn = @emp_ssn;
        DELETE FROM Works_On WHERE essn = @emp_ssn;
        UPDATE Employee SET super_ssn = NULL WHERE super_ssn = @emp_ssn;
        DELETE FROM Employee WHERE ssn = @emp_ssn;

        COMMIT TRANSACTION;
        PRINT 'Funcion�rio removido com sucesso.';
        RETURN 0;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Erro inesperado.';
        RETURN -1;
    END CATCH
END