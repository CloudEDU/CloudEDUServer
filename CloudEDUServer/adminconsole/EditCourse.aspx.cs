﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class EditCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                COURSE course=null;
                try
                {
                    string idStr = Request.Params.Get("id");
                    if (idStr == null || idStr == "") return;
                    int id = int.Parse(idStr);
                    course = CourseAccess.GetCourseById(id);
                }
                catch
                {
                    Response.Write("账号不存在");
                    Response.End();
                }
                if (course == null)
                {
                    Response.Write("账号不存在");
                    Response.End();
                }
                course.TITLE = Request.Params.Get("title");
                course.INTRO = Request.Params.Get("intro");
                try
                {
                    course.PRICE = decimal.Parse(Request.Params.Get("price"));
                }
                catch
                {
                    Response.Write("价格错误");
                    Response.End();
                }
                try
                {
                    CATEGORY[] category=CourseAccess.GetAllCategories();
                    int categoryInt=int.Parse(Request.Params.Get("category"));
                    course.CATEGORY = category[categoryInt].ID;
                }
                catch
                {
                    Response.Write("类型错误");
                    Response.End();
                }
                
                try
                {
                    CourseAccess.UpdateCourse(course);
                }
                catch
                {
                    Response.Write("连接错误");
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