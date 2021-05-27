using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce.UserSite
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            txtUserName.Focus();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_OrderCustomerDet WHERE Email = '{ txtUserName.Text }' AND Password = '{ txtPassword.Text }' AND Status='Active' ";
                cmd.Connection = con;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count >= 1)
                {
                    Response.Write("<script> alert('Login Successful.');</script>");
                    Session["SCustomerID"] = dt.Rows[0]["CustomerID"].ToString();
                    Session["SCustomerFirstName"] = dt.Rows[0]["FirstName"].ToString();
                    Response.Redirect("DisplayAllProducts.aspx", false);
                }
                else
                {
                    Response.Write("<script>alert('Invalid User Details');</script>");
                }               
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}