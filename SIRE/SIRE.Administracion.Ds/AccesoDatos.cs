using SIRE.Administracion.Datos;
using SIRE.Administracion.Datos.Generales;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIRE.Administracion.Ds
{
    public class AccesoDatos : IAccesoDatos
    {

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

                    if (criterios.OrderField == "CategoriaProducto ASC")
                    {
                        orderField = "CategoriaProducto ASC";
                    }

                    if (criterios.OrderField == "CategoriaProducto DESC")
                    {
                        orderField = "CategoriaProducto DESC";
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
                DTO_TiposProductos fila = new DTO_TiposProductos();
                while (dr.Read())
                {
                    fila.ConTipoProducto = dr.GetInt16(dr.GetOrdinal("ConTipoProducto"));
                    fila.DesTipoProducto = dr.GetString(dr.GetOrdinal("DesTipoProducto"));
                    fila.CategoriaProducto = dr.GetInt16(dr.GetOrdinal("CategoriaProducto"));
                    fila.DesCategoriaProducto = dr.GetString(dr.GetOrdinal("DesCategoriaProducto"));
                    fila.UsrIngreso = dr.GetString(dr.GetOrdinal("UsuarioIngreso"));
                    fila.FecIngreso = dr.GetDateTime(dr.GetOrdinal("FechaIngreso"));
                    fila.UsrModifico = dr.GetString(dr.GetOrdinal("UsuarioModifico"));
                    fila.FecModifico = dr.GetDateTime(dr.GetOrdinal("FechaModifico"));

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
            DataSet dad;
            SqlDataReader dr;
            int ultimoParametro = 0;
            string orderField = "";

            try
            {

                cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

                cmd = new SqlCommand("pa_MantenimientoTipoProducto", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Obtener;
                cmd.Parameters.Add("@pConTipoProducto", SqlDbType.Text);
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
        
        #endregion

        #region Categoria Productos

        public List<DTO_CategoriaProducto> ObtenerCategoriasProductos()
        {

            List<DTO_CategoriaProducto> resultado = new List<DTO_CategoriaProducto>();
            SqlConnection cnn = null;
            SqlCommand cmd = null;
            SqlDataReader dr;

          
            try
            {

                cnn = new SqlConnection(@"Data Source=MIRIAM;Initial Catalog=BDSIRE;Integrated Security=True;User ID=sa;Password=sql2014");

                cmd = new SqlCommand("pa_MantenimientoCategoriaProducto", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@pTipoOperacion", SqlDbType.TinyInt);
                cmd.Parameters["@pTipoOperacion"].Value = DTO_TipoOperacionMantenimiento.Combos;

                cnn.Open();
                cmd.ExecuteNonQuery();

                dr = cmd.ExecuteReader();
                DTO_CategoriaProducto fila = new DTO_CategoriaProducto();
                while (dr.Read())
                {
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


    }
}
