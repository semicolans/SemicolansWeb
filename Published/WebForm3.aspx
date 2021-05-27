<%@ Page Title="" Language="C#" MasterPageFile="~/UserSite/User.Master" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="SemicolansWeb.UserSite.WebForm3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        body {
            font-family: Arial;
            font-size: 10pt;
        }

        .Repeater, .Repeater td, .Repeater td {
            border: 1px solid #ccc;
        }

            .Repeater td {
                background-color: #eee !important;
            }

            .Repeater th {
                background-color: #6C6C6C !important;
                color: White;
                font-size: 10pt;
                line-height: 200%;
            }

            .Repeater span {
                color: black;
                font-size: 10pt;
                line-height: 200%;
            }

        .page_enabled, .page_disabled {
            display: inline-block;
            height: 20px;
            min-width: 20px;
            line-height: 20px;
            text-align: center;
            text-decoration: none;
            border: 1px solid #ccc;
        }

        .page_enabled {
            background-color: #eee;
            color: #000;
        }

        .page_disabled {
            background-color: #6C6C6C;
            color: #fff !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="Repeater" cellspacing="0" rules="all" border="1">
        <tr>
            <th scope="col" style="width: 80px">Customer Id
            </th>
            <th scope="col" style="width: 150px">Customer Name
            </th>
            <th scope="col" style="width: 150px">Company Name
            </th>
        </tr>
        <asp:Repeater ID="rptCustomers" runat="server">
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Label ID="lblCustomerId" runat="server" Text='<%# Eval("ItemBarcode") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblContactName" runat="server" Text='<%# Eval("ItemName") %>' />
                    </td>
                    <td>
                        <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("ItemSupName") %>' />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <br />
    <asp:Repeater ID="rptPager" runat="server">
        <ItemTemplate>
            <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                CssClass='<%# Convert.ToBoolean(Eval("Enabled")) ? "page_enabled" : "page_disabled" %>'
                OnClick="Page_Changed" OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'></asp:LinkButton>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
