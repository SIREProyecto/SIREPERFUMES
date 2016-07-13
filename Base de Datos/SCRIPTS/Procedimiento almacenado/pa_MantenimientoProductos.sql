IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoProductos'
)

DROP PROCEDURE dbo.pa_MantenimientoProductos

GO

CREATE PROCEDURE pa_MantenimientoProductos
(
	@pDesProducto VARCHAR(60) = NULL,
	@pCodProducto VARCHAR(30) = NULL,
	@pMinimoStock INT = NULL,
	@pMaximoStock INT = NULL,
	@pNuevoInventario BIT = NULL,
	@pSuspendido BIT = NULL,
	@pDesRutaImagen VARCHAR(150) = NULL,
	@pNomImagen VARCHAR(60) = NULL,
	@pCategoriaProducto SMALLINT = NULL,
	@pTipoProducto SMALLINT= NULL,
	@pMarca SMALLINT= NULL,
	@pProveedor SMALLINT= NULL,
	@pTipoGenero TINYINT= NULL,
	@pEstadoPorProceso TINYINT= NULL,
	@pPresentacion SMALLINT= NULL,
	@pCompania TINYINT = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pCodProductoBUS VARCHAR(30) = NULL,
	@pDesProductoBUS VARCHAR(60) = NULL,
	@pCategoriaProductoBUS SMALLINT = NULL,
	@pMarcaBUS SMALLINT = NULL,
	@pTipoProductoBUS SMALLINT = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConProducto',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConProductoOUT INT = NULL OUTPUT,
	@pConProducto INT = NULL 

)
AS 

BEGIN

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
		
		IF @pCodProductoBUS = ''
			SET @pCodProductoBUS = NULL

		IF @pDesProductoBUS = ''
			SET @pDesProductoBUS = NULL


		SELECT @pnumTotalRegistros = COUNT(*) FROM  Productos   
		WHERE  CodProducto = COALESCE(@pCodProductoBUS, CodProducto) AND
			   DesProducto = COALESCE(@pDesProductoBUS, DesProducto) AND
			   CategoriaProducto = COALESCE(@pCategoriaProductoBUS, CategoriaProducto) AND
			   Marca = COALESCE(@pMarcaBUS, Marca) AND
			   TipoProducto = COALESCE(@pTipoProductoBUS, TipoProducto) 
 
		SET @ldesParmDefinition3 = N'@pCodProductoBUS VARCHAR(30) = NULL,
									 @pDesProductoBUS VARCHAR(60) = NULL,
									 @pCategoriaProductoBUS SMALLINT = NULL,
									 @pMarcaBUS SMALLINT = NULL,
									 @pTipoProductoBUS SMALLINT = NULL '

		SET @lSQLString3 = 'SELECT P.ConProducto,P.DesProducto,P.CodProducto,P.MinimoStock,P.MaximoStock,
							P.NuevoInventario,P.Suspendido,P.DesRutaImagen,P.NomImagen,P.CategoriaProducto,
							P.TipoProducto,P.Marca,P.Proveedor,P.TipoGenero,P.EstadoPorProceso,P.UsuarioIngreso,P.FechaIngreso,
							P.UsuarioModifico,P.FechaModifico,P.Compania,P.Presentacion,C.DesCategoriaProducto,
							T.DesTipoProducto,M.DesMarca,PR.NomProveedor,G.DesTipoGenero,E.Estado,PE.DesPresentacion 	' 
							+ 'FROM Productos P  '
							+ ' INNER JOIN CategoriaProducto C ON P.CategoriaProducto = C.ConCategoriaProducto '
							+ ' INNER JOIN TipoProducto T ON P.TipoProducto = T.ConTipoProducto '
							+ ' INNER JOIN Marcas M ON P.Marca = M.ConMarca '
							+ ' INNER JOIN Proveedores PR ON P.Proveedor = PR.ConProveedor '
							+ ' INNER JOIN TipoGenero G ON P.TipoGenero = G.ConTipoGenero '
							+ ' INNER JOIN EstadosPorProceso E ON P.EstadoPorProceso = E.ConEstadoPorProceso '
							+ ' INNER JOIN Presentacion PE ON P.Presentacion  = PE.ConPresentacion ' +
							' WHERE ' +
							' P.CodProducto = COALESCE(@pCodProductoBUS, P.CodProducto) AND ' +
							' P.DesProducto = COALESCE(@pDesProductoBUS, P.DesProducto) AND ' +
							' P.CategoriaProducto = COALESCE(@pCategoriaProductoBUS, P.CategoriaProducto) AND ' +
							' P.Marca = COALESCE(@pMarcaBUS, P.Marca) AND ' +
							' P.TipoProducto = COALESCE(@pTipoProductoBUS, P.TipoProducto) AND ' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'P.ConProducto') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pCodProductoBUS = @pCodProductoBUS, @pDesProductoBUS = @pDesProductoBUS,
		@pCategoriaProductoBUS = @pCategoriaProductoBUS,@pMarcaBUS = @pMarcaBUS,@pTipoProductoBUS = @pTipoProductoBUS

	END

	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO Productos 
		(DesProducto,CodProducto,MinimoStock,MaximoStock,NuevoInventario,Suspendido,
		DesRutaImagen,NomImagen,CategoriaProducto,TipoProducto,Marca,Proveedor,
		TipoGenero,EstadoPorProceso,UsuarioIngreso,Compania,Presentacion)
		VALUES
		(@pDesProducto,@pCodProducto,@pMinimoStock,@pMaximoStock,@pNuevoInventario,@pSuspendido,
		@pDesRutaImagen,@pNomImagen,@pCategoriaProducto,@pTipoProducto,@pMarca,@pProveedor,
		@pTipoGenero,@pEstadoPorProceso,@pUsuarioIngreso,@pCompania,@pPresentacion)
		SET @pConProductoOUT = @@IDENTITY
	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE Productos
		SET    DesProducto = @pDesProducto,
			   CodProducto = @pCodProducto,
			   MinimoStock =  @pMinimoStock,
			   MaximoStock =  @pMaximoStock,
			   NuevoInventario =  @pNuevoInventario,
			   Suspendido =  @pSuspendido,
			   DesRutaImagen =  @pDesRutaImagen,
			   NomImagen =  @pNomImagen,
			   CategoriaProducto =  @pCategoriaProducto,
			   TipoProducto =  @pTipoProducto,
			   Marca =  @pMarca,
			   Proveedor =  @pProveedor,
		       TipoGenero =  @pTipoGenero,
			   EstadoPorProceso =  @pEstadoPorProceso,
			   Compania =  @pCompania,
			   Presentacion =  @pPresentacion,
			   UsuarioModifico = @pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConProducto = @pConProducto
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT P.ConProducto,P.DesProducto,P.CodProducto,P.MinimoStock,P.MaximoStock,
		P.NuevoInventario,P.Suspendido,P.DesRutaImagen,P.NomImagen,P.CategoriaProducto,
		P.TipoProducto,P.Marca,P.Proveedor,P.TipoGenero,P.EstadoPorProceso,P.UsuarioIngreso,P.FechaIngreso,
		P.UsuarioModifico,P.FechaModifico,P.Compania,P.Presentacion,C.DesCategoriaProducto,
		T.DesTipoProducto,M.DesMarca,PR.NomProveedor,G.DesTipoGenero,E.Estado,PE.DesPresentacion
		FROM Productos P
		INNER JOIN CategoriaProducto C ON P.CategoriaProducto = C.ConCategoriaProducto
		INNER JOIN TipoProducto T ON P.TipoProducto = T.ConTipoProducto
		INNER JOIN Marcas M ON P.Marca = M.ConMarca
		INNER JOIN Proveedores PR ON P.Proveedor = PR.ConProveedor
		INNER JOIN TipoGenero G ON P.TipoGenero = G.ConTipoGenero
		INNER JOIN EstadosPorProceso E ON P.EstadoPorProceso = E.ConEstadoPorProceso
		INNER JOIN Presentacion PE ON P.Presentacion  = PE.ConPresentacion
		WHERE P.ConProducto = @pConProducto
		 
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM Productos
		WHERE ConProducto = @pConProducto
	END

END

