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

namespace eCommerce.UserSite
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            txtUserName.Focus();
        }

        //Add button Click
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (txtFirstName.Text == "")
            {
                Response.Write("<script>alert('Input First Name.');</script>");
            }
            else if (txtLastName.Text == "")
            {
                Response.Write("<script>alert('Input Last Name.');</script>");
            }
            else if (txtFullAddress.Text == "")
            {
                Response.Write("<script>alert('Input Address.');</script>");
            }
            else if (txtUserName.Text == "")
            {
                Response.Write("<script>alert('User Name or Email cannot be empty.');</script>");
            }
            else if (txtPassword.Text == "")
            {
                Response.Write("<script>alert('Password cannot be empty.');</script>");
            }
            else if (txtPassword.Text != txtConfirmPassword.Text)
            {
                Response.Write("<script>alert('Password Doesn't Match');</script>");
            }
            else
            {
                if (checkIfCustomerExists())
                {
                    Response.Write("<script>alert('User with this ID already Exist. You cannot add another User with the same ID');</script>");
                }
                else
                {
                    addNewCustomer();
                }
            }
        }

        //Check If the User Already Exists or Not
        bool checkIfCustomerExists()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"SELECT * FROM tbl_OrderCustomerDet WHERE Email='" +  txtUserName.Text + "'";
                cmd.Connection = con;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count >= 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }


            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
                return false;
            }
        }

        //Add New Customer
        void addNewCustomer()
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                }


                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"INSERT INTO tbl_OrderCustomerDet(FirstName,LastName,Email,Password,FullAddress,State,City,PinCode,Country,CountryCode, " +
                    $"ContactNo,Gender,DOB,imgLink,CreateDate,CreateBy,Status) " +
                    $"VALUES(@FirstName,@LastName,@Email,@Password,@FullAddress,@State,@City,@PinCode,@Country,@CountryCode, " +
                    $"@ContactNo,@Gender,@DOB,@imgLink,@CreateDate,@CreateBy,@Status)";
                cmd.Connection = con;

                cmd.Parameters.AddWithValue("@FirstName", ConvertFirstLetterUpper(txtFirstName.Text.Trim()));
                cmd.Parameters.AddWithValue("@LastName", ConvertFirstLetterUpper(txtLastName.Text.Trim()));
                cmd.Parameters.AddWithValue("@Email", txtUserName.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                cmd.Parameters.AddWithValue("@FullAddress", ConvertFirstLetterUpper(txtFullAddress.Text.Trim()));
                cmd.Parameters.AddWithValue("@State", ConvertFirstLetterUpper(txtState.Text.Trim()));
                cmd.Parameters.AddWithValue("@City", ConvertFirstLetterUpper(txtCity.Text.Trim()));
                cmd.Parameters.AddWithValue("@PinCode", txtPinCode.Text.Trim());
                cmd.Parameters.AddWithValue("@Country", cboCountry.Text.Trim());
                cmd.Parameters.AddWithValue("@CountryCode", cboCountry.Text.Trim());
                cmd.Parameters.AddWithValue("@ContactNo", txtContactNo.Text.Trim());
                cmd.Parameters.AddWithValue("@Gender", "");
                cmd.Parameters.AddWithValue("@DOB", "");
                cmd.Parameters.AddWithValue("@imgLink", "");
                cmd.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@CreateBy", "Admin");
                cmd.Parameters.AddWithValue("@Status", "Active");
                cmd.ExecuteNonQuery();
                con.Close();

                    SqlConnection con1 = new SqlConnection(strcon);
                    if (con1.State == ConnectionState.Closed)
                    {
                        con1.Open();
                    }

                    SqlCommand cmd1 = new SqlCommand();
                    cmd1.CommandText = $"SELECT * FROM tbl_OrderCustomerDet WHERE Email = '{ txtUserName.Text }'";
                    cmd1.Connection = con1;
                    SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);

                    if (dt1.Rows.Count >= 1)
                    {
                        Session["SCustomerID"]= dt1.Rows[0]["CustomerID"].ToString();
                        Session["SCustomerFirstName"] = dt1.Rows[0]["FirstName"].ToString();
                        Response.Redirect("DisplayAllProducts.aspx",false);
                    }
                    else
                    {
                        Response.Write("<script>alert('Invalid User ID');</script>");
                    }

                clearForm();
                Response.Write("<script>alert('You have successfully registered..');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void clearForm()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";

            txtUserName.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            txtFullAddress.Text = "";
            txtState.Text = "";
            txtCity.Text = "";
            txtPinCode.Text = "";
            txtCountryCode.Text = "";
            txtContactNo.Text = "";
        }


        //Title Case Letters
        static String ConvertFirstLetterUpper(String str)
        {
            char[] ch = str.ToCharArray();
            for (int i = 0; i < str.Length; i++)
            {
                if (i == 0 && ch[i] != ' ' ||
                    ch[i] != ' ' && ch[i - 1] == ' ')
                {
                    if (ch[i] >= 'a' && ch[i] <= 'z')
                    {
                        ch[i] = (char)(ch[i] - 'a' + 'A');
                    }
                }
                else if (ch[i] >= 'A' && ch[i] <= 'Z')
                    ch[i] = (char)(ch[i] + 'a' - 'A');
            }
            String st = new String(ch);
            return st;
        }

        //Generate Auto FileName
        public static string GetRandomPassword(int length)
        {
            char[] chars = "abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray();
            string password = string.Empty;
            Random random = new Random();

            for (int i = 0; i < length; i++)
            {
                int x = random.Next(1, chars.Length);
                //For avoiding Repetation of Characters
                if (!password.Contains(chars.GetValue(x).ToString()))
                    password += chars.GetValue(x);
                else
                    i = i - 1;
            }
            return password;
        }
    }
}