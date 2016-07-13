using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SIRE.Administracion.Datos.Productos
{
    public class DTO_Productos : DTOMantenimiento, IMantenimiento
    {

        #region [ Propiedades ]

        #region [ Propieadades de entidad ]

        public int ConProducto { get; set; }
        public string DesProducto { get; set; }
        public string CodProducto { get; set; }
        public int MinimoStock { get; set; }
        public int MaximoStock { get; set; }
        public bool NuevoInventario { get; set; }
        public bool Suspendido { get; set; }
        public string DesRutaImagen { get; set; }
        public string NomImagen { get; set; }
        public Int16 CategoriaProducto { get; set; }
        public Int16 TipoProducto { get; set; }
        public Int16 Marca { get; set; }
        public Int16 Proveedor { get; set; }
        public byte TipoGenero { get; set; }
        public byte EstadoPorProceso { get; set; }
        public byte Compania { get; set; }
        public Int16 Presentacion { get; set; }

        //JOIN
        public string DesCategoriaProducto { get; set; }
        public string DesTipoProducto { get; set; }
        public string DesMarca { get; set; }
        public string NomProveedor { get; set; }
        public string DesTipoGenero { get; set; }
        public string Estado { get; set; }
        public string DesPresentacion { get; set; }

        #endregion
    
        #endregion

        #region [ Constructores ]

        public DTO_Productos()
        {
            ResultadoMantenimiento = new DTO_Resultado();
        }

        #endregion
    }

    public class DTO_ProductosConsulta : DTO_Consulta
    {
        #region [ Propiedades ]

        public string CodProducto { get; set; }
        public string DesProducto { get; set; }
        public Int16 CategoriaProducto { get; set; }
        public Int16 TipoProducto { get; set; }
        public Int16 Marca { get; set; }

        #endregion
    }

}