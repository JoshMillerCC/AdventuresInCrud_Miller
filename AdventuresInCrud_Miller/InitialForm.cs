using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;

namespace AdventuresInCrud_Miller
{
    public partial class InitialForm : Form
    {
        GreenForm gf = new GreenForm();
        YellowForm yf = new YellowForm();
        public InitialForm()
        {
            InitializeComponent();
        }

        private void greenButton_Click(object sender, EventArgs e)
        {
            this.Visible = false;
            gf.ShowDialog();
            this.Visible = true;
        }

        private void yellowButton_Click(object sender, EventArgs e)
        {
            this.Visible = false;
            yf.ShowDialog();
            this.Visible = true;
        }
    }
}
