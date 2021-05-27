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
    public partial class WebForm3 : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetShoppingCarddetails();
            }
        }

        void GetShoppingCarddetails()
        {
            DataTable dt = new DataTable();
            DataRow dr;

            if (Session["ShoppingCard"] == null)
            {

                dt = (DataTable)Session["ShoppingCard"];
                grdShoppingCard.DataSource = dt;
                grdShoppingCard.DataBind();

                if (grdShoppingCard.Rows.Count > 0)
                {
                    lblSubTotal.Text = GrandTotal().ToString("##,0.00");
                    lblNetTotal.Text = GrandTotal().ToString("##,0.00");
                }


                grdShoppingCardMob.DataSource = dt;
                grdShoppingCardMob.DataBind();

            }
            else
            {
                dt = (DataTable)Session["ShoppingCard"];
                int SerialNo;
                SerialNo = dt.Rows.Count;

                dr = dt.NewRow();
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_ItemDet WHERE ItemCode='" + Request.QueryString["RequestedItemcode"] + "' ";
                cmd.Connection = con;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);

                grdShoppingCard.DataSource = dt;
                grdShoppingCard.DataBind();

                grdShoppingCardMob.DataSource = dt;
                grdShoppingCardMob.DataBind();

                Session["ShoppingCard"] = dt;
                lblSubTotal.Text = GrandTotal().ToString("##,0.00");
                lblNetTotal.Text = GrandTotal().ToString("##,0.00");

            }

            DataTable dt1 = new DataTable();
            dt1 = (DataTable)Session["ShoppingCard"];

            if (dt1 != null)
            {
                lblEmptyShoppingCard.Visible = false;
                lblEmptyShoppingCardMob.Visible = false;
                btnCheckOut.Visible = true;
                btnRemoveAll.Visible = true;
            }
            else
            {
                lblEmptyShoppingCard.Visible = true;
                lblEmptyShoppingCardMob.Visible = true;
                btnCheckOut.Visible = false;
                lblSubTotal.Text = "0.00";
                lblNetTotal.Text = "0.00";
                btnRemoveAll.Visible = false;
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

        protected void btnShopping_Click1(object sender, EventArgs e)
        {
            Response.Redirect("DisplayAllProducts.aspx");
        }

        protected void grdShoppingCard_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string RequestedSerialNo = "";
            int index = 1;
            if (e.CommandName == "DeleteShoppingItem")
            {

                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ';' });
                RequestedSerialNo = commandArgs[0];
                //Response.Redirect("DisplayProductDetails.aspx?RequestedItemCode=" + commandArgs[0].ToString() + "& RequestedItemCategory =" + commandArgs[1].ToString() + "& RequestedItemSubCategory =" + commandArgs[2].ToString());

                DataTable dt = new DataTable();
                dt = (DataTable)Session["ShoppingCard"];
                if (dt != null)
                {
                    index = Convert.ToInt32(RequestedSerialNo);
                    dt.Rows[index].Delete();
                    Session["ShoppingCard"] = dt;

                    GetShoppingCarddetails();
                    Response.Redirect("ShoppingCard.aspx");
                    
                }
            }
            if (e.CommandName == "PlusQty")
            {

                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ';' });
                RequestedSerialNo = commandArgs[0].ToString();
                //Response.Redirect("DisplayProductDetails.aspx?RequestedItemCode=" + commandArgs[0].ToString() + "& RequestedItemCategory =" + commandArgs[1].ToString() + "& RequestedItemSubCategory =" + commandArgs[2].ToString());

                DataTable dt = new DataTable();
                dt = (DataTable)Session["ShoppingCard"];
                if (dt != null)
                {
                    index = Convert.ToInt32(commandArgs[0].ToString());
                    double Quantity = Convert.ToDouble(dt.Rows[index]["Qty"]);
                    double DPrice = Convert.ToDouble(dt.Rows[index]["ItemDPrice"]);
                    double SPrice = Convert.ToDouble(dt.Rows[index]["ItemSPrice"]);
                    double TotalPrice = 0;
                    Quantity = Quantity + 1;
                    if (DPrice == 0)
                    {
                        TotalPrice = SPrice * Quantity;
                    }
                    else
                    {
                        TotalPrice = DPrice * Quantity;
                    }

                    dt.Rows[index]["Qty"] = Quantity;
                    dt.Rows[index]["TotalPrice"] = string.Format("{0:#,#.00}", TotalPrice);

                    Session["ShoppingCard"] = dt;

                    GetShoppingCarddetails();
                    Response.Redirect("ShoppingCard.aspx");
                    
                }
            }
            if (e.CommandName == "MinusQty")
            {

                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ';' });
                RequestedSerialNo = commandArgs[0].ToString();
                //Response.Redirect("DisplayProductDetails.aspx?RequestedItemCode=" + commandArgs[0].ToString() + "& RequestedItemCategory =" + commandArgs[1].ToString() + "& RequestedItemSubCategory =" + commandArgs[2].ToString());

                DataTable dt = new DataTable();
                dt = (DataTable)Session["ShoppingCard"];
                if (dt != null)
                {
                    index = Convert.ToInt32(commandArgs[0].ToString());
                    double Quantity = Convert.ToDouble(dt.Rows[index]["Qty"]);
                    double DPrice = Convert.ToDouble(dt.Rows[index]["ItemDPrice"]);
                    double SPrice = Convert.ToDouble(dt.Rows[index]["ItemSPrice"]);
                    double TotalPrice = 0;
                    Quantity = Quantity - 1;
                    if (DPrice == 0)
                    {
                        TotalPrice = SPrice * Quantity;
                    }
                    else
                    {
                        TotalPrice = DPrice * Quantity;
                    }    
                    if (Quantity<=0)
                    {
                        dt.Rows[index].Delete();
                    }
                    else
                    {
                        dt.Rows[index]["Qty"] = Quantity;
                        dt.Rows[index]["TotalPrice"] = string.Format("{0:#,#.00}", TotalPrice); ;
                    }
                    Session["ShoppingCard"] = dt;

                    GetShoppingCarddetails();
                    Response.Redirect("ShoppingCard.aspx");

                }
            }
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            Response.Redirect("CheckoutPage.aspx");
        }
    }
}