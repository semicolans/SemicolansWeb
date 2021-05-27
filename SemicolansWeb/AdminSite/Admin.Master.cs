using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce.AdminSite
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["SUserCompleteName"].Equals(""))
                {

                }
                else
                {
                    lblUserName.Text = Session["SUserCompleteName"].ToString() + " " + Session["SUserEmailID"].ToString();
                    //lblCompanyID.Text = Session["SCompanyName"].ToString();
                }
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            Session["SUserType"] = "";
            Session["SCompanyID"] = "";
            Session["SUserEmailID"] = "";
            Session["SUserCompleteName"] = "";
            Response.Write("<script> alert('Logout Successful.');</script>");
            Response.Redirect("../UserSite/DisplayAllProducts.aspx");
        }
    }
}