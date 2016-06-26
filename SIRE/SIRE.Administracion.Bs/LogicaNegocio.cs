﻿using SIRE.Administracion.Datos;
using SIRE.Administracion.Datos.Generales;
using SIRE.Administracion.Ds;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIRE.Administracion.Bs
{
    public class LogicaNegocio : ILogicaNegocio
    {
        private static ILogicaNegocio mInstancia;

        public static ILogicaNegocio Instancia
        {
            get
            {
                ILogicaNegocio retorno;
                if (mInstancia == null)
                    retorno = new LogicaNegocio();
                else
                    retorno = mInstancia;
                return retorno;
            }
            set
            {
                mInstancia = value;
            }
        }

        #region Conexion

        Boolean ILogicaNegocio.ComprobarStringConexion(_ConexionBD ConexBD)
        {
            return AccesoDatos.Instancia.ComprobarStringConexion(ConexBD);
        }
        #endregion

        #region Parametros Generales

        public List<DTO_ParametrosGenerales> ConsultarParametrosGenerales(DTO_ParametrosGeneralesConsulta criterios, ref int tnumTotalRegistros)
        {
            return AccesoDatos.Instancia.ConsultarParametrosGenerales(criterios, ref tnumTotalRegistros);
        }

        public DTO_ParametrosGenerales IngresarParametrosGenerales(DTO_ParametrosGenerales dto)
        {
            return AccesoDatos.Instancia.IngresarParametrosGenerales(dto);
        }

        public DTO_ParametrosGenerales EditarParametrosGenerales(DTO_ParametrosGenerales dto)
        {
            return AccesoDatos.Instancia.EditarParametrosGenerales(dto);
        }

        public DTO_ParametrosGenerales ObtenerParametrosGenerales(string CodParametroGeneral)
        {
            return AccesoDatos.Instancia.ObtenerParametrosGenerales(CodParametroGeneral);
        }
        #endregion

        #region Tipos de Productos

        public List<DTO_TiposProductos> ConsultarTiposProductos(DTO_TiposProductosConsulta criterios, ref int tnumTotalRegistros)
        {
            return AccesoDatos.Instancia.ConsultarTiposProductos(criterios, ref tnumTotalRegistros);
        }

        public DTO_TiposProductos IngresarTiposProductos(DTO_TiposProductos dto)
        {
            return AccesoDatos.Instancia.IngresarTiposProductos(dto);
        }

        public DTO_TiposProductos EditarTiposProductos(DTO_TiposProductos dto)
        {
            return AccesoDatos.Instancia.EditarTiposProductos(dto);
        }

        public DTO_TiposProductos ObtenerTiposProductos(Int16 ConTipoProducto)
        {
            return AccesoDatos.Instancia.ObtenerTiposProductos(ConTipoProducto);
        }

        #endregion

        #region Categoria Producto

        public List<DTO_CategoriaProducto> ObtenerCategoriasProductos()
        {
            return AccesoDatos.Instancia.ObtenerCategoriasProductos();
        }

        #endregion
    }
}
