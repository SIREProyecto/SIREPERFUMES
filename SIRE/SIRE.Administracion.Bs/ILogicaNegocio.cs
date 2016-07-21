using SIRE.Administracion.Datos;
using SIRE.Administracion.Datos.Generales;
using SIRE.Administracion.Datos.Productos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIRE.Administracion.Bs
{
    public interface ILogicaNegocio
    {

        #region Conexion

        Boolean ComprobarStringConexion(_ConexionBD ConexBD);

        #endregion

        #region Parametros Generales

        List<DTO_ParametrosGenerales> ConsultarParametrosGenerales(DTO_ParametrosGeneralesConsulta criterios, ref int tnumTotalRegistros);
        DTO_ParametrosGenerales IngresarParametrosGenerales(DTO_ParametrosGenerales dto);
        DTO_ParametrosGenerales EditarParametrosGenerales(DTO_ParametrosGenerales dto);
        DTO_ParametrosGenerales ObtenerParametrosGenerales(string CodParametroGeneral);

        #endregion

        #region Tipos de Productos

        List<DTO_TiposProductos> ConsultarTiposProductos(DTO_TiposProductosConsulta criterios, ref int tnumTotalRegistros);
        DTO_TiposProductos IngresarTiposProductos(DTO_TiposProductos dto);
        DTO_TiposProductos EditarTiposProductos(DTO_TiposProductos dto);
        DTO_TiposProductos ObtenerTiposProductos(Int16 ConTipoProducto);
        DTO_TiposProductos EliminarTiposProductos(DTO_TiposProductos dto);
        List<DTO_TiposProductos> ComboTiposProductos();

        #endregion

        #region Categoria Productos

        List<DTO_CategoriaProducto> ObtenerCategoriasProductos();

        #endregion

        #region Productos

        List<DTO_Productos> ConsultarProductos(DTO_ProductosConsulta criterios, ref int tnumTotalRegistros);
        DTO_Productos IngresarProductos(DTO_Productos dto);
        DTO_Productos EditarProductos(DTO_Productos dto);
        DTO_Productos ObtenerProductos(int ConProducto);
        DTO_Productos EliminarProductos(DTO_Productos dto);
        
        #endregion

        #region Marca

        List<DTO_Marcas> ComboMarcas();

        #endregion

    }
}
