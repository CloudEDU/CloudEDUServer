using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class EditUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string account = Request.Params.Get("account");
                if (account == null)
                {
                    return;
                }

                CUSTOMER customer = null;
                try
                {
                    customer=CustomerAccess.GetCustomerByID(int.Parse(Request.Params.Get("id")));
                }
                catch
                {
                    Response.Write("用户不存在");
                    Response.End();
                }
                if (customer == null)
                {
                    Response.Write("用户不存在");
                    Response.End();
                }

                string password = Request.Params.Get("password");
                string email = Request.Params.Get("email");
                string birthday = Request.Params.Get("birthday");
                string degree = Request.Params.Get("degree");

                if (password != null || !password.Equals(""))
                {
                    customer.PASSWORD = password;
                }
                customer.EMAIL = email;
                customer.DEGREE = degree;

                try
                {
                    if (birthday[6] == '/') birthday=birthday.Insert(5, "0");
                    if (birthday.Length < 10) birthday = birthday.Insert(8,"0");
                    DateTime dt=Convert.ToDateTime(birthday);
                    customer.BIRTHDAY = dt;
                   
                }
                catch{
                    Response.Write("日期有误");
                    Response.End();
                }
                try
                {
                    CustomerAccess.UpdateCustomer(customer);
                }
                catch
                {
                    Response.Write("编辑错误");
                    Response.End();
                }
                Response.Write("success");
                Response.End();

            }
            catch
            {
            }
        }
    }
}