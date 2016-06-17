using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SIRE.Administracion.Datos.Generales
{
    public class DTO_TiposProductos : DTOMantenimiento, IMantenimiento
    {

        #region [ Propiedades ]

        #region [ Propieadades de entidad ]


        public Int16 ConTipoProducto { get; set; }
        public string DesTipoProducto { get; set; }
        public Int16 CategoriaProducto { get; set; }

        //JOIN
        public string DesCategoriaProducto { get; set; }

        #endregion
    
        #endregion

        #region [ Constructores ]

        public DTO_TiposProductos()
        {
            ResultadoMantenimiento = new DTO_Resultado();
        }

        #endregion
    }

    public class DTO_TiposProductosConsulta : DTO_Consulta
    {
        #region [ Propiedades ]

        public string DesTipoProducto { get; set; }
        public Int16 CategoriaProducto { get; set; }

        #endregion
    }
}
