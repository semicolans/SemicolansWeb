using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.ComponentModel;


namespace eCommerce.UserSite
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        //private int iPageSize = 15;
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        //For Pagination Repeater
        readonly PagedDataSource _pgsource = new PagedDataSource();
        int _firstIndex, _lastIndex;
        private int _pageSize = 50;
        private int CurrentPage
        {
            get
            {
                if (ViewState["CurrentPage"] == null)
                {
                    return 0;
                }
                return ((int)ViewState["CurrentPage"]);
            }
            set
            {
                ViewState["CurrentPage"] = value;
            }
        }
        //For Pagination Repeater
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillCategoryValues();
                fillSubCategoryValues();
                fillMakeValues();
                fillModelValues();
            }
            //Display_Products();
            if (Page.IsPostBack) return;
            BindDataIntoRepeater();
        }

        // Bind PagedDataSource into Repeater
        [System.Web.Services.WebMethod]
        private void BindDataIntoRepeater()
        {
            //var dt = GetDataFromDb();

            string CategoryFind = "";
            string SubCategoryFind = "";
            string MakeFind = "";
            string ModelFind = "";

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
            //Getting Filtered iTEM mAKE Values
            if (lblFilteredMake.Text == "")
            {
                MakeFind = "";
            }
            else
            {
                MakeFind = "AND tbl_ItemDet.ItemMake IN (" + lblFilteredMake.Text + ")";
            }
            //Getting Filtered iTEM Model Values
            if (lblFilteredModel.Text == "")
            {
                ModelFind = "";
            }
            else
            {
                ModelFind = "AND tbl_ItemDet.ItemUnit IN (" + lblFilteredModel.Text + ")";
            }


            SqlConnection con = new SqlConnection(strcon);
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }

            DataTable dt = new DataTable();
            string conString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("SELECT * FROM tbl_ItemDet INNER JOIN tbl_PriceLink1 " +
                "ON tbl_PriceLink1.ItemCode = tbl_ItemDet.ItemCode WHERE tbl_ItemDet.chkActiveItem = '1' AND tbl_ItemDet.ItemCatCode!='CAT-11-000000' " +
                "AND tbl_ItemDet.chkShowOnWeb='1' AND tbl_ItemDet.chkShowPriceLink='1' " +
                "" + CategoryFind + " " + SubCategoryFind + " " + MakeFind + " " + ModelFind + " ", sqlCon);
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlCon.Close();

            _pgsource.DataSource = dt.DefaultView;
            _pgsource.AllowPaging = true;
            // Number of items to be displayed in the Repeater
            _pgsource.PageSize = _pageSize;
            _pgsource.CurrentPageIndex = CurrentPage;
            // Keep the Total pages in View State
            ViewState["TotalPages"] = _pgsource.PageCount;
            // Example: "Page 1 of 10"
            lblpage.Text = "Page " + (CurrentPage + 1) + " of " + _pgsource.PageCount;
            // Enable First, Last, Previous, Next buttons
            lbPrevious.Enabled = !_pgsource.IsFirstPage;
            lbNext.Enabled = !_pgsource.IsLastPage;
            lbFirst.Enabled = !_pgsource.IsFirstPage;
            lbLast.Enabled = !_pgsource.IsLastPage;

            // Bind data into repeater
            dtlProductRecords.DataSource = _pgsource;
            dtlProductRecords.DataBind();
            dtlProductRecordsMob.DataSource = _pgsource;
            dtlProductRecordsMob.DataBind();
            dtlProductRecordsTab.DataSource = _pgsource;
            dtlProductRecordsTab.DataBind();

            // Call the function to do paging
            HandlePaging();
        }
        private void HandlePaging()
        {
            var dt = new DataTable();
            dt.Columns.Add("PageIndex"); //Start from 0
            dt.Columns.Add("PageText"); //Start from 1

            _firstIndex = CurrentPage - 5;
            if (CurrentPage > 5)
                _lastIndex = CurrentPage + 5;
            else
                _lastIndex = 10;

            // Check last page is greater than total page then reduced it 
            // to total no. of page is last index
            if (_lastIndex > Convert.ToInt32(ViewState["TotalPages"]))
            {
                _lastIndex = Convert.ToInt32(ViewState["TotalPages"]);
                _firstIndex = _lastIndex - 10;
            }

            if (_firstIndex < 0)
                _firstIndex = 0;

            // Now creating page number based on above first and last page index
            for (var i = _firstIndex; i < _lastIndex; i++)
            {
                var dr = dt.NewRow();
                dr[0] = i;
                dr[1] = i + 1;
                dt.Rows.Add(dr);
            }

            rptPaging.DataSource = dt;
            rptPaging.DataBind();
        }
        protected void lbFirst_Click(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindDataIntoRepeater();
        }
        protected void lbLast_Click(object sender, EventArgs e)
        {
            CurrentPage = (Convert.ToInt32(ViewState["TotalPages"]) - 1);
            BindDataIntoRepeater();
        }
        protected void lbPrevious_Click(object sender, EventArgs e)
        {
            CurrentPage -= 1;
            BindDataIntoRepeater();
        }
        protected void lbNext_Click(object sender, EventArgs e)
        {
            CurrentPage += 1;
            BindDataIntoRepeater();
        }

        protected void rptPaging_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (!e.CommandName.Equals("newPage")) return;
            CurrentPage = Convert.ToInt32(e.CommandArgument.ToString());
            BindDataIntoRepeater();
        }

        protected void rptPaging_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            var lnkPage = (LinkButton)e.Item.FindControl("lbPaging");
            if (lnkPage.CommandArgument != CurrentPage.ToString()) return;
            lnkPage.Enabled = false;
            lnkPage.BackColor = Color.FromName("#C0C0C0");
        }



        //void Display_Products()
        //{
        //    try
        //    {
        //        string CategoryFind = "";
        //        string SubCategoryFind = "";

        //        //Getting Filtered Category Values
        //        if (lblFilteredCategory.Text == "")
        //        {
        //            CategoryFind = "";
        //        }
        //        else
        //        {
        //            CategoryFind = "AND tbl_ItemDet.ItemCatName IN (" + lblFilteredCategory.Text + ")";
        //        }
        //        //Getting Filtered Sub Category Values
        //        if (lblFilteredSubCategory.Text == "")
        //        {
        //            SubCategoryFind = "";
        //        }
        //        else
        //        {
        //            SubCategoryFind = "AND tbl_ItemDet.ItemSubCatName1 IN (" + lblFilteredSubCategory.Text + ")";
        //        }

        //        SqlConnection con = new SqlConnection(strcon);
        //        if (con.State == ConnectionState.Closed)
        //        {
        //            con.Open();
        //        }

        //        DataTable dtData = new DataTable();
        //        string conString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        //        SqlConnection sqlCon = new SqlConnection(conString);
        //        sqlCon.Open();
        //        SqlCommand sqlCmd = new SqlCommand("SELECT TOP 5000 * FROM tbl_ItemDet INNER JOIN tbl_PriceLink1 " +
        //            "ON tbl_PriceLink1.ItemCode = tbl_ItemDet.ItemCode WHERE tbl_ItemDet.chkActiveItem = '1'  " + CategoryFind + " " + SubCategoryFind + " ", sqlCon);
        //        SqlDataAdapter sqlDa = new SqlDataAdapter(sqlCmd);
        //        sqlDa.Fill(dtData);
        //        sqlCon.Close();

        //        PagedDataSource pdsData = new PagedDataSource();
        //        DataView dv = new DataView(dtData);
        //        pdsData.DataSource = dv;
        //        pdsData.AllowPaging = true;
        //        pdsData.PageSize = iPageSize;

        //        if (ViewState["PageNumber"] != null)
        //            pdsData.CurrentPageIndex = Convert.ToInt32(ViewState["PageNumber"]);
        //        else
        //            pdsData.CurrentPageIndex = 0;
        //        //if (pdsData.PageCount > 1)
        //        //{
        //        //    RepeaterPgNoFooter.Visible = true;
        //        //    ArrayList alPages = new ArrayList();
        //        //    for (int i = 1; i <= pdsData.PageCount; i++)
        //        //        alPages.Add((i).ToString());
        //        //    RepeaterPgNoFooter.DataSource = alPages;
        //        //    RepeaterPgNoFooter.DataBind();
        //        //}
        //        //else
        //        //{
        //        //    RepeaterPgNoFooter.Visible = false;
        //        //}
        //        dtlProductRecords.DataSource = pdsData;
        //        dtlProductRecords.DataBind();

        //        dtlProductRecordsMob.DataSource = pdsData;
        //        dtlProductRecordsMob.DataBind();

        //        dtlProductRecordsTab.DataSource = pdsData;
        //        dtlProductRecordsTab.DataBind();

        //        con.Close();

        //    }
        //    catch (Exception ex)
        //    {
        //        Response.Write("<script>alert('" + ex.Message + "');</script>");
        //    }
        //}

        //protected void RepeaterPgNoFooter_ItemCommand(object source, RepeaterCommandEventArgs e)
        //{
        //    ViewState["PageNumber"] = Convert.ToInt32(e.CommandArgument);
        //    Display_Products();
        //}

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
                        dr["ItemUPrice"] =  ds.Tables[0].Rows[0]["ItemUPrice"].ToString();
                        dr["ItemDPrice"] = ds.Tables[0].Rows[0]["ItemDPrice"].ToString();
                        dr["ItemSPrice"] =  ds.Tables[0].Rows[0]["ItemSPrice"].ToString();


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
                        dr["DiscountValue"] =  DisValue;
                        dr["TotalPrice"] = TotalPrice;

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
                        dr["ItemUPrice"] =  ds.Tables[0].Rows[0]["ItemUPrice"].ToString();
                        dr["ItemDPrice"] =  ds.Tables[0].Rows[0]["ItemDPrice"].ToString();
                        dr["ItemSPrice"] =  ds.Tables[0].Rows[0]["ItemSPrice"].ToString();
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
                        dr["DiscountValue"] =  DisValue;
                        dr["TotalPrice"] = TotalPrice;

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
                cmd.CommandText = $"SELECT DISTINCT(ItemCatName),COUNT(ItemCode) AS NoOfItems FROM tbl_ItemDet WHERE ItemCatName !='' AND ItemCatName!='Null' AND ItemCatName Is Not Null GROUP BY ItemCatName";
                
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lstCategoryName.DataSource = dt;
                lstCategoryName.DataValueField = "ItemCatName";
                lstCategoryName.DataBind();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        //Fill Sub Category Values
        [WebMethod()]
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
                    CategoryFind = "AND ItemCatName IN (" + lblFilteredCategory.Text + ")";
                }

                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                if (lblFilteredCategory.Text != "")
                {
                    cmd.CommandText = $"SELECT DISTINCT(ItemSubCatName1),COUNT(ItemCode) FROM tbl_Itemdet WHERE " +
                        $"ItemSubCatName1 !='' AND ItemSubCatName1 !='Null' AND ItemSubCatName1 Is Not Null " + CategoryFind + " GROUP BY ItemSubCatName1";
                }
                else
                {
                    cmd.CommandText = $"SELECT DISTINCT(ItemSubCatName1),COUNT(ItemCode) FROM tbl_Itemdet WHERE ItemSubCatName1 !='' AND ItemSubCatName1 !='Null' AND ItemSubCatName1 Is Not Null GROUP BY ItemSubCatName1";
                }

                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lstSubCategoryName.DataSource = dt;
                lstSubCategoryName.DataValueField = "ItemSubCatName1";
                lstSubCategoryName.DataBind();

                if (dt.Rows.Count == 0)
                {
                    FilterSubCatSection.Visible = false;
                }
                else
                {
                    FilterSubCatSection.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        //Fill Make Values
        [WebMethod()]
        void fillMakeValues()
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
                    CategoryFind = "AND ItemCatName IN (" + lblFilteredCategory.Text + ")";
                }
                //Getting Filtered Sub Category Values
                if (lblFilteredSubCategory.Text == "")
                {
                    SubCategoryFind = "";
                }
                else
                {
                    SubCategoryFind = "AND ItemSubCatName1 IN (" + lblFilteredSubCategory.Text + ")";
                }



                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT DISTINCT(ItemMake),COUNT(ItemCode) AS NoOfItems FROM tbl_ItemDet " +
                    $"WHERE ItemMake!='' AND ItemMake!='Null' AND ItemMake Is Not Null AND ItemMake!='-' " +
                    $"" + CategoryFind + " " + SubCategoryFind + " GROUP BY ItemMake";

                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lstMakeName.DataSource = dt;
                lstMakeName.DataValueField = "ItemMake";
                lstMakeName.DataBind();


                if (dt.Rows.Count == 0) 
                {
                    FilterMakeSection.Visible = false;
                }
                else
                {
                    FilterMakeSection.Visible = true;
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        //Fill Model Values
        [WebMethod()]
        void fillModelValues()
        {
            try
            {
                string CategoryFind = "";
                string SubCategoryFind = "";
                string MakeFind = "";

                //Getting Filtered Category Values
                if (lblFilteredCategory.Text == "")
                {
                    CategoryFind = "";
                }
                else
                {
                    CategoryFind = "AND ItemCatName IN (" + lblFilteredCategory.Text + ")";
                }
                //Getting Filtered Sub Category Values
                if (lblFilteredSubCategory.Text == "")
                {
                    SubCategoryFind = "";
                }
                else
                {
                    SubCategoryFind = "AND ItemSubCatName1 IN (" + lblFilteredSubCategory.Text + ")";
                }
                //Getting Filtered Item Make Values
                if (lblFilteredMake.Text == "")
                {
                    MakeFind = "";
                }
                else
                {
                    MakeFind = "AND ItemMake IN (" + lblFilteredModel.Text + ")";
                }


                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT DISTINCT(ItemUnit),COUNT(ItemCode) AS NoOfItems FROM tbl_ItemDet " +
                    $"WHERE ItemUnit!='' AND ItemUnit!='Null' AND ItemUnit Is Not Null AND ItemUnit!='-' " +
                    $"" + CategoryFind + " " + SubCategoryFind + " " + MakeFind + " GROUP BY ItemUnit";

                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                lstModelName.DataSource = dt;
                lstModelName.DataValueField = "ItemUnit";
                lstModelName.DataBind();


                if (dt.Rows.Count == 0)
                {
                    FilterModelSection.Visible = false;
                }
                else
                {
                    FilterModelSection.Visible = true;
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }



        //Clear All category Filterred
        protected void btnClearCategory_Click(object sender, EventArgs e)
        {
            lblFilteredCategory.Text = "";
            fillCategoryValues();
            fillSubCategoryValues();
            fillMakeValues();
            fillModelValues();
            BindDataIntoRepeater();
        }

        ////Cleare All Sub Category Filtered
        protected void btnSearchSubCategory_Click(object sender, EventArgs e)
        {
            lblFilteredSubCategory.Text = "";
            fillSubCategoryValues();
            fillMakeValues();
            fillModelValues();
            BindDataIntoRepeater();
        }

        //Search Make Button Click
        protected void btnSearchMake_Click(object sender, EventArgs e)
        {
            lblFilteredMake.Text = "";
            fillMakeValues();
            fillMakeValues();
            fillModelValues();
            BindDataIntoRepeater();
        }

        //Search Model Button Click
        protected void btnSearchModel_Click(object sender, EventArgs e)
        {
            fillModelValues();
            lblFilteredModel.Text = "";
            fillModelValues();
            BindDataIntoRepeater();
        }


        //Auto Filter Category Wise Products From Check List
        protected void lstCategoryName_SelectedIndexChanged(object sender, EventArgs e)
        {
            string chkBoxCategoryValue = "";
            lblFilteredCategory.Text = "";
            for (int i = 0; i < lstCategoryName.Items.Count; i++)
            {
                if (lstCategoryName.Items[i].Selected)
                {
                    if (chkBoxCategoryValue == "")
                    {
                        chkBoxCategoryValue = "'" + lstCategoryName.Items[i].Text + "'";
                    }
                    else
                    {
                        chkBoxCategoryValue = chkBoxCategoryValue + "," + "'" + lstCategoryName.Items[i].Text + "'";
                    }
                    lblFilteredCategory.Text = chkBoxCategoryValue;
                }
            }

            fillSubCategoryValues();
            fillMakeValues();
            fillModelValues();
            BindDataIntoRepeater();
        }

        //Auto Filter Sub Category Wise Products From Check List
        protected void lstSubCategoryName_SelectedIndexChanged(object sender, EventArgs e)
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
            fillMakeValues();
            fillModelValues();
            BindDataIntoRepeater();
        }

        //Auto Filter Item Make Wise Products From Check List
        protected void lstMakeName_SelectedIndexChanged(object sender, EventArgs e)
        {
            string chkBoxMakeValue = "";
            lblFilteredMake.Text = "";
            for (int i = 0; i < lstMakeName.Items.Count; i++)
            {
                if (lstMakeName.Items[i].Selected)
                {
                    if (chkBoxMakeValue == "")
                    {
                        chkBoxMakeValue = "'" + lstMakeName.Items[i].Text + "'";
                    }
                    else
                    {
                        chkBoxMakeValue = chkBoxMakeValue + "," + "'" + lstMakeName.Items[i].Text + "'";
                    }
                    lblFilteredMake.Text = chkBoxMakeValue;
                }
            }

            fillModelValues();
            BindDataIntoRepeater();
        }

        //Auto Filter Item Model Wise Products From Check List
        protected void lstModelName_SelectedIndexChanged(object sender, EventArgs e)
        {
            string chkBoxModelValue = "";
            lblFilteredModel.Text = "";
            for (int i = 0; i < lstModelName.Items.Count; i++)
            {
                if (lstModelName.Items[i].Selected)
                {
                    if (chkBoxModelValue == "")
                    {
                        chkBoxModelValue = "'" + lstModelName.Items[i].Text + "'";
                    }
                    else
                    {
                        chkBoxModelValue = chkBoxModelValue + "," + "'" + lstModelName.Items[i].Text + "'";
                    }
                    lblFilteredModel.Text = chkBoxModelValue;
                }
            }

            fillModelValues();
            BindDataIntoRepeater();
        }
    }
}