/*1. Hacer una función valuada en tabla que obtenga la tabla de amortización de los 
Reembolsos quincenales que un participante tiene que realizar en 6 meses*/




 ALTER FUNCTION MORTI00(
 @idalu INT
 )
 RETURNS @TABLA TABLE
 (
nquincena int,
anterior decimal(9,2),
pago decimal(9,2),
nuevo decimal(9,2)
 )
 AS

BEGIN

DECLARE @sueldo decimal (9,2)
DECLARE @anterior decimal(9,2)
DECLARE @pago decimal(9,2)
DECLARE @nuevo decimal (9,2)
DECLARE @nquincena int = 1
DECLARE @fquincena int = 12

SET @nquincena = 1
SET @fquincena = 12
SET @sueldo = (select sueldo FROM ALUMNOS WHERE ID = @idalu)
SET @pago = (SELECT dbo.REEMBOLSOQUINCENAL(@sueldo))
SET @anterior = ((@sueldo)*2.5)

 WHILE @nquincena <= @fquincena
 BEGIN

 SET @nuevo = (@anterior-@pago)

 insert @TABLA 
 select @nquincena, @anterior, @pago, @nuevo

SET @anterior = @nuevo;
SET @nquincena = @nquincena+1;


END
RETURN
END
 
 /**/


 select * from MORTI00(2);

print dbo.REEMBOLSOQUINCENAL(55000);
print dbo.REEMBOLSOQUINCENAL2(1);