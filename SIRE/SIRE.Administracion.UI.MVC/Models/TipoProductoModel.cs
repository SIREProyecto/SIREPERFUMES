using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SIRE.Administracion.UI.MVC.Models
{
    public class TipoProductoModel : BaseModel
    {
        [Display(Name = "Código")]
        public Byte Codigo { get; set; }

        [Display(Name = "Descripción")]
        public String Descripcion { get; set; }

        public List<TipoProductoModel> Buscar(TipoProductoConsultaModel criterios, ref int totalDeRegistros)
        {
            List<TipoProductoModel> listaModelos = new List<TipoProductoModel>();

            try
            {
                TipoProductoModel modelo = new TipoProductoModel() {
                    Codigo = 1,
                    Descripcion = "Abarrotes"};

                listaModelos.Add(modelo);

                modelo = new TipoProductoModel()
                {
                    Codigo = 2,
                    Descripcion = "Decoración"
                };

                listaModelos.Add(modelo);

                modelo = new TipoProductoModel()
                {
                    Codigo = 3,
                    Descripcion = "Hogar"
                };

                listaModelos.Add(modelo);

                modelo = new TipoProductoModel()
                {
                    Codigo = 4,
                    Descripcion = "Bisutería"
                };

                listaModelos.Add(modelo);
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return listaModelos;
        }
    }

    public class TipoProductoConsultaModel : BaseConsultaModel
    {
        [Display(Name = "Código")]
        public Byte Codigo { get; set; }

        [Display(Name = "Descripción")]
        public String Descripcion { get; set; }
    }
}