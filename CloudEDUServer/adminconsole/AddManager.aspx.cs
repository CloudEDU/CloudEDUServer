﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class AddManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string account = Request.Params.Get("account");
                string password = Request.Params.Get("password");
                if (account == null || password == null)
                {
                    return;
                }

                MANAGER manager;
                try
                {
                    manager = ManagerAccess.GetManagerByName(account);
                }
                catch
                {
                    Response.Write("连接错误，请重新试");
                    Response.End();
                    return;
                }
                if (manager != null)
                {
                    Response.Write("该账号已经存在");
                    Response.End();
                }


                MANAGER newManager = new MANAGER();
                newManager.NAME = account;
                newManager.PASSWORD = password;
                if (ManagerAccess.AddManager(newManager))
                {
                    Response.Write("success");
                    Response.End();
                }
                else
                {
                    Response.Write("新建管理员失败,请重试");
                    Response.End();
                }
            }
            catch
            {
            }
        }
    }
}