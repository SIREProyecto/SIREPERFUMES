
CREATE TABLE CategoriaProducto
( 
	ConCategoriaProducto smallint IDENTITY ( 1,1 ) ,
	DesCategoriaProducto varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT UsuarioBD_1378041156
		 DEFAULT  'dbo',
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE CategoriaProducto
	ADD CONSTRAINT PK_ConCategoriaProducto PRIMARY KEY  CLUSTERED (ConCategoriaProducto ASC)
go



CREATE TABLE Clientes
( 
	ConCliente           int IDENTITY ( 1,1 ) ,
	TipoGenero           tinyint  NOT NULL ,
	NomCliente           varchar(100)  NOT NULL ,
	PrimerApellido       varchar(60)  NULL ,
	SegundoApellido      varchar(60)  NULL ,
	Notas                varchar(200)  NULL ,
	NumeroIdentificacion varchar(60)  NOT NULL ,
	FechaNacimiento      datetime  NOT NULL ,
	LugarTrabajo         varchar(100)  NOT NULL ,
	DesRutaImagen        varchar(150)  NULL ,
	NomImagen            varchar(60)  NULL ,
	LimiteCredito        numeric(12,4)  NOT NULL ,
	TipoCliente          tinyint  NOT NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	CriterioNivel        tinyint  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_401387948
		 DEFAULT  GetDate(),
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaModifico        datetime  NULL ,
	UsuarioModifico      varchar(35)  NULL ,
	SaldoDisponible      numeric(16,4)  NOT NULL ,
	Empleado             tinyint  NOT NULL ,
	Compania             tinyint  NOT NULL 
)
go



ALTER TABLE Clientes
	ADD CONSTRAINT PK_CodigoClientes PRIMARY KEY  CLUSTERED (ConCliente ASC)
go



CREATE TABLE Compania
( 
	ConCompania          tinyint IDENTITY ( 1,1 ) ,
	DesCompania          varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_619686323
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	LogoCompania         varchar(max)  NULL ,
	MonedaNacional       char(3)  NOT NULL ,
	MonedaExtranjera     char(3)  NOT NULL 
)
go



ALTER TABLE Compania
	ADD CONSTRAINT PK_ConCompania PRIMARY KEY  CLUSTERED (ConCompania ASC)
go



CREATE TABLE CriterioNivel
( 
	ConCriterioNivel     tinyint IDENTITY ( 1,1 ) ,
	DesCriterioNivel     varchar(30)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_1356636332
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_2072262433
		 DEFAULT  GetDate()
)
go



ALTER TABLE CriterioNivel
	ADD CONSTRAINT PK_ConCriterioNivel PRIMARY KEY  CLUSTERED (ConCriterioNivel ASC)
go



CREATE TABLE CuentasPorCobrar
( 
	ConCuentaPorCobrar   smallint IDENTITY ( 1,1 ) ,
	Saldo                numeric(16,4)  NOT NULL ,
	FecCuentaPorCobrar   datetime  NOT NULL ,
	Cuotas               int  NOT NULL ,
	FecProxPagoCuentaPorCobrar datetime  NULL ,
	CuotaProxPagoCuentaPorCobrar numeric(16,4)  NULL ,
	Periodicidad         tinyint  NOT NULL ,
	Factura              int  NOT NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1074922212
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE CuentasPorCobrar
	ADD CONSTRAINT PK_ConCuentasPorCobrar PRIMARY KEY  CLUSTERED (ConCuentaPorCobrar ASC)
go



CREATE TABLE DetalleFactura
( 
	ConDetFactura        int IDENTITY ( 1,1 ) ,
	Cantidad             int  NOT NULL ,
	Precio               numeric(10,4)  NOT NULL ,
	PrecioTotal          numeric(16,4)  NOT NULL ,
	CostoFijo            numeric(10,4)  NOT NULL ,
	PrecioDescuento      numeric(16,4)  NULL ,
	ConFactura           int  NOT NULL ,
	TipoDescuento        tinyint  NULL ,
	Producto             int  NOT NULL ,
	Descuento            numeric(10,4)  NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NULL 
	CONSTRAINT FechaSistema_2075130862
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Presentacion         smallint  NOT NULL 
)
go



ALTER TABLE DetalleFactura
	ADD CONSTRAINT PK_ConDetFactura PRIMARY KEY  CLUSTERED (ConDetFactura ASC)
go



CREATE TABLE DetalleNotaCredito
( 
	ConDetNotaCredito    int IDENTITY ( 1,1 ) ,
	Cantidad             int  NOT NULL ,
	Precio               numeric(16,4)  NOT NULL ,
	PrecioTotal          numeric(16,4)  NOT NULL ,
	TipoDescuento        tinyint  NULL ,
	ConNotaCredito       int  NOT NULL ,
	CostoFijo            numeric(10,4)  NOT NULL ,
	Producto             int  NOT NULL ,
	Descuento            numeric(10,4)  NULL ,
	PrecioDescuento      numeric(10,4)  NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_712014186
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Presentacion         smallint  NOT NULL 
)
go



ALTER TABLE DetalleNotaCredito
	ADD CONSTRAINT PK_ConDetNotaCredito PRIMARY KEY  CLUSTERED (ConDetNotaCredito ASC)
go



CREATE TABLE DetallePedidoCompra
( 
	ConDetPedidoCompra   int IDENTITY ( 1,1 ) ,
	Cantidad             int  NOT NULL ,
	CostoUnitario        numeric(10,4)  NOT NULL ,
	PrecioTotal          numeric(10,4)  NOT NULL ,
	Producto             int  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1171756145
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	ConPedidoCompra      int  NOT NULL ,
	Presentacion         smallint  NOT NULL 
)
go



ALTER TABLE DetallePedidoCompra
	ADD CONSTRAINT PK_ConDetPedidoCompra PRIMARY KEY  CLUSTERED (ConDetPedidoCompra ASC)
go



CREATE TABLE DetallePedidoConsignacion
( 
	ConDetPedidoConsignacion int IDENTITY ( 1,1 ) ,
	Cantidad             int  NOT NULL ,
	CostoUnitario        numeric(10,4)  NOT NULL ,
	PrecioTotal          numeric(10,4)  NOT NULL ,
	Producto             int  NOT NULL ,
	ConPedidoConsignacion int  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_2092294724
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Presentacion         smallint  NOT NULL 
)
go



ALTER TABLE DetallePedidoConsignacion
	ADD CONSTRAINT PK_ConDetPedidoConsignacion PRIMARY KEY  CLUSTERED (ConDetPedidoConsignacion ASC)
go



CREATE TABLE DetalleRetiroConsignacion
( 
	ConDetRetiroConsignacion int IDENTITY ( 1,1 ) ,
	Cantidad             int  NOT NULL ,
	ConRetiroConsignacion int  NOT NULL ,
	Producto             int  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1934233020
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Presentacion         smallint  NOT NULL 
)
go



ALTER TABLE DetalleRetiroConsignacion
	ADD CONSTRAINT PK_ConDetRetiroConsignacion PRIMARY KEY  CLUSTERED (ConDetRetiroConsignacion ASC)
go



CREATE TABLE DireccionClientes
( 
	ConDireccionCliente  tinyint IDENTITY ( 1,1 ) ,
	DesDireccionCliente  varchar(120)  NOT NULL ,
	Cliente              int  NOT NULL ,
	TipoDireccion        tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1259396246
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE DireccionClientes
	ADD CONSTRAINT PK_CodigoDireccionClientes PRIMARY KEY  CLUSTERED (ConDireccionCliente ASC)
go



CREATE TABLE DireccionEmpleado
( 
	ConDireccionEmpleado tinyint IDENTITY ( 1,1 ) ,
	DesDireccionEmpleado varchar(120)  NOT NULL ,
	TipoDireccion        tinyint  NOT NULL ,
	Empleado             tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1378014867
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE DireccionEmpleado
	ADD CONSTRAINT PK_CodigoDireccionEmpleado PRIMARY KEY  CLUSTERED (ConDireccionEmpleado ASC)
go



CREATE TABLE Empleados
( 
	ConEmpleado          tinyint IDENTITY ( 1,1 ) ,
	NomEmpleado          varchar(60)  NOT NULL ,
	PrimerApellido       varchar(60)  NOT NULL ,
	SegundoApellido      varchar(60)  NULL ,
	Cargo                varchar(60)  NOT NULL ,
	Notas                varchar(100)  NULL ,
	TipoGenero           tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_84368282
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NOT NULL ,
	FechaModifico        datetime  NOT NULL ,
	PorComision          numeric(7,4)  NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	Compania             tinyint  NOT NULL 
)
go



ALTER TABLE Empleados
	ADD CONSTRAINT PK_CodigoEmpleados PRIMARY KEY  CLUSTERED (ConEmpleado ASC)
go



CREATE TABLE EncabFactura
( 
	ConFactura           int IDENTITY ( 1,1 ) ,
	FecFactura           datetime  NOT NULL ,
	Notas                varchar(100)  NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	Empleado             tinyint  NOT NULL ,
	Cliente              int  NOT NULL ,
	TipoPago             tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1381807778
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	NotaCredito          int  NULL ,
	MovInventConsignacion int  NOT NULL ,
	MovInventGeneral     int  NOT NULL 
)
go



ALTER TABLE EncabFactura
	ADD CONSTRAINT PK_ConFactura PRIMARY KEY  CLUSTERED (ConFactura ASC)
go



CREATE TABLE EncabNotaCredito
( 
	ConNotaCredito       int IDENTITY ( 1,1 ) ,
	FecNotaCredito       datetime  NOT NULL ,
	ConFactura           int  NOT NULL ,
	Notas                varchar(100)  NULL ,
	TotalNotaCredito     numeric(16,4)  NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1550042842
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE EncabNotaCredito
	ADD CONSTRAINT PK_ConNotaCredito PRIMARY KEY  CLUSTERED (ConNotaCredito ASC)
go



CREATE TABLE EncabPedidoCompra
( 
	ConPedidoCompra      int IDENTITY ( 1,1 ) ,
	TotalCompra          numeric(16,4)  NOT NULL ,
	FecPedidoCompra      datetime  NOT NULL ,
	Notas                varchar(100)  NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_958727331
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Proveedor            smallint  NOT NULL ,
	Empleado             tinyint  NOT NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	MovInventGeneral     int  NOT NULL 
)
go



ALTER TABLE EncabPedidoCompra
	ADD CONSTRAINT PK_ConPedidoCompra PRIMARY KEY  CLUSTERED (ConPedidoCompra ASC)
go



CREATE TABLE EncabPedidoConsignacion
( 
	ConPedidoConsignacion int  NOT NULL ,
	TotalCompra          numeric(16,4)  NOT NULL ,
	FecPedidoConsignacion datetime  NOT NULL ,
	Notas                varchar(100)  NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	Proveedor            smallint  NOT NULL ,
	Empleado             tinyint  NOT NULL ,
	MovInventConsignacion int  NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_209972983
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE EncabPedidoConsignacion
	ADD CONSTRAINT PK_ConPedidoConsignacion PRIMARY KEY  CLUSTERED (ConPedidoConsignacion ASC)
go



CREATE TABLE EncabRetiroConsignacion
( 
	ConRetiroConsignacion int IDENTITY ( 1,1 ) ,
	FecRetiroConsignacion datetime  NOT NULL ,
	Notas                varchar(100)  NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	EmpleadoRetira       tinyint  NOT NULL ,
	MovInventConsignacion int  NULL ,
	EmpleadoEntrega      tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_478412535
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE EncabRetiroConsignacion
	ADD CONSTRAINT PK_ConRetiroConsignacion PRIMARY KEY  CLUSTERED (ConRetiroConsignacion ASC)
go



CREATE TABLE Estados
( 
	CodEstado            char(3)  NOT NULL ,
	DesEstado            varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_722468539
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1747164573
		 DEFAULT  GetDate()
)
go



ALTER TABLE Estados
	ADD CONSTRAINT PK_CodEstadoEstados PRIMARY KEY  CLUSTERED (CodEstado ASC)
go



CREATE TABLE EstadosPorProceso
( 
	ConEstadoPorProceso  tinyint IDENTITY ( 1,1 ) ,
	Estado               char(3)  NOT NULL ,
	ProcesoEstado        tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_448334598
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_288352397
		 DEFAULT  GetDate()
)
go



ALTER TABLE EstadosPorProceso
	ADD CONSTRAINT PK_ConEstadoPorProceso PRIMARY KEY  CLUSTERED (ConEstadoPorProceso ASC)
go



CREATE TABLE HistoricoPrecio
( 
	FecHistoricoPrecio   datetime  NOT NULL 
	CONSTRAINT FechaSistema_1382503403
		 DEFAULT  GetDate(),
	PrecHistoricoPrecio  int  NOT NULL ,
	ProdHistoricoPrecio  int  NOT NULL ,
	MonHistoricoPrecio   char(3)  NOT NULL ,
	TipDeCambHistoricoPrecio int  NOT NULL ,
	PrecCompHistoricoPrecio numeric(10,4)  NOT NULL ,
	PrecConvHistoricoPrecio numeric(10,4)  NULL ,
	PrecTotHistoricoPrecio numeric(10,4)  NOT NULL ,
	PorPrecMayorHistoricoPrecio numeric(7,4)  NOT NULL ,
	PorPrecDetHistoricoPrecio numeric(7,4)  NOT NULL ,
	PrecMayFinlHistoricoPrecio numeric(10,4)  NOT NULL ,
	PrecDetFinlHistoricoPrecio numeric(10,4)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL ,
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE HistoricoPrecio
	ADD CONSTRAINT PK_FecHistoricoPrecio PRIMARY KEY  CLUSTERED (FecHistoricoPrecio ASC)
go



CREATE TABLE Marcas
( 
	ConMarca             smallint IDENTITY ( 1,1 ) ,
	DesMarca             varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1466552752
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE Marcas
	ADD CONSTRAINT PK_CodigoMarcas PRIMARY KEY  CLUSTERED (ConMarca ASC)
go



CREATE TABLE MarcaTipoProducto
( 
	ConMarcaTipoProducto smallint IDENTITY ( 1,1 ) ,
	Marca                smallint  NOT NULL ,
	TipoProducto         smallint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1310443667
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE MarcaTipoProducto
	ADD CONSTRAINT PK_ConMarcaTipoProducto PRIMARY KEY  CLUSTERED (ConMarcaTipoProducto ASC)
go



CREATE TABLE Monedas
( 
	CodMoneda            char(3)  NOT NULL ,
	DesMoneda            varchar(30)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_822867661
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1679536035
		 DEFAULT  GetDate()
)
go



ALTER TABLE Monedas
	ADD CONSTRAINT PK_ConMoneda PRIMARY KEY  CLUSTERED (CodMoneda ASC)
go



CREATE TABLE MovimientosInventConsignacion
( 
	ConMovInventConsignacion int IDENTITY ( 1,1 ) ,
	Referencia           varchar(30)  NOT NULL ,
	FecMovInventConsignacion datetime  NOT NULL ,
	Detalle              varchar(150)  NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	TipoMovimiento       tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_86465489
		 DEFAULT  GetDate()
)
go



ALTER TABLE MovimientosInventConsignacion
	ADD CONSTRAINT PK_ConMovInventConsignacion PRIMARY KEY  CLUSTERED (ConMovInventConsignacion ASC)
go



CREATE TABLE MovimientosInventGeneral
( 
	ConMovInventGeneral  int IDENTITY ( 1,1 ) ,
	Referencia           varchar(30)  NOT NULL ,
	FecMovInventGeneral  datetime  NOT NULL ,
	Detalle              varchar(150)  NULL ,
	TipoMovimiento       tinyint  NOT NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1381303578
		 DEFAULT  GetDate()
)
go



ALTER TABLE MovimientosInventGeneral
	ADD CONSTRAINT PK_ConMovInventGeneral PRIMARY KEY  CLUSTERED (ConMovInventGeneral ASC)
go



CREATE TABLE Operador
( 
	ConOperador          tinyint IDENTITY ( 1,1 ) ,
	DesOperador          varchar(20)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NULL 
	CONSTRAINT UsuarioBD_767611849
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_418950048
		 DEFAULT  GetDate()
)
go



ALTER TABLE Operador
	ADD CONSTRAINT PK_ConOperador PRIMARY KEY  CLUSTERED (ConOperador ASC)
go



CREATE TABLE PagosCuentaPorCobrar
( 
	ConPagoCuentaPorCobrar int IDENTITY ( 1,1 ) ,
	FecPagoCuentaPorCobrar datetime  NOT NULL ,
	MtoPagoCuentaPorCobrar numeric(16,4)  NOT NULL ,
	CuentaPorCobrar      smallint  NOT NULL ,
	FecProximoPago       datetime  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_976249475
		 DEFAULT  GetDate(),
	UsuarioModifico      datetime  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE PagosCuentaPorCobrar
	ADD CONSTRAINT PK_ConPagoCuentaPorCobrar PRIMARY KEY  CLUSTERED (ConPagoCuentaPorCobrar ASC)
go



CREATE TABLE ParametrosGenerales
( 
	CodParametroGeneral  char(6)  NOT NULL ,
	DesParametroGeneral  varchar(30)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT UsuarioBD_114362688
		 DEFAULT  'dbo',
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Compania             tinyint  NOT NULL ,
	ValorParametroFecha  datetime  NULL ,
	ValorParametroNumero int  NULL ,
	ValorParametroTexto  varchar(60)  NULL 
)
go



ALTER TABLE ParametrosGenerales
	ADD CONSTRAINT PK_CodParametroGeneral PRIMARY KEY  CLUSTERED (CodParametroGeneral ASC)
go



CREATE TABLE Periodicidad
( 
	ConPeriodicidad      tinyint IDENTITY ( 1,1 ) ,
	DesPeriodicidad      varchar(20)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_515343776
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1600175277
		 DEFAULT  GetDate()
)
go



ALTER TABLE Periodicidad
	ADD CONSTRAINT PK_ConPeriodicidad PRIMARY KEY  CLUSTERED (ConPeriodicidad ASC)
go



CREATE TABLE Precios
( 
	ConPrecio            int IDENTITY ( 1,1 ) ,
	PrecioCompra         numeric(10,4)  NOT NULL ,
	PrecioConversion     numeric(10,4)  NULL ,
	PorPrecioPorMayor    numeric(7,4)  NOT NULL ,
	PorPrecioPorDetalle  numeric(7,4)  NOT NULL ,
	PrecioPorMayorFinal  numeric(10,4)  NOT NULL ,
	PrecioPorDetalleFinal numeric(10,4)  NOT NULL ,
	Producto             int  NOT NULL ,
	Moneda               char(3)  NOT NULL ,
	TipoDeCambio         int  NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1712561836
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Presentacion         smallint  NOT NULL 
)
go



ALTER TABLE Precios
	ADD CONSTRAINT PK_ConPrecio PRIMARY KEY  CLUSTERED (ConPrecio ASC)
go



CREATE TABLE Presentacion
( 
	ConPresentacion      smallint IDENTITY ( 1,1 ) ,
	DesPresentacion      varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1333577919
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE Presentacion
	ADD CONSTRAINT PK_ConPresentacion PRIMARY KEY  CLUSTERED (ConPresentacion ASC)
go



CREATE TABLE PresentacionTipoProducto
( 
	ConPresentacionTipoProducto smallint IDENTITY ( 1,1 ) ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1773935874
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Presentacion         smallint  NOT NULL ,
	TipoProducto         smallint  NOT NULL 
)
go



ALTER TABLE PresentacionTipoProducto
	ADD CONSTRAINT PK_CodigoPresentacionTipoProducto PRIMARY KEY  CLUSTERED (ConPresentacionTipoProducto ASC)
go



CREATE TABLE ProcesosEstados
( 
	ConProcesoEstado     tinyint IDENTITY ( 1,1 ) ,
	DesProcesoEstado     varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_1278822613
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1855080514
		 DEFAULT  GetDate()
)
go



ALTER TABLE ProcesosEstados
	ADD CONSTRAINT PK_ConProcesoEstado PRIMARY KEY  CLUSTERED (ConProcesoEstado ASC)
go



CREATE TABLE Productos
( 
	ConProducto          int IDENTITY ( 1,1 ) ,
	DesProducto          varchar(60)  NOT NULL ,
	CodProducto          varchar(30)  NOT NULL ,
	MinimoStock          int  NOT NULL ,
	MaximoStock          int  NOT NULL ,
	NuevoInventario      bit  NULL ,
	Suspendido           bit  NOT NULL ,
	DesRutaImagen        varchar(150)  NULL ,
	NomImagen            varchar(60)  NULL ,
	CategoriaProducto    smallint  NOT NULL ,
	TipoProducto         smallint  NOT NULL ,
	Marca                smallint  NOT NULL ,
	Proveedor            smallint  NOT NULL ,
	TipoGenero           tinyint  NOT NULL ,
	EstadoPorProceso     tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_202789813
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Compania             tinyint  NOT NULL ,
	Presentacion         smallint  NOT NULL 
)
go



ALTER TABLE Productos
	ADD CONSTRAINT PK_CodigoProductos PRIMARY KEY  CLUSTERED (ConProducto ASC,Presentacion ASC)
go



CREATE TABLE Proveedores
( 
	ConProveedor         smallint IDENTITY ( 1,1 ) ,
	NomProveedor         varchar(60)  NOT NULL ,
	DesCompaniaProveedor varchar(60)  NULL ,
	PrimerApellido       varchar(60)  NULL ,
	SegundoApellido      varchar(60)  NULL ,
	Cargo                varchar(60)  NOT NULL ,
	TelefonoTrabajo      varchar(30)  NOT NULL ,
	TelefonoMovil        varchar(30)  NOT NULL ,
	Direccion            varchar(250)  NOT NULL ,
	CorreoElectronico    varchar(120)  NOT NULL ,
	RazonSocial          varchar(100)  NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_475708611
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Compania             tinyint  NOT NULL 
)
go



ALTER TABLE Proveedores
	ADD CONSTRAINT PK_CodigoProveedores PRIMARY KEY  CLUSTERED (ConProveedor ASC)
go



CREATE TABLE RetiroInventarioGeneral
( 
	ConRetiroInventarioGeneral int IDENTITY ( 1,1 ) ,
	FecRetiroInventarioGeneral datetime  NOT NULL ,
	DesMotivoRetiroInventarioGeneral varchar(200)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1468592876
		 DEFAULT  GetDate(),
	Producto             int  NOT NULL ,
	MovInventGeneral     int  NOT NULL ,
	Presentacion         smallint  NOT NULL 
)
go



ALTER TABLE RetiroInventarioGeneral
	ADD CONSTRAINT PK_ConRetiroInventarioGeneral PRIMARY KEY  CLUSTERED (ConRetiroInventarioGeneral ASC)
go



CREATE TABLE SegmentacionClientes
( 
	ConSegmentacionCliente tinyint IDENTITY ( 1,1 ) ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_72391058
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Cliente              int  NOT NULL ,
	ClienteAsociacion    int  NOT NULL 
)
go



ALTER TABLE SegmentacionClientes
	ADD CONSTRAINT PK_ConSegmentacionClientes PRIMARY KEY  CLUSTERED (ConSegmentacionCliente ASC)
go



CREATE TABLE TelefonoClientes
( 
	DesTelefonoCliente   varchar(30)  NOT NULL ,
	Cliente              int  NOT NULL ,
	ConTelefonoCliente   tinyint IDENTITY ( 1,1 ) ,
	TipoTelefono         tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1561843415
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	Operador             tinyint  NOT NULL 
)
go



ALTER TABLE TelefonoClientes
	ADD CONSTRAINT PK_CodigoTelefonoClientes PRIMARY KEY  CLUSTERED (ConTelefonoCliente ASC)
go



CREATE TABLE TelefonoEmpleados
( 
	ConTelefonoEmpleado  tinyint IDENTITY ( 1,1 ) ,
	DesTelefonoEmpleado  varchar(30)  NOT NULL ,
	Empleado             tinyint  NOT NULL ,
	TipoTelefono         tinyint  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_639487916
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE TelefonoEmpleados
	ADD CONSTRAINT PK_CodigoTelefonoEmpleados PRIMARY KEY  CLUSTERED (ConTelefonoEmpleado ASC)
go



CREATE TABLE TipoCliente
( 
	ConTipoCliente       tinyint IDENTITY ( 1,1 ) ,
	DesTipoCliente       varchar(20)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_744709549
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_188271035
		 DEFAULT  GetDate()
)
go



ALTER TABLE TipoCliente
	ADD CONSTRAINT PK_CodigoTipoCliente PRIMARY KEY  CLUSTERED (ConTipoCliente ASC)
go



CREATE TABLE TipoDeCambio
( 
	ConTipoDeCambio      int IDENTITY ( 1,1 ) ,
	MtoTipoDeCambio      numeric(7,4)  NOT NULL ,
	FecTipoDeCambio      datetime  NOT NULL ,
	MonedaOrigen         char(3)  NOT NULL ,
	MonedaDestino        char(3)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1013161148
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL 
)
go



ALTER TABLE TipoDeCambio
	ADD CONSTRAINT PK_ConTipoDeCambio PRIMARY KEY  CLUSTERED (ConTipoDeCambio ASC)
go



CREATE TABLE TipoDescuento
( 
	ConTipoDescuento     tinyint IDENTITY ( 1,1 ) ,
	DesTipoDescuento     varchar(20)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_1791142314
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1787086585
		 DEFAULT  GetDate()
)
go



ALTER TABLE TipoDescuento
	ADD CONSTRAINT PK_ConTipoDescuento PRIMARY KEY  CLUSTERED (ConTipoDescuento ASC)
go



CREATE TABLE TipoDireccion
( 
	ConTipoDireccion     tinyint IDENTITY ( 1,1 ) ,
	DesTipoDireccion     varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_1472504743
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1820247014
		 DEFAULT  GetDate()
)
go



ALTER TABLE TipoDireccion
	ADD CONSTRAINT PK_CodigoTipoDireccion PRIMARY KEY  CLUSTERED (ConTipoDireccion ASC)
go



CREATE TABLE TipoGenero
( 
	ConTipoGenero        tinyint IDENTITY ( 1,1 ) ,
	DesTipoGenero        varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_728575089
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_352816570
		 DEFAULT  GetDate()
)
go



ALTER TABLE TipoGenero
	ADD CONSTRAINT PK_CodigoTipoGenero PRIMARY KEY  CLUSTERED (ConTipoGenero ASC)
go



CREATE TABLE TipoMovimiento
( 
	ConTipoMovimiento    tinyint IDENTITY ( 1,1 ) ,
	DesTipoMovimiento    varchar(30)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_1629839642
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_2105933011
		 DEFAULT  GetDate()
)
go



ALTER TABLE TipoMovimiento
	ADD CONSTRAINT PK_ConTipoMovimiento PRIMARY KEY  CLUSTERED (ConTipoMovimiento ASC)
go



CREATE TABLE TipoPago
( 
	ConTipoPago          tinyint IDENTITY ( 1,1 ) ,
	DesTipoPago          varchar(20)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_869064134
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_620931238
		 DEFAULT  GetDate()
)
go



ALTER TABLE TipoPago
	ADD CONSTRAINT PK_ConTipoPago PRIMARY KEY  CLUSTERED (ConTipoPago ASC)
go



CREATE TABLE TipoProducto
( 
	ConTipoProducto      smallint IDENTITY ( 1,1 ) ,
	DesTipoProducto      varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL ,
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1349637055
		 DEFAULT  GetDate(),
	UsuarioModifico      varchar(35)  NULL ,
	FechaModifico        datetime  NULL ,
	CategoriaProducto    smallint  NOT NULL 
)
go



ALTER TABLE TipoProducto
	ADD CONSTRAINT PK_ConTipoProducto PRIMARY KEY  CLUSTERED (ConTipoProducto ASC)
go



CREATE TABLE TipoTelefono
( 
	ConTipoTelefono      tinyint IDENTITY ( 1,1 ) ,
	DesTipoTelefono      varchar(60)  NOT NULL ,
	UsuarioIngreso       varchar(35)  NOT NULL 
	CONSTRAINT UsuarioBD_832411054
		 DEFAULT  'dbo',
	FechaIngreso         datetime  NOT NULL 
	CONSTRAINT FechaSistema_1165019840
		 DEFAULT  GetDate()
)
go



ALTER TABLE TipoTelefono
	ADD CONSTRAINT PK_CodigoTipoTelefono PRIMARY KEY  CLUSTERED (ConTipoTelefono ASC)
go




ALTER TABLE Clientes
	ADD CONSTRAINT FK_TipoGenero_Cliente FOREIGN KEY (TipoGenero) REFERENCES TipoGenero(ConTipoGenero)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Clientes
	ADD CONSTRAINT FK_TipoCliente_Cliente FOREIGN KEY (TipoCliente) REFERENCES TipoCliente(ConTipoCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Clientes
	ADD CONSTRAINT FK_EstadoPorProceso_Cliente FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Clientes
	ADD CONSTRAINT FK_CriterioNivel_Cliente FOREIGN KEY (CriterioNivel) REFERENCES CriterioNivel(ConCriterioNivel)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Clientes
	ADD CONSTRAINT FK_Empleado_Cliente FOREIGN KEY (Empleado) REFERENCES Empleados(ConEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Clientes
	ADD CONSTRAINT FK_Compania_Cliente FOREIGN KEY (Compania) REFERENCES Compania(ConCompania)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Compania
	ADD CONSTRAINT FK_MonedaNacional_Compania FOREIGN KEY (MonedaNacional) REFERENCES Monedas(CodMoneda)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Compania
	ADD CONSTRAINT FK_MonedaExtranjera_Compania FOREIGN KEY (MonedaExtranjera) REFERENCES Monedas(CodMoneda)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE CuentasPorCobrar
	ADD CONSTRAINT FK_Periodicidad_CuentasPorCobrar FOREIGN KEY (Periodicidad) REFERENCES Periodicidad(ConPeriodicidad)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE CuentasPorCobrar
	ADD CONSTRAINT FK_Factura_CuentasPorCobrar FOREIGN KEY (Factura) REFERENCES EncabFactura(ConFactura)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE CuentasPorCobrar
	ADD CONSTRAINT FK_EstadoPorProceso_CuentasPorCobrar FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleFactura
	ADD CONSTRAINT FK_EncabFactura_DetalleFactura FOREIGN KEY (ConFactura) REFERENCES EncabFactura(ConFactura)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleFactura
	ADD CONSTRAINT FK_TipoDescuento_DetalleFactura FOREIGN KEY (TipoDescuento) REFERENCES TipoDescuento(ConTipoDescuento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleFactura
	ADD CONSTRAINT FK_Producto_DetalleFactura FOREIGN KEY (Producto,Presentacion) REFERENCES Productos(ConProducto,Presentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleNotaCredito
	ADD CONSTRAINT FK_TipoDescuento_DetalleNotaCredito FOREIGN KEY (TipoDescuento) REFERENCES TipoDescuento(ConTipoDescuento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleNotaCredito
	ADD CONSTRAINT FK_EncabNotaCredito_DetalleNotaCredito FOREIGN KEY (ConNotaCredito) REFERENCES EncabNotaCredito(ConNotaCredito)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleNotaCredito
	ADD CONSTRAINT FK_Producto_DetalleNotaCredito FOREIGN KEY (Producto,Presentacion) REFERENCES Productos(ConProducto,Presentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetallePedidoCompra
	ADD CONSTRAINT FK_Producto_DetallePedidoCompra FOREIGN KEY (Producto,Presentacion) REFERENCES Productos(ConProducto,Presentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetallePedidoCompra
	ADD CONSTRAINT FK_PedidoCompra_DetallePedidoCompra FOREIGN KEY (ConPedidoCompra) REFERENCES EncabPedidoCompra(ConPedidoCompra)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetallePedidoConsignacion
	ADD CONSTRAINT FK_Producto_DetallePedidoConsignacion FOREIGN KEY (Producto,Presentacion) REFERENCES Productos(ConProducto,Presentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetallePedidoConsignacion
	ADD CONSTRAINT FK_PedidoConsignacion_DetallePedidoConsignacion FOREIGN KEY (ConPedidoConsignacion) REFERENCES EncabPedidoConsignacion(ConPedidoConsignacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleRetiroConsignacion
	ADD CONSTRAINT FK_RetiroConsignacion_DetalleRetiroConsignacion FOREIGN KEY (ConRetiroConsignacion) REFERENCES EncabRetiroConsignacion(ConRetiroConsignacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleRetiroConsignacion
	ADD CONSTRAINT FK_Producto_DetalleRetiroConsignacion FOREIGN KEY (Producto,Presentacion) REFERENCES Productos(ConProducto,Presentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DireccionClientes
	ADD CONSTRAINT FK_Cliente_DireccionClientes FOREIGN KEY (Cliente) REFERENCES Clientes(ConCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DireccionClientes
	ADD CONSTRAINT FK_TipoDireccion_DireccionClientes FOREIGN KEY (TipoDireccion) REFERENCES TipoDireccion(ConTipoDireccion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DireccionEmpleado
	ADD CONSTRAINT FK_TipoDireccion_DireccionEmpleado FOREIGN KEY (TipoDireccion) REFERENCES TipoDireccion(ConTipoDireccion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DireccionEmpleado
	ADD CONSTRAINT FK_Empleado_DireccionEmpleado FOREIGN KEY (Empleado) REFERENCES Empleados(ConEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Empleados
	ADD CONSTRAINT FK_TipoGenero_Empleados FOREIGN KEY (TipoGenero) REFERENCES TipoGenero(ConTipoGenero)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Empleados
	ADD CONSTRAINT FK_EstadoPorProceso_Empleados FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Empleados
	ADD CONSTRAINT FK_Compania_Empleados FOREIGN KEY (Compania) REFERENCES Compania(ConCompania)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabFactura
	ADD CONSTRAINT FK_EstadoPorProceso_EncabFactura FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabFactura
	ADD CONSTRAINT FK_Empleado_EncabFactura FOREIGN KEY (Empleado) REFERENCES Empleados(ConEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabFactura
	ADD CONSTRAINT FK_Cliente_EncabFactura FOREIGN KEY (Cliente) REFERENCES Clientes(ConCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabFactura
	ADD CONSTRAINT FK_TipoPago_EncabFactura FOREIGN KEY (TipoPago) REFERENCES TipoPago(ConTipoPago)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabFactura
	ADD CONSTRAINT FK_NotaCredito_EncabFactura FOREIGN KEY (NotaCredito) REFERENCES EncabNotaCredito(ConNotaCredito)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabFactura
	ADD CONSTRAINT FK_MovInventConsignacion_EncabFactura FOREIGN KEY (MovInventConsignacion) REFERENCES MovimientosInventConsignacion(ConMovInventConsignacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabFactura
	ADD CONSTRAINT FK_MovInventGeneral_EncabFactura FOREIGN KEY (MovInventGeneral) REFERENCES MovimientosInventGeneral(ConMovInventGeneral)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabNotaCredito
	ADD CONSTRAINT FK_Factura_EncabNotaCredito FOREIGN KEY (ConFactura) REFERENCES EncabFactura(ConFactura)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabPedidoCompra
	ADD CONSTRAINT FK_Proveedor_EncabPedidoCompra FOREIGN KEY (Proveedor) REFERENCES Proveedores(ConProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabPedidoCompra
	ADD CONSTRAINT FK_Empleado_EncabPedidoCompra FOREIGN KEY (Empleado) REFERENCES Empleados(ConEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabPedidoCompra
	ADD CONSTRAINT FK_EstadoPorProceso_EncabPedidoCompra FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabPedidoCompra
	ADD CONSTRAINT FK_MovInventGeneral_EncabPedidoCompra FOREIGN KEY (MovInventGeneral) REFERENCES MovimientosInventGeneral(ConMovInventGeneral)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabPedidoConsignacion
	ADD CONSTRAINT FK_EstadoPorProceso_EncabPedidoConsignacion FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabPedidoConsignacion
	ADD CONSTRAINT FK_Proveedor_EncabPedidoConsignacion FOREIGN KEY (Proveedor) REFERENCES Proveedores(ConProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabPedidoConsignacion
	ADD CONSTRAINT R_80 FOREIGN KEY (Empleado) REFERENCES Empleados(ConEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabPedidoConsignacion
	ADD CONSTRAINT FK_MovInventConsignacion_EncabPedidoConsignacion FOREIGN KEY (MovInventConsignacion) REFERENCES MovimientosInventConsignacion(ConMovInventConsignacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabRetiroConsignacion
	ADD CONSTRAINT FK_EstadoPorProceso_EncabRetiroConsignacion FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabRetiroConsignacion
	ADD CONSTRAINT FK_EmpleadoRetira_EncabRetiroConsignacion FOREIGN KEY (EmpleadoRetira) REFERENCES Empleados(ConEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabRetiroConsignacion
	ADD CONSTRAINT FK_MovInventConsignacion_EncabRetiroConsignacion FOREIGN KEY (MovInventConsignacion) REFERENCES MovimientosInventConsignacion(ConMovInventConsignacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EncabRetiroConsignacion
	ADD CONSTRAINT FK_EmpleadoEntrega_EncabRetiroConsignacion FOREIGN KEY (EmpleadoEntrega) REFERENCES Empleados(ConEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EstadosPorProceso
	ADD CONSTRAINT FK_Estado_EstadosPorProceso FOREIGN KEY (Estado) REFERENCES Estados(CodEstado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE EstadosPorProceso
	ADD CONSTRAINT FK_ProcesoEstado_EstadosPorProceso FOREIGN KEY (ProcesoEstado) REFERENCES ProcesosEstados(ConProcesoEstado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MarcaTipoProducto
	ADD CONSTRAINT FK_Marca_MarcaTipoProducto FOREIGN KEY (Marca) REFERENCES Marcas(ConMarca)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MarcaTipoProducto
	ADD CONSTRAINT FK_TipoProducto_MarcaTipoProducto FOREIGN KEY (TipoProducto) REFERENCES TipoProducto(ConTipoProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MovimientosInventConsignacion
	ADD CONSTRAINT FK_EstadoPorProceso_MovimientosInventConsignacion FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MovimientosInventConsignacion
	ADD CONSTRAINT FK_TipoMovimiento_MovimientosInventConsignacion FOREIGN KEY (TipoMovimiento) REFERENCES TipoMovimiento(ConTipoMovimiento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MovimientosInventGeneral
	ADD CONSTRAINT FK_TipoMovimiento_MovimientosInventGeneral FOREIGN KEY (TipoMovimiento) REFERENCES TipoMovimiento(ConTipoMovimiento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MovimientosInventGeneral
	ADD CONSTRAINT FK_EstadoPorProceso_MovimientosInventGeneral FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PagosCuentaPorCobrar
	ADD CONSTRAINT R_112 FOREIGN KEY (CuentaPorCobrar) REFERENCES CuentasPorCobrar(ConCuentaPorCobrar)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE ParametrosGenerales
	ADD CONSTRAINT FK_Compania_ParametrosGenerales FOREIGN KEY (Compania) REFERENCES Compania(ConCompania)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Precios
	ADD CONSTRAINT FK_Producto_Precio FOREIGN KEY (Producto,Presentacion) REFERENCES Productos(ConProducto,Presentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Precios
	ADD CONSTRAINT FK_Moneda_Precio FOREIGN KEY (Moneda) REFERENCES Monedas(CodMoneda)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Precios
	ADD CONSTRAINT FK_TipoDeCambio FOREIGN KEY (TipoDeCambio) REFERENCES TipoDeCambio(ConTipoDeCambio)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PresentacionTipoProducto
	ADD CONSTRAINT FK_Presentacion_PresentacionTipoProducto FOREIGN KEY (Presentacion) REFERENCES Presentacion(ConPresentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE PresentacionTipoProducto
	ADD CONSTRAINT FK_TipoProducto_PresentacionTipoProducto FOREIGN KEY (TipoProducto) REFERENCES TipoProducto(ConTipoProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Productos
	ADD CONSTRAINT FK_CategoriaProducto_Productos FOREIGN KEY (CategoriaProducto) REFERENCES CategoriaProducto(ConCategoriaProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Productos
	ADD CONSTRAINT FK_TipoProducto_Productos FOREIGN KEY (TipoProducto) REFERENCES TipoProducto(ConTipoProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Productos
	ADD CONSTRAINT FK_Marcas_Productos FOREIGN KEY (Marca) REFERENCES Marcas(ConMarca)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Productos
	ADD CONSTRAINT FK_Proveedores_Productos FOREIGN KEY (Proveedor) REFERENCES Proveedores(ConProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Productos
	ADD CONSTRAINT FK_TipoGenero_Productos FOREIGN KEY (TipoGenero) REFERENCES TipoGenero(ConTipoGenero)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Productos
	ADD CONSTRAINT FK_Estado_Producto FOREIGN KEY (EstadoPorProceso) REFERENCES EstadosPorProceso(ConEstadoPorProceso)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Productos
	ADD CONSTRAINT FK_Compania_Productos FOREIGN KEY (Compania) REFERENCES Compania(ConCompania)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Productos
	ADD CONSTRAINT FK_Presentacion_Productos FOREIGN KEY (Presentacion) REFERENCES Presentacion(ConPresentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Proveedores
	ADD CONSTRAINT FK_Compania_Proveedores FOREIGN KEY (Compania) REFERENCES Compania(ConCompania)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE RetiroInventarioGeneral
	ADD CONSTRAINT FK_Producto_RetiroInventarioGeneral FOREIGN KEY (Producto,Presentacion) REFERENCES Productos(ConProducto,Presentacion)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE RetiroInventarioGeneral
	ADD CONSTRAINT FK_MovInventGeneral_RetiroInventarioGeneral FOREIGN KEY (MovInventGeneral) REFERENCES MovimientosInventGeneral(ConMovInventGeneral)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE SegmentacionClientes
	ADD CONSTRAINT FK_Cliente_SegmentacionClientes FOREIGN KEY (Cliente) REFERENCES Clientes(ConCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE SegmentacionClientes
	ADD CONSTRAINT FK_ClienteAsociacion_SegmentacionClientes FOREIGN KEY (ClienteAsociacion) REFERENCES Clientes(ConCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE TelefonoClientes
	ADD CONSTRAINT FK_Cliente_TelefonoClientes FOREIGN KEY (Cliente) REFERENCES Clientes(ConCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE TelefonoClientes
	ADD CONSTRAINT FK_TipoTelefono_TelefonoClientes FOREIGN KEY (TipoTelefono) REFERENCES TipoTelefono(ConTipoTelefono)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE TelefonoClientes
	ADD CONSTRAINT FK_Operador_TelefonoClientes FOREIGN KEY (Operador) REFERENCES Operador(ConOperador)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE TelefonoEmpleados
	ADD CONSTRAINT FK_Empleado_TelefonoEmpleados FOREIGN KEY (Empleado) REFERENCES Empleados(ConEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE TelefonoEmpleados
	ADD CONSTRAINT FK_TipoTelefonoTelefonoEmpleados FOREIGN KEY (TipoTelefono) REFERENCES TipoTelefono(ConTipoTelefono)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE TipoDeCambio
	ADD CONSTRAINT FK_MonedaOrigen_TipoDeCambio FOREIGN KEY (MonedaOrigen) REFERENCES Monedas(CodMoneda)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE TipoDeCambio
	ADD CONSTRAINT FK_MonedaDestino_TipoDeCambio FOREIGN KEY (MonedaDestino) REFERENCES Monedas(CodMoneda)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE TipoProducto
	ADD CONSTRAINT R_135 FOREIGN KEY (CategoriaProducto) REFERENCES CategoriaProducto(ConCategoriaProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go



/**Insert-TipoGenero**/
INSERT INTO TipoGenero (DesTipoGenero) VALUES('Femenino')
INSERT INTO TipoGenero (DesTipoGenero) VALUES('Masculino')

/**Insert-TipoCliente**/
INSERT INTO TipoCliente (DesTipoCliente) VALUES('Físico')
INSERT INTO TipoCliente (DesTipoCliente) VALUES('Jurídico')

/**Insert-TipoDireccion**/
INSERT INTO TipoDireccion (DesTipoDireccion) VALUES('Correo Electrónico')
INSERT INTO TipoDireccion (DesTipoDireccion) VALUES('Dirección Física')

/**Insert-TipoTelefono**/
INSERT INTO TipoTelefono (DesTipoTelefono) VALUES('Fax')
INSERT INTO TipoTelefono (DesTipoTelefono) VALUES('Teléfono Oficina')
INSERT INTO TipoTelefono (DesTipoTelefono) VALUES('Teléfono Celular')


/**Insert-Operador**/ 
INSERT INTO Operador (DesOperador) VALUES('ICE')
INSERT INTO Operador (DesOperador) VALUES('Claro')
INSERT INTO Operador (DesOperador) VALUES('Movistar')


/**Insert-CriterioNivel**/
INSERT INTO CriterioNivel (DesCriterioNivel) VALUES('Bueno')
INSERT INTO CriterioNivel (DesCriterioNivel) VALUES('Regular')
INSERT INTO CriterioNivel (DesCriterioNivel) VALUES('Malo')


/**Insert-Monedas**/
INSERT INTO Monedas (CodMoneda, DesMoneda) VALUES('COL','Colones')
INSERT INTO Monedas (CodMoneda, DesMoneda) VALUES('DOL','Dólares')


/**Insert-Periodicidad**/
INSERT INTO Periodicidad (DesPeriodicidad) VALUES('Quincenal')
INSERT INTO Periodicidad (DesPeriodicidad) VALUES('Mensual')


/**Insert-TipoMovimiento**/
INSERT INTO TipoMovimiento (DesTipoMovimiento)  VALUES('Pedido Consignación')
INSERT INTO TipoMovimiento (DesTipoMovimiento) VALUES('Retiro Consignación')
INSERT INTO TipoMovimiento (DesTipoMovimiento) VALUES('Retiro Inventario')
INSERT INTO TipoMovimiento (DesTipoMovimiento) VALUES('Venta')
INSERT INTO TipoMovimiento (DesTipoMovimiento) VALUES('Pedido Compra')


/**Insert-TipoPago**/
INSERT INTO TipoPago (DesTipoPago) VALUES('Efectivo')
INSERT INTO TipoPago (DesTipoPago) VALUES('Crédito')


/**Insert-TipoDescuento**/
INSERT INTO TipoDescuento (DesTipoDescuento) VALUES('Valor Porcentual')
INSERT INTO TipoDescuento (DesTipoDescuento)  VALUES('Valor Absoluto')


/**Insert-Estado**/
INSERT INTO Estados (CodEstado,DesEstado) VALUES('ING', 'Ingresado')
INSERT INTO Estados (CodEstado,DesEstado) VALUES('APR', 'Aprobado')
INSERT INTO Estados (CodEstado,DesEstado) VALUES('ANU', 'Anulado')
INSERT INTO Estados (CodEstado,DesEstado) VALUES('APL', 'Aplicado')
INSERT INTO Estados (CodEstado,DesEstado) VALUES('CAN', 'Cancelado')
INSERT INTO Estados (CodEstado,DesEstado) VALUES('ACT', 'Activo')
INSERT INTO Estados (CodEstado,DesEstado) VALUES('INA', 'Inactivo')
INSERT INTO Estados (CodEstado,DesEstado) VALUES('RET', 'Retenido')
INSERT INTO Estados (CodEstado,DesEstado) VALUES('RER', 'Retirado')

/**Insert-ProcesosEstados**/
INSERT INTO ProcesosEstados (DesProcesoEstado) VALUES('Nota  Crédito')
INSERT INTO ProcesosEstados (DesProcesoEstado) VALUES('Cuentas por Cobrar')
INSERT INTO ProcesosEstados (DesProcesoEstado) VALUES('Retiro Consignación')
INSERT INTO ProcesosEstados (DesProcesoEstado) VALUES('Factura')
INSERT INTO ProcesosEstados (DesProcesoEstado)  VALUES('Pedido Consignación')
INSERT INTO ProcesosEstados (DesProcesoEstado) VALUES('Pedido Compra')
INSERT INTO ProcesosEstados (DesProcesoEstado) VALUES('Empleado')
INSERT INTO ProcesosEstados (DesProcesoEstado) VALUES('Producto')
INSERT INTO ProcesosEstados (DesProcesoEstado) VALUES('Cliente')

/**Insert-EstadoPorProceso**/
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',1)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('APR',1)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ANU',1)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('APL',1)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',2)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('CAN',2)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('APR',2)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',3)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ANU',3)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('APR',3)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',4)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ANU',4)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('APR',4)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',5)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ANU',5)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('APR',5)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',6)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ANU',6)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('APR',6)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',7)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ACT',7)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('INA',7)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',8)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ACT',8)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('INA',8)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('RET',8)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('RER',8)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ING',9)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('ACT',9)
INSERT INTO EstadosPorProceso (Estado,ProcesoEstado) VALUES('INA',9)


