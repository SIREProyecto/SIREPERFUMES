IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoMarcaTipoProducto'
)

DROP PROCEDURE dbo.pa_MantenimientoMarcaTipoProducto

GO

CREATE PROCEDURE pa_MantenimientoMarcaTipoProducto
(
	@pMarca SMALLINT = NULL,
	@pTipoProducto SMALLINT = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pMarcaBUS SMALLINT = NULL,
	@pTipoProductoBUS SMALLINT = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConMarcaTipoProducto',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConMarcaTipoProductoOUT SMALLINT OUTPUT,
	@pConMarcaTipoProducto SMALLINT = NULL

)
AS 

BEGIN

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
	
		SELECT @pnumTotalRegistros = COUNT(*) FROM  MarcaTipoProducto   
		WHERE  Marca = COALESCE(@pMarcaBUS, Marca) AND
			   TipoProducto = COALESCE(@pTipoProductoBUS, TipoProducto)
 
		SET @ldesParmDefinition3 = N'@pMarcaBUS SMALLINT,@pTipoProductoBUS SMALLINT '

		SET @lSQLString3 = 'SELECT 	MT.ConMarcaTipoProducto, MT.Marca,M.DesMarca,
							MT.TipoProducto, T.DesTipoProducto,
							MT.UsuarioIngreso, MT.FechaIngreso, 	
							MT.UsuarioModifico, MT.FechaModifico' + 'FROM	MarcaTipoProducto MT ' + 
							' INNER JOIN  Marcas M ON MT.Marca = M.ConMarca'
							 + 
							 ' INNER JOIN TipoProducto T ON MT.TipoProducto = T.ConTipoProducto'
							 + 
							'WHERE ' + ' Marca = COALESCE(@pMarcaBUS, Marca) AND
							  TipoProducto = COALESCE(@pTipoProductoBUS, TipoProducto)' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'ConMarcaTipoProducto') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pMarcaBUS = @pMarcaBUS,@pTipoProductoBUS= @pTipoProductoBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO MarcaTipoProducto (Marca, TipoProducto,UsuarioIngreso)
		VALUES(@pMarca,@pTipoProducto,@pUsuarioIngreso)
		SET @pConMarcaTipoProductoOUT = @@IDENTITY
	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE MarcaTipoProducto
		SET    Marca = @pMarca,
			   TipoProducto = @pTipoProducto,
			   UsuarioModifico = @pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConMarcaTipoProducto = @pConMarcaTipoProducto
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT MT.ConMarcaTipoProducto,MT.Marca,M.DesMarca,
			   MT.TipoProducto,T.DesTipoProducto,
			   MT.UsuarioIngreso,MT.FechaIngreso,
			   MT.UsuarioModifico,MT.FechaModifico
		FROM   MarcaTipoProducto MT
			   INNER JOIN Marcas M 
			   ON MT.Marca = M.ConMarca
			   INNER JOIN TipoProducto T
			   ON MT.TipoProducto = T.ConTipoProducto
		WHERE  ConMarcaTipoProducto = @pConMarcaTipoProducto
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM MarcaTipoProducto
		WHERE  ConMarcaTipoProducto = @pConMarcaTipoProducto
	END

END

