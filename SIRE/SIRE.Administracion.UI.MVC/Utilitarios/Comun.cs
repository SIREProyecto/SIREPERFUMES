using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.WebPages.Html;

namespace SIRE.Administracion.UI.MVC.Utilitarios
{
    public class Comun
    {

        //COMBOBOX Categoria Productos

        public static List<SelectListItem> DropdownlistCategoriasProductos()
        {

            var lista = SIRE.Administracion.Bs.LogicaNegocio.Instancia.ObtenerCategoriasProductos();

            var items = new List<SelectListItem>();  

            try
            {
                foreach (var p in lista)
                {
                    var s = new SelectListItem();
                    s.Text = p.DesCategoriaProducto.ToString();
                    s.Value = p.ConCategoriaProducto.ToString();


                    items.Add(s);
                }

            }
            catch (Exception ex)
            {


            }

            return items;

        }

        //COMBOBOX Tipos de Productos

        public static List<SelectListItem> DropdownlistTiposProductos()
        {

            var lista = SIRE.Administracion.Bs.LogicaNegocio.Instancia.ComboTiposProductos();

            var items = new List<SelectListItem>();

            try
            {
                foreach (var p in lista)
                {
                    var s = new SelectListItem();
                    s.Text = p.ConTipoProducto.ToString();
                    s.Value = p.DesTipoProducto.ToString();


                    items.Add(s);
                }

            }
            catch (Exception ex)
            {


            }

            return items;

        }

        //COMBOBOX Marcas

        public static List<SelectListItem> DropdownlistMarcas()
        {

            var lista = SIRE.Administracion.Bs.LogicaNegocio.Instancia.ComboMarcas();

            var items = new List<SelectListItem>();

            try
            {
                foreach (var p in lista)
                {
                    var s = new SelectListItem();
                    s.Text = p.ConMarca.ToString();
                    s.Value = p.DesMarca.ToString();


                    items.Add(s);
                }

            }
            catch (Exception ex)
            {


            }

            return items;

        }

    }
}