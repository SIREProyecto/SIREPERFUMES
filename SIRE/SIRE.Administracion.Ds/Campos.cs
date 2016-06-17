using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace SIRE.Administracion.Ds
{
     [Serializable]
    public class Campos
    {
        public string name { get; set; }
        public object value { get; set; }
        public DbType _tipo = DbType.String;

        public ParameterDirection direction = ParameterDirection.Input;

       
        public Campos(string nombre, object valor, ParameterDirection direccion, DbType tipo)
        {
            name = nombre;
            value = valor;
            direction = direccion;
            _tipo = tipo;
        }
    }
}
