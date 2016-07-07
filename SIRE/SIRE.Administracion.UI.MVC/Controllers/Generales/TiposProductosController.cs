using SIRE.Administracion.UI.MVC.Models.Generales;
using SIRE.Administracion.UI.MVC.Utilitarios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace SIRE.Administracion.UI.MVC.Controllers.Generales
{
    public class TiposProductosController : Controller
    {
        //
        // GET: /TiposProductos/

        public ActionResult Index()
        {
            return View();
        }

          
        public ActionResult Busqueda()
        {
            GetDropdownlistTiposProductos();

            return View();

        }


        public ActionResult Editar(Int16 codigo, string tInfo_Mensaje = null, string tInfo_Tecnica = null, string ttipo_Mensaje = null)
        {
            GetDropdownlistTiposProductos();
            TiposProductosModel modelo = new TiposProductosModel();
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
                modelo = modelo.ObtenerTiposProductos(codigo);
            }
            return View(modelo);
        }

      
        #region POST /ParametrosGenerales/

        [HttpPost]
        public JsonResult Buscar(string tDesTipoProductoBus, Int16 tCategoriaProductoBus = 0,
        int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            int lnumTotalRegistros = 0;

            try
            {
                var modeloConsulta = new TiposProductosModelConsulta()
                {
                    DesTipoProductoBus = tDesTipoProductoBus,
                    CategoriaProductoBus = tCategoriaProductoBus,
                    StartIndex = jtStartIndex,
                    PageSize = jtPageSize,
                    OrderField = jtSorting
                };

                var modelo = new TiposProductosModel();

                var resultado = new List<TiposProductosModel>();


                resultado = modelo.ConsultarTiposProductos(modeloConsulta, ref lnumTotalRegistros);


                return Json(new { Result = "OK", Records = resultado, TotalRecordCount = lnumTotalRegistros });
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        #region Editar

        [HttpPost]
        [OutputCache(NoStore = true, Duration = 1)]
        public ActionResult Editar(TiposProductosModel modelo)
        {


            try
            {
                if (!ModelState.IsValid)
                {
                    GetDropdownlistTiposProductos();
                    return View(modelo);
                }

                else
                {
                    GetDropdownlistTiposProductos();
                    string mensajeAccion = string.Empty;
                    string mensajetecnico = string.Empty;
                    string tipomensaje = string.Empty;

                    if (modelo.ConTipoProducto == 0)
                    {
                        modelo.UsrIngreso = "SIRE";
                        modelo = modelo.IngresarTiposProductos();

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

                        modelo = modelo.EditarTiposProductos();
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
                {"controller", "TiposProductos"},
                {"action", "Editar"},
                {"codigo", modelo.ConTipoProducto},
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
        public JsonResult Eliminar(Int16 codigo)
        {
            string estadoAccion = "OK";
            string mensajeAccion = "";
            string mensajetecnico = string.Empty;
            string tipomensaje = string.Empty;

            try
            {
                var modelo = new TiposProductosModel();
                modelo.ConTipoProducto = codigo;
                modelo = modelo.EliminarTiposProductos();
                mensajeAccion = Etiquetas.GenMes_EliminarExito;
                tipomensaje = Etiquetas.msgIconoInformacion;

                if (modelo.CodigoError != 0)
                {
                    estadoAccion = "ERROR";
                    mensajeAccion = Etiquetas.GenMes_EliminarError;
                    mensajetecnico = modelo.DescripcionError;
                    tipomensaje = Etiquetas.msgIconoError;
                }

                ViewBag.MesajeExito = Etiquetas.GenMes_EliminarExito; ;
                    ViewBag.MesajeTenico =mensajetecnico;
                    ViewBag.TipoMensaje = Etiquetas.msgIconoInformacion;
                    ViewBag.Accion = "OK";
                    
                    
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

        private void GetDropdownlistTiposProductos() 
        {
            ViewBag.ComboCategoriaProducto = Comun.DropdownlistCategoriasProductos();
        }

          

    }
}
