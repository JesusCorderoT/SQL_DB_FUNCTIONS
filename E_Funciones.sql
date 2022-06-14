/* TEMA: SQL SERVER
SUBTEMA: FUNCIONES ESCALARES */

/*1. Crear una función Suma que reciba dos números enteros y regrese la suma de
ambos números*/

 create function SUMA
 (
 @valor1 int,
 @valor2 int
 )
 returns int
 as
 begin 
   declare @resultado int
   set @resultado=(@valor1+@valor2)
   return @resultado
 end;
GO

 Print dbo.SUMA(5,7);
 
 /**/
 
 /*2. Crear la función GetGenero la cual reciba como parámetros el curp y regrese el
género al que pertenece*/

 create function GETGENERO
 (
 @CURP VARCHAR(18)
 )
 returns VARCHAR(18)
 as
 begin 
   RETURN
   	 CASE
	WHEN SUBSTRING(@CURP, 11, 1) = 'H' THEN 'HOMBRE'
	WHEN SUBSTRING(@CURP, 11, 1) = 'M' THEN 'MUJER'
	ELSE 'N/A'
	END 
 end

  Print dbo.GETGENERO('COTJ231299HCMRS09');
  Print dbo.GETGENERO('DIVP231299MCMRS09');
  
  /**/
 
/*3. Crear la función GetFechaNacimiento la cual reciba como parámetros el curp y
regrese la fecha de nacimiento. La fecha de nacimiento deberá completarse a 4
dígitos, debiéndose determinar si es año dos mil o año mil novecientos*/

 create function GETFECHANACIMIENTO1
 (
 @CURP VARCHAR(18)
 )
 returns VARCHAR(18)
 as
	begin 
	  RETURN
	   	CASE 
			WHEN (SUBSTRING(@CURP,9, 1)) = '9' THEN STUFF(STUFF(STUFF(SUBSTRING(@CURP,5, 6),3,0,'-'),6,0,'-'),7,0,'19')
			WHEN (SUBSTRING(@CURP,9, 1)) = '2' THEN STUFF(STUFF(STUFF(SUBSTRING(@CURP,5, 6),3,0,'-'),6,0,'-'),7,0,'20')
			WHEN (SUBSTRING(@CURP,9, 1)) = '0' THEN STUFF(STUFF(STUFF(SUBSTRING(@CURP,5, 6),3,0,'-'),6,0,'-'),7,0,'20')
		END
	END 
 
 Print dbo.GETFECHANACIMIENTO1('COTJ231209HCMRS09');
  
  /*4. Crear la función GetidEstado la cual reciba como parámetros 
  el curp y regrese Id Estado con base en la siguiente tabla*/
   create function GETIDESTADOF
 (
 @CURP VARCHAR(18)
 )
 returns VARCHAR(18)
 as
	begin 
	  RETURN
	   	CASE 
			WHEN SUBSTRING(@CURP,12, 2) = 'AS' THEN '1'
			WHEN SUBSTRING(@CURP,12, 2) = 'BC' THEN '2'
			WHEN SUBSTRING(@CURP,12, 2) = 'BS' THEN '3'
			WHEN SUBSTRING(@CURP,12, 2) = 'CC' THEN '4'
			WHEN SUBSTRING(@CURP,12, 2) = 'CH' THEN '5'
			WHEN SUBSTRING(@CURP,12, 2) = 'CS' THEN '6'
			WHEN SUBSTRING(@CURP,12, 2) = 'CL' THEN '7'
			WHEN SUBSTRING(@CURP,12, 2) = 'CM' THEN '8'
			WHEN SUBSTRING(@CURP,12, 2) = 'DG' THEN '9'
			WHEN SUBSTRING(@CURP,12, 2) = 'GT' THEN '10'
			WHEN SUBSTRING(@CURP,12, 2) = 'GR' THEN '11'
			WHEN SUBSTRING(@CURP,12, 2) = 'HG' THEN '12'
			WHEN SUBSTRING(@CURP,12, 2) = 'JC' THEN '13'
			WHEN SUBSTRING(@CURP,12, 2) = 'MC' THEN '14'
			WHEN SUBSTRING(@CURP,12, 2) = 'MN' THEN '15'
			WHEN SUBSTRING(@CURP,12, 2) = 'MS' THEN '16'
			WHEN SUBSTRING(@CURP,12, 2) = 'NT' THEN '17'
			WHEN SUBSTRING(@CURP,12, 2) = 'NL' THEN '18'
			WHEN SUBSTRING(@CURP,12, 2) = 'OC' THEN '19'
			WHEN SUBSTRING(@CURP,12, 2) = 'PL' THEN '20'
			WHEN SUBSTRING(@CURP,12, 2) = 'QT' THEN '21'
			WHEN SUBSTRING(@CURP,12, 2) = 'QR' THEN '22'
			WHEN SUBSTRING(@CURP,12, 2) = 'SP' THEN '23'
			WHEN SUBSTRING(@CURP,12, 2) = 'SL' THEN '24'
			WHEN SUBSTRING(@CURP,12, 2) = 'SR' THEN '25'
			WHEN SUBSTRING(@CURP,12, 2) = 'TC' THEN '26'
			WHEN SUBSTRING(@CURP,12, 2) = 'TS' THEN '27'
			WHEN SUBSTRING(@CURP,12, 2) = 'TL' THEN '28'
			WHEN SUBSTRING(@CURP,12, 2) = 'VZ' THEN '29'
			WHEN SUBSTRING(@CURP,12, 2) = 'YN' THEN '30'
			WHEN SUBSTRING(@CURP,12, 2) = 'ZS' THEN '31'
		END
	END 
 Print dbo.GETIDESTADOF('COTJ231299HMSRS09');
 
/*5. Realizar una función llamada Calculadora que reciba como parámetros dos
enteros y un operador (+,-,*,/,%) regresando el resultado de la operación se
deberá cuidar de no hacer división entre cero*/
 create function CALCULADORAFINAL0
 (
 @valor1 INT,
 @op varchar(1),
 @valor2 INT
 )
 returns int
 begin 
RETURN(
    	 CASE 
	WHEN @op = '+' THEN @valor1+@valor2
	WHEN @op = '-' THEN @valor1-@valor2
	WHEN @op = '%' THEN @valor1%@valor2
	WHEN @op = '/' THEN IIF(@valor2 = 0,0,@valor1/@valor2)
	/*ELSE 'No existe es opcion compa'*/
	END)
   END
    
 Print dbo.CALCULADORAFINAL6(0,'/',3);

/*6. Realizar una función llamada GetHonorarios que calcule el importe a 
pagar a un determinado instructor y curso, por lo que la función recibirá
como parámetro el id del instructor y el id del curso.*/

 create function GETHONORARIOS 
 (
 @idinstructor int,
 @idcurso int
 )
 returns int
 as
 begin 
   declare @resultado int
   declare @paghora int
   declare @horascu int

	set @paghora =(
		SELECT ins.cuotaHora FROM instructores ins WHERE id = @idinstructor);

	set @horascu =(SELECT horas from CatCursos CC INNER JOIN Cursos CUR
		ON CC.id = CUR.idcatcurso WHERE CUR.id = @idcurso);

		set @resultado =@paghora * @horascu;
		return @resultado;
	END;
GO

 Print dbo.GETHONORARIOS(1,27);

/*7. Crear la función GetEdad la cual reciba como parámetros la fecha de nacimiento y
la fecha a la que se requiere realizar el cálculo de la edad. Los años deberán se
cumplidos, considerando mes y día*/

 CREATE FUNCTION GETEDAD2
 (
  @f1 varchar(10),
  @f2 varchar(10)
 )
 returns int
 as
 BEGIN
 DECLARE @edad int
 set @edad = (DATEDIFF(YEAR,@f1,@f2))
 return @edad
 end
 go

 PRINT dbo.GETEDAD2('1999-12-23','2022-05-26');

/*8. Crear la función Factorial la cual reciba como parámetros un número entero y
regrese como resultado el factorial.*/

create function FACTORIAL(
@num int
)
returns bigint
as
begin
declare @i int = 1

 while @num>1
 begin
  set @i = @num *  @i
  set @num=@num-1
  end
return @i
end

select dbo.FACTORIAL(5);

/*9. Crear la función ReembolsoQuincenal la cual reciba como parámetros un
SueldoMensual y regrese como resultado el Importe de Reembolso quincenal,
considerando que el importe total a reembolsar es igual a dos meses y medio de
sueldo, y el periodo de reembolso es de 6 meses*/
ALTER function REEMBOLSOQUINCENAL
 (
  @MES decimal (9,3)
 )
 returns DECIMAL (9,3)
 as
 begin 
    declare @R1 decimal (9,3)
    declare @R2 decimal (9,3)

   SET @R1=((@MES)*2.5)
   SET @R2 = (@R1/12)

   return @R2 
 END;
GO
 Print dbo.REEMBOLSOQUINCENAL(22000.00);


 ALTER function REEMBOLSOQUINCENAL3
 (
  @ida int
 )
 returns DECIMAL (9,3)
 as
 begin 
    declare @R1 decimal (9,3)
    declare @R2 decimal (9,3)

   SET @R1=((select sueldo from ALUMNOS where id = @ida) *2.5)
   SET @R2 = (@R1/12)
   return @R2 
 END;
GO

print dbo.REEMBOLSOQUINCENAL3(1);

/*13. Hacer una función que convierta a mayúsculas la primera letra de cada palabra de
un cadena de caracteres recibida.*/

create function MAYUS(@Text as varchar(8000))
returns varchar(8000)
as
begin
  declare @Reset bit;
  declare @Ret varchar(8000);
  declare @i int;
  declare @c char(1);

  if @Text is null
    return null;

  select @Reset = 1, @i = 1, @Ret = '';

  while (@i <= len(@Text))
    select @c = substring(@Text, @i, 1),
      @Ret = @Ret + case when @Reset = 1 then UPPER(@c) else LOWER(@c) end,
      @Reset = case when @c like '[a-zA-Z]' then 0 else 1 end,
      @i = @i + 1
  return @Ret
end

Print dbo.MAYUS('texto en minus Y TEXTO EN MAYUS')





























set @mes =1
set @cuotahora = select cuotahora where
SET @porcentajeintereanual=(IFF(@@cuotahora>200,.24,.18))
SET @pagomensual = @cuotahora*25
SET SALDOANTERIOR = @cuotahora*25






while @mes<=12
begin

set @intereses = ((@saldoanterior*@porcentajeintereanual)/12)
set @pagomensual = IIF(@saldoanterior<=@pagomensual,(@)@saldoanterior+@intereses),@@pagomensual)
set @saldonuevo = ((@saldoanterior+@intereses )-@pagomensual)

insert @table 

MES,SALDOANTERIOR,INTERESES,PAGOMENSUAL,SALDONUEVO
set @saldoanterior = @saldonuevo
set @mes = IFF(@saldoanterior<=0,@mes+12.@mes+1)

end
return
end