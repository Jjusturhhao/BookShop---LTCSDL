using Microsoft.Win32;
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

namespace Bookshop
{
    public partial class Login : Form
    {
        private SqlConnection con = new SqlConnection("Data Source=.;Initial Catalog=BookStoreManagement;Integrated Security=True;TrustServerCertificate=True");
        public Login()
        {
            InitializeComponent();
        }


        private void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string role = AuthenticateUser(username, password); // Kiểm tra tài khoản

            if (role == "Admin")
            {
                MessageBox.Show("Đăng nhập thành công! Chào mừng Admin!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.DialogResult = DialogResult.OK;
                this.Close(); // Đóng form Login
            }
            else if (role == "Customer")
            {
                MessageBox.Show("Đăng nhập thành công! Chào mừng khách hàng!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                Homepage home = new Homepage();
                home.Show();
                this.Hide(); // Ẩn form Login
            }
            else
            {
                MessageBox.Show("Sai tài khoản hoặc mật khẩu!", "Lỗi đăng nhập", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private string AuthenticateUser(string username, string password)
        {
            string role = null; // Mặc định là null nếu không tìm thấy user

            try
            {
                con.Open();
                string query = "SELECT Role FROM Users WHERE Username = @Username AND Password = @Password";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password); // Kiểm tra trực tiếp mật khẩu

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        role = result.ToString(); // Lấy Role của user
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi hệ thống: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }

            return role; // Trả về vai trò của người dùng (Admin, Customer hoặc null)
        }

    private void btnRegister_Click_1(object sender, EventArgs e)
        {
            Register registerForm = new Register();
            registerForm.ShowDialog(); // Mở form đăng ký
        }
    }
}
