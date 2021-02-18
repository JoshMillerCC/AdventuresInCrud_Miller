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
    public partial class YellowForm : Form
    {
        public YellowForm()
        {
            InitializeComponent();
            getYellowData();
        }

        private void getYellowData()
        {
            using (SqlConnection conn = new SqlConnection(db.getConnection()))
            {
                // change order of GreenView columns for better layout
                SqlCommand cmd = new SqlCommand("YellowView", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                conn.Open();
                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                YellowDataGrid.DataSource = dt;
            }
        }

        private void DeleteButton_Click(object sender, EventArgs e)
        {
            if(DeleteTextBox.Text == null || DeleteTextBox.Text == string.Empty)
            {
                DeleteTextBox.Text = "Invalid CustomerID";
                return;
            }
            else
            {
                int ID = Convert.ToInt32(DeleteTextBox.Text);
                using (SqlConnection conn = new SqlConnection(db.getConnection()))
                {
                    SqlCommand cmd = new SqlCommand("DeleteCustomer", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", ID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                getYellowData();
            }
            
        }

        // update doesn't work on the first few hundred people due to them not having
        // an addressID for us to compare to when updating.
        private void UpdateButton_Click(object sender, EventArgs e)
        {
            int ID = Convert.ToInt32(CustomerIDTextBox.Text);
            string title = TitleTextBox.Text;
            string firstname = FirstNameTextBox.Text;
            string middlename = MiddleNameTextBox.Text;
            string lastname = LastNameTextBox.Text;
            string suffix = SuffixTextBox.Text;
            string companyname = CompanyNameTextBox.Text;
            string salesperson = SalesPersonTextBox.Text;
            string emailaddress = EmailAddressTextBox.Text;
            string phone = PhoneNumberTextBox.Text;
            string addresstype = AddressTypeTextBox.Text;
            string addressline1 = AddressLine1TextBox.Text;
            string addressline2 = AddressLine2TextBox.Text;
            string city = CityTextBox.Text;
            string stateprovince = StateProcinceTextBox.Text;
            string countryregion = CountryRegionTextBox.Text;
            string postalcode = PostalCodeTextBox.Text;

            using (SqlConnection conn = new SqlConnection(db.getConnection()))
            {
                SqlCommand cmd = new SqlCommand("UpdateCustomerAddress", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", ID);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@firstname", firstname);
                cmd.Parameters.AddWithValue("@middlename", middlename);
                cmd.Parameters.AddWithValue("@lastname", lastname);
                cmd.Parameters.AddWithValue("@suffix", suffix);
                cmd.Parameters.AddWithValue("@companyname", companyname);
                cmd.Parameters.AddWithValue("@salesperson", salesperson);
                cmd.Parameters.AddWithValue("@emailaddress", emailaddress);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.Parameters.AddWithValue("@addresstype", addresstype);
                cmd.Parameters.AddWithValue("@addressline1", addressline1);
                cmd.Parameters.AddWithValue("@addressline2", addressline2);
                cmd.Parameters.AddWithValue("@city", city);
                cmd.Parameters.AddWithValue("@stateprovince", stateprovince);
                cmd.Parameters.AddWithValue("@countryregion", countryregion);
                cmd.Parameters.AddWithValue("@postalcode", postalcode);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
            getYellowData();
        }

        private void GetInfoButton_Click(object sender, EventArgs e)
        {
            int ID = Convert.ToInt32(CustomerIDTextBox.Text);
            using (SqlConnection conn = new SqlConnection(db.getConnection()))
            {
                SqlCommand cmd = new SqlCommand("getinfo", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", ID);
                conn.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                sdr.Read();
                TitleTextBox.Text = sdr.GetValue(0).ToString();
                FirstNameTextBox.Text = sdr.GetValue(1).ToString();
                MiddleNameTextBox.Text = sdr.GetValue(2).ToString();
                LastNameTextBox.Text = sdr.GetValue(3).ToString();
                SuffixTextBox.Text = sdr.GetValue(4).ToString();
                CompanyNameTextBox.Text = sdr.GetValue(5).ToString();
                SalesPersonTextBox.Text = sdr.GetValue(6).ToString();
                EmailAddressTextBox.Text = sdr.GetValue(7).ToString();
                PhoneNumberTextBox.Text = sdr.GetValue(8).ToString();
                AddressTypeTextBox.Text = sdr.GetValue(9).ToString();
                AddressLine1TextBox.Text = sdr.GetValue(10).ToString();
                AddressLine2TextBox.Text = sdr.GetValue(11).ToString();
                CityTextBox.Text = sdr.GetValue(12).ToString();
                StateProcinceTextBox.Text = sdr.GetValue(13).ToString();
                CountryRegionTextBox.Text = sdr.GetValue(14).ToString();
                PostalCodeTextBox.Text = sdr.GetValue(15).ToString();
            }

        }

        private void AddButton_Click(object sender, EventArgs e)
        {
            string title = TitleTextBox.Text;
            string firstname = FirstNameTextBox.Text;
            string middlename = MiddleNameTextBox.Text;
            string lastname = LastNameTextBox.Text;
            string suffix = SuffixTextBox.Text;
            string companyname = CompanyNameTextBox.Text;
            string salesperson = SalesPersonTextBox.Text;
            string emailaddress = EmailAddressTextBox.Text;
            string phone = PhoneNumberTextBox.Text;
            string addresstype = AddressTypeTextBox.Text;
            string addressline1 = AddressLine1TextBox.Text;
            string addressline2 = AddressLine2TextBox.Text;
            string city = CityTextBox.Text;
            string stateprovince = StateProcinceTextBox.Text;
            string countryregion = CountryRegionTextBox.Text;
            string postalcode = PostalCodeTextBox.Text;

            using (SqlConnection conn = new SqlConnection(db.getConnection()))
            {
                SqlCommand cmd = new SqlCommand("addNewCustomer", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@firstname", firstname);
                cmd.Parameters.AddWithValue("@middlename", middlename);
                cmd.Parameters.AddWithValue("@lastname", lastname);
                cmd.Parameters.AddWithValue("@suffix", suffix);
                cmd.Parameters.AddWithValue("@companyname", companyname);
                cmd.Parameters.AddWithValue("@salesperson", salesperson);
                cmd.Parameters.AddWithValue("@emailaddress", emailaddress);
                cmd.Parameters.AddWithValue("@phone", phone);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            using(SqlConnection conn = new SqlConnection(db.getConnection()))
            {
                SqlCommand cmd = new SqlCommand("addNewAddress", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@addressline1", addressline1);
                cmd.Parameters.AddWithValue("@addressline2", addressline2);
                cmd.Parameters.AddWithValue("@city", city);
                cmd.Parameters.AddWithValue("@stateprovince", stateprovince);
                cmd.Parameters.AddWithValue("@countryregion", countryregion);
                cmd.Parameters.AddWithValue("@postalcode", postalcode);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            
            using (SqlConnection conn = new SqlConnection(db.getConnection()))
            {
                SqlCommand cmd = new SqlCommand("addNewCustomerAddress", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@addresstype", addresstype);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            getYellowData();
        }
    }
}
