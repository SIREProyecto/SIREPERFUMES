using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIRE.Administracion.Datos.Generales
{
    public class DTO_ParametrosGenerales : DTOMantenimiento, IMantenimiento
    {
        #region [ Propiedades ]

        #region [ Propieadades de entidad ]


        public string CodParametroGeneral { get; set; }    
        public string DesParametroGeneral { get; set; }
        public byte Compania { get; set; }

        #endregion
    
        #endregion

        #region [ Constructores ]

        public DTO_ParametrosGenerales()
        {
            ResultadoMantenimiento = new DTO_Resultado();
        }

        #endregion
    }

    public class DTO_ParametrosGeneralesConsulta : DTO_Consulta
    {
        #region [ Propiedades ]


        public string CocParametroGeneral { get; set; }
        public string DesParametroGeneral { get; set; }

        #endregion
    }
}
