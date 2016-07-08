IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoTipoDeCambio'
)

DROP PROCEDURE dbo.pa_MantenimientoTipoDeCambio

GO

CREATE PROCEDURE pa_MantenimientoTipoDeCambio
(
	@pMtoTipoDeCambio NUMERIC(7,4) = NULL,
	@pFecTipoDeCambio DATETIME = NULL,
	@pMonedaOrigen CHAR(3) = NULL,
	@pMonedaDestino CHAR(3) = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pFecTipoDeCambioBUS DATETIME = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConTipoDeCambio',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConTipoDeCambioOUT INT OUTPUT,
	@pConTipoDeCambio INT = NULL

)
AS 

BEGIN

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
	
		SELECT @pnumTotalRegistros = COUNT(*) FROM  TipoDeCambio   
		WHERE  FecTipoDeCambio = COALESCE(@pFecTipoDeCambioBUS, FecTipoDeCambio) 
 
		SET @ldesParmDefinition3 = N'@pFecTipoDeCambioBUS DATETIME '

		SET @lSQLString3 = 'SELECT 	T.ConTipoDeCambio,T.MtoTipoDeCambio,
							T.FecTipoDeCambio, T.MonedaOrigen, M.DesMoneda AS DesMonedaOrigen,
							T.MonedaDestino, M.DesMoneda AS DesMonedaDestino,
							T.UsuarioIngreso, T.FechaIngreso, 	
							T.UsuarioModifico, T.FechaModifico ' + ' FROM	TipoDeCambio T ' +
							' INNER JOIN Monedas M ON T.MonedaOrigen = M.CodMoneda '+
							' WHERE ' + ' FecTipoDeCambio = COALESCE(@pFecTipoDeCambioBUS, FecTipoDeCambio)  ' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'ConTipoDeCambio') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pFecTipoDeCambioBUS = @pFecTipoDeCambioBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO TipoDeCambio (MtoTipoDeCambio,FecTipoDeCambio,MonedaOrigen,MonedaDestino,UsuarioIngreso)
		VALUES(@pMtoTipoDeCambio,@pFecTipoDeCambio,@pMonedaOrigen,@pMonedaDestino,@pUsuarioIngreso)
		SET @pConTipoDeCambioOUT = @@IDENTITY
	END

	IF @pTipoOperacion = 3
	BEGIN

		UPDATE TipoDeCambio
		SET    MtoTipoDeCambio = @pMtoTipoDeCambio,
			   FecTipoDeCambio = FecTipoDeCambio,
			   MonedaOrigen = @pMonedaOrigen,
			   MonedaDestino = @pMonedaDestino,
			   UsuarioModifico = @pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConTipoDeCambio = @pConTipoDeCambio
		
	END
	IF @pTipoOperacion = 4
	BEGIN
		SELECT 	T.ConTipoDeCambio,T.MtoTipoDeCambio,
				T.FecTipoDeCambio, T.MonedaOrigen, M.DesMoneda AS DesMonedaOrigen,
				T.MonedaDestino, M.DesMoneda AS DesMonedaDestino,
				T.UsuarioIngreso, T.FechaIngreso, 	
				T.UsuarioModifico, T.FechaModifico 
		FROM	TipoDeCambio T 
		INNER JOIN Monedas M ON T.MonedaOrigen = M.CodMoneda
		WHERE  FecTipoDeCambio = COALESCE(@pFecTipoDeCambioBUS, FecTipoDeCambio) 
	END


END

