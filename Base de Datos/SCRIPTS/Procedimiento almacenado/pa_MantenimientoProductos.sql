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
	@pConProductoOUT INT OUTPUT,
	@pConProducto INT 

)
AS 

BEGIN

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
	
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

		SET @lSQLString3 = 'SELECT ConProveedor,NomProveedor,DesCompaniaProveedor,PrimerApellido,
							SegundoApellido,Cargo,TelefonoTrabajo,TelefonoMovil,Direccion,CorreoElectronico,
							RazonSocial,UsuarioIngreso,FechaIngreso,UsuarioModifico,FechaModifico,Compania 	' 
							+ 'FROM	Proveedores  '
							+
							'WHERE ' + ' NomProveedor = COALESCE(@pNomProveedorBUS, NomProveedor) AND
							 Cargo = COALESCE(@pCargoBUS, Cargo) ' +
							' ORDER BY ' + COALESCE(@pnomCampoOrdenBUS, 'ConProveedor') + 
							CASE @pnumPageSize
							WHEN -1 THEN ''
							ELSE
							'  OFFSET ' + CONVERT(CHAR(10), @lnumOffSet3) + ' ROWS '  +
							'  FETCH NEXT ' + CONVERT(CHAR(10), @pnumPageSize) + ' ROWS ONLY' 
							END
		

		EXECUTE sp_executesql @lSQLString3, @ldesParmDefinition3, @pNomProveedorBUS = @pNomProveedorBUS, @pCargoBUS = @pCargoBUS

	END

	
	IF @pTipoOperacion = 2
	BEGIN

		INSERT INTO Proveedores (NomProveedor,DesCompaniaProveedor,PrimerApellido,
					SegundoApellido,Cargo,TelefonoTrabajo,TelefonoMovil,Direccion,CorreoElectronico,
					RazonSocial,UsuarioIngreso,Compania)
		VALUES     (@pNomProveedor,@pDesCompaniaProveedor,@pPrimerApellido,
					@pTelefonoTrabajo,@pTelefonoTrabajo,@pTelefonoTrabajo,@pTelefonoMovil,@pDireccion,@pCorreoElectronico,
					@pRazonSocial, @pUsuarioIngreso, @pCompania)
		SET @pConProveedorOUT = @@IDENTITY
	END

	
	IF @pTipoOperacion = 3
	BEGIN

		UPDATE Proveedores
		SET    NomProveedor = @pNomProveedor,
			   DesCompaniaProveedor = @pDesCompaniaProveedor,
			   PrimerApellido = @pPrimerApellido,
			   SegundoApellido = @pTelefonoTrabajo,
			   Cargo = @pTelefonoTrabajo,
			   TelefonoTrabajo = @pTelefonoTrabajo,
			   TelefonoMovil = @pTelefonoMovil,
			   Direccion = @pDireccion,
			   CorreoElectronico = @pCorreoElectronico,
			   RazonSocial = @pRazonSocial,
			   UsuarioModifico = @pUsuarioModifico,
			   FechaModifico = GETDATE()
		WHERE  ConProveedor = @pConProveedor
		

	END

	
	IF @pTipoOperacion = 4
	BEGIN
		SELECT  ConProveedor,NomProveedor,DesCompaniaProveedor,PrimerApellido,
				SegundoApellido,Cargo,TelefonoTrabajo,TelefonoMovil,
				Direccion,CorreoElectronico,RazonSocial,UsuarioIngreso,
				FechaIngreso,UsuarioModifico,FechaModifico,Compania  
		FROM	Proveedores 
		WHERE   ConProveedor = @pConProveedor
		 
	END

	
	IF @pTipoOperacion = 5
	BEGIN
		
		DELETE FROM Proveedores
		WHERE  ConProveedor = @pConProveedor
	END

END

