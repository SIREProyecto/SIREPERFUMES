IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoParametrosGenerales'
)

DROP PROCEDURE dbo.pa_MantenimientoParametrosGenerales

GO

CREATE PROCEDURE pa_MantenimientoParametrosGenerales
(
	@pCodParametroGeneral CHAR(6) = NULL,
	@pDesParametroGeneral VARCHAR(30) = NULL,
	@pCompania TINYINT = NULL,
	@pValorParametroFecha DATETIME = NULL,
	@pValorParametroNumero INT = NULL,
	@pValorParametroTexto VARCHAR(60) = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pDesParametroGeneralBUS VARCHAR(30) = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'CodParametroGeneral',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT

)
AS 

BEGIN

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
	
		IF @pDesParametroGeneralBUS = ''
			SET @pDesParametroGeneralBUS = NULL
		
		SELECT @pnumTotalRegistros = COUNT(*) FROM  ParametrosGenerales   
		WHERE  DesParametroGeneral LIKE COALESCE(@pDesParametroGeneralBUS, DesParametroGeneral) 

		print @pnumTotalRegistros
		SET @ldesParmDefinition3 = N'@pDesParametroGeneralBUS VARCHAR(30) '
		

		SET @lSQLString3 = 'SELECT 	CodParametroGeneral,DesParametroGeneral,
							UsuarioIngreso, FechaIngreso, 	
							UsuarioModifico, FechaModifico, Compania,ValorParametroFecha,ValorParametroNumero,ValorParametroTexto ' 
							+ ' FROM	ParametrosGenerales  ' +
							' WHERE ' + ' DesParametroGeneral LIKE COALESCE(@pDesParametroGeneralBUS, DesParametroGeneral) ' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'CodParametroGeneral') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pDesParametroGeneralBUS = @pDesParametroGeneralBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN


		INSERT INTO ParametrosGenerales (CodParametroGeneral,DesParametroGeneral,UsuarioIngreso,
					Compania,ValorParametroFecha,ValorParametroNumero,ValorParametroTexto)
		VALUES     (@pCodParametroGeneral,@pDesParametroGeneral,@pUsuarioIngreso,
					@pCompania,@pValorParametroFecha,@pValorParametroNumero,@pValorParametroTexto)

	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE ParametrosGenerales
		SET    DesParametroGeneral = @pDesParametroGeneral,
			   ValorParametroFecha = @pValorParametroFecha,
			   ValorParametroNumero = @pValorParametroNumero,
			   ValorParametroTexto = @pValorParametroTexto,
			   UsuarioModifico = @pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  CodParametroGeneral = @pCodParametroGeneral
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT CodParametroGeneral, DesParametroGeneral,
			   UsuarioIngreso,FechaIngreso,
			   UsuarioModifico,FechaModifico,
			   Compania ,ValorParametroFecha,
			   ValorParametroNumero,ValorParametroTexto
		FROM   ParametrosGenerales 
		WHERE  CodParametroGeneral = @pCodParametroGeneral
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM ParametrosGenerales
		WHERE  CodParametroGeneral = @pCodParametroGeneral
	END

END

