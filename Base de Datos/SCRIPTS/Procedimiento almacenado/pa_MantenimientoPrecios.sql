IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoPrecios'
)

DROP PROCEDURE dbo.pa_MantenimientoPrecios

GO

CREATE PROCEDURE pa_MantenimientoPrecios
(
	@pPrecioCompra NUMERIC(10,4) = NULL,
	@pPrecioConversion NUMERIC(10,4) = NULL,
	@pPorPrecioPorMayor NUMERIC(7,4) = NULL,
	@pPorPrecioPorDetalle NUMERIC(7,4) = NULL,
	@pPrecioPorMayorFinal NUMERIC(10,4) = NULL,
	@pPrecioPorDetalleFinal NUMERIC(10,4) = NULL,
	@pProducto INT = NULL,
	@pMoneda CHAR(3) = NULL,
	@pTipoDeCambio INT = NULL,
	@pPresentacion SMALLINT = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pFecTipoDeCambioBUS DATETIME = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConTipoDeCambio',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConPrecioOUT INT OUTPUT,
	@pConPrecio INT = NULL

)
AS 

BEGIN

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO Precios (PrecioCompra,PrecioConversion,PorPrecioPorMayor,PorPrecioPorDetalle,
							 PrecioPorMayorFinal,PrecioPorDetalleFinal,Producto,Moneda,
							 TipoDeCambio,Presentacion,UsuarioIngreso)
		VALUES(@pPrecioCompra,@pPrecioConversion,@pPorPrecioPorMayor,@pPorPrecioPorDetalle,
		@pPrecioPorMayorFinal,@pPrecioPorDetalleFinal,@pProducto,@pMoneda,@pTipoDeCambio,@pPresentacion,@pUsuarioIngreso)
		SET @pConPrecioOUT = @@IDENTITY
	END

		
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE Precios
		SET PrecioCompra =@pPrecioCompra,
		PrecioConversion=@pPrecioConversion,
		PorPrecioPorMayor=@pPorPrecioPorMayor,
		PorPrecioPorDetalle=@pPorPrecioPorDetalle,
		PrecioPorMayorFinal=@pPrecioPorMayorFinal,
		PrecioPorDetalleFinal=@pPrecioPorDetalleFinal,
		Producto=@pProducto,
		Moneda=@pMoneda,
		TipoDeCambio=@pTipoDeCambio,
		Presentacion=@pPresentacion,
		UsuarioModifico= @pUsuarioModifico
		WHERE ConPrecio = @pConPrecio
	END

	IF @pTipoOperacion = 4
	BEGIN
		SELECT ConPrecio, PrecioCompra,
			   PrecioConversion,PorPrecioPorMayor,
			   PorPrecioPorDetalle,PrecioPorMayorFinal,
			   PrecioPorDetalleFinal,Producto,
			   Moneda,TipoDeCambio,
			   UsuarioIngreso,FechaIngreso,
			   UsuarioModifico,FechaModifico,
			   Presentacion
		FROM   Precios 
		WHERE ConPrecio = @pConPrecio
	END

END

