IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoTipoProducto'
)

DROP PROCEDURE dbo.pa_MantenimientoTipoProducto

GO

CREATE PROCEDURE pa_MantenimientoTipoProducto
(
	@pDesTipoProducto VARCHAR(60) = NULL,
	@pCategoriaProducto SMALLINT = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pDesTipoProductoBUS VARCHAR(60) = NULL,
	@pCategoriaProductoBUS SMALLINT = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConTipoProducto',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConTipoProductoOUT SMALLINT = NULL OUTPUT,
	@pConTipoProducto SMALLINT = NULL

)
AS 

BEGIN

	IF @pTipoOperacion = 55
	BEGIN

		SELECT ConTipoProducto, DesTipoProducto FROM TipoProducto
	END

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
	
		IF @pDesTipoProductoBUS = ''
			SET @pDesTipoProductoBUS = NULL

		IF @pCategoriaProductoBUS = 0
			SET @pCategoriaProductoBUS = NULL

		SELECT @pnumTotalRegistros = COUNT(*) FROM  TipoProducto   
		WHERE  DesTipoProducto = COALESCE(@pDesTipoProductoBUS, DesTipoProducto) 
		AND CategoriaProducto = COALESCE(@pCategoriaProductoBUS,CategoriaProducto)
 
		SET @ldesParmDefinition3 = N'@pDesTipoProductoBUS VARCHAR(60), @pCategoriaProductoBUS SMALLINT '

		SET @lSQLString3 = 'SELECT 	TP.ConTipoProducto,TP.DesTipoProducto,TP.CategoriaProducto,
							TP.UsuarioIngreso, TP.FechaIngreso, 	
							TP.UsuarioModifico, TP.FechaModifico,' +
							' CA.DesCategoriaProducto '
							 + ' FROM	TipoProducto TP ' +
							' INNER JOIN CategoriaProducto CA ON TP.CategoriaProducto = CA.ConCategoriaProducto ' +
							'WHERE ' + ' DesTipoProducto = COALESCE(@pDesTipoProductoBUS, DesTipoProducto) ' +
							' AND CategoriaProducto = COALESCE(@pCategoriaProductoBUS,CategoriaProducto) ' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'ConTipoProducto') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pDesTipoProductoBUS = @pDesTipoProductoBUS, 
		@pCategoriaProductoBUS = @pCategoriaProductoBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO TipoProducto (DesTipoProducto,UsuarioIngreso,CategoriaProducto)
		VALUES(@pDesTipoProducto,@pUsuarioIngreso,@pCategoriaProducto)
		SET @pConTipoProductoOUT = @@IDENTITY
	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE TipoProducto
		SET    DesTipoProducto = @pDesTipoProducto,
			   CategoriaProducto  = @pCategoriaProducto,
			   UsuarioModifico = @pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConTipoProducto = @pConTipoProducto
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT TP.ConTipoProducto, TP.DesTipoProducto,CA.DesCategoriaProducto,
			   TP.CategoriaProducto,
			   TP.UsuarioIngreso,TP.FechaIngreso,
			   TP.UsuarioModifico,TP.FechaModifico
		FROM   TipoProducto TP INNER JOIN CategoriaProducto CA
		ON TP.CategoriaProducto = CA.ConCategoriaProducto
		WHERE  TP.ConTipoProducto = @pConTipoProducto
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM TipoProducto
		WHERE  ConTipoProducto = @pConTipoProducto
	END

END

