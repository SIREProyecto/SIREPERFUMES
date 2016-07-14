using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIRE.Administracion.UI.MVC.Utilitarios
{
    public class Etiquetas
    {
        #region ParametrosGenerales

        public const string CodigoParametro = "Código";
        public const string DescripcionParametro = "Descripción";
        
        #endregion

        #region TiposDeProductos

        public const string ConTipoProducto = "Código";
        public const string DesTipoProducto = "Descripción";
        public const string UsuarioIngreso = "Usuario Ingreso";
        public const string FechaIngreso = "Fecha Ingreso";
        public const string UsuarioModifico = "Usuario Modificó";
        public const string FechaModifico = "Fecha Modificación";
        public const string CategoriaProducto = "Categoría Producto";
    
        #endregion
        
        #region Productos

        public const string DesProducto = "Descripción";
        public const string CodProducto = "Código";
        public const string MinimoStock = "Mínimo Stock";
        public const string MaximoStock = "Máximo Stock";
        public const string NuevoInventario = "Nuevo Inventario";
        public const string Suspendido = "Suspendido";
        public const string DesRutaImagen = "Imagen";
        public const string Categoria_Producto = "Categoría Producto";
        public const string TipoProducto = "Tipo Producto";
        public const string Marca = "Marca";
        public const string Proveedor = "Proveedor";
        public const string TipoGenero = "Tipo Género";
        public const string EstadoPorProceso = "Estado";
        public const string Presentacion = "Presentación";

        #endregion

        #region Mensajes
        public const string CAMPO_REQUERIDO = "*";
        public const string GenMes_Requerido = "Dato requerido";
        public const string GenSeleccionar = "Seleccionar";
        public const string GenMes_IngresoExito = "El registro fue ingresado satisfactoriamente";
        public const string GenMes_EdicionExito = "El registro fue modificado satisfactoriamente";
        public const string GenMes_IngresoError = "Se ha producido un error al ingresar el registro";
        public const string GenMes_EdicionError = "Se ha producido un error al modificar el registro";
        public const string GenMes_EliminarExito = "El registro fue eliminado satisfactoriamente";
        public const string GenMes_EliminarError = "Se ha producido un error al eliminar el registro";

        public const string msgIconoConfirmar = "C";
        public const string msgIconoPrecaucion = "A";
        public const string msgIconoInformacion = "I";
        public const string msgIconoError = "E";
        #endregion




    }
}