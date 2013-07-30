<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditCourse.aspx.cs" Inherits="CloudEDUServer.adminconsole.EditCourse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/text.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/layout.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/usercss.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <link href="css/table/demo_page.css" rel="stylesheet" type="text/css" />
    <!-- BEGIN: load jquery -->
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery-ui/jquery.ui.core.min.js"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.slide.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <script src="js/table/jquery.dataTables.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->

    <!-- BEGIN: load jqplot -->
    <link rel="stylesheet" type="text/css" href="css/jquery.jqplot.min.css" />
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="js/jqPlot/excanvas.min.js"></script><![endif]-->
    <script language="javascript" type="text/javascript" src="js/jqPlot/jquery.jqplot.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.barRenderer.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.pieRenderer.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.highlighter.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.pointLabels.min.js"></script>
    <!-- END: load jqplot -->

    <!--jQuery Date Picker-->
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.progressbar.min.js" type="text/javascript"></script>
    <!-- jQuery dialog related-->
    <script src="js/jquery-ui/external/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.draggable.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.position.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.resizable.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.dialog.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.blind.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.explode.min.js" type="text/javascript"></script>
    <!-- jQuery dialog end here-->
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>

    <!--Fancy Button-->
    <script src="js/fancy-button/fancy-button.js" type="text/javascript"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <!-- Load TinyMCE -->
    <script src="js/tiny-mce/jquery.tinymce.js" type="text/javascript"></script>

    <script type="text/javascript" src="js/table/table.js"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <script src="js/MD5.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            setupLeftMenu();
            setSidebarHeight();
            document.getElementById("type").value = "<%=Session["editType"]%>";
            <%Session["editType"] = null;%>
        });

        
        var isUpdate = false;
        function editCourse(id) {
            if (isUpdate) {
                alert("数据跟新中，请稍后");
                return;
            }
            isUpdate = true;

            var title = document.getElementById("title").value;
            var intro = document.getElementById("intro").value;
            var price = document.getElementById("price").value;
            var category = document.getElementById("category").value;
                    jQuery.post("EditCourse.aspx", {id:id, title: title, intro: intro, price: price, category: category }, function (data) {
                        if (data == "success") {
                            isUpdate = false;
                            alert("课程编辑成功");
                            window.location.href = "Default.aspx";
                            return;
                        }
                        else {
                            alert(data);
                            isUpdate = false;
                        }
                    });
        }

        function checkStr(str) {
            var reg = /[^A-Za-z0-9_]/;
            if (reg.test(str)) return false;
            else return true;
        }

        var isShow = false;
        function showNewCategory() {
            if (isShow) {
                $("#NewCategory").hide();
                document.getElementById('showNewCategoryButton').innerHTML = "Add Category";
                isShow = false;
            }
            else {
                $("#NewCategory").show();
                document.getElementById('showNewCategoryButton').innerHTML = "Cancel Category";
                isShow = true;
            }
        }

        var isPost = false;
        function submitNewCategory(courseId) {
            if (isPost) {
                alert("正在更新中，请稍后");
                return;
            }
            isPost = true;
            jQuery.post("EditCourse.aspx", { operate: "new",id:courseId, title: document.getElementById("NewCategoryTitle").value }, function (data) {
                if (data == "success") {
                    document.getElementById("NewCategoryTitle").value = "";
                    alert("新建成功");
                    window.location.href = "EditCourse.aspx";
                }
                else {
                    alert(data);
                }
                isPost = false;
            })
        }

   </script>
</head>
<body id="Body1" class="Body1" runat="server">
   <div class="container_12">
        <!--#include file="Navigation.aspx" -->
        <%
            if (!ManagerAccess.haveCourseEditPermission((MANAGER)Session["manager"]))
            {
                Response.Redirect("Default.aspx");
                Response.End();
            }
        %>

       <%
           
           if (Session["editCourse"] == null)
           {
               Response.Redirect("Default.aspx"); 
           } 
           COURSE course=(COURSE) Session["editCourse"];
           Session["editCourse"] = null;
       %>
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2> Edit Course</h2>

                <br />
                 <button onclick="showNewCategory()" style="float:right" id="showNewCategoryButton">Add Category</button>
                <br/>
                <br />
                <table id="NewCategory" style="float:right; display:none; z-index:100;">
                    <tr>
                        <td class="col1">
                            <label>Title</label>
                        </td>
                        <td class="col2">
                            <input type="text" id="NewCategoryTitle" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td style="text-align:right">
                            <button onclick="submitNewCategory(<%=course.ID %>)">确认</button>
                        </td>
                    </tr>
                </table>
                <div class="block ">
                    <form>
                    <table class="form">
                        <tr>
                            <td>
                                <label>Title</label>
                            </td>
                            <td>
                                <input type="text" value="<%=course.TITLE %>" class="success" id="title"/>      
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Description</label>
                             </td>
                            <td>
                                <textarea style="width:300px; height:100px;" id="intro">
                                    <%=course.INTRO %>
                                </textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>Price</label>
                            </td>
                            <td>
                                <input type="text" value="<%=course.PRICE.ToString().Substring(0,course.PRICE.ToString().Length-2) %>"  id="price" />
                            </td>
                        </tr>


                        <tr>
                            <td>
                                 <label>category</label>
                            </td>
                            <td>
                                <select id="category" name="select">
                                    <%
                                       CATEGORY []category=CourseAccess.GetAllCategories();
                                       for (int i=0; i<category.Length; i++)
                                       { 
                                    %>
                                        <option value="<%=i %>"><%=category[i].CATE_NAME %></option>
                                    <%}%>
                                </select>
                                <script>
                                    <%
                                    int cateId=0;
                                    for (int i = 0; i < category.Length; i++)
                                    {
                                        if (category[i].ID == (int)course.CATEGORY)
                                        {
                                            cateId = i;
                                            break;
                                        }
                                    }
                                    %>
                                    document.getElementById('category').value='<%=cateId%>';
                                </script>
                            </td>
                        </tr>                            
                    </table>  
                    </form>
                    <button onclick="editCourse(<%=course.ID %>)" style="margin-left:250px;">确认</button>
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear">
    </div>
    <div id="site_info">
        <p>
            Copyright <a href="#">Cloud Edu</a>. All Rights Reserved.
        </p>
    </div>
</body>
</html>
