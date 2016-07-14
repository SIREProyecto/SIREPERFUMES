using SIRE.Administracion.Datos.Productos;
using SIRE.Administracion.UI.MVC.Utilitarios;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SIRE.Administracion.UI.MVC.Models.Productos
{
    public class ProductosModel : MantenimientoGeneralModel
    {
        #region Propiedades

        public int ConProducto { get; set; }
        [Display(Name = Etiquetas.DesProducto)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public string DesProducto { get; set; }

        [Display(Name = Etiquetas.CodProducto)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public string CodProducto { get; set; }

        [Display(Name = Etiquetas.MinimoStock)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public int MinimoStock { get; set; }

        [Display(Name = Etiquetas.MaximoStock)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public int MaximoStock { get; set; }

        [Display(Name = Etiquetas.NuevoInventario)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public bool NuevoInventario { get; set; }

        [Display(Name = Etiquetas.Suspendido)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public bool Suspendido { get; set; }

        [Display(Name = Etiquetas.DesRutaImagen)]
        public string DesRutaImagen { get; set; }

        public string NomImagen { get; set; }

        [Display(Name = Etiquetas.Categoria_Producto)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public Int16 CategoriaProducto { get; set; }

        [Display(Name = Etiquetas.TipoProducto)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public Int16 TipoProducto { get; set; }

        [Display(Name = Etiquetas.Marca)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public Int16 Marca { get; set; }

        [Display(Name = Etiquetas.Proveedor)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public Int16 Proveedor { get; set; }

        [Display(Name = Etiquetas.TipoGenero)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public byte TipoGenero { get; set; }

        [Display(Name = Etiquetas.EstadoPorProceso)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public byte EstadoPorProceso { get; set; }

        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public byte Compania { get; set; }

        [Display(Name = Etiquetas.Presentacion)]
        [Required(AllowEmptyStrings = false, ErrorMessage = Etiquetas.GenMes_Requerido)]
        public Int16 Presentacion { get; set; }

        //JOIN
        public string DesCategoriaProducto { get; set; }
        public string DesTipoProducto { get; set; }
        public string DesMarca { get; set; }
        public string NomProveedor { get; set; }
        public string DesTipoGenero { get; set; }
        public string Estado { get; set; }
        public string DesPresentacion { get; set; }

        #endregion


        #region Consultar

        public List<ProductosModel> ConsultarProductos(ProductosModelConsulta criterios, ref int tnumTotalRegistros)
        {
            var modelos = new List<ProductosModel>();

            var dtos = new DTO_ProductosConsulta();

            dtos = criterios.ConvertirADTO();

            try
            {
                var result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.ConsultarProductos(dtos, ref tnumTotalRegistros);

                foreach (var item in result)
                {
                    ProductosModel modelo = new ProductosModel();
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

        #region Obtener

        public ProductosModel ObtenerProductos(int ConProducto)
        {
            ProductosModel modelo = new ProductosModel();


            try
            {
                DTO_Productos result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.ObtenerProductos(ConProducto);
                modelo = ConvertirAModelo(result);

            }
            catch (Exception ex)
            {
                modelo = new ProductosModel();

                modelo.CodigoError = 4;
                modelo.DescripcionError = ex.Message;

            }

            return modelo;
        }

        #endregion

        #region Ingresar

        public ProductosModel IngresarProductos()
        {
            ProductosModel modelo = new ProductosModel();
            DTO_Productos dto;


            dto = ConvertirADTO();

            try
            {
                DTO_Productos result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.IngresarProductos(dto);

                modelo = ConvertirAModelo(result);
            }
            catch (Exception ex)
            {

                modelo = new ProductosModel();
                modelo.CodigoError = 4;
                modelo.DescripcionError = ex.Message + ex.StackTrace;

            }


            return modelo;
        }

        #endregion

        #region Editar

        public ProductosModel EditarProductos()
        {
            ProductosModel modelo = new ProductosModel();
            DTO_Productos dto;

            dto = ConvertirADTO();

            try
            {
                DTO_Productos result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.EditarProductos(dto);

                modelo = ConvertirAModelo(result);
            }
            catch (Exception ex)
            {

                modelo = new ProductosModel();
                modelo.CodigoError = 4;
                modelo.DescripcionError = ex.Message;

            }

            return modelo;

        }

        #endregion

        #region Eliminar

        public ProductosModel EliminarProductos()
        {
            ProductosModel modelo = new ProductosModel();
            DTO_Productos dto;

            dto = ConvertirADTO();

            try
            {
                DTO_Productos result = SIRE.Administracion.Bs.LogicaNegocio.Instancia.EliminarProductos(dto);

                modelo = ConvertirAModelo(result);
            }
            catch (Exception ex)
            {

                modelo = new ProductosModel();
                modelo.CodigoError = 4;
                modelo.DescripcionError = ex.Message;

            }

            return modelo;

        }

        #endregion

        public ProductosModel ConvertirAModelo(DTO_Productos dto)
        {
            var modelo = new ProductosModel();

            modelo.ConProducto = dto.ConProducto;
            modelo.DesProducto = dto.DesProducto;
            modelo.CodProducto = dto.CodProducto;
            modelo.MinimoStock = dto.MinimoStock;
            modelo.MaximoStock = dto.MaximoStock;
            modelo.NuevoInventario = dto.NuevoInventario;
            modelo.Suspendido = dto.Suspendido;
            modelo.DesRutaImagen = dto.DesRutaImagen;
            modelo.NomImagen = dto.NomImagen;
            modelo.CategoriaProducto = dto.CategoriaProducto;
            modelo.TipoProducto = dto.TipoProducto;
            modelo.Marca = dto.Marca;
            modelo.TipoGenero = dto.TipoGenero;
            modelo.Estado = dto.Estado;
            modelo.Proveedor = dto.Proveedor;
            modelo.Compania = dto.Compania;
            modelo.Presentacion = dto.Presentacion;
            modelo.DesCategoriaProducto = dto.DesCategoriaProducto;
            modelo.DesTipoProducto = dto.DesTipoProducto;
            modelo.DesMarca = dto.DesMarca;
            modelo.DesTipoGenero = dto.DesTipoGenero;
            modelo.Estado = dto.Estado;
            modelo.NomProveedor = dto.NomProveedor;
            modelo.DesPresentacion = dto.DesPresentacion;
            modelo.UsrIngreso = dto.UsrIngreso;
            modelo.FecIngreso = dto.FecIngreso;
            modelo.UsrModifico = dto.UsrModifico;
            modelo.FecModifico = dto.FecModifico;
            modelo.CodigoError = dto.ResultadoMantenimiento.CodigoError;
            modelo.DescripcionError = dto.ResultadoMantenimiento.DescripcionError;
            modelo.OtrasDescripciones = dto.ResultadoMantenimiento.OtrasDescripciones;

            return modelo;
        }

        public DTO_Productos ConvertirADTO()
        {
            var dto = new DTO_Productos();

            dto.ConProducto = this.ConProducto;
            dto.DesProducto = this.DesProducto;
            dto.CodProducto = this.CodProducto;
            dto.MinimoStock = this.MinimoStock;
            dto.MaximoStock = this.MaximoStock;
            dto.NuevoInventario = this.NuevoInventario;
            dto.Suspendido = this.Suspendido;
            dto.DesRutaImagen = this.DesRutaImagen;
            dto.NomImagen = this.NomImagen;
            dto.CategoriaProducto = this.CategoriaProducto;
            dto.TipoProducto = this.TipoProducto;
            dto.Marca = this.Marca;
            dto.TipoGenero = this.TipoGenero;
            dto.Estado = this.Estado;
            dto.Proveedor = this.Proveedor;
            dto.Compania = this.Compania;
            dto.Presentacion = this.Presentacion;
            dto.DesCategoriaProducto = this.DesCategoriaProducto;
            dto.DesTipoProducto = this.DesTipoProducto;
            dto.DesMarca = this.DesMarca;
            dto.DesTipoGenero = this.DesTipoGenero;
            dto.Estado = this.Estado;
            dto.NomProveedor = this.NomProveedor;
            dto.DesPresentacion = this.DesPresentacion;
            dto.UsrIngreso = this.UsrIngreso;
            dto.FecIngreso = this.FecIngreso;
            dto.UsrModifico = this.UsrModifico;
            dto.FecModifico = this.FecModifico;

            return dto;
        }
    }

    public class ProductosModelConsulta : MantenimientoGeneralConsultaModel
    {
        [Display(Name = Etiquetas.CodProducto)]
        public string CodProducto { get; set; }
        [Display(Name = Etiquetas.DesProducto)]
        public string DesProducto { get; set; }
        [Display(Name = Etiquetas.Categoria_Producto)]
        public Int16 CategoriaProducto { get; set; }
        [Display(Name = Etiquetas.TipoProducto)]
        public Int16 TipoProducto { get; set; }
        [Display(Name = Etiquetas.Marca)]
        public Int16 Marca { get; set; }

        public DTO_ProductosConsulta ConvertirADTO()
        {
            var dto = new DTO_ProductosConsulta();

            dto.CodProducto = this.CodProducto;
            dto.DesProducto = this.DesProducto;
            dto.CategoriaProducto = this.CategoriaProducto;
            dto.TipoProducto = this.TipoProducto;
            dto.Marca = this.Marca;
            dto.StartIndex = this.StartIndex;
            dto.OrderField = this.OrderField;
            dto.SessionID = this.SessionID;

            return dto;
        }
    }
}