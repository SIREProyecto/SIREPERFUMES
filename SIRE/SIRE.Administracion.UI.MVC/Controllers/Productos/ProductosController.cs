using SIRE.Administracion.UI.MVC.Models.Productos;
using SIRE.Administracion.UI.MVC.Utilitarios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace SIRE.Administracion.UI.MVC.Controllers.Productos
{
    public class ProductosController : Controller
    {
        #region GET /Productos/

        public ActionResult Index()
        {
            return View();
        }
        
        public ActionResult Busqueda()
        {
   
            return View();

        }

        public ActionResult Editar(int codigo, string tInfo_Mensaje = null, string tInfo_Tecnica = null, string ttipo_Mensaje = null)
        {
           
            ProductosModel modelo = new ProductosModel();

            if (tInfo_Mensaje != null)
            {
                ViewBag.MesajeExito = tInfo_Mensaje;
            }
            if (tInfo_Tecnica != null)
            {
                ViewBag.MesajeTenico = tInfo_Tecnica;
            }

            if (ttipo_Mensaje != null)
            {
                ViewBag.TipoMensaje = ttipo_Mensaje;
            }

            if (codigo != 0)
            {
                modelo = modelo.ObtenerProductos(codigo);
            }
            return View(modelo);
        }

        #endregion

        #region POST /Productos/

        #region Buscar

        [HttpPost]
        public JsonResult Buscar(string tCodProductoBus, string tDesProductoBus,
            Int16 tCategoriaProductoBus = 0, Int16 tTipoProductoBus = 0, Int16 tMarcaBus = 0,
        int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            int lnumTotalRegistros = 0;

            try
            {
                var modeloConsulta = new ProductosModelConsulta()
                {
                    CodProducto = tCodProductoBus,
                    DesProducto = tDesProductoBus,
                    CategoriaProducto = tCategoriaProductoBus,
                    TipoProducto = tTipoProductoBus,
                    Marca = tMarcaBus,
                    StartIndex = jtStartIndex,
                    PageSize = jtPageSize,
                    OrderField = jtSorting
                };

                var modelo = new ProductosModel();

                var resultado = new List<ProductosModel>();


                resultado = modelo.ConsultarProductos(modeloConsulta, ref lnumTotalRegistros);


                return Json(new { Result = "OK", Records = resultado, TotalRecordCount = lnumTotalRegistros });
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        #endregion

        #region Editar

        [HttpPost]
        [OutputCache(NoStore = true, Duration = 1)]
        public ActionResult Editar(ProductosModel modelo)
        {


            try
            {
                if (!ModelState.IsValid)
                {

                    return View(modelo);
                }

                else
                {

                    string mensajeAccion = string.Empty;
                    string mensajetecnico = string.Empty;
                    string tipomensaje = string.Empty;

                    if (modelo.ConProducto == 0)
                    {
                        modelo.UsrIngreso = "SIRE";
                        modelo = modelo.IngresarProductos();

                        mensajeAccion = Etiquetas.GenMes_IngresoExito;
                        tipomensaje = Etiquetas.msgIconoInformacion;
                        if (modelo.CodigoError != 0)
                        {

                            mensajeAccion = Etiquetas.GenMes_IngresoError;
                            mensajetecnico = modelo.DescripcionError;
                            tipomensaje = Etiquetas.msgIconoError;
                        }
                    }
                    else
                    {

                        modelo = modelo.EditarProductos();
                        mensajeAccion = Etiquetas.GenMes_EdicionExito;
                        tipomensaje = Etiquetas.msgIconoConfirmar;
                        if (modelo.CodigoError != 0)
                        {

                            mensajeAccion = Etiquetas.GenMes_EdicionError;
                            mensajetecnico = modelo.DescripcionError;
                            tipomensaje = Etiquetas.msgIconoError;
                        }
                    }

                    return RedirectToAction("Editar", new RouteValueDictionary{
                {"controller", "Productos"},
                {"action", "Editar"},
                {"codigo", modelo.ConProducto},
                {"tInfo_Mensaje", mensajeAccion},
                {"tInfo_Tecnica",mensajetecnico},
                {"ttipo_Mensaje",tipomensaje}});
                }
            }

            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }

        }


        #endregion

        #region Eliminar
        [HttpPost]
        public JsonResult Eliminar(int codigo)
        {
            string estadoAccion = "OK";
            string mensajeAccion = "";
            string mensajetecnico = string.Empty;
            string tipomensaje = string.Empty;

            try
            {
                var modelo = new ProductosModel();
                modelo.ConProducto = codigo;
                modelo = modelo.EliminarProductos();
                mensajeAccion = Etiquetas.GenMes_EliminarExito;
                tipomensaje = Etiquetas.msgIconoInformacion;

                if (modelo.CodigoError != 0)
                {
                    estadoAccion = "ERROR";
                    mensajeAccion = Etiquetas.GenMes_EliminarError;
                    mensajetecnico = modelo.DescripcionError;
                    tipomensaje = Etiquetas.msgIconoError;
                }

                return Json(new

                {
                    Result = estadoAccion,
                    Message = mensajeAccion,
                    MensajeTecnico = mensajetecnico,
                    TipoMensaje = tipomensaje

                });
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }


        #endregion

        #endregion


    }
}
