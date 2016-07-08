IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoPresentacionTipoProducto'
)

DROP PROCEDURE dbo.pa_MantenimientoPresentacionTipoProducto

GO

CREATE PROCEDURE pa_MantenimientoPresentacionTipoProducto
(
	@pPresentacion SMALLINT = NULL,
	@pTipoProducto SMALLINT = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pPresentacionBUS SMALLINT = NULL,
	@pTipoProductoBUS SMALLINT = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConPresentacionTipoProducto',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConPresentacionTipoProductoOUT SMALLINT OUTPUT,
	@pConPresentacionTipoProducto SMALLINT 

)
AS 

BEGIN

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
	
		SELECT @pnumTotalRegistros = COUNT(*) FROM  PresentacionTipoProducto   
		WHERE  Presentacion = COALESCE(@pPresentacionBUS, Presentacion) AND
			   TipoProducto = COALESCE(@pTipoProductoBUS, TipoProducto) 
 
		SET @ldesParmDefinition3 = N'@pPresentacionBUS SMALLINT,@pTipoProductoBUS SMALLINT '

		SET @lSQLString3 = 'SELECT 	PT.ConPresentacionTipoProducto,PT.Presentacion,P.DesPresentacion,
							PT.TipoProducto,T.DesTipoProducto, 
							PT.UsuarioIngreso, PT.FechaIngreso, 	
							PT.UsuarioModifico, PT.FechaModifico' 
							+ 'FROM	PresentacionTipoProducto PT  ' +
							' INNER JOIN Presentacion P ON PT.Presentacion = P.ConPresentacion '+
							' INNER JOIN TipoProducto T ON PT.TipoProducto = T.ConTipoProducto'+
							'WHERE ' + ' PT.Presentacion = COALESCE(@pPresentacionBUS, PT.Presentacion) AND
							PT.TipoProducto = COALESCE(@pTipoProductoBUS, PT.TipoProducto)  ' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'PresentacionTipoProducto') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pPresentacionBUS = @pPresentacionBUS, @pTipoProductoBUS = @pTipoProductoBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO PresentacionTipoProducto (Presentacion,TipoProducto,UsuarioIngreso)
		VALUES     (@pPresentacion,@pTipoProducto,@pUsuarioIngreso)
		SET @pConPresentacionTipoProductoOUT = @@IDENTITY
	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE PresentacionTipoProducto
		SET    Presentacion = @pPresentacion,
			   TipoProducto = @pTipoProducto,
			   UsuarioModifico = @pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConPresentacionTipoProducto = @pConPresentacionTipoProducto
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT 	PT.ConPresentacionTipoProducto,PT.Presentacion,P.DesPresentacion,
				PT.TipoProducto,T.DesTipoProducto, 
				PT.UsuarioIngreso, PT.FechaIngreso, 	
				PT.UsuarioModifico, PT.FechaModifico 
		FROM	PresentacionTipoProducto PT  
				INNER JOIN Presentacion P ON PT.Presentacion = P.ConPresentacion 
				INNER JOIN TipoProducto T ON PT.TipoProducto = T.ConTipoProducto
		WHERE   ConPresentacionTipoProducto = @pConPresentacionTipoProducto
		 
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM PresentacionTipoProducto
		WHERE  ConPresentacionTipoProducto = @pConPresentacionTipoProducto
	END

END

