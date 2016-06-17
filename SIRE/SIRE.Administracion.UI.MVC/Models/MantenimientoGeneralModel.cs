using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SIRE.Administracion.UI.MVC.Models
{
    public class MantenimientoGeneralModel
    {
        [Display(Name = "Fecha de ingreso")]
        public DateTime FecIngreso { get; set; }
        [Display(Name = "Usuario ingresó")]
        public string UsrIngreso { get; set; }

        [Display(Name = "Fecha de modificación")]
        public DateTime? FecModifico { get; set; }

        [Display(Name = "Usuario modificó")]
        public string UsrModifico { get; set; }

        public string SessionID
        {
            get
            {
                return HttpContext.Current.Session.SessionID;
            }
        }

        public int StartIndex { get; set; }
        public int PageSize { get; set; }
        public string OrderField { get; set; }


        public int CodigoError { get; set; }

        private string descripcionError;

        public string DescripcionError
        {
            get
            {
                return descripcionError;
            }
            set
            {
                if (value == null)
                {
                    descripcionError = "";
                }
                else
                {
                    descripcionError = value.Replace(System.Environment.NewLine, " ");
                }
            }
        }

        public string OtrasDescripciones { get; set; }


    }

    public class MantenimientoGeneralConsultaModel
    {

        public int StartIndex { get; set; }
        public int PageSize { get; set; }
        public string OrderField { get; set; }

        public string SessionID
        {
            get
            {
                return HttpContext.Current.Session.SessionID;
            }
        }


    }
}