using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIRE.Administracion.Datos
{
    public class DTO_Resultado
    {

        public int CodigoError { get; set; }

        public string DescripcionError { get; set; }

        public string OtrasDescripciones { get; set; }

        public DTO_Resultado()
        {
            CodigoError = 0;
            DescripcionError = string.Empty;
        }
    }
}
