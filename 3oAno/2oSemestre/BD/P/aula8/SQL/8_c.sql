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
        JOIN Department d ON i.Mgr_ssn = d.Mgr_ssn
        WHERE i.Dnumber <> d.Dnumber
    )
    BEGIN
        RAISERROR('ERRO: Um funcionário não pode ser gestor de mais de um departamento.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- se não existir conflito
    INSERT INTO Department
    SELECT * FROM inserted;
END
