using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SemicolansWeb.UserSite
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //dlCustomers.DataSource = GetCustomersData("");
                //dlCustomers.DataBind();
            }
        }

        public static DataSet GetCustomersData(string search)
        {

            DataTable dt = new DataTable();
            string conString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            SqlConnection sqlCon = new SqlConnection(conString);
            sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("SELECT * FROM tbl_ItemDet INNER JOIN tbl_PriceLink1 " +
                "ON tbl_PriceLink1.ItemCode = tbl_ItemDet.ItemCode WHERE tbl_ItemDet.chkActiveItem = '1' AND tbl_ItemDet.ItemCatCode!='CAT-11-000000' " +
                "AND tbl_ItemDet.chkShowOnWeb='1' AND tbl_ItemDet.chkShowPriceLink='1' " +
                " ", sqlCon);
            SqlDataAdapter da = new SqlDataAdapter(sqlCmd);
            da.Fill(dt);
            sqlCon.Close();

            string query = "[GetCustomersPageWiseSearch]";
            SqlCommand cmd = new SqlCommand(query);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PageIndex", 1);
            cmd.Parameters.AddWithValue("@PageSize", 100);
            cmd.Parameters.AddWithValue("@search", search);
            cmd.Parameters.Add("@RecordCount", SqlDbType.Int, 4).Direction = ParameterDirection.Output;
            return GetData(cmd);
        }

        private static DataSet GetData(SqlCommand cmd)
        {
            string strConnString = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            using (SqlConnection con = new SqlConnection(strConnString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using (DataSet ds = new DataSet())
                    {
                        sda.Fill(ds, "tbl_Itemdet");
                        return ds;
                    }
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string GetCustomers(string search)
        {
            DataSet ds = GetCustomersData(search);
            if (ds.Tables[0].Rows.Count > 0)
            {
                return GetCustomersData(search).GetXml();
            }
            else
            {
                return "";
            }
        }
    }
}