using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
 
using System.Data.SqlClient;

namespace AdventuresInCrud_Miller
{
    public partial class GreenForm : Form
    {
        public GreenForm()
        {
            InitializeComponent();
            getGreenData();
        }

        private void getGreenData()
        {
            using (SqlConnection conn = new SqlConnection(db.getConnection()))
            {
                // change order of GreenView columns for better layout
                SqlCommand cmd = new SqlCommand("GreenView", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();
                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                dataGridView1.DataSource = dt;
            }
        }
    }
}
