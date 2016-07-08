IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoCategoriaProducto'
)

DROP PROCEDURE dbo.pa_MantenimientoCategoriaProducto

GO

CREATE PROCEDURE pa_MantenimientoCategoriaProducto
(
	@pDesCategoriaProducto VARCHAR(60) = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pDesCategoriaProductoBUS VARCHAR(60) = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConCategoriaProducto',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConCategoriaProductoOUT SMALLINT = NULL OUTPUT,
	@pConCategoriaProducto SMALLINT = NULL

)
AS 

BEGIN
	
	IF @pTipoOperacion = 55
	BEGIN

		SELECT ConCategoriaProducto,DesCategoriaProducto FROM CategoriaProducto
	END

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)

		SET @pDesCategoriaProductoBUS =   '%' + @pDesCategoriaProductoBUS +'%'
					

		SELECT @pnumTotalRegistros = COUNT(*) FROM  CategoriaProducto   
		WHERE DesCategoriaProducto LIKE COALESCE(@pDesCategoriaProductoBUS, DesCategoriaProducto) 
 
		SET @ldesParmDefinition3 = N'@pDesCategoriaProductoBUS VARCHAR(60)'

		SET @lSQLString3 = 'SELECT 	ConCategoriaProducto, DesCategoriaProducto,
							UsuarioIngreso, FechaIngreso, 	
							UsuarioModifico, FechaModifico' + 'FROM	CategoriaProducto ' + 
							'WHERE ' + 'DesCategoriaProducto LIKE COALESCE(@pDesCategoriaProductoBUS, DesCategoriaProducto)' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'ConCategoriaProducto') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pDesCategoriaProductoBUS = @pDesCategoriaProductoBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO CategoriaProducto (DesCategoriaProducto,UsuarioIngreso)
		VALUES(@pDesCategoriaProducto,@pUsuarioIngreso)
		SET @pConCategoriaProductoOUT = @@IDENTITY
	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE CategoriaProducto
		SET    DesCategoriaProducto = @pDesCategoriaProducto,
			   UsuarioModifico =@pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConCategoriaProducto = @pConCategoriaProducto
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT ConCategoriaProducto,DesCategoriaProducto,
			   UsuarioIngreso,FechaIngreso,
			   UsuarioModifico,FechaModifico
		FROM   CategoriaProducto
		WHERE  ConCategoriaProducto = @pConCategoriaProducto
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM ConCategoriaProducto
		WHERE ConCategoriaProducto = @pConCategoriaProducto 
	END

END

