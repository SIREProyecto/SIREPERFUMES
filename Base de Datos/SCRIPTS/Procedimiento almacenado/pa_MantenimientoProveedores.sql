IF EXISTS (
  SELECT	* 
  FROM		INFORMATION_SCHEMA.ROUTINES 
  WHERE		SPECIFIC_SCHEMA = N'dbo'
		AND SPECIFIC_NAME = N'pa_MantenimientoProveedores'
)

DROP PROCEDURE dbo.pa_MantenimientoProveedores

GO

CREATE PROCEDURE pa_MantenimientoProveedores
(
	@pNomProveedor VARCHAR(60) = NULL,
	@pDesCompaniaProveedor VARCHAR(60) = NULL,
	@pPrimerApellido VARCHAR(60) = NULL,
	@pSegundoApellido VARCHAR(60) = NULL,
	@pCargo VARCHAR(60) = NULL,
	@pTelefonoTrabajo VARCHAR(30) = NULL,
	@pTelefonoMovil VARCHAR(30) = NULL,
	@pDireccion VARCHAR(250) = NULL,
	@pCorreoElectronico VARCHAR(120) = NULL,
	@pRazonSocial VARCHAR(100) = NULL,
	@pCompania TINYINT = NULL,
	@pUsuarioIngreso VARCHAR(35) = NULL,
	@pUsuarioModifico VARCHAR(35) = NULL,
	@pTipoOperacion TINYINT,
	@pNomProveedorBUS VARCHAR(60) = NULL,
	@pCargoBUS VARCHAR(60) = NULL,
	@pnomCampoOrdenBUS VARCHAR(60) = 'ConProveedor',
	@pnumPageSize INT = NULL,
	@pnumCurrentPage INT = NULL,
	@pnumTotalRegistros INT = NULL OUTPUT,
	@pConProveedorOUT SMALLINT OUTPUT,
	@pConProveedor SMALLINT 

)
AS 

BEGIN

	IF @pTipoOperacion = 1
	BEGIN
		
		DECLARE @ldesParmDefinition3 NVARCHAR(MAX)
		DECLARE @lSQLString3 NVARCHAR(MAX)
		DECLARE @lnumOffSet3 INT

		SET @lnumOffSet3 =  @pnumPageSize * (@pnumCurrentPage - 1)
	
		SELECT @pnumTotalRegistros = COUNT(*) FROM  Proveedores   
		WHERE  NomProveedor = COALESCE(@pNomProveedorBUS, NomProveedor) AND
			   Cargo = COALESCE(@pCargoBUS, Cargo) 
 
		SET @ldesParmDefinition3 = N'@pNomProveedorBUS VARCHAR(60),@pCargoBUS VARCHAR(60)  '

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

