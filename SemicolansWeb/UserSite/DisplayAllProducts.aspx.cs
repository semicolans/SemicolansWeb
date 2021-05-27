using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce.UserSite
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        //string RequestedItemCode = "";
        //double RequestedQty = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillCategoryValues();
                fillSubCategoryValues();
            }
            Display_Products();
        }

        void Display_Products()
        {
            try
            {
                string CategoryFind = "";
                string SubCategoryFind = "";

                //Getting Filtered Category Values
                if (lblFilteredCategory.Text == "")
                {
                    CategoryFind = "";
                }
                else
                {
                    CategoryFind = "AND tbl_ItemDet.ItemCatName IN (" + lblFilteredCategory.Text + ")";
                }
                //Getting Filtered Sub Category Values
                if (lblFilteredSubCategory.Text == "")
                {
                    SubCategoryFind = "";
                }
                else
                {
                    SubCategoryFind = "AND tbl_ItemDet.ItemSubCatName1 IN (" + lblFilteredSubCategory.Text + ")";
                }

                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_ItemDet INNER JOIN tbl_PriceLink1 ON tbl_PriceLink1.ItemCode=tbl_ItemDet.ItemCode WHERE tbl_ItemDet.chkActiveItem='1'  " + CategoryFind + " " + SubCategoryFind + " ";
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

                con.Close();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }


        protected void dtlProductRecords_ItemCommand(object source, DataListCommandEventArgs e)
        {

            if (e.CommandName=="QuickView")
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
                double Qty1=0;
                if (Convert.ToDouble(Qty.Text)==0)
                {
                    Qty1 =1;
                }
                else
                {
                    Qty1 = Convert.ToDouble(Qty.Text);
                }                
                double RequestedQty = Qty1;
                //Response.Redirect("DisplayAllProducts.aspx?RequestedItemCode=" + commandArgs[0].ToString() + "& RequestedItemCategory =" + commandArgs[1].ToString() + "& RequestedItemSubCategory =" + commandArgs[2].ToString() + "&RequestedQty=" + Qty.Text.ToString());


                DataTable dt = new DataTable();
                DataRow dr;
                //dt.Columns.Add("CompanyID");
                dt.Columns.Add("SerialNo");
                dt.Columns.Add("ItemCode");
                dt.Columns.Add("ItemBarcode");
                dt.Columns.Add("ItemName");
                dt.Columns.Add("ItemCatName");
                dt.Columns.Add("ItemSubCatName1");
                dt.Columns.Add("Qty");
                dt.Columns.Add("ItemUprice");
                dt.Columns.Add("ItemSPrice");
                dt.Columns.Add("ItemDprice");
                dt.Columns.Add("TotalPrice");
                dt.Columns.Add("DiscountValue");
                dt.Columns.Add("imgPath");


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
                        cmd.CommandText = $"SELECT * FROM tbl_ItemDet INNER JOIN tbl_PriceLink1 ON tbl_PriceLink1.ItemCode=tbl_ItemDet.ItemCode WHERE tbl_ItemDet.ItemCode='" + RequestedItemCode + "' ";
                        cmd.Connection = con;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        da.Fill(ds);

                        dr["SerialNo"] = 1;

                        dr["ItemCode"] = ds.Tables[0].Rows[0]["ItemCode"].ToString();
                        dr["ItemBarcode"] = ds.Tables[0].Rows[0]["ItemBarcode"].ToString();
                        dr["ItemName"] = ds.Tables[0].Rows[0]["ItemName"].ToString();
                        dr["ItemCatName"] = ds.Tables[0].Rows[0]["ItemCatName"].ToString();
                        dr["ItemSubCatName1"] = ds.Tables[0].Rows[0]["ItemSubCatName1"].ToString();
                        dr["imgPath"] = ds.Tables[0].Rows[0]["imgPath"].ToString();
                        dr["Qty"] = RequestedQty;
                        dr["ItemUPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemUPrice"].ToString());
                        dr["ItemDPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        dr["ItemSPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemSPrice"].ToString());


                        double DPrice = Convert.ToDouble(ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        double SPrice = Convert.ToDouble(ds.Tables[0].Rows[0]["ItemSPrice"].ToString());
                        double Quantity = Convert.ToDouble(RequestedQty);
                        double TotalPrice = 0;
                        double DisValue = 0;
                        if (DPrice == 0) {
                            TotalPrice = SPrice * Quantity;
                            DisValue = 0;
                        }
                        else
                        {
                            TotalPrice = DPrice * Quantity;
                            DisValue = SPrice - DPrice;
                        }                        
                        dr["DiscountValue"] = string.Format("{0:#,#.00}", DisValue);
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
                        cmd.CommandText = $"SELECT * FROM tbl_ItemDet INNER JOIN tbl_PriceLink1 ON tbl_PriceLink1.ItemCode=tbl_ItemDet.ItemCode WHERE tbl_ItemDet.ItemCode='" + RequestedItemCode + "' ";
                        cmd.Connection = con;

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        da.Fill(ds);

                        dr["SerialNo"] = SerialNo + 1;
                        //dr["CompanyID"] = ds.Tables[0].Rows[0]["CompanyID"].ToString();
                        dr["ItemCode"] = ds.Tables[0].Rows[0]["ItemCode"].ToString();
                        dr["ItemBarcode"] = ds.Tables[0].Rows[0]["ItemBarcode"].ToString();
                        dr["ItemName"] = ds.Tables[0].Rows[0]["ItemName"].ToString();
                        dr["ItemCatName"] = ds.Tables[0].Rows[0]["ItemCatName"].ToString();
                        dr["ItemSubCatName1"] = ds.Tables[0].Rows[0]["ItemSubCatName1"].ToString();
                        dr["imgPath"] = ds.Tables[0].Rows[0]["imgPath"].ToString();
                        dr["Qty"] = RequestedQty;
                        dr["ItemUPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemUPrice"].ToString());
                        dr["ItemDPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        dr["ItemSPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemSPrice"].ToString());
                        //dr["ItemSPrice"] = string.Format("{0:#,#.00}", ds.Tables[0].Rows[0]["ItemSPrice"].ToString());


                        double DPrice = Convert.ToDouble(ds.Tables[0].Rows[0]["ItemDPrice"].ToString());
                        double SPrice = Convert.ToDouble(ds.Tables[0].Rows[0]["ItemSPrice"].ToString());
                        double Quantity = Convert.ToDouble(RequestedQty);
                        double TotalPrice = 0;
                        double DisValue = 0;
                        if (DPrice == 0)
                        {
                            TotalPrice = SPrice * Quantity;
                            DisValue = 0;
                        }
                        else
                        {
                            TotalPrice = DPrice * Quantity;
                            DisValue = SPrice - DPrice;
                        }
                        dr["DiscountValue"] = string.Format("{0:#,#.00}", DisValue);
                        dr["TotalPrice"] = string.Format("{0:#,#.00}", TotalPrice);

                        dt.Rows.Add(dr);
                        Session["ShoppingCard"] = dt;
                    }
                }
                else
                {
                    dt = (DataTable)Session["ShoppingCard"];
                }
                Response.Redirect("DisplayAllProducts.aspx");
            }

            if (e.CommandName == "MinusQty")
            {
                TextBox Qty = (TextBox)(e.Item.FindControl("txtQty"));
                Double Qty1 = Convert.ToDouble(Qty.Text);
                if (Qty1 != 0)
                {
                    Qty1 = Qty1 - 1;
                    Qty.Text = Convert.ToString(Qty1);
                }
            }
            if (e.CommandName == "PlusQty")
            {
                TextBox Qty = (TextBox)(e.Item.FindControl("txtQty"));
                Double Qty1 = Convert.ToDouble(Qty.Text);
                if (Qty1 != 100)
                {
                    Qty1 = Qty1 + 1;
                    Qty.Text = Convert.ToString(Qty1);
                }
            }
        }

        protected void dtlProductRecords_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            //Display Qty in Shopping Card

            Label ItemCodeTemp = (Label)(e.Item.FindControl("lblItemCode"));
            TextBox QtyTemp = (TextBox)(e.Item.FindControl("txtQty"));
            LinkButton PlusTemp = (LinkButton)(e.Item.FindControl("btnPlus"));
            LinkButton MinusTemp = (LinkButton)(e.Item.FindControl("btnMinus"));
            LinkButton AddToCardTemp = (LinkButton)(e.Item.FindControl("btnAddToCard"));
            LinkButton ComingSoonTemp = (LinkButton)(e.Item.FindControl("btnComingSoon"));

            DataTable dtTemp;
            dtTemp = (DataTable)Session["ShoppingCard"];
        }

        //Fill Category Values
        [WebMethod()]
        void fillCategoryValues()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                if (txtSearchCategory.Text!="")
                {
                    cmd.CommandText = $"SELECT CatName FROM tbl_CatDet WHERE CatName LIKE '%" + txtSearchCategory.Text + "%'";
                }
                else
                {
                    cmd.CommandText = $"SELECT CatName FROM tbl_CatDet";
                }
                
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                //grdCategoryDet.DataSource = dt;
                //grdCategoryDet.DataBind();
                lstCategoryName.DataSource = dt;
                lstCategoryName.DataValueField = "CatName";
                lstCategoryName.DataBind();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        //Fill Sub Category Values
        //[WebMethod()]
        void fillSubCategoryValues()
        {
            try
            {
                string CategoryFind = "";

                //Getting Filtered Category Values
                if (lblFilteredCategory.Text == "")
                {
                    CategoryFind = "";
                }
                else
                {
                    CategoryFind = "AND CatName IN (" + lblFilteredCategory.Text + ")";
                }


                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                if (txtSearchSubCategory.Text == "")
                {
                    cmd.CommandText = $"SELECT SubCatName FROM tbl_SubCatDet WHERE " +
                        $"SubCatName LIKE '%" + txtSearchSubCategory.Text + "%' " + CategoryFind + " ";
                }
                else
                {
                    cmd.CommandText = $"SELECT SubCatName FROM tbl_SubCatDet WHERE SubCatName<>'' " + CategoryFind + " ";
                }

                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lstSubCategoryName.DataSource = dt;
                lstSubCategoryName.DataValueField = "SubCatName";
                lstSubCategoryName.DataBind();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void txtSearchSubCategory_TextChanged(object sender, EventArgs e)
        {
            fillSubCategoryValues();
        }

        //protected void txtSearchCategory_TextChanged(object sender, EventArgs e)
        //{
        //    fillCategoryValues();
        //}


        //Search Category Button Click
        protected void btnSearchCategory_Click(object sender, EventArgs e)
        {
            string chkBoxCategoryValue = "";
            lblFilteredCategory.Text = "";
            for (int i = 0; i < lstCategoryName.Items.Count; i++)
            {
                if (lstCategoryName.Items[i].Selected)
                {
                    if (chkBoxCategoryValue=="")
                    {
                        chkBoxCategoryValue = "'" + lstCategoryName.Items[i].Text +"'";
                    }
                    else
                    {
                        chkBoxCategoryValue= chkBoxCategoryValue + "," + "'" + lstCategoryName.Items[i].Text + "'";
                    }
                    lblFilteredCategory.Text = chkBoxCategoryValue;
                }
            }

            fillSubCategoryValues();
            Display_Products();
        }

        ////Search Sub Category Button Click
        protected void btnSearchSubCategory_Click(object sender, EventArgs e)
        {
            string chkBoxSubCategoryValue = "";
            lblFilteredSubCategory.Text = "";
            for (int i = 0; i < lstSubCategoryName.Items.Count; i++)
            {
                if (lstSubCategoryName.Items[i].Selected)
                {
                    if (chkBoxSubCategoryValue == "")
                    {
                        chkBoxSubCategoryValue = "'" + lstSubCategoryName.Items[i].Text + "'";
                    }
                    else
                    {
                        chkBoxSubCategoryValue = chkBoxSubCategoryValue + "," + "'" + lstSubCategoryName.Items[i].Text + "'";
                    }
                    lblFilteredSubCategory.Text = chkBoxSubCategoryValue;
                }
            }

            Display_Products();
        }
    }
}