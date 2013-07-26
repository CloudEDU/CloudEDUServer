<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="CloudEDUServer.adminconsole.EditUser" %>

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

    <script src="js/setup.js" type="text/javascript"></script>
    <script src="js/MD5.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            setupLeftMenu();
            setSidebarHeight(); 
        });


        var isUpdate = false;
        var id=<%=Request.Params.Get("id")%>
        function editUser() {
            if (isUpdate) {
                alert("操作中，请稍后");
                return;
            }
            isUpdate = true;

            if (confirm("确认编辑该用户吗")) {
                var account = document.getElementById("account").value;
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var degree = document.getElementById("degree").value;
                var email = document.getElementById("email").value;
                var birthday = document.getElementById("birthday").value;
             
                var isNewPassword = false;
                if (password != "" || confirmPassword != "") isNewPassword = true;

                if (isNewPassword && !checkStr(password)) {
                    alert("密码只能由大小写字母、数字、下划线组成");
                    isUpdate = false;
                    return;
                }
                if (isNewPassword && password != confirmPassword) {
                    alert("两次密码不一致");
                    isUpdate = false;
                    return;
                }
                else{

                    if (!checkEmail(email)) {
                        alert("邮箱错误");
                        isUpdate = false;
                        return;
                    }
                    if (!checkBirthday(birthday)) {
                        alert("日期格式错误");
                        isUpdata = false;
                        return;
                    }
                    if (isNewPassword) {
                        password = hex_md5(password);
                    }
                    jQuery.post("EditUser.aspx", {id:id, account: account, password: password, degree:degree,email:email,birthday:birthday }, function (data) {
                        if (data == "success") {
                            isUpdate = false;
                            alert("管理员编辑成功");
                            window.location.href = "Default.aspx";
                            return;
                        }
                        else {
                            alert(data);
                            isUpdate = false;
                        }
                    });
                }
            }
            else {
                isUpdate = false;
            }
        }

        function checkStr(str) {
            var reg = /[^A-Za-z0-9_]/;
            if (reg.test(str)) return false;
            else return true;
        }

        function checkEmail(str) {
            var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
            if (!myreg.test(str)) {
                return false;
            }
            else return true;
        }

        function checkBirthday(str) {
            try{
                var year =parseInt( str.substr(0, 4) );
                    
                if (year<1900 || year>2013) return false;

                var month;
                if (str[6]== '/') month = str[5];
                else month =parseInt( str.substr(5, 2) );
                if (month<1 || month>12) return false;

                var day;
                if (str[str.length - 2] == '/')  day =parseInt( str[str.length - 1]);
                else day = parseInt(str.substr(str.length - 2, 2));

                switch (month)
                {
                    case 1, 3, 5, 7, 8, 10, 12:
                        if (day > 31) return false;
                        break;
                    case 4, 6, 9, 11:
                        if (day > 30) return false;
                    case 2:
                        if (year % 400 == 0 || (year % 400 != 0 && year % 4 == 0)) {
                            if (day > 29) return false;
                        }
                        else if (day > 28) return false;
                }

                if (day < 0) return false;
                return true;
            }
            catch (e) {
                return false;
            }
        }
    </script>

</head>
<body id="Body1" runat="server">
    <div class="container_12">    
        <!--#include file="Navigation.aspx" -->

        <div class="grid_10">
            <div class="box round first grid">
                <%
                    CUSTOMER customer = null; 
                    try
                    {
                        customer = CustomerAccess.GetCustomerByID(int.Parse(Request.Params.Get("id")));
                    }
                    catch
                    {
                    }
                    finally
                    {
                        if (customer == null)
                        {
                            Response.Redirect("Default.aspx");
                            Response.End();
                        }
                        else
                        {
                %>
                            <form>
                            <table class="form">
                                <tr>
                                    <td>
                                        <label>账号</label>
                                    </td>
                                    <td>
                                        <input type="text" readonly value="<%=customer.NAME %>" maxlength="14" class="success" id="account"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>密码</label>
                                    </td>
                                    <td>
                                        <input type="password" maxlength="14"  id="password" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>确认密码</label>
                                    </td>
                                    <td>
                                        <input type="password"  maxlength="14" id="confirmPassword" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                         <label>Balance</label>
                                    </td>
                                    <td>
                                        <label><%=customer.BALANCE %></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                         <label>Degree</label>
                                    </td>
                                    <td>
                                        <select id="degree"  name="select">
                                            <option value="grad">Grad</option>
                                            <option value="undergrad">Undergrad</option>
                                            <option value="senior high">Senior High</option>
                                            <option value="junior high">Junior High</option>
                                            <option value="primaryschool">Primary School</option>
                                            <option value="lower">Lower</option>
                                        </select>
                                        <script>
                                            document.getElementById("degree").value = '<%=customer.DEGREE.Trim().ToLower() %>';     
                                        </script>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>EMail</label>
                                    </td>
                                    <td>
                                        <input type="text" id="email" value="<%=customer.EMAIL %>" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Birthday</label>
                                    </td>
                                    <td>
                                        <input type="text" id="birthday" value="<%=customer.BIRTHDAY.Year.ToString()+'/'+customer.BIRTHDAY.Month.ToString()+'/'+customer.BIRTHDAY.Day.ToString() %>"/>
                                    </td>
                                </tr>
                            </table>  
                            </form>
                            <button onclick="editUser()">确认</button>
                        <%        
                            }
                         }
                        %>

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
