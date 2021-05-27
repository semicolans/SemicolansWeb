using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace eCommerce.UserSite
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["SCustomerFirstName"] == null)
            {
                lblCustomerName.Text = "";
                lblCustomerNameFooter.Text = "";
                btnLogin.Visible = true;
                btnRegister.Visible = true;
                AccountMenu.Visible = false;
                lblCustomerName.Visible = false;
                lblCustomerNameFooter.Visible = false;
                CustomerMenuFooter.Visible = false;
                btnCustomerLogin.Visible = true;
                CustomerAcMenuFooter.Visible = false;
            }
            else
            {
                lblCustomerName.Visible = true;
                lblCustomerNameFooter.Visible = true;
                btnLogin.Visible = false;
                btnRegister.Visible = false;
                lblCustomerName.Text = "Welcome " + Session["SCustomerFirstName"].ToString();
                lblCustomerNameFooter.Text = "Welcome " + Session["SCustomerFirstName"].ToString();
                AccountMenu.Visible = true;
                CustomerMenuFooter.Visible = true;
                btnCustomerLogin.Visible = false;
                CustomerAcMenuFooter.Visible = true;
            }

            DataTable dt = new DataTable();
            dt = (DataTable)Session["ShoppingCard"];
            if (dt != null)
            {
                lblEmptyShoppingCard.Visible = false;
                lblEmptyShoppingCardFooter.Visible = false;
                btnCheckOut.Visible = true;
                btnViewCard.Visible = true;
                btnCheckOutFooter.Visible = true;
                btnViewCardFooter.Visible = true;
                lblShoppingQty.Text = dt.Rows.Count.ToString();
                lblShoppingQtyFooter.Text = dt.Rows.Count.ToString();
                //lblShoppingTotal.Text = GrandTotal().ToString("##,0.00");

                grdShoppingCard.DataSource = dt;
                grdShoppingCard.DataBind();

                grdShoppingCardFooter.DataSource = dt;
                grdShoppingCardFooter.DataBind();
            }
            else
            {
                lblEmptyShoppingCard.Visible = true;
                btnCheckOut.Visible = false;
                btnViewCard.Visible = false;
                btnCheckOutFooter.Visible = false;
                btnViewCardFooter.Visible = false;
                lblShoppingQty.Text = "0";
                lblEmptyShoppingCardFooter.Visible = true;
                lblShoppingQtyFooter.Text = "0";
                //lblShoppingTotal.Text = "0.00";
            }
        }

        public double GrandTotal()
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["ShoppingCard"];
            int nrow = dt.Rows.Count;
            int i = 0;
            double gtotal = 0;
            while (i < nrow)
            {
                gtotal = gtotal + Convert.ToDouble(dt.Rows[i]["TotalPrice"].ToString());

                i = i + 1;
            }
            return gtotal;
        }

        protected void btnViewCard_Click(object sender, EventArgs e)
        {
            Response.Redirect("ShoppingCard.aspx");
        }

        protected void grdShoppingCard_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteShoppingItem")
            {

                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ';' });
                string RequestedSerialNo = commandArgs[0];

                DataTable dt = new DataTable();
                dt = (DataTable)Session["ShoppingCard"];
                if (dt != null)
                {
                    int index = Convert.ToInt32(RequestedSerialNo);
                    dt.Rows[index].Delete();
                    Session["ShoppingCard"] = dt;

                    Response.Redirect("DisplayAllProducts.aspx");
                }
            }
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            Response.Redirect("CheckOutPage.aspx");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Session["CustomerRegistrationCallFrom"] = "Home";
            Response.Redirect("CustomerRegistrationForm.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["SCustomerFirstName"] = null;
            Session["SCustomerID"] = null;
            Response.Redirect("DisplayAllProducts.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Session["CustomerLoginCallFrom"] = "Home";
            Response.Redirect("CustomerLogin.aspx");
        }

        protected void btnViewCardFooter_Click(object sender, EventArgs e)
        {
            Response.Redirect("ShoppingCard.aspx");
        }

        protected void btnCheckOutFooter_Click(object sender, EventArgs e)
        {
            Response.Redirect("CheckoutPage.aspx");
        }
    }
}

