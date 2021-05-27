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
    public partial class WebForm2 : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            DisplayProductDetails();
            DisplayRelatedProducts();

            ClientScript.RegisterStartupScript(this.GetType(), "randomtext", "AutoExpandDescription()", true);
        }

        void DisplayProductDetails()
        {
            try
            {

                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }
                //Get Selected Product Details
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_ItemDet WHERE Status='Active' AND ItemCode='" + Request.QueryString["RequestedItemcode"] + "' ";
                cmd.Connection = con;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                da.Fill(ds);

                dtlProductDetails.DataSource = ds;
                dtlProductDetails.DataBind();

                con.Close();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void DisplayRelatedProducts()
        {
            try
            {

                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                //Get Related Product Details Category And Sub Category Wise
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT TOP 7 * FROM tbl_ItemDet WHERE Status='Active' " +
                    $"AND ItemCategory LIKE '%" + Request.QueryString["RequestedItemCategory"] + "%' " +
                    "AND ItemSubCategory LIKE '%" + Request.QueryString["RequestedItemSubCategory"] + "%' " +
                    "AND ItemCode!='" + Request.QueryString["RequestedItemcode"] + "'";
                cmd.Connection = con;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                da.Fill(ds);

                dtlProductRecords.DataSource = ds;
                dtlProductRecords.DataBind();

                dtlProductRecordsMob.DataSource = ds;
                dtlProductRecordsMob.DataBind();

                dtlProductRecordsTab.DataSource = ds;
                dtlProductRecordsTab.DataBind();

                if (dt.Rows.Count == 0)
                {
                    //Get Related Product Details Category Wise
                    SqlCommand cmd1 = new SqlCommand();
                    cmd1.CommandText = $"SELECT TOP 7 * FROM tbl_ItemDet WHERE Status='Active' " +
                        $"AND ItemCategory LIKE '%" + Request.QueryString["RequestedItemCategory"] + "%' " +
                        "AND ItemCode!='" + Request.QueryString["RequestedItemcode"] + "'";
                    cmd1.Connection = con;

                    SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                    DataTable dt1 = new DataTable();
                    DataSet ds1 = new DataSet();
                    da1.Fill(ds1);

                    dtlProductRecords.DataSource = ds1;
                    dtlProductRecords.DataBind();

                    dtlProductRecordsMob.DataSource = ds1;
                    dtlProductRecordsMob.DataBind();

                    dtlProductRecordsTab.DataSource = ds1;
                    dtlProductRecordsTab.DataBind();

                    if (dt1.Rows.Count == 0)
                    {
                        //Get Related Product All
                        SqlCommand cmd2 = new SqlCommand();
                        cmd2.CommandText = $"SELECT TOP 7 * FROM tbl_ItemDet WHERE Status='Active' " +
                            $"AND ItemCode!='" + Request.QueryString["RequestedItemcode"] + "'";
                        cmd2.Connection = con;

                        SqlDataAdapter da2 = new SqlDataAdapter(cmd2);
                        DataTable dt2 = new DataTable();
                        DataSet ds2 = new DataSet();
                        da2.Fill(ds2);

                        dtlProductRecords.DataSource = ds2;
                        dtlProductRecords.DataBind();

                        dtlProductRecordsMob.DataSource = ds2;
                        dtlProductRecordsMob.DataBind();

                        dtlProductRecordsTab.DataSource = ds2;
                        dtlProductRecordsTab.DataBind();
                    }
                }
                con.Close();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
        protected void dtlProductRecords_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "QuickView")
            {
                //Response.Redirect("DisplayProductDetails.aspx?RequestedItemCode=" + e.CommandArgument.ToString());
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ';' });
                string id = commandArgs[0];
                string CategoryName = commandArgs[1];
                Response.Redirect("DisplayProductDetails.aspx?RequestedItemCode=" + commandArgs[0].ToString() + "& RequestedItemCategory =" + commandArgs[1].ToString() + "& RequestedItemSubCategory =" + commandArgs[2].ToString());
            }

            if (e.CommandName == "AddToCard")
            {

                TextBox Qty = (TextBox)(e.Item.FindControl("txtQty"));
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ';' });
                string RequestedItemCode = commandArgs[0];
                string CategoryName = commandArgs[1];
                double Qty1 = 0;
                if (Convert.ToDouble(Qty.Text) == 0)
                {
                    Qty1 = 1;
                }
                else
                {
                    Qty1 = Convert.ToDouble(Qty.Text);
                }
                double RequestedQty = Qty1;
                //Response.Redirect("DisplayAllProducts.aspx?RequestedItemCode=" + commandArgs[0].ToString() + "& RequestedItemCategory =" + commandArgs[1].ToString() + "& RequestedItemSubCategory =" + commandArgs[2].ToString() + "&RequestedQty=" + Qty.Text.ToString());


                DataTable dt = new DataTable();
                DataRow dr;
                dt.Columns.Add("CompanyID");
                dt.Columns.Add("SerialNo");
                dt.Columns.Add("ItemCode");
                dt.Columns.Add("ItemBarcode");
                dt.Columns.Add("ItemName");
                dt.Columns.Add("ItemCategory");
                dt.Columns.Add("ItemSubCategory");
                dt.Columns.Add("Qty");
                dt.Columns.Add("ItemUprice");
                dt.Columns.Add("ItemSPrice");
                dt.Columns.Add("ItemDprice");
                dt.Columns.Add("TotalPrice");
                dt.Columns.Add("DiscountValue");
                dt.Columns.Add("imgLink1");


                if (RequestedItemCode != null)
                {
                    if (Session["ShoppingCard"] == null)
                    {

                        dr = dt.NewRow();

                        SqlConnection con = new SqlConnection(strcon);
                        if (con.State == ConnectionState.Closed)
                        {
                            con.Open();
                        }

                        SqlCommand cmd = new SqlCommand();
                        cmd.CommandText = $"SELECT * FROM tbl_ItemDet WHERE ItemCode='" + RequestedItemCode + "' ";
                        cmd.Connection = con;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        da.Fill(ds);

                        dr["SerialNo"] = 1;
                        dr["CompanyID"] = ds.Tables[0].Rows[0]["CompanyID"].ToString();
                        dr["ItemCode"] = ds.Tables[0].Rows[0]["ItemCode"].ToString();
                        dr["ItemBarcode"] = ds.Tables[0].Rows[0]["ItemBarcode"].ToString();
                        dr["ItemName"] = ds.Tables[0].Rows[0]["ItemName"].ToString();
                        dr["ItemCategory"] = ds.Tables[0].Rows[0]["ItemCategory"].ToString();
                        dr["ItemSubCategory"] = ds.Tables[0].Rows[0]["ItemSubCategory"].ToString();
                        dr["imgLink1"] = ds.Tables[0].Rows[0]["imgLink1"].ToString();
                        dr["Qty"] = RequestedQty;
                        dr["ItemUPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemUPrice"].ToString());
                        dr["ItemDPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        dr["ItemSPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemSPrice"].ToString());
                        dr["DiscountValue"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["DiscountValue"].ToString());

                        double Price = Convert.ToDouble(ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        double Quantity = Convert.ToDouble(RequestedQty);
                        double TotalPrice = Price * Quantity;
                        dr["TotalPrice"] = string.Format("{0:#,#.00}", TotalPrice);

                        dt.Rows.Add(dr);
                        Session["ShoppingCard"] = dt;
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
                        cmd.CommandText = $"SELECT * FROM tbl_ItemDet WHERE ItemCode='" + RequestedItemCode + "' ";
                        cmd.Connection = con;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        da.Fill(ds);

                        dr["SerialNo"] = SerialNo + 1;
                        dr["CompanyID"] = ds.Tables[0].Rows[0]["CompanyID"].ToString();
                        dr["ItemCode"] = ds.Tables[0].Rows[0]["ItemCode"].ToString();
                        dr["ItemBarcode"] = ds.Tables[0].Rows[0]["ItemBarcode"].ToString();
                        dr["ItemName"] = ds.Tables[0].Rows[0]["ItemName"].ToString();
                        dr["ItemCategory"] = ds.Tables[0].Rows[0]["ItemCategory"].ToString();
                        dr["ItemSubCategory"] = ds.Tables[0].Rows[0]["ItemSubCategory"].ToString();
                        dr["imgLink1"] = ds.Tables[0].Rows[0]["imgLink1"].ToString();
                        dr["Qty"] = RequestedQty;
                        dr["ItemUPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemUPrice"].ToString());
                        dr["ItemDPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        dr["ItemSPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemSPrice"].ToString());
                        dr["DiscountValue"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["DiscountValue"].ToString());

                        double Price = Convert.ToDouble(ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        double Quantity = Convert.ToDouble(RequestedQty);
                        double TotalPrice = Price * Quantity;
                        dr["TotalPrice"] = string.Format("{0:#,#.00}", TotalPrice);

                        dt.Rows.Add(dr);
                        Session["ShoppingCard"] = dt;
                    }
                }
                else
                {
                    dt = (DataTable)Session["ShoppingCard"];
                }
                Response.Redirect("DisplayProductDetails.aspx");
            }
        }

        protected void dtlProductDetails_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "MinusQty")
            {
                TextBox Qty = (TextBox)(e.Item.FindControl("txtQtySingle"));
                Double Qty1 = Convert.ToDouble(Qty.Text);
                if (Qty1 != 0)
                {
                    Qty1 = Qty1 - 1;
                    Qty.Text = Convert.ToString(Qty1);
                }
            }
            if (e.CommandName == "PlusQty")
            {
                TextBox Qty = (TextBox)(e.Item.FindControl("txtQtySingle"));
                Double Qty1 = Convert.ToDouble(Qty.Text);
                if (Qty1 != 100)
                {
                    Qty1 = Qty1 + 1;
                    Qty.Text = Convert.ToString(Qty1);
                }
            }
            if (e.CommandName == "AddToCard")
            {
                TextBox Qty = (TextBox)(e.Item.FindControl("txtQtySingle"));
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ';' });
                string RequestedItemCode = commandArgs[0];
                string CategoryName = commandArgs[1];
                double Qty1 = 0;
                if (Convert.ToDouble(Qty.Text) == 0)
                {
                    Qty1 = 1;
                }
                else
                {
                    Qty1 = Convert.ToDouble(Qty.Text);
                }
                double RequestedQty = Qty1;
                //Response.Redirect("DisplayAllProducts.aspx?RequestedItemCode=" + commandArgs[0].ToString() + "& RequestedItemCategory =" + commandArgs[1].ToString() + "& RequestedItemSubCategory =" + commandArgs[2].ToString() + "&RequestedQty=" + Qty.Text.ToString());


                DataTable dt = new DataTable();
                DataRow dr;
                dt.Columns.Add("CompanyID");
                dt.Columns.Add("SerialNo");
                dt.Columns.Add("ItemCode");
                dt.Columns.Add("ItemBarcode");
                dt.Columns.Add("ItemName");
                dt.Columns.Add("ItemCategory");
                dt.Columns.Add("ItemSubCategory");
                dt.Columns.Add("Qty");
                dt.Columns.Add("ItemUprice");
                dt.Columns.Add("ItemSPrice");
                dt.Columns.Add("ItemDprice");
                dt.Columns.Add("TotalPrice");
                dt.Columns.Add("DiscountValue");
                dt.Columns.Add("imgLink1");


                if (RequestedItemCode != null)
                {
                    if (Session["ShoppingCard"] == null)
                    {

                        dr = dt.NewRow();

                        SqlConnection con = new SqlConnection(strcon);
                        if (con.State == ConnectionState.Closed)
                        {
                            con.Open();
                        }

                        SqlCommand cmd = new SqlCommand();
                        cmd.CommandText = $"SELECT * FROM tbl_ItemDet WHERE ItemCode='" + RequestedItemCode + "' ";
                        cmd.Connection = con;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        da.Fill(ds);

                        dr["SerialNo"] = 1;
                        dr["CompanyID"] = ds.Tables[0].Rows[0]["CompanyID"].ToString();
                        dr["ItemCode"] = ds.Tables[0].Rows[0]["ItemCode"].ToString();
                        dr["ItemBarcode"] = ds.Tables[0].Rows[0]["ItemBarcode"].ToString();
                        dr["ItemName"] = ds.Tables[0].Rows[0]["ItemName"].ToString();
                        dr["ItemCategory"] = ds.Tables[0].Rows[0]["ItemCategory"].ToString();
                        dr["ItemSubCategory"] = ds.Tables[0].Rows[0]["ItemSubCategory"].ToString();
                        dr["imgLink1"] = ds.Tables[0].Rows[0]["imgLink1"].ToString();
                        dr["Qty"] = RequestedQty;
                        dr["ItemUPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemUPrice"].ToString());
                        dr["ItemDPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        dr["ItemSPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemSPrice"].ToString());
                        dr["DiscountValue"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["DiscountValue"].ToString());

                        double Price = Convert.ToDouble(ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        double Quantity = Convert.ToDouble(RequestedQty);
                        double TotalPrice = Price * Quantity;
                        dr["TotalPrice"] = string.Format("{0:#,#.00}", TotalPrice);

                        dt.Rows.Add(dr);
                        Session["ShoppingCard"] = dt;
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
                        cmd.CommandText = $"SELECT * FROM tbl_ItemDet WHERE ItemCode='" + RequestedItemCode + "' ";
                        cmd.Connection = con;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        da.Fill(ds);

                        dr["SerialNo"] = SerialNo + 1;
                        dr["CompanyID"] = ds.Tables[0].Rows[0]["CompanyID"].ToString();
                        dr["ItemCode"] = ds.Tables[0].Rows[0]["ItemCode"].ToString();
                        dr["ItemBarcode"] = ds.Tables[0].Rows[0]["ItemBarcode"].ToString();
                        dr["ItemName"] = ds.Tables[0].Rows[0]["ItemName"].ToString();
                        dr["ItemCategory"] = ds.Tables[0].Rows[0]["ItemCategory"].ToString();
                        dr["ItemSubCategory"] = ds.Tables[0].Rows[0]["ItemSubCategory"].ToString();
                        dr["imgLink1"] = ds.Tables[0].Rows[0]["imgLink1"].ToString();
                        dr["Qty"] = RequestedQty;
                        dr["ItemUPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemUPrice"].ToString());
                        dr["ItemDPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        dr["ItemSPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemSPrice"].ToString());
                        dr["DiscountValue"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["DiscountValue"].ToString());

                        double Price = Convert.ToDouble(ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        double Quantity = Convert.ToDouble(RequestedQty);
                        double TotalPrice = Price * Quantity;
                        dr["TotalPrice"] = string.Format("{0:#,#.00}", TotalPrice);

                        dt.Rows.Add(dr);
                        Session["ShoppingCard"] = dt;
                    }
                }
                else
                {
                    dt = (DataTable)Session["ShoppingCard"];
                }

                string[] commandArgs1 = e.CommandArgument.ToString().Split(new char[] { ';' });
                string id = commandArgs1[0];
                string CategoryName1 = commandArgs1[1];
                Response.Redirect("DisplayProductDetails.aspx?RequestedItemCode=" + commandArgs1[0].ToString() + "& RequestedItemCategory =" + commandArgs1[1].ToString() + "& RequestedItemSubCategory =" + commandArgs1[2].ToString());

                //Response.Redirect("DisplayProductDetails.aspx");
            }
        }
    }
}