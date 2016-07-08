IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoPresentacion'
)

DROP PROCEDURE dbo.pa_MantenimientoPresentacion

GO

CREATE PROCEDURE pa_MantenimientoPresentacion
(
	@pDesPresentacion VARCHAR(60) = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pDesPresentacionBUS VARCHAR(60) = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConPresentacion',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConPresentacionOUT SMALLINT OUTPUT,
	@pConPresentacion SMALLINT 

)
AS 

BEGIN

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
	
		SELECT @pnumTotalRegistros = COUNT(*) FROM  Presentacion   
		WHERE  DesPresentacion LIKE COALESCE(@pDesPresentacionBUS, DesPresentacion) 
 
		SET @ldesParmDefinition3 = N'@pDesPresentacionBUS VARCHAR(60) '

		SET @lSQLString3 = 'SELECT 	ConPresentacion,DesPresentacion,
							UsuarioIngreso, FechaIngreso, 	
							UsuarioModifico, FechaModifico' 
							+ 'FROM	Presentacion  ' +
							'WHERE ' + ' DesPresentacion LIKE COALESCE(@pDesParametroGeneralBUS, DesParametroGeneral) ' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'ConPresentacion') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pDesPresentacionBUS = @pDesPresentacionBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO Presentacion (DesPresentacion,UsuarioIngreso)
		VALUES     (@pDesPresentacion,@pUsuarioIngreso)
		SET @pConPresentacionOUT = @@IDENTITY
	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE Presentacion
		SET    DesPresentacion = @pDesPresentacion,
			   UsuarioModifico = @pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConPresentacion = @pConPresentacion
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT ConPresentacion, DesPresentacion,
			   UsuarioIngreso,FechaIngreso,
			   UsuarioModifico,FechaModifico
		FROM   Presentacion 
		WHERE  ConPresentacion = @pConPresentacion
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM Presentacion
		WHERE  ConPresentacion = @pConPresentacion
	END

END

