using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SIRE.Administracion.Datos.Generales
{
    public class DTO_CategoriaProducto : DTOMantenimiento, IMantenimiento
    {
        #region [ Propiedades ]

        #region [ Propieadades de entidad ]


        public Int16 ConCategoriaProducto { get; set; }
        public string DesCategoriaProducto { get; set; }

        #endregion

        #endregion

                
        #region [ Constructores ]

        public DTO_CategoriaProducto()
        {
            ResultadoMantenimiento = new DTO_Resultado();
        }

        #endregion
    }
}
