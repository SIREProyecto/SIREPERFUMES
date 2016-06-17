using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SIRE.Administracion.Datos
{
    public class _ConexionBD
    {
        private String _Servidor;
        private String _BaseDatos;
        private String _Puerto;
        private String _Usuario;
        private String _contrasenia;
        private String _Instancia;
        private Boolean _IndicarInstancia;
        private Boolean _HabilitarInstancia;
        private Boolean _IndicarPuerto;

        /*---------------------------------------------------------*/
        /*---------------------------------------------------------*/

        public String Servidor
        {
            get { return _Servidor; }
            set { _Servidor = value; }
        }


        public String BaseDatos
        {
            get { return _BaseDatos; }
            set { _BaseDatos = value; }
        }

        public String Puerto
        {
            get { return _Puerto; }
            set { _Puerto = value; }
        }

        public String Usuario
        {
            get { return _Usuario; }
            set { _Usuario = value; }
        }

        public String Contrasenia
        {
            get { return _contrasenia; }
            set { _contrasenia = value; }
        }


        public String Instancia
        {
            get { return _Instancia; }
            set { _Instancia = value; }
        }

        public Boolean IndicarInstancia
        {
            get { return _IndicarInstancia; }
            set { _IndicarInstancia = value; }
        }

        public Boolean HabilitarInstancia
        {
            get { return _HabilitarInstancia; }
            set { _HabilitarInstancia = value; }
        }

        public Boolean IndicarPuerto
        {
            get { return _IndicarPuerto; }
            set { _IndicarPuerto = value; }
        }

    }
}
