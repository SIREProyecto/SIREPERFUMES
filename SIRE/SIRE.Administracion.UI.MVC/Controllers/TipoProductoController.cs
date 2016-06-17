using SIRE.Administracion.UI.MVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SIRE.Administracion.UI.MVC.Controllers
{
    public class TipoProductoController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Buscar()
        {
            TipoProductoConsultaModel busqueda = new TipoProductoConsultaModel();

            return View();
        }

        [HttpPost]
        public JsonResult Buscar(string descripcion,
                                 int indiceInicial = 0, int tamanoPagina = 10, string campoOrden = null)
        {
            int totalDeRegistros = 0;

            try
            {
                TipoProductoConsultaModel modeloConsulta = new TipoProductoConsultaModel()
                {
                    Descripcion = descripcion,
                    StartIndex = indiceInicial,
                    PageSize = tamanoPagina,
                    OrderField = campoOrden
                };

                TipoProductoModel modelo = new TipoProductoModel();

                List<TipoProductoModel> resultado = new List<TipoProductoModel>();

                resultado = modelo.Buscar(modeloConsulta, ref totalDeRegistros);

                if (totalDeRegistros == 0)
                {
                    //ViewBag.MensajeUsuario = Etiquetas.GEN_MSJ_NO_HAY_DATOS_CONSULTA;
                    //ViewBag.TipoMensaje = Etiquetas.GEN_MSJ_TIPO_MENSAJE_CONFIRMACION;
                }

                return Json(new { Result = "OK", Records = resultado, TotalRecordCount = totalDeRegistros });
            }
            catch (Exception ex)
            {
                //ViewBag.MensajeUsuario = Etiquetas.GEN_MSJ_CONSULTA_FALLIDA;
                //ViewBag.MesajeTenico = ex.Message;
                //ViewBag.TipoMensaje = Etiquetas.GEN_MSJ_TIPO_MENSAJE_ERROR;

                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }

        public ActionResult Editar()
        {
            return View();
        }
    }
}
