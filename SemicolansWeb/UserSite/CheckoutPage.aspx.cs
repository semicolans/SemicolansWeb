using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace eCommerce.UserSite
{
    
    public partial class WebForm4 : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        static Boolean boolEmptyShoppingCart;
        static string AutoOrderID;
        static string strCustomerID;
        static string strCustomerAddress;
        static string strCustomerImage;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetShoppingCarddetails();
                GetCustomerInformation();
            }
            if (Session["SCustomerID"]==null && boolEmptyShoppingCart == false)
            {
                SectionEmptyCart.Visible = true;
                CustomerDetails.Visible =true;
                CustomerDetailsSummery.Visible = false;
                PaymentMethod.Visible = false;
                PaymentMethodSummery.Visible = false;
                PaymentDetails.Visible = false;
                PaymentDetailsSummery.Visible = false;
            }
            else
            {
                SectionEmptyCart.Visible = false;
                CustomerDetails.Visible = false;
                txtUserName.Visible = false;
                if (Session["SCustomerID"] == null)
                {
                    CustomerDetailsSummery.Visible = false;
                    PaymentMethod.Visible = false;
                }else
                {
                    CustomerDetailsSummery.Visible = true;
                    PaymentMethod.Visible = true;
                }
                PaymentMethodSummery.Visible = false;
                PaymentDetails.Visible = false;
                PaymentDetailsSummery.Visible = false;
            }
            if (txtFirstName.Visible==true)
            {
                txtFirstName.Focus();
            }
            else if (txtNameOnCard.Visible==true)
            {
                txtNameOnCard.Focus();
            }
        }

        void GetCustomerInformation()
        {
            if (Session["SCustomerID"] != null)
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_OrderCustomerDet WHERE CustomerID = '{ Session["SCustomerID"] }'  AND Status='Active' ";
                cmd.Connection = con;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count >= 1)
                {
                    txtFirstName.Text = dt.Rows[0]["FirstName"].ToString();
                    txtLastName.Text = dt.Rows[0]["LastName"].ToString();
                    txtFullAddress.Text = dt.Rows[0]["FullAddress"].ToString();
                    txtState.Text = dt.Rows[0]["State"].ToString();
                    txtCity.Text = dt.Rows[0]["City"].ToString();
                    txtPinCode.Text = dt.Rows[0]["PinCode"].ToString();
                    cboCountry.Text = dt.Rows[0]["Country"].ToString();
                    txtContactNo.Text = dt.Rows[0]["ContactNo"].ToString();
                    txtUserName.Text = dt.Rows[0]["Email"].ToString();

                    lblFirstName.Text = dt.Rows[0]["FirstName"].ToString();
                    lblLastName.Text = dt.Rows[0]["LastName"].ToString();
                    lblAddress.Text = dt.Rows[0]["FullAddress"].ToString();
                    lblState.Text = dt.Rows[0]["State"].ToString();
                    lblCity.Text = dt.Rows[0]["City"].ToString();
                    lblPinCode.Text = dt.Rows[0]["PinCode"].ToString();
                    lblContactNo.Text = dt.Rows[0]["Country"].ToString() + dt.Rows[0]["ContactNo"].ToString();
                    lblEmail.Text = dt.Rows[0]["Email"].ToString();

                    strCustomerID = dt.Rows[0]["CustomerID"].ToString();
                    strCustomerAddress = dt.Rows[0]["FullAddress"].ToString();
                    strCustomerImage = dt.Rows[0]["imgLink"].ToString();
                }
                else
                {
                    txtFirstName.Text = "";
                    txtLastName.Text = "";
                    txtFullAddress.Text = "";
                    txtState.Text = "";
                    txtCity.Text = "";
                    txtPinCode.Text = "";
                    txtContactNo.Text = "";
                    txtUserName.Text = "";

                    lblFirstName.Text = "";
                    lblLastName.Text = "";
                    lblAddress.Text = "";
                    lblState.Text = "";
                    lblCity.Text = "";
                    lblPinCode.Text = "";
                    lblContactNo.Text = "";
                    lblEmail.Text = "";
                }
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

                Session["ShoppingCard"] = dt;
                lblSubTotal.Text = GrandTotal().ToString("##,0.00");
                lblNetTotal.Text = GrandTotal().ToString("##,0.00");

            }

            DataTable dt1 = new DataTable();
            dt1 = (DataTable)Session["ShoppingCard"];

            if (dt1 != null)
            {
                lblEmptyShoppingCard.Visible = false;
                boolEmptyShoppingCart = false;
            }
            else
            {
                lblEmptyShoppingCard.Visible = true;
                lblSubTotal.Text = "0.00";
                lblNetTotal.Text = "0.00";
                boolEmptyShoppingCart = true;
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

        protected void btnSubmitCusInfo_Click(object sender, EventArgs e)
        {
            if (txtFirstName.Text=="")
            {
                Response.Write("<script>alert('Please input First Name.');</script>");
                txtFirstName.Focus();
            }
            else if (txtLastName.Text=="")
            {
                Response.Write("<script>alert('Please input Last Name.');</script>");
                txtLastName.Focus();
            }
            else if (txtFullAddress.Text == "")
            {
                Response.Write("<script>alert('Please input valid delivery address.');</script>");
                txtFullAddress.Focus();
            }
            else if (txtContactNo.Text == "")
            {
                Response.Write("<script>alert('Conatct number cannot be empty, Please input valid contact number.');</script>");
                txtContactNo.Focus();
            }
            else if (txtUserName.Text == "")
            {
                Response.Write("<script>alert('Please input valid email address.');</script>");
                if (txtUserName.Visible==true)
                {
                    txtUserName.Focus();
                }              
            }
            else
            {
                lblFirstName.Text = txtFirstName.Text;
                lblLastName.Text = txtLastName.Text;
                lblAddress.Text = txtFullAddress.Text;
                lblState.Text = txtState.Text;
                lblCity.Text = txtCity.Text;
                lblPinCode.Text = txtPinCode.Text;
                lblContactNo.Text = cboCountry.Text + txtContactNo.Text;

                CustomerDetails.Visible = false;
                CustomerDetailsSummery.Visible = true;
                PaymentMethod.Visible = true;
                PaymentDetails.Visible = false;
            }
        }

        protected void btnChangeCusInfo_Click(object sender, EventArgs e)
        {
            txtFirstName.Text = lblFirstName.Text;
            txtLastName.Text = lblLastName.Text;
            txtFullAddress.Text = lblAddress.Text;
            txtState.Text = lblState.Text;
            txtCity.Text = lblCity.Text;
            txtPinCode.Text = lblPinCode.Text;

            CustomerDetails.Visible = true;
            CustomerDetailsSummery.Visible = false;
            PaymentMethod.Visible = false;
            PaymentDetails.Visible = false;
        }

        protected void btnSubmitPaymentDet_Click(object sender, EventArgs e)
        {
            if (chkCashOnDelivery.Checked==true)
            {
                lblPaymentMethod.Text = "Cash On Delivery";
                PaymentDetails.Visible = false;
                PaymentMethodSummery.Visible = true;
            }
            else
            {
                lblPaymentMethod.Text = "Card Payment";
                PaymentDetails.Visible = true;
                PaymentMethodSummery.Visible = true;
            }
            CustomerDetails.Visible = false;
            CustomerDetailsSummery.Visible = true;
            PaymentMethod.Visible = false;
        }

        protected void btnChangePaymentMethod_Click(object sender, EventArgs e)
        {
            txtNameOnCard.Text = "";
            txtCardNumber.Text = "";
            txtExpMonth.Text = "";
            txtExpYear.Text = "";
            txtCVC.Text = "";
            PaymentMethod.Visible = true;
            PaymentMethodSummery.Visible = false;
        }

        protected void btnSubmitPayemntDetails_Click(object sender, EventArgs e)
        {
            if (txtNameOnCard.Text == "")
            {
                Response.Write("<script>alert('Please input Name on card.');</script>");
                txtNameOnCard.Focus();
            }
            else if (txtCardNumber.Text == "")
            {
                Response.Write("<script>alert('Card number cannot be empty,Please input card number.');</script>");
                txtCardNumber.Focus();
            }
            else if (txtExpMonth.Text == "")
            {
                Response.Write("<script>alert('Please input expiry month of the card.');</script>");
                txtExpMonth.Focus();
            }
            else if (txtExpYear.Text == "")
            {
                Response.Write("<script>alert('Please input expiry year of the card.');</script>");
                txtExpYear.Focus();
            }
            else if (txtCVC.Text == "")
            {
                Response.Write("<script>alert('CVC number cannot be empty,Please input valid CVC number of the card.');</script>");
                txtCVC.Focus();
            }
            else
            {
                lblNameOnCard.Text = txtNameOnCard.Text;
                lblCardNumber.Text = txtCardNumber.Text;
                lblExpMonth.Text = txtExpMonth.Text;
                lblExpYear.Text = txtExpYear.Text;
                lblCVC.Text = txtCVC.Text;

                PaymentMethod.Visible = false;
                PaymentMethodSummery.Visible = true;
                PaymentDetails.Visible = false;
                PaymentDetailsSummery.Visible = true;
            } 
        }

        protected void lblNameOnCard_DataBinding(object sender, EventArgs e)
        {
            txtNameOnCard.Text = lblNameOnCard.Text;
            txtCardNumber.Text = lblCardNumber.Text;
            txtExpMonth.Text = lblExpMonth.Text;
            txtExpYear.Text = lblExpYear.Text;
            txtCVC.Text = lblCVC.Text;

            PaymentDetails.Visible = true;
            PaymentDetailsSummery.Visible = false;
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            if (txtFirstName.Text=="")
            {
                Response.Write("<script>alert('Please input your first name.');</script>");
                txtFirstName.Focus();
            }
            else if(txtLastName.Text == "")
            {
                Response.Write("<script>alert('Please input your last name.');</script>");
                txtLastName.Focus();
            }
            else if (txtFullAddress.Text == "")
            {
                Response.Write("<script>alert('Please input your delivery address.');</script>");
                txtFullAddress.Focus();
            }
            else if (txtContactNo.Text == "")
            {
                Response.Write("<script>alert('Please input your contact number.');</script>");
                txtContactNo.Focus();
            }
            else if (txtUserName.Text == "")
            {
                Response.Write("<script>alert('Please input your email address.');</script>");
                txtUserName.Focus();
            }
            else if (chkCardPayment.Checked==false && chkCashOnDelivery.Checked==false)
            {
                Response.Write("<script>alert('Please select valid payment method.');</script>");
            }
            else if (chkCardPayment.Checked == true && txtNameOnCard.Text=="")
            {
                Response.Write("<script>alert('Please input name on your card.');</script>");
            }
            else if (chkCardPayment.Checked == true && txtCardNumber.Text == "")
            {
                Response.Write("<script>alert('Please input card number.');</script>");
            }
            else if (chkCardPayment.Checked == true && txtExpMonth.Text == "")
            {
                Response.Write("<script>alert('Please input expiry month of the card.');</script>");
            }
            else if (chkCardPayment.Checked == true && txtExpYear.Text == "")
            {
                Response.Write("<script>alert('Please input expiry year of the card.');</script>");
            }
            else if (chkCardPayment.Checked == true && txtCVC.Text == "")
            {
                Response.Write("<script>alert('Please input CVC number of the card.');</script>");
            }
            else
            {
                DataTable dt;
                dt = (DataTable)Session["ShoppingCard"];
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    SqlConnection con = new SqlConnection(strcon);
                    if (con.State == ConnectionState.Closed)
                    {
                        con.Open();
                    }

                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = $"INSERT INTO tbl_OrderDet(OrderID,SerialNo,CreateDate,CreateBy,ItemCode,ItemBarcode,ItemName,ItemCategory,ItemSubCategory," +
                        "ItemUPrice,ItemSPrice,ItemDPrice,Qty,DiscountValue,TotalPrice,ItemImgLink1," +
                        "CustomerID,CustomerFirstName,CustomerLastName,CustomerAddress,DeliveryAddress,EmailID," +
                        "CustomerImage,PaymentType,ContactNo,NameOnCard,CardNumber,ExpMonth,ExpYear,CVC,OrderStatus) " +
                        $"VALUES(@OrderID,@SerialNo,@CreateDate,@CreateBy,@ItemCode,@ItemBarcode,@ItemName,@ItemCategory,@ItemSubCategory," +
                        "@ItemUPrice,@ItemSPrice,@ItemDPrice,@Qty,@DiscountValue,@TotalPrice,@ItemImgLink1," +
                        "@CustomerID,@CustomerFirstName,@CustomerLastName,@CustomerAddress,@DeliveryAddress,@EmailID," +
                        "@CustomerImage,@PaymentType,@ContactNo,@NameOnCard,@CardNumber,@ExpMonth,@ExpYear,@CVC,@OrderStatus)";
                    cmd.Connection = con;

                    cmd.Parameters.AddWithValue("@OrderID", findorderid());
                    cmd.Parameters.AddWithValue("@SerialNo", dt.Rows[i]["SerialNo"]);
                    //cmd.Parameters.AddWithValue("@CompanyID", dt.Rows[i]["CompanyID"]);
                    cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@CreateBy", lblFirstName.Text+lblLastName.Text);
                    cmd.Parameters.AddWithValue("@ItemCode", dt.Rows[i]["ItemCode"]);
                    cmd.Parameters.AddWithValue("@ItemBarcode", dt.Rows[i]["ItemBarcode"]);
                    cmd.Parameters.AddWithValue("@ItemName", dt.Rows[i]["ItemName"]);
                    cmd.Parameters.AddWithValue("@ItemCategory", dt.Rows[i]["ItemCatName"]);
                    cmd.Parameters.AddWithValue("@ItemSubCategory", dt.Rows[i]["ItemSubCatName1"]);
                    cmd.Parameters.AddWithValue("@ItemUPrice", Convert.ToDouble((dt.Rows[i]["ItemUPrice"]).ToString()));
                    cmd.Parameters.AddWithValue("@ItemSPrice", Convert.ToDouble((dt.Rows[i]["ItemSPrice"]).ToString()));
                    cmd.Parameters.AddWithValue("@ItemDPrice", Convert.ToDouble((dt.Rows[i]["ItemDPrice"]).ToString()));
                    cmd.Parameters.AddWithValue("@Qty", Convert.ToDouble((dt.Rows[i]["Qty"]).ToString()));
                    cmd.Parameters.AddWithValue("@DiscountValue", Convert.ToDouble((dt.Rows[i]["DiscountValue"]).ToString()));
                    cmd.Parameters.AddWithValue("@TotalPrice", Convert.ToDouble((dt.Rows[i]["TotalPrice"]).ToString()));
                    cmd.Parameters.AddWithValue("@ItemImgLink1", dt.Rows[i]["imgPath"]);

                    cmd.Parameters.AddWithValue("@CustomerID",strCustomerID );
                    cmd.Parameters.AddWithValue("@CustomerFirstName",lblFirstName.Text);
                    cmd.Parameters.AddWithValue("@CustomerLastName",lblLastName.Text);
                    cmd.Parameters.AddWithValue("@CustomerAddress", strCustomerAddress);
                    cmd.Parameters.AddWithValue("@DeliveryAddress",lblAddress.Text);
                    cmd.Parameters.AddWithValue("@EmailID",lblEmail.Text);
                    cmd.Parameters.AddWithValue("@CustomerImage",strCustomerImage);

                    string strPaymentType = "";
                    if (chkCashOnDelivery.Checked==true)
                    {
                        strPaymentType = "Cash On delivery";
                    }
                    else if (chkCardPayment.Checked == true)
                    {
                        strPaymentType = "Card Payment";
                    }

                    cmd.Parameters.AddWithValue("@PaymentType", strPaymentType);
                    cmd.Parameters.AddWithValue("@ContactNo",lblContactNo.Text);
                    cmd.Parameters.AddWithValue("@NameOnCard",lblNameOnCard.Text);
                    cmd.Parameters.AddWithValue("@CardNumber", lblCardNumber.Text);
                    cmd.Parameters.AddWithValue("@ExpMonth",lblExpMonth.Text);
                    cmd.Parameters.AddWithValue("@ExpYear",lblExpYear.Text);
                    cmd.Parameters.AddWithValue("@CVC",lblCVC.Text);
                    cmd.Parameters.AddWithValue("@OrderStatus","Pending");

                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                ClientScript.RegisterStartupScript(this.GetType(), "randomtext", "alertOrderSuccess()", true);
                dt.Clear();
                strCustomerID = "";
                strCustomerImage = "";
                strCustomerAddress = "";
                clearForm();
               
                //ClientScript.RegisterStartupScript(this.GetType(), "Success", "<script type='text/javascript'>alert('Data has been submitted successfully!');window.location='DisplayAllProducts.aspx';</script>'");
                //Response.Redirect("DisplayAllProducts.aspx", true);
            }
        }

        public string findorderid()
        {
            String pass = "abcdefghijklmnopqrstuvwxyz123456789";
            Random r = new Random();
            char[] mypass = new char[5];
            for (int i = 0; i < 5; i++)
            {
                mypass[i] = pass[(int)(35 * r.NextDouble())];

            }
            String orderid;
            orderid = DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() + new string(mypass);

            AutoOrderID = orderid;
            return AutoOrderID;
        }

        void clearForm()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtFullAddress.Text = "";
            txtState.Text = "";
            txtCity.Text = "";
            txtPinCode.Text = "";
            txtContactNo.Text = "";
            txtUserName.Text = "";

            lblFirstName.Text = "";
            lblLastName.Text = "";
            lblAddress.Text = "";
            lblState.Text = "";
            lblCity.Text = "";
            lblPinCode.Text = "";
            lblContactNo.Text = "";
            lblEmail.Text = "";

            chkCashOnDelivery.Checked = true;
            chkCardPayment.Checked = false;

            lblPaymentMethod.Text = "";

            txtNameOnCard.Text = "";
            txtExpMonth.Text = "";
            txtExpYear.Text = "";
            txtCardNumber.Text = "";
            txtCVC.Text = "";

            lblNameOnCard.Text = "";
            lblCardNumber.Text = "";
            lblExpMonth.Text = "";
            lblExpYear.Text = "";
            lblCVC.Text = "";
        }

        protected void btnShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("DisplayAllProducts.aspx");
        }
    }
}