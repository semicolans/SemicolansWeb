using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce.AdminSite
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillCategoryValues();
                fillSubCategoryValues();
                fillSupplierValues();
                Display_Products();
            }
        }
        void Display_Products()
        {
            try
            {
                string CategoryFind = "";
                string SubCategoryFind = "";
                string SupplierFind = "";

                
                //Getting Filtered Category Values
                if (cboCategoryName.SelectedValue == "" || cboCategoryName.SelectedValue == "All")
                {
                    CategoryFind = "";
                }
                else
                {
                    CategoryFind = "AND tbl_ItemDet.ItemCatName='" + cboCategoryName.SelectedValue + "' ";
                }
                //Getting Filtered Sub Category Values
                if (cboSubCategoryName.SelectedValue == "" || cboSubCategoryName.SelectedValue == "All")
                {
                    SubCategoryFind = "";
                }
                else
                {
                    SubCategoryFind = "AND tbl_ItemDet.ItemSubCatName1='" + cboSubCategoryName.SelectedValue + "' ";
                }
                //Getting FilteredSupplier Values
                if (cboSupplierName.SelectedValue == "" || cboSupplierName.SelectedValue == "All")
                {
                    SupplierFind = "";
                }
                else
                {
                    SupplierFind = "AND tbl_ItemDet.ItemSupName='" + cboSupplierName.SelectedValue + "' ";
                }



                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_ItemDet INNER JOIN tbl_PriceLink1 ON tbl_PriceLink1.ItemCode=tbl_ItemDet.ItemCode WHERE tbl_ItemDet.chkActiveItem='1'  " +
                    $" " + CategoryFind + " " + SubCategoryFind + " " + SupplierFind + " ";
                cmd.Connection = con;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                da.Fill(ds);

                grdProductDet.DataSource = ds;
                grdProductDet.DataBind();

                grdProductDetTableView.DataSource = ds;
                grdProductDetTableView.DataBind();

                con.Close();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void fillCategoryValues()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                //cboCategoryName.Items.Add("All");
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_CatDet";
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                cboCategoryName.DataSource = dt;
                cboCategoryName.DataValueField = "CatName";
                cboCategoryName.DataBind();
                cboCategoryName.Items.Add("All");
                cboCategoryName.SelectedIndex = cboCategoryName.Items.Count - 1;
            }
            catch (Exception ex)
            {

            }
        }

        void fillSubCategoryValues()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_SubCatDet WHERE CatName='" + cboCategoryName.Text + "'";
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                cboSubCategoryName.DataSource = dt;
                cboSubCategoryName.DataValueField = "SubCatName";
                cboSubCategoryName.DataBind();
                cboSubCategoryName.Items.Add("All");
                cboSubCategoryName.SelectedIndex = cboSubCategoryName.Items.Count - 1;

            }
            catch (Exception ex)
            {

            }
        }

        void fillSupplierValues()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                //cboCategoryName.Items.Add("All");
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_SupDet WHERE ActiveSupplier='1'";
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                cboSupplierName.DataSource = dt;
                cboSupplierName.DataValueField = "SupName";
                cboSupplierName.DataBind();
                cboSupplierName.Items.Add("All");
                cboSupplierName.SelectedIndex = cboSupplierName.Items.Count - 1;
            }
            catch (Exception ex)
            {

            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Display_Products();
        }

        protected void btlGridView_Click(object sender, EventArgs e)
        {
            ProductDetGridView.Visible = true;
            ProductDetTableView.Visible = false;
        }

        protected void btnTableView_Click(object sender, EventArgs e)
        {
            ProductDetGridView.Visible = false;
            ProductDetTableView.Visible = true;
        }
    }
}