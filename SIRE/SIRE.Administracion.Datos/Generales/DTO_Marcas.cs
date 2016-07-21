using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SIRE.Administracion.Datos.Generales
{
    public class DTO_Marcas : DTOMantenimiento, IMantenimiento
    {

        #region [ Propiedades ]

        #region [ Propieadades de entidad ]

        public Int16 ConMarca { get; set; }
        public string DesMarca { get; set; }

        //JOIN

        #endregion
    
        #endregion

        #region [ Constructores ]

        public DTO_Marcas()
        {
            ResultadoMantenimiento = new DTO_Resultado();
        }

        #endregion
    }

    public class DTO_MarcasConsulta : DTO_Consulta
    {
        #region [ Propiedades ]

        public string DesMarca { get; set; }

        #endregion
    }

}
