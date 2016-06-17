using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SIRE.Administracion.UI.MVC.Models
{
    public class BaseModel
    {
        public string CodigoSesion
        {
            get
            {
                return HttpContext.Current.Session.SessionID;
            }
        }

        public int CodigoError { get; set; }

        public string DescripcionError { get; set; }

        public string DescripcionErrorAdicional { get; set; }
    }

    public class BaseConsultaModel
    {
        public int StartIndex { get; set; }

        public int PageSize { get; set; }

        public string OrderField { get; set; }

        public string CodigoSesion
        {
            get
            {
                return HttpContext.Current.Session.SessionID;
            }
        }
    }
}