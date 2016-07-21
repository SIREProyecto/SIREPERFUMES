using SIRE.Administracion.Datos;
using SIRE.Administracion.Datos.Generales;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using ProjectBase.Validation;
using SIRE.Administracion.Datos.Productos;

namespace SIRE.Administracion.Ds
{
    public class AccesoDatos : IAccesoDatos
    {
        private static Database sqlDataBase;
        public static String SQLCnnString;
        private static IAccesoDatos mInstancia;

     
        public static IAccesoDatos Instancia
        {
            get
            {
                IAccesoDatos retorno;
                if (mInstancia == null)
                    retorno = new AccesoDatos();
                else
                    retorno = mInstancia;
                return retorno;
            }
            set
            {
                mInstancia = value;
            }


        }

        public AccesoDatos()
        {
            sqlDataBase = DatabaseFactory.CreateDatabase(ConfigurationManager.AppSettings["DBSACP"]);
        }

        #region Conexion
         

        Boolean IAccesoDatos.ComprobarStringConexion(_ConexionBD ConexBD)
        {

            SqlConnection cnn = null;

            if (ConexBD.IndicarPuerto)
                SQLCnnString = "Data Source=" + ConexBD.Servidor + "," + ConexBD.Puerto + ";Initial Catalog=" + ConexBD.BaseDatos + ";User ID=" + ConexBD.Usuario + ";Password=" + ConexBD.Contrasenia;
            if (ConexBD.IndicarInstancia)
                SQLCnnString = "Data Source=" + ConexBD.Servidor + @"\" + ConexBD.Instancia + ";Initial Catalog=" + ConexBD.BaseDatos + ";User ID=" + ConexBD.Usuario + ";Password=" + ConexBD.Contrasenia;
            if (ConexBD.HabilitarInstancia)
                SQLCnnString = @"Data Source=.\" + ConexBD.Instancia + ";Initial Catalog=" + ConexBD.BaseDatos + ";User ID=" + ConexBD.Usuario + ";Password=" + ConexBD.Contrasenia;
            else
                SQLCnnString = @"Data Source= " + ConexBD.Servidor + ";Initial Catalog=" + ConexBD.BaseDatos + ";User ID=" + ConexBD.Usuario + ";Password=" + ConexBD.Contrasenia;

            cnn = new SqlConnection(SQLCnnString);

            try
            {
                cnn.Open();
            }

            catch (Exception e)
            {
                return false;
            }

            return true;

        }
        #endregion

        #region ParametrosGenerales

        public List<DTO_ParametrosGenerales> ConsultarParametrosGenerales(DTO_ParametrosGeneralesConsulta criterios, ref int tnumTotalRegistros)
        {

            List<DTO_ParametrosGenerales> resultado = new List<DTO_ParametrosGenerales>();
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            DataSet dad;
            SqlDataReader dr;
            int ultimoParametro = 0;
            string orderField = "";

            try
            {

                if (criterios.OrderField != null)
                {

                    if (criterios.OrderField == "CodParametroGeneral ASC")
                    {
                        orderField = "CodParametroGeneral ASC";
                    }

                    if (criterios.OrderField == "CodParametroGeneral DESC")
                    {
                        orderField = "CodParametroGeneral DESC";
                    }

                    if (criterios.OrderField == "DesParametroGeneral ASC")
                    {
                        orderField = "DesParametroGeneral ASC";
                    }

                    if (criterios.OrderField == "DesParametroGeneral DESC")
                    {
                        orderField = "DesParametroGeneral DESC";
                    }
                }

                else
                {
                    orderField = "CodParametroGeneral";
                }
                 
                
                cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

                cmd = new SqlCommand("pa_MantenimientoParametrosGenerales", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Consultar;
                cmd.Parameters.Add("@pDesParametroGeneralBUS", SqlDbType.Text);
                cmd.Parameters["@pDesParametroGeneralBUS"].Value = criterios.DesParametroGeneral;
                cmd.Parameters.Add("@pnomCampoOrdenBUS", SqlDbType.Text);
                cmd.Parameters["@pnomCampoOrdenBUS"].Value = orderField;
                cmd.Parameters.Add("@pnumPageSize", SqlDbType.Int);
                cmd.Parameters["@pnumPageSize"].Value = criterios.PageSize;
                cmd.Parameters.Add("@pnumCurrentPage", SqlDbType.Int);
                cmd.Parameters["@pnumCurrentPage"].Value = criterios.CurrentPage;

                SqlParameter outputParam = cmd.Parameters.Add("@pnumTotalRegistros", SqlDbType.Int);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters["@pnumTotalRegistros"].Value = null;
                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                tnumTotalRegistros = (int)cmd.Parameters[5].Value;
                dr = cmd.ExecuteReader();
                DTO_ParametrosGenerales fila = new DTO_ParametrosGenerales();
                while (dr.Read())
                {
                    fila.CodParametroGeneral = dr.GetString(dr.GetOrdinal("CodParametroGeneral"));
                    fila.DesParametroGeneral = dr.GetString(dr.GetOrdinal("DesParametroGeneral"));

                    resultado.Add(fila);
                }//Fin del While
                

                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return resultado;
        }

        public DTO_ParametrosGenerales ObtenerParametrosGenerales (string CodParametroGeneral)
        {

            DTO_ParametrosGenerales resultado = new DTO_ParametrosGenerales();
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            DataSet dad;
            SqlDataReader dr;
            int ultimoParametro = 0;
            string orderField = "";

            try
            {

                cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

                cmd = new SqlCommand("pa_MantenimientoParametrosGenerales", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Obtener;
                cmd.Parameters.Add("@pCodParametroGeneral", SqlDbType.Text);
                cmd.Parameters["@pCodParametroGeneral"].Value = CodParametroGeneral;
                
                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                dr = cmd.ExecuteReader();
                DTO_ParametrosGenerales fila = new DTO_ParametrosGenerales();

                //foreach (DataRow item in dt.Rows)
                //{

                //    modelo = getFromDataRow(item);

                //}
                while (dr.Read())
                {
                    resultado.CodParametroGeneral = dr.GetString(dr.GetOrdinal("CodParametroGeneral"));
                    resultado.DesParametroGeneral = dr.GetString(dr.GetOrdinal("DesParametroGeneral"));

                    //resultado;
                }//Fin del While


                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return resultado;
        }
        
        public DTO_ParametrosGenerales IngresarParametrosGenerales(DTO_ParametrosGenerales dto)
        {
             
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

               
            try
            {
                cmd = new SqlCommand("pa_MantenimientoParametrosGenerales", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Insertar;
                cmd.Parameters.Add("@pCodParametroGeneral", SqlDbType.Text);
                cmd.Parameters["@pCodParametroGeneral"].Value = dto.CodParametroGeneral;
                cmd.Parameters.Add("@pDesParametroGeneral", SqlDbType.Text);
                cmd.Parameters["@pDesParametroGeneral"].Value = dto.DesParametroGeneral;
                cmd.Parameters.Add("@pUsuarioIngreso", SqlDbType.Text);
                cmd.Parameters["@pUsuarioIngreso"].Value = dto.UsrIngreso;
                cmd.Parameters.Add("@pCompania", SqlDbType.TinyInt);
                //cmd.Parameters["@pCompania"].Value = dto.Compania;

                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                dto = ObtenerParametrosGenerales(dto.CodParametroGeneral);

            }
            catch (Exception ex)
            {
                dto = new DTO_ParametrosGenerales();
                dto.ResultadoMantenimiento.CodigoError = 1;
                dto.ResultadoMantenimiento.DescripcionError = ex.Message;
            }


            return dto;
        }

        public DTO_ParametrosGenerales EditarParametrosGenerales(DTO_ParametrosGenerales dto)
        {
             
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

               
            try
            {
                cmd = new SqlCommand("pa_MantenimientoParametrosGenerales", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Modificar;
                cmd.Parameters.Add("@pCodParametroGeneral", SqlDbType.Text);
                cmd.Parameters["@pCodParametroGeneral"].Value = dto.CodParametroGeneral;
                cmd.Parameters.Add("@pDesParametroGeneral", SqlDbType.Text);
                cmd.Parameters["@pDesParametroGeneral"].Value = dto.DesParametroGeneral;
                cmd.Parameters.Add("@pUsuarioModifico", SqlDbType.Text);
                cmd.Parameters["@pUsuarioModifico"].Value = dto.UsrModifico;
                cmd.Parameters.Add("@pCompania", SqlDbType.TinyInt);
                //cmd.Parameters["@pCompania"].Value = dto.Compania;

                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                dto = ObtenerParametrosGenerales(dto.CodParametroGeneral);

            }
            catch (Exception ex)
            {
                dto = new DTO_ParametrosGenerales();
                dto.ResultadoMantenimiento.CodigoError = 1;
                dto.ResultadoMantenimiento.DescripcionError = ex.Message;
            }


            return dto;
        }
        #endregion

        #region Tipos de Productos

        public List<DTO_TiposProductos> ConsultarTiposProductos(DTO_TiposProductosConsulta criterios, ref int tnumTotalRegistros)
        {

            List<DTO_TiposProductos> resultado = new List<DTO_TiposProductos>();
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            SqlDataReader dr;
            
            string orderField = "";

            try
            {

                if (criterios.OrderField != null)
                {
                    if (criterios.OrderField == "DesTipoProducto ASC")
                    {
                        orderField = "DesTipoProducto ASC";
                    }

                    if (criterios.OrderField == "DesTipoProducto DESC")
                    {
                        orderField = "DesTipoProducto DESC";
                    }

                    if (criterios.OrderField == "DesCategoriaProducto ASC")
                    {
                        orderField = "DesCategoriaProducto ASC";
                    }

                    if (criterios.OrderField == "DesCategoriaProducto DESC")
                    {
                        orderField = "DesCategoriaProducto DESC";
                    }

                    if (criterios.OrderField == "ConTipoProducto ASC")
                    {
                        orderField = "ConTipoProducto ASC";
                    }

                    if (criterios.OrderField == "ConTipoProducto DESC")
                    {
                        orderField = "ConTipoProducto DESC";
                    }
                }

                else
                {
                    orderField = "ConTipoProducto";
                }


                cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

                cmd = new SqlCommand("pa_MantenimientoTipoProducto", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Consultar;
                cmd.Parameters.Add("@pDesTipoProductoBUS", SqlDbType.Text);
                cmd.Parameters["@pDesTipoProductoBUS"].Value = criterios.DesTipoProducto;
                cmd.Parameters.Add("@pCategoriaProductoBUS", SqlDbType.SmallInt);
                cmd.Parameters["@pCategoriaProductoBUS"].Value = criterios.CategoriaProducto;
                cmd.Parameters.Add("@pnomCampoOrdenBUS", SqlDbType.Text);
                cmd.Parameters["@pnomCampoOrdenBUS"].Value = orderField;
                cmd.Parameters.Add("@pnumPageSize", SqlDbType.Int);
                cmd.Parameters["@pnumPageSize"].Value = criterios.PageSize;
                cmd.Parameters.Add("@pnumCurrentPage", SqlDbType.Int);
                cmd.Parameters["@pnumCurrentPage"].Value = criterios.CurrentPage;

                SqlParameter outputParam = cmd.Parameters.Add("@pnumTotalRegistros", SqlDbType.Int);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters["@pnumTotalRegistros"].Value = null;
                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                tnumTotalRegistros = (int)cmd.Parameters[6].Value;
                dr = cmd.ExecuteReader();
                
                while (dr.Read())
                {
                    DTO_TiposProductos fila = new DTO_TiposProductos();
                    fila.ConTipoProducto = dr.GetInt16(dr.GetOrdinal("ConTipoProducto"));
                    fila.DesTipoProducto = dr.GetString(dr.GetOrdinal("DesTipoProducto"));
                    fila.CategoriaProducto = dr.GetInt16(dr.GetOrdinal("CategoriaProducto"));
                    fila.DesCategoriaProducto = dr.GetString(dr.GetOrdinal("DesCategoriaProducto"));

                    resultado.Add(fila);
                }//Fin del While


                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return resultado;
        }

        public DTO_TiposProductos ObtenerTiposProductos(Int16 ConTipoProducto)
        {

            DTO_TiposProductos resultado = new DTO_TiposProductos();
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            SqlDataReader dr;
           
            try
            {

                cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

                cmd = new SqlCommand("pa_MantenimientoTipoProducto", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Obtener;
                cmd.Parameters.Add("@pConTipoProducto", SqlDbType.SmallInt);
                cmd.Parameters["@pConTipoProducto"].Value = ConTipoProducto;

                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                dr = cmd.ExecuteReader();
                DTO_TiposProductos fila = new DTO_TiposProductos();

                //foreach (DataRow item in dt.Rows)
                //{

                //    modelo = getFromDataRow(item);

                //}
                while (dr.Read())
                {
                    resultado.ConTipoProducto = dr.GetInt16(dr.GetOrdinal("ConTipoProducto"));
                    resultado.DesTipoProducto = dr.GetString(dr.GetOrdinal("DesTipoProducto"));
                    resultado.CategoriaProducto = dr.GetInt16(dr.GetOrdinal("CategoriaProducto"));
                    resultado.DesCategoriaProducto = dr.GetString(dr.GetOrdinal("DesCategoriaProducto"));

                    //resultado;
                }//Fin del While


                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return resultado;
        }

        public DTO_TiposProductos IngresarTiposProductos(DTO_TiposProductos dto)
        {

            SqlConnection cnn = null;
            SqlCommand cmd = null;
            cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

            Int16 ConTipoProducto = 0;
            try
            {
                cmd = new SqlCommand("pa_MantenimientoTipoProducto", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Insertar;
                cmd.Parameters.Add("@pDesTipoProducto", SqlDbType.Text);
                cmd.Parameters["@pDesTipoProducto"].Value = dto.DesTipoProducto;
                cmd.Parameters.Add("@pCategoriaProducto", SqlDbType.SmallInt);
                cmd.Parameters["@pCategoriaProducto"].Value = dto.CategoriaProducto;
                cmd.Parameters.Add("@pUsuarioIngreso", SqlDbType.Text);
                cmd.Parameters["@pUsuarioIngreso"].Value = dto.UsrIngreso;
                SqlParameter outputParam = cmd.Parameters.Add("@pConTipoProductoOUT", SqlDbType.SmallInt);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters["@pConTipoProductoOUT"].Value = null;


                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();
                ConTipoProducto = (Int16)cmd.Parameters[4].Value;
                dto = ObtenerTiposProductos(ConTipoProducto);

            }
            catch (Exception ex)
            {
                dto = new DTO_TiposProductos();
                dto.ResultadoMantenimiento.CodigoError = 1;
                dto.ResultadoMantenimiento.DescripcionError = ex.Message;
            }


            return dto;
        }

        public DTO_TiposProductos EditarTiposProductos(DTO_TiposProductos dto)
        {

            SqlConnection cnn = null;
            SqlCommand cmd = null;
            cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");


            try
            {
                cmd = new SqlCommand("pa_MantenimientoTipoProducto", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Modificar;
                cmd.Parameters.Add("@pDesTipoProducto", SqlDbType.Text);
                cmd.Parameters["@pDesTipoProducto"].Value = dto.DesTipoProducto;
                cmd.Parameters.Add("@pCategoriaProducto", SqlDbType.SmallInt);
                cmd.Parameters["@pCategoriaProducto"].Value = dto.CategoriaProducto;
                cmd.Parameters.Add("@pUsuarioModifico", SqlDbType.Text);
                cmd.Parameters["@pUsuarioModifico"].Value = dto.UsrModifico;
                cmd.Parameters.Add("@pConTipoProducto", SqlDbType.SmallInt);
                cmd.Parameters["@pConTipoProducto"].Value = dto.ConTipoProducto;

                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                dto = ObtenerTiposProductos(dto.ConTipoProducto);

            }
            catch (Exception ex)
            {
                dto = new DTO_TiposProductos();
                dto.ResultadoMantenimiento.CodigoError = 1;
                dto.ResultadoMantenimiento.DescripcionError = ex.Message;
            }


            return dto;
        }

        public DTO_TiposProductos EliminarTiposProductos(DTO_TiposProductos dto)
        {

            SqlConnection cnn = null;
            SqlCommand cmd = null;
            cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");


            try
            {
                cmd = new SqlCommand("pa_MantenimientoTipoProducto", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Eliminar;
                cmd.Parameters.Add("@pConTipoProducto", SqlDbType.Int);
                cmd.Parameters["@pConTipoProducto"].Value = dto.ConTipoProducto;

                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

    
            }
            catch (Exception ex)
            {
                dto = new DTO_TiposProductos();
                dto.ResultadoMantenimiento.CodigoError = 1;
                dto.ResultadoMantenimiento.DescripcionError = ex.Message;
            }


            return dto;
        }

        public List<DTO_TiposProductos> ComboTiposProductos()
        {

            List<DTO_TiposProductos> resultado = new List<DTO_TiposProductos>();

            try
            {

                String StrSQL = String.Format("SELECT ConTipoProducto,DesTipoProducto FROM TipoProducto");
                DbCommand varCmd = sqlDataBase.GetSqlStringCommand(StrSQL);
                IDataReader dr = sqlDataBase.ExecuteReader(varCmd);

                while (dr.Read())
                {
                    DTO_TiposProductos fila = new DTO_TiposProductos();
                    fila.ConTipoProducto = dr.GetInt16(dr.GetOrdinal("ConTipoProducto"));
                    fila.DesTipoProducto = dr.GetString(dr.GetOrdinal("DesTipoProducto"));

                    resultado.Add(fila);
                }//Fin del While


                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return resultado;
        }

        #endregion

        #region Categoria Productos

        public List<DTO_CategoriaProducto> ObtenerCategoriasProductos()
        {

            List<DTO_CategoriaProducto> resultado = new List<DTO_CategoriaProducto>();
                  
            try
            {

                String StrSQL = String.Format("SELECT ConCategoriaProducto,DesCategoriaProducto FROM CategoriaProducto");
                DbCommand varCmd = sqlDataBase.GetSqlStringCommand(StrSQL);
                IDataReader dr = sqlDataBase.ExecuteReader(varCmd);
                
                while (dr.Read())
                {
                    DTO_CategoriaProducto fila = new DTO_CategoriaProducto();
                    fila.ConCategoriaProducto = dr.GetInt16(dr.GetOrdinal("ConCategoriaProducto"));
                    fila.DesCategoriaProducto = dr.GetString(dr.GetOrdinal("DesCategoriaProducto"));

                    resultado.Add(fila);
                }//Fin del While


                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return resultado;
        }


        #endregion

        #region Productos

        public List<DTO_Productos> ConsultarProductos(DTO_ProductosConsulta criterios, ref int tnumTotalRegistros)
        {

            List<DTO_Productos> resultado = new List<DTO_Productos>();
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            SqlDataReader dr;

            string orderField = "";

            try
            {

                if (criterios.OrderField != null)
                {
                    if (criterios.OrderField == "DesTipoProducto ASC")
                    {
                        orderField = "DesTipoProducto ASC";
                    }

                    if (criterios.OrderField == "DesTipoProducto DESC")
                    {
                        orderField = "DesTipoProducto DESC";
                    }

                    if (criterios.OrderField == "DesCategoriaProducto ASC")
                    {
                        orderField = "DesCategoriaProducto ASC";
                    }

                    if (criterios.OrderField == "DesCategoriaProducto DESC")
                    {
                        orderField = "DesCategoriaProducto DESC";
                    }

                    if (criterios.OrderField == "ConTipoProducto ASC")
                    {
                        orderField = "ConTipoProducto ASC";
                    }

                    if (criterios.OrderField == "ConTipoProducto DESC")
                    {
                        orderField = "ConTipoProducto DESC";
                    }
                }

                else
                {
                    orderField = "ConTipoProducto";
                }


                cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

                cmd = new SqlCommand("pa_MantenimientoProductos", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Consultar;
                cmd.Parameters.Add("@pCodProductoBUS", SqlDbType.Text);
                cmd.Parameters["@pCodProductoBUS"].Value = criterios.CodProducto;
                cmd.Parameters.Add("@pDesProductoBUS", SqlDbType.Text);
                cmd.Parameters["@pDesProductoBUS"].Value = criterios.DesProducto;
                cmd.Parameters.Add("@pCategoriaProductoBUS", SqlDbType.SmallInt);
                cmd.Parameters["@pCategoriaProductoBUS"].Value = criterios.CategoriaProducto;
                cmd.Parameters.Add("@pMarcaBUS", SqlDbType.SmallInt);
                cmd.Parameters["@pMarcaBUS"].Value = criterios.Marca;
                cmd.Parameters.Add("@pTipoProductoBUS", SqlDbType.SmallInt);
                cmd.Parameters["@pTipoProductoBUS"].Value = criterios.TipoProducto;
                cmd.Parameters.Add("@pnomCampoOrdenBUS", SqlDbType.Text);
                cmd.Parameters["@pnomCampoOrdenBUS"].Value = orderField;
                cmd.Parameters.Add("@pnumPageSize", SqlDbType.Int);
                cmd.Parameters["@pnumPageSize"].Value = criterios.PageSize;
                cmd.Parameters.Add("@pnumCurrentPage", SqlDbType.Int);
                cmd.Parameters["@pnumCurrentPage"].Value = criterios.CurrentPage;

                SqlParameter outputParam = cmd.Parameters.Add("@pnumTotalRegistros", SqlDbType.Int);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters["@pnumTotalRegistros"].Value = null;
                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                tnumTotalRegistros = (int)cmd.Parameters[9].Value;
                dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    DTO_Productos fila = new DTO_Productos();
                    fila.ConProducto = dr.GetInt16(dr.GetOrdinal("ConProducto"));
                    fila.DesProducto = dr.GetString(dr.GetOrdinal("DesProducto"));
                    fila.CodProducto = dr.GetString(dr.GetOrdinal("CodProducto"));
                    fila.MinimoStock = dr.GetInt32(dr.GetOrdinal("MinimoStock"));
                    fila.MaximoStock = dr.GetInt32(dr.GetOrdinal("MaximoStock"));
                    fila.NuevoInventario = dr.GetBoolean(dr.GetOrdinal("NuevoInventario"));
                    fila.Suspendido = dr.GetBoolean(dr.GetOrdinal("Suspendido"));
                    fila.DesRutaImagen = dr.GetString(dr.GetOrdinal("DesRutaImagen"));
                    fila.NomImagen = dr.GetString(dr.GetOrdinal("NomImagen"));
                    fila.CategoriaProducto = dr.GetInt16(dr.GetOrdinal("CategoriaProducto"));
                    fila.TipoProducto = dr.GetInt16(dr.GetOrdinal("TipoProducto"));
                    fila.Marca = dr.GetInt16(dr.GetOrdinal("Marca"));
                    fila.Proveedor = dr.GetInt16(dr.GetOrdinal("Proveedor"));
                    fila.TipoGenero = dr.GetByte(dr.GetOrdinal("TipoGenero"));
                    fila.EstadoPorProceso = dr.GetByte(dr.GetOrdinal("EstadoPorProceso"));
                    fila.Compania = dr.GetByte(dr.GetOrdinal("Compania"));
                    fila.Presentacion = dr.GetInt16(dr.GetOrdinal("Presentacion"));
                    fila.DesCategoriaProducto = dr.GetString(dr.GetOrdinal("DesCategoriaProducto"));
                    fila.DesTipoProducto = dr.GetString(dr.GetOrdinal("DesTipoProducto"));
                    fila.DesMarca = dr.GetString(dr.GetOrdinal("DesMarca"));
                    fila.NomProveedor = dr.GetString(dr.GetOrdinal("NomProveedor"));
                    fila.DesTipoGenero = dr.GetString(dr.GetOrdinal("DesTipoGenero"));
                    fila.Estado = dr.GetString(dr.GetOrdinal("Estado"));
                    fila.DesPresentacion = dr.GetString(dr.GetOrdinal("DesPresentacion"));


                    resultado.Add(fila);
                }//Fin del While


                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return resultado;
        }

        public DTO_Productos ObtenerProductos(int ConProducto)
        {

            DTO_Productos fila = new DTO_Productos();
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            SqlDataReader dr;

            try
            {

                cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

                cmd = new SqlCommand("pa_MantenimientoProductos", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Obtener;
                cmd.Parameters.Add("@pConProducto", SqlDbType.Int);
                cmd.Parameters["@pConProducto"].Value = ConProducto;

                cnn.Open();

                cmd.ExecuteNonQuery();

                dr = cmd.ExecuteReader();
                
                while (dr.Read())
                {
                    fila.ConProducto = dr.GetInt16(dr.GetOrdinal("ConProducto"));
                    fila.DesProducto = dr.GetString(dr.GetOrdinal("DesProducto"));
                    fila.CodProducto = dr.GetString(dr.GetOrdinal("CodProducto"));
                    fila.MinimoStock = dr.GetInt32(dr.GetOrdinal("MinimoStock"));
                    fila.MaximoStock = dr.GetInt32(dr.GetOrdinal("MaximoStock"));
                    fila.NuevoInventario = dr.GetBoolean(dr.GetOrdinal("NuevoInventario"));
                    fila.Suspendido = dr.GetBoolean(dr.GetOrdinal("Suspendido"));
                    fila.DesRutaImagen = dr.GetString(dr.GetOrdinal("DesRutaImagen"));
                    fila.NomImagen = dr.GetString(dr.GetOrdinal("NomImagen"));
                    fila.CategoriaProducto = dr.GetInt16(dr.GetOrdinal("CategoriaProducto"));
                    fila.TipoProducto = dr.GetInt16(dr.GetOrdinal("TipoProducto"));
                    fila.Marca = dr.GetInt16(dr.GetOrdinal("Marca"));
                    fila.Proveedor = dr.GetInt16(dr.GetOrdinal("Proveedor"));
                    fila.TipoGenero = dr.GetByte(dr.GetOrdinal("TipoGenero"));
                    fila.EstadoPorProceso = dr.GetByte(dr.GetOrdinal("EstadoPorProceso"));
                    fila.Compania = dr.GetByte(dr.GetOrdinal("Compania"));
                    fila.Presentacion = dr.GetInt16(dr.GetOrdinal("Presentacion"));
                    fila.DesCategoriaProducto = dr.GetString(dr.GetOrdinal("DesCategoriaProducto"));
                    fila.DesTipoProducto = dr.GetString(dr.GetOrdinal("DesTipoProducto"));
                    fila.DesMarca = dr.GetString(dr.GetOrdinal("DesMarca"));
                    fila.NomProveedor = dr.GetString(dr.GetOrdinal("NomProveedor"));
                    fila.DesTipoGenero = dr.GetString(dr.GetOrdinal("DesTipoGenero"));
                    fila.Estado = dr.GetString(dr.GetOrdinal("Estado"));
                    fila.DesPresentacion = dr.GetString(dr.GetOrdinal("DesPresentacion"));

                    //resultado;
                }//Fin del While


                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return fila;
        }

        public DTO_Productos IngresarProductos(DTO_Productos dto)
        {

            SqlConnection cnn = null;
            SqlCommand cmd = null;
            cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

            int ConProducto = 0;
            try
            {
                cmd = new SqlCommand("pa_MantenimientoProductos", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Insertar;
                cmd.Parameters.Add("@pDesProducto", SqlDbType.Text);
                cmd.Parameters["@pDesProducto"].Value = dto.DesProducto;
                cmd.Parameters.Add("@pCodProducto", SqlDbType.Text);
                cmd.Parameters["@pCodProducto"].Value = dto.CodProducto;
                cmd.Parameters.Add("@pMinimoStock", SqlDbType.Int);
                cmd.Parameters["@pMinimoStock"].Value = dto.MinimoStock;
                cmd.Parameters.Add("@pMaximoStock", SqlDbType.Int);
                cmd.Parameters["@pMaximoStock"].Value = dto.MaximoStock;
                cmd.Parameters.Add("@pNuevoInventario", SqlDbType.Bit);
                cmd.Parameters["@pNuevoInventario"].Value = dto.NuevoInventario;
                cmd.Parameters.Add("@pSuspendido", SqlDbType.Bit);
                cmd.Parameters["@pSuspendido"].Value = dto.Suspendido;
                cmd.Parameters.Add("@pDesRutaImagen", SqlDbType.Text);
                cmd.Parameters["@pDesRutaImagen"].Value = dto.DesRutaImagen;
                cmd.Parameters.Add("@pNomImagen", SqlDbType.Text);
                cmd.Parameters["@pNomImagen"].Value = dto.NomImagen;
                cmd.Parameters.Add("@pCategoriaProducto", SqlDbType.SmallInt);
                cmd.Parameters["@pCategoriaProducto"].Value = dto.CategoriaProducto;
                cmd.Parameters.Add("@pTipoProducto", SqlDbType.SmallInt);
                cmd.Parameters["@pTipoProducto"].Value = dto.TipoProducto;
                cmd.Parameters.Add("@pMarca", SqlDbType.SmallInt);
                cmd.Parameters["@pMarca"].Value = dto.Marca;
                cmd.Parameters.Add("@pProveedor", SqlDbType.SmallInt);
                cmd.Parameters["@pProveedor"].Value = dto.Proveedor;
                cmd.Parameters.Add("@pTipoGenero", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoGenero"].Value = dto.TipoGenero;
                cmd.Parameters.Add("@pEstadoPorProceso", SqlDbType.TinyInt);
                cmd.Parameters["@pEstadoPorProceso"].Value = dto.EstadoPorProceso;
                cmd.Parameters.Add("@pCompania", SqlDbType.TinyInt);
                cmd.Parameters["@pCompania"].Value = dto.Compania;
                cmd.Parameters.Add("@pPresentacion", SqlDbType.SmallInt);
                cmd.Parameters["@pPresentacion"].Value = dto.Presentacion;
                cmd.Parameters.Add("@pUsuarioIngreso", SqlDbType.Text);
                cmd.Parameters["@pUsuarioIngreso"].Value = dto.UsrIngreso;
                SqlParameter outputParam = cmd.Parameters.Add("@pConProductoOUT", SqlDbType.Int);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters["@pConProductoOUT"].Value = null;


                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();
                ConProducto = (int)cmd.Parameters[18].Value;
                dto = ObtenerProductos(ConProducto);

            }
            catch (Exception ex)
            {
                dto = new DTO_Productos();
                dto.ResultadoMantenimiento.CodigoError = 1;
                dto.ResultadoMantenimiento.DescripcionError = ex.Message;
            }


            return dto;
        }

        public DTO_Productos EditarProductos(DTO_Productos dto)
        {

            SqlConnection cnn = null;
            SqlCommand cmd = null;
            cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");


            try
            {
                cmd = new SqlCommand("pa_MantenimientoProductos", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Modificar;
                cmd.Parameters.Add("@pDesProducto", SqlDbType.Text);
                cmd.Parameters["@pDesProducto"].Value = dto.DesProducto;
                cmd.Parameters.Add("@pCodProducto", SqlDbType.Text);
                cmd.Parameters["@pCodProducto"].Value = dto.CodProducto;
                cmd.Parameters.Add("@pMinimoStock", SqlDbType.Int);
                cmd.Parameters["@pMinimoStock"].Value = dto.MinimoStock;
                cmd.Parameters.Add("@pMaximoStock", SqlDbType.Int);
                cmd.Parameters["@pMaximoStock"].Value = dto.MaximoStock;
                cmd.Parameters.Add("@pNuevoInventario", SqlDbType.Bit);
                cmd.Parameters["@pNuevoInventario"].Value = dto.NuevoInventario;
                cmd.Parameters.Add("@pSuspendido", SqlDbType.Bit);
                cmd.Parameters["@pSuspendido"].Value = dto.Suspendido;
                cmd.Parameters.Add("@pDesRutaImagen", SqlDbType.Text);
                cmd.Parameters["@pDesRutaImagen"].Value = dto.DesRutaImagen;
                cmd.Parameters.Add("@pNomImagen", SqlDbType.Text);
                cmd.Parameters["@pNomImagen"].Value = dto.NomImagen;
                cmd.Parameters.Add("@pCategoriaProducto", SqlDbType.SmallInt);
                cmd.Parameters["@pCategoriaProducto"].Value = dto.CategoriaProducto;
                cmd.Parameters.Add("@pTipoProducto", SqlDbType.SmallInt);
                cmd.Parameters["@pTipoProducto"].Value = dto.TipoProducto;
                cmd.Parameters.Add("@pMarca", SqlDbType.SmallInt);
                cmd.Parameters["@pMarca"].Value = dto.Marca;
                cmd.Parameters.Add("@pProveedor", SqlDbType.SmallInt);
                cmd.Parameters["@pProveedor"].Value = dto.Proveedor;
                cmd.Parameters.Add("@pTipoGenero", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoGenero"].Value = dto.TipoGenero;
                cmd.Parameters.Add("@pEstadoPorProceso", SqlDbType.TinyInt);
                cmd.Parameters["@pEstadoPorProceso"].Value = dto.EstadoPorProceso;
                cmd.Parameters.Add("@pCompania", SqlDbType.TinyInt);
                cmd.Parameters["@pCompania"].Value = dto.Compania;
                cmd.Parameters.Add("@pPresentacion", SqlDbType.SmallInt);
                cmd.Parameters["@pPresentacion"].Value = dto.Presentacion;
                cmd.Parameters.Add("@pUsuarioModifico", SqlDbType.Text);
                cmd.Parameters["@pUsuarioModifico"].Value = dto.UsrModifico;
                cmd.Parameters.Add("@pConTipoProducto", SqlDbType.Int);
                cmd.Parameters["@pConTipoProducto"].Value = dto.ConProducto;

                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();

                dto = ObtenerProductos(dto.ConProducto);

            }
            catch (Exception ex)
            {
                dto = new DTO_Productos();
                dto.ResultadoMantenimiento.CodigoError = 1;
                dto.ResultadoMantenimiento.DescripcionError = ex.Message;
            }


            return dto;
        }

        public DTO_Productos EliminarProductos(DTO_Productos dto)
        {

            SqlConnection cnn = null;
            SqlCommand cmd = null;
            cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");


            try
            {
                cmd = new SqlCommand("pa_MantenimientoProductos", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Eliminar;
                cmd.Parameters.Add("@pConProducto", SqlDbType.Int);
                cmd.Parameters["@pConProducto"].Value = dto.ConProducto;

                cnn.Open();

                //IDataReader dr = 
                cmd.ExecuteNonQuery();


            }
            catch (Exception ex)
            {
                dto = new DTO_Productos();
                dto.ResultadoMantenimiento.CodigoError = 1;
                dto.ResultadoMantenimiento.DescripcionError = ex.Message;
            }


            return dto;
        }

        #endregion

        #region Marcas

        public List<DTO_Marcas> ComboMarcas()
        {

            List<DTO_Marcas> resultado = new List<DTO_Marcas>();

            try
            {

                String StrSQL = String.Format("SELECT ConMarca,DesMarca FROM Marcas");
                DbCommand varCmd = sqlDataBase.GetSqlStringCommand(StrSQL);
                IDataReader dr = sqlDataBase.ExecuteReader(varCmd);

                while (dr.Read())
                {
                    DTO_Marcas fila = new DTO_Marcas();
                    fila.ConMarca = dr.GetInt16(dr.GetOrdinal("ConMarca"));
                    fila.DesMarca = dr.GetString(dr.GetOrdinal("DesMarca"));

                    resultado.Add(fila);
                }//Fin del While


                dr.Close();
                dr.Dispose();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                throw;
            }

            return resultado;
        }

        #endregion
    }
}
