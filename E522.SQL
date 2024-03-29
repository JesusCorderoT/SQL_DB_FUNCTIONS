/*1. Hacer una funci�n valuada en tabla que obtenga la tabla de amortizaci�n de los 
Reembolsos quincenales que un participante tiene que realizar en 6 meses*/

 ALTER FUNCTION MORTI00(
 @idalu INT
 )
 RETURNS @TABLA TABLE
 (nquincena int,anterior decimal(9,2),pago decimal(9,2),nuevo decimal(9,2))
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

		insert @TABLA select @nquincena, @anterior, @pago, @nuevo

		 SET @anterior = @nuevo;
		 SET @nquincena = @nquincena+1;
	   END
	RETURN
END
 
 /**/


 select * from MORTI00(2);

print dbo.REEMBOLSOQUINCENAL(55000);


/*2. Hacer una funci�n valuada en tabla que obtenga la tabla de amortizaci�n de los 
pr�stamos posibles que se le pueden hacer a un instructor. 

La funci�n recibir� como par�metro el id del instructor 

El importe del pr�stamo ser� 200 veces la cuota por hora

El porcentaje de inter�s ser� el 24% anual cuando la cuota por hora sea superior a 200

Para el resto ser� de 18%

El pago mensual ser� el equivalente a 25 horas*/