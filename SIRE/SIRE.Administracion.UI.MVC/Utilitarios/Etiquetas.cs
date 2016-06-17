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

        #region Mensajes
        public const string CAMPO_REQUERIDO = "*";
        public const string GenMes_Requerido = "Dato requerido";
        public const string GenSeleccionar = "Seleccionar";
        public const string GenMes_IngresoExito = "El registro fue ingresado satisfactoriamente";
        public const string GenMes_EdicionExito = "El registro fue modificado satisfactoriamente";
        public const string GenMes_IngresoError = "Se ha producido un error al ingresar el registro: @1";
        public const string GenMes_EdicionError = "Se ha producido un error al modificar el registro: @1";

        public const string msgIconoConfirmar = "C";
        public const string msgIconoPrecaucion = "A";
        public const string msgIconoInformacion = "I";
        public const string msgIconoError = "E";
        #endregion




    }
}