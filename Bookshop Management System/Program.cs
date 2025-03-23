using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Bookshop
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            // Khởi tạo và hiển thị frmLogin trước
            Login loginForm = new Login();
            if (loginForm.ShowDialog() == DialogResult.OK)
            {
                // Nếu đăng nhập thành công, mở frmMenu
                Application.Run(new Menu());
            }
        }
    }
}
