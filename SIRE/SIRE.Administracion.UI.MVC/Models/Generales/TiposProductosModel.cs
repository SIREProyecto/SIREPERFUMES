using SIRE.Administracion.Datos.Generales;
using SIRE.Administracion.UI.MVC.Utilitarios;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SIRE.Administracion.UI.MVC.Models.Generales
{

    public class TiposProductosModel : MantenimientoGeneralModel
    {
        #region Propiedades

        [Display(Name = Etiquetas.ConTipoProducto)]
        public Int16 ConTipoProducto { get; set; }
        [Display(Name = Etiquetas.DesTipoProducto)]
        public string DesTipoProducto { get; set; }
        [Display(Name = Etiquetas.CategoriaProducto)]
        public Int16 CategoriaProducto { get; set; }

        //Join
        public string DesCategoriaProducto { get; set; }



        #endregion

        #region Acciones

        #region Consultar

        public List<TiposProductosModel> Consultar(TiposProductosModelConsulta criterios, ref int tnumTotalRegistros)
        {
            var modelos = new List<TiposProductosModel>();

            var dtos = new DTO_TiposProductosConsulta();

            dtos = criterios.ConvertirADTO();

            try
            {
                var result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.Consultar(dtos, ref tnumTotalRegistros);

                foreach (var item in result)
                {
                    TiposProductosModel modelo = new TiposProductosModel();
                    modelo = ConvertirAModelo(item);

                    modelos.Add(modelo);
                }

            }
            catch (Exception ex)
            {
            }

            return modelos;
        }

        #endregion

        #endregion

        public TiposProductosModel ConvertirAModelo(DTO_TiposProductos dto)
        {
            var modelo = new TiposProductosModel();

            modelo.ConTipoProducto = dto.ConTipoProducto;
            modelo.DesTipoProducto = dto.DesTipoProducto;
            modelo.DesCategoriaProducto = dto.DesCategoriaProducto;
            modelo.CategoriaProducto = dto.CategoriaProducto;
            modelo.UsrIngreso = dto.UsrIngreso;
            modelo.FecIngreso = dto.FecIngreso;
            modelo.UsrModifico = dto.UsrModifico;
            modelo.FecModifico = dto.FecModifico;
            modelo.CodigoError = dto.ResultadoMantenimiento.CodigoError;
            modelo.DescripcionError = dto.ResultadoMantenimiento.DescripcionError;
            modelo.OtrasDescripciones = dto.ResultadoMantenimiento.OtrasDescripciones;

            return modelo;
        }

        public DTO_TiposProductos ConvertirADTO()
        {
            var dto = new DTO_TiposProductos();

            dto.ConTipoProducto = this.ConTipoProducto;
            dto.DesTipoProducto = this.DesTipoProducto;
            dto.CategoriaProducto = this.CategoriaProducto;
            dto.DesCategoriaProducto = this.DesCategoriaProducto;
            dto.UsrIngreso = this.UsrIngreso;
            dto.FecIngreso = this.FecIngreso;
            dto.UsrModifico = this.UsrModifico;
            dto.FecModifico = this.FecModifico;

            return dto;
        }
    }

    public class TiposProductosModelConsulta : MantenimientoGeneralConsultaModel
    {
        [Display(Name = Etiquetas.DesTipoProducto)]
        public string DesTipoProductoBus { get; set; }
        [Display(Name = Etiquetas.CategoriaProducto)]
        public Int16 CategoriaProductoBus { get; set; }

        public DTO_TiposProductosConsulta ConvertirADTO()
        {
            var dto = new DTO_TiposProductosConsulta();

            dto.DesTipoProducto = this.DesTipoProductoBus;
            dto.CategoriaProducto = this.CategoriaProductoBus;
            dto.PageSize = this.PageSize;
            dto.StartIndex = this.StartIndex;
            dto.OrderField = this.OrderField;
            dto.SessionID = this.SessionID;

            return dto;
        }
    }
}