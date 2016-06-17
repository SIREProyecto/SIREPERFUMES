using SIRE.Administracion.Datos;
using SIRE.Administracion.Datos.Generales;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIRE.Administracion.Ds
{
    public interface IAccesoDatos
    {

        #region Conexion

        Boolean ComprobarStringConexion(_ConexionBD ConexBD);

        #endregion

        #region ParametrosGenerales

        List<DTO_ParametrosGenerales> ConsultarParametrosGenerales(DTO_ParametrosGeneralesConsulta criterios, ref int tnumTotalRegistros);
        DTO_ParametrosGenerales ObtenerParametrosGenerales (string CodParametroGeneral);
        DTO_ParametrosGenerales IngresarParametrosGenerales(DTO_ParametrosGenerales dto);
        DTO_ParametrosGenerales EditarParametrosGenerales(DTO_ParametrosGenerales dto);

        #endregion



        #region TiposDeProductos

        List<DTO_TiposProductos> Consultar(DTO_TiposProductosConsulta criterios, ref int tnumTotalRegistros);

        #endregion
    }
}
