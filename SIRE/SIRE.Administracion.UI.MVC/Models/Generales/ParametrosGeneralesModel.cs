using SIRE.Administracion.Datos.Generales;
using SIRE.Administracion.UI.MVC.Utilitarios;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SIRE.Administracion.UI.MVC.Models.Generales
{
    public class ParametrosGeneralesModel : MantenimientoGeneralModel
    {
        #region Propiedades

        [Display(Name = Etiquetas.CodigoParametro)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public string CodParametroGeneral { get; set; }
        [Display(Name = Etiquetas.DescripcionParametro)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public string DesParametroGeneral { get; set; }
        public byte Compania { get; set; }


        #endregion

        #region Acciones

        #region Consultar

        public List<ParametrosGeneralesModel> ConsultarParametrosGenerales(ParametrosGeneralesModelConsulta criterios, ref int tnumTotalRegistros)
        {
            var modelos = new List<ParametrosGeneralesModel>();

            var dtos = new DTO_ParametrosGeneralesConsulta();

            dtos = criterios.ConvertirADTO();

            try
            {
                var result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.ConsultarParametrosGenerales(dtos, ref tnumTotalRegistros);

                foreach (var item in result)
                {
                    ParametrosGeneralesModel modelo = new ParametrosGeneralesModel();
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

        public ParametrosGeneralesModel ObtenerParametrosGenerales(string CodParametroGeneral)
        {
            ParametrosGeneralesModel modelo = new ParametrosGeneralesModel();


            try
            {
                DTO_ParametrosGenerales result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.ObtenerParametrosGenerales(CodParametroGeneral);
                modelo = ConvertirAModelo(result);

            }
            catch (Exception ex)
            {
                modelo = new ParametrosGeneralesModel();

                modelo.CodigoError = 4;
                modelo.DescripcionError = ex.Message;

            }

            return modelo;
        }

        public ParametrosGeneralesModel IngresarParametrosGenerales()
        {
            ParametrosGeneralesModel modelo = new ParametrosGeneralesModel();
            DTO_ParametrosGenerales dto;


            dto = ConvertirADTO();

            try
            {
                DTO_ParametrosGenerales result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.IngresarParametrosGenerales(dto);

                modelo = ConvertirAModelo(result);
            }
            catch (Exception ex)
            {

                modelo = new ParametrosGeneralesModel();
                modelo.CodigoError = 4;
                modelo.DescripcionError = ex.Message + ex.StackTrace;

            }


            return modelo;
        }

        public ParametrosGeneralesModel EditarParametrosGenerales()
        {
            ParametrosGeneralesModel modelo = new ParametrosGeneralesModel();
            DTO_ParametrosGenerales dto;

            dto = ConvertirADTO();

            try
            {
                DTO_ParametrosGenerales result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.EditarParametrosGenerales(dto);

                modelo = ConvertirAModelo(result);
            }
            catch (Exception ex)
            {

                modelo = new ParametrosGeneralesModel();
                modelo.CodigoError = 4;
                modelo.DescripcionError = ex.Message;

            }

            return modelo;

        }

        #endregion

        public ParametrosGeneralesModel ConvertirAModelo(DTO_ParametrosGenerales dto)
        {
            var modelo = new ParametrosGeneralesModel();

            modelo.CodParametroGeneral = dto.CodParametroGeneral;
            modelo.DesParametroGeneral = dto.DesParametroGeneral;
            modelo.CodigoError = dto.ResultadoMantenimiento.CodigoError;
            modelo.DescripcionError = dto.ResultadoMantenimiento.DescripcionError;
            modelo.OtrasDescripciones = dto.ResultadoMantenimiento.OtrasDescripciones;

            return modelo;
        }

        public DTO_ParametrosGenerales ConvertirADTO()
        {
            var dto = new DTO_ParametrosGenerales();

            dto.CodParametroGeneral = this.CodParametroGeneral;
            dto.DesParametroGeneral = this.DesParametroGeneral;

            return dto;
        }
    }

    public class ParametrosGeneralesModelConsulta : MantenimientoGeneralConsultaModel
    {
        [Display(Name = Etiquetas.DescripcionParametro)]
        public string desParametrosGeneralesBus { get; set; }

        public DTO_ParametrosGeneralesConsulta ConvertirADTO()
        {
            var dto = new DTO_ParametrosGeneralesConsulta();

            dto.DesParametroGeneral = this.desParametrosGeneralesBus;
            dto.PageSize = this.PageSize;
            dto.StartIndex = this.StartIndex;
            dto.OrderField = this.OrderField;
            dto.SessionID = this.SessionID;

            return dto;
        }
    }
}