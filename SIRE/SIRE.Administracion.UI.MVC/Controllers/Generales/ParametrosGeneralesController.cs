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
    public class ParametrosGeneralesController : Controller
    {
        #region GET: /ParametrosGenerales/

        public ActionResult Index()
        {
            //var busqueda = new ParametrosGeneralesModel();

            return View();
        }

        public ActionResult Busqueda()
        {
            //var busqueda = new ParametrosGeneralesModel();

            return View();

        }


        public ActionResult Editar(string codigo, string tInfo_Mensaje = null, string tInfo_Tecnica = null, string ttipo_Mensaje = null)
        {
            ParametrosGeneralesModel modelo = new ParametrosGeneralesModel();
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
            return View(modelo);
        }

        #endregion

        #region POST /ParametrosGenerales/

        [HttpPost]
        public JsonResult Buscar(string tdesParametrosGeneralesBus,
        int jtStartIndex = 0, int jtPageSize = 0, string jtSorting = null)
        {
            int lnumTotalRegistros = 0;

            try
            {
                var modeloConsulta = new ParametrosGeneralesModelConsulta()
                {
                    desParametrosGeneralesBus = tdesParametrosGeneralesBus,
                    StartIndex = jtStartIndex,
                    PageSize = jtPageSize,
                    OrderField = jtSorting
                };

                var modelo = new ParametrosGeneralesModel();

                var resultado = new List<ParametrosGeneralesModel>();


                resultado = modelo.ConsultarParametrosGenerales(modeloConsulta, ref lnumTotalRegistros);


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
        public ActionResult Editar(ParametrosGeneralesModel modelo)
        {

            try
            {
                //var errors = ModelState.Where(x => x.Value.Errors.Count > 0).Select(x => new { x.Key, x.Value.Errors }).ToArray();

                ////if (modelo.ValidaModelo(modelo) == true)
                ////{
                ////    ModelState.AddModelError("tipFragmentacion", Etiquetas.validacion);

                ////    GetDropdownlistInstrumentos();
                ////    ViewBag.ComboTasaReferencia = FuncionesComunes.DropdownlistGenTasaReferencia(modelo.conMonedaEmision);
                ////    ViewBag.ComboFecPrimeraAmortizacion = FuncionesComunes.GetDropdownlistFecPrimeraAmortizacion(modelo.fecVenceInstrumento, modelo.fecEmision, modelo.conPeriodicidadAmort, modelo.tipBaseCalculo, modelo.tipFragmentacion);
                ////    return View(modelo);

                ////}

                if (!ModelState.IsValid)
                {
                    
                    return View(modelo);
                }

                else
                {
                string mensajeAccion = string.Empty; ;
                string mensajetecnico = string.Empty;
                string tipomensaje = string.Empty;

                if (modelo.CodParametroGeneral == null)
                {
                   
                    modelo = modelo.IngresarParametrosGenerales();
                    
                    mensajeAccion = Etiquetas.GenMes_IngresoExito;
                    tipomensaje = Etiquetas.msgIconoConfirmar;
                    if (modelo.CodigoError != 0)
                    {

                        mensajeAccion = Etiquetas.GenMes_IngresoError;
                        mensajetecnico = modelo.DescripcionError;
                        tipomensaje = Etiquetas.msgIconoError;
                    }
                }
                else
                {
                    
                    modelo = modelo.EditarParametrosGenerales();
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
                {"controller", "ParametrosGenerales"},
                {"action", "Editar"},
                {"codigo", modelo.CodParametroGeneral},
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

        #endregion

    }
}
