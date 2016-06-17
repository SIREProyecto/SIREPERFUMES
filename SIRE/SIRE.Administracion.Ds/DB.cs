using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SIRE.Administracion.Ds
{
    public class DB:IDisposable
    {
        protected DBS objeto;
        //DataTable ExecuteDatatables(CommandType commandType, string commandText, Campos[] commandParameters);
        private DataTable ExecuteDataTable(CommandType commandType,string commandText, Campos[] commandParameters)
        {
            return objeto.ExecuteDatatable(commandType, commandText, commandParameters);
        }

        void IDisposable.Dispose()
        {
            throw new NotImplementedException();
        }
    }
 }