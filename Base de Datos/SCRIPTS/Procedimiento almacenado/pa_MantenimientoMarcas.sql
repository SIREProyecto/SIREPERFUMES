IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoMarcas'
)

DROP PROCEDURE dbo.pa_MantenimientoMarcas

GO

CREATE PROCEDURE pa_MantenimientoMarcas
(
	@pDesMarca VARCHAR(60) = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pDesMarcaBUS VARCHAR(60) = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConMarca',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConMarcaOUT TINYINT OUTPUT,
	@pConMarca TINYINT = NULL

)
AS 

BEGIN
	
	IF @pTipoOperacion = 55
	BEGIN

		SELECT ConMarca,DesMarca FROM Marcas
	END

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)

		SET @pDesMarcaBUS =   '%' + @pDesMarcaBUS +'%'
					

		SELECT @pnumTotalRegistros = COUNT(*) FROM  Marcas   
		WHERE DesMarca LIKE COALESCE(@pDesMarcaBUS, DesMarca) 
 
		SET @ldesParmDefinition3 = N'@pDesMarcaBUS VARCHAR(60)'

		SET @lSQLString3 = 'SELECT 	ConMarca, DesMarca,
							UsuarioIngreso, FechaIngreso, 	
							UsuarioModifico, FechaModifico' + 'FROM	Marcas ' + 
							'WHERE ' + 'DesMarca LIKE COALESCE(@pDesMarcaBUS, DesMarca)' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'ConMarca') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pDesMarcaBUS = @pDesMarcaBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO Marcas (DesMarca,UsuarioIngreso)
		VALUES(@pDesMarca,@pUsuarioIngreso)
		SET @pConMarcaOUT = @@IDENTITY
	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE Marcas
		SET    DesMarca = @pDesMarca,
			   UsuarioModifico =@pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConMarca = @pConMarca
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT ConMarca,DesMarca,
			   UsuarioIngreso,FechaIngreso,
			   UsuarioModifico,FechaModifico
		FROM   Marcas
		WHERE  ConMarca = @pConMarca
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM Marcas
		WHERE  ConMarca = @pConMarca
	END

END

