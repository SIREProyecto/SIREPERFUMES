using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace SIRE.Administracion.Ds
{
    public interface DBS
    {
        DataTable ExecuteDatatable(CommandType commandType, string commandText, Campos[] commandParameters);

    }
}
