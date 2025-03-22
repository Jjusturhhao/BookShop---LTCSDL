using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Bookshop
{
    public partial class Authors : Form
    {
        public Authors()
        {
            InitializeComponent();
        }
        public int AuthorID;
        SqlConnection con = new SqlConnection("Data Source=.;Initial Catalog=BookStoreManagement;Integrated Security=True;TrustServerCertificate=True");

        private void Authors_Load(object sender, EventArgs e)
        {
            GetAuthorRecords();
            ResetFormControls();
        }
        private void ResetFormControls()
        {
            AuthorID = 0;
            txtAuthorName.Clear();
            txtDescription.Clear();
            txtAuthorID.Text = GenerateNextAuthorID().ToString();
            txtAuthorID.ReadOnly = true;
        }

        private void GetAuthorRecords()
        {
            SqlCommand cmd = new SqlCommand("Select * from Author", con);
            DataTable dt = new DataTable();
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            dt.Load(sdr);
            con.Close();
            AuthorsRecordsDataGridView.DataSource = dt;
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            ResetFormControls();
        }

        private void btnInsert_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Author (AuthorName, Description) VALUES (@AuthorName, @Description)", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@AuthorName", txtAuthorName.Text);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                MessageBox.Show("New Author Record Successfully Saved In The Database", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                GetAuthorRecords();
                ResetFormControls();
            }
            catch (Exception Ex)
            {
                MessageBox.Show(Ex.Message);
            }
        }

        private int GenerateNextAuthorID()
        {
            int nextID = 1; 

            SqlCommand cmd = new SqlCommand("SELECT MAX(AuthorID) FROM Author", con);
            con.Open();
            object result = cmd.ExecuteScalar();
            con.Close();

            if (result != DBNull.Value && result != null)
            {
                nextID = Convert.ToInt32(result) + 1;
            }

            return nextID;
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (AuthorID > 0)
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Author SET AuthorID = @AuthorID, AuthorName = @AuthorName, Description = @Description WHERE AuthorID = @ID", con);
                    cmd.Parameters.AddWithValue("@AuthorID", txtAuthorID.Text);
                    cmd.Parameters.AddWithValue("@AuthorName", txtAuthorName.Text);
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                    cmd.Parameters.AddWithValue("@ID", this.AuthorID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    MessageBox.Show("Author Updated Sucessfully", "Updated", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    GetAuthorRecords();
                    ResetFormControls();
                }
                catch (Exception Ex)
                {
                    MessageBox.Show(Ex.Message);
                }
            }
            else
            {
                MessageBox.Show("Please Select A Author To Update Its Information.", "Select?", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnDel_Click(object sender, EventArgs e)
        {
            if (AuthorID > 0)
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Author WHERE AuthorID = @ID", con);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@ID", this.AuthorID);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                MessageBox.Show("Author Record Deleted Sucessfully", "Deleted", MessageBoxButtons.OK, MessageBoxIcon.Information);
                GetAuthorRecords();
                ResetFormControls();
            }
            else
            {
                MessageBox.Show("Please Select A Author Records To Delete.", "Select?", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void AuthorsRecordsDataGridView_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = AuthorsRecordsDataGridView.Rows[e.RowIndex];
                AuthorID = Convert.ToInt32(row.Cells[0].Value);
                txtAuthorID.Text = row.Cells[0].Value.ToString();
                txtAuthorName.Text = row.Cells[1].Value.ToString();
                txtDescription.Text = row.Cells[2].Value.ToString();
            }
        }
    }
}
