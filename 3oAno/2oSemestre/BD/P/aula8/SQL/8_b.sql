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
-- Description:	Retornar um record-set com os funcionários gestores de departamentos, ssn e num de anos como gestor
-- =============================================
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

