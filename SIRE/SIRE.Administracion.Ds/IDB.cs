using System;
namespace SIRE.Administracion.Ds
{
    interface IDB
    {
        System.Data.DataTable ExecuteDataTable(System.Data.CommandType commandType, string commandText, Campos[] commandParameters);
    }
}
