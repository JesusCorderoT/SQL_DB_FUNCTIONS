-----------------------------------SUBTEMA: FUNCIONES DEFINIDAS POR EL USUARIO------------------------------------------
--Funciones escalares: La funci�n que devuelve un solo valor de datos se llama funci�n escalar.

--Funciones con valores de tabla: la funci�n que devuelve varios registros como un tipo de datos de tabla se denomina funci�n con valores de tabla.

------------------------------------------CARACTER�STICAS DE LAS FUNCIONES----------------------------------------------
--Las funciones no pueden ejecutar Procedimientos Almacenados (S.P.).
--Solo se puede anidar hasta 32 funciones al momento de ejecutar.
--No pueden insertar datos en otra tabla con la instrucci�n INTO.
--En las funciones tipo tablas, el resultado no se puede regresar con la instrucci�n ORDER BY en el RETURN.
--Solo las tablas temporales como variables est�n permitidas dentro de las funciones.
-------------------------------------------SINTAXIS-------------------------------------
--Crear:
      /* CREATE FUNCTION <nombreFuncion>
		(
		<Parametro><TipodeDato>,�n
		) 

        RETURNS <TipodeDato> 
        AS
		BEGIN
			 <Instruccion, operacion, etc.>
             RETURN <campo de regreso del mismo valor del regreso de la funci�n>
		END */
----------------------------------------------------------------------------------------
--Modificar:
		/* ALTER FUNCTION <nombreFuncion>(<Parametro><TipodeDato>,�n) 
		   RETURNS <TipodeDato> 
		   AS
		   BEGIN
				 <Instruccion, operacion, etc.>
			     RETURN <campo de regreso del mismo valor del regreso de la funci�n>
		   END */
----------------------------------------------------------------------------------------
--Borrar:
       /* DROP FUNCTION <nombreFuncion> */
-----------------------------------------------------------------------------------------
-----------------------------------------FUNCIONES ESCALARES-------------------------------------------
--Funciones escalares: La funci�n que devuelve un solo valor de datos se llama funci�n escalar.
--La cl�usula "returns" indica el tipo de dato retornado.

Alter FUNCTION Mayusculas
(
@Nombre Varchar(50),
@Apellido Varchar(50)
)
RETURNS Varchar(100)
AS
BEGIN
 RETURN (UPPER(@Apellido) + ', ' + UPPER(@Nombre))
END

--Ejecutar
Print dbo.Mayusculas('laura','ruiz')

-----------------------------------------FUNCIONES CON VALORES DE TABLA-------------------------------------------
--Funciones con valores de tabla: la funci�n que devuelve varios registros como un tipo de datos de tabla se denomina 
--funci�n con valores de tabla.
/*
create function <nombreFuncion>
 (
 <Parametro><TipodeDato>,�n
 )
 returns @NombreTablaRetorno table-- nombre de la tabla
 --formato de la tabla
 (
  <Campo1><TipodeDato>,
  <Campo2><TipodeDato>,
  <Campo3><TipodeDato>
 )
 as
 begin
   insert @NombreTablaRetorno
    select @ValorCampo1, @ValorCampo2, @ValorCampo3 
   RETURN
 end
 */


CREATE FUNCTION MISAEROPUERTOS()
RETURNS @TABLA TABLE(
       IDA CHAR(4),
       NOM VARCHAR(40),
       PAI VARCHAR(40)
)
AS
BEGIN
       INSERT INTO @TABLA
             SELECT AER.IDAERO,AER.NOMBRE,PAI.PAIS
                    FROM AEROPUERTO AER
                    JOIN PAIS PAI ON AER.IDPAIS=PAI.IDPAIS
       RETURN
END
GO