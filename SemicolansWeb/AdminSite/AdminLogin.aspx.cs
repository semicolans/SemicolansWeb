using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce.AdminSite
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State==ConnectionState.Closed)
                {
                    con.Open();
                }
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_UserAccounts WHERE UserName = '{ txtUserName.Text }' AND UserPassword = '{ txtPassword.Text }' ";
                cmd.Connection = con;

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        Response.Write("<script> alert('Login Successful.');</script>");
                        Session["SUserType"] = dr.GetValue(7).ToString();
                        //Session["SCompanyID"] = dr.GetValue(2).ToString();
                        //Session["SCompanyName"] = dr.GetValue(3).ToString();
                        //Session["SCompanyKeyword"] = dr.GetValue(4).ToString();
                        Session["SUserEmailID"] = dr.GetValue(4).ToString();
                        Session["SUserCompleteName"] = dr.GetValue(3).ToString();
                    }
                    Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    Response.Write("<script> alert('Invalid User Details.');</script>");
                }
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

    }
}