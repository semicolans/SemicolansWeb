<%@ Page Title="" Language="C#" MasterPageFile="~/UserSite/User.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="SemicolansWeb.UserSite.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        .auto-style3 {
            width: 162px;
        }

        table {
            border-collapse: collapse;
        }

        table, td, th {
            border: 1px solid blue;
        }

        th {
            background-color: dodgerblue;
            color: white;
        }
    </style>--%>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <asp:repeater id="rptResult" runat="server">
            <HeaderTemplate>
                <table class="auto-style1">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Created Date</th>
                    </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("ItemName") %></td>
                            <td><%#Eval("ItemCatName") %></td>
                            <td><%#Eval("ItemSupName") %></td>
                            <td><%#Eval("CreateDate") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:repeater>
    </div>

    <div style="margin-top: 20px;">
        <table style="width: 600px;">
            <tr>
                <td>
                    <asp:linkbutton id="lbFirst" runat="server" onclick="lbFirst_Click">First</asp:linkbutton>
                </td>
                <td>
                    <asp:linkbutton id="lbPrevious" runat="server" onclick="lbPrevious_Click">Previous</asp:linkbutton>
                </td>
                <td>
                    <asp:datalist id="rptPaging" runat="server" onitemcommand="rptPaging_ItemCommand" onitemdatabound="rptPaging_ItemDataBound" repeatdirection="Horizontal">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbPaging" runat="server" CommandArgument='<%# Eval("PageIndex") %>'  CommandName="newPage"
                                Text='<%# Eval("PageText") %> ' Width="20px">
						    </asp:LinkButton>
                        </ItemTemplate>
                    </asp:datalist>
                </td>
                <td>
                    <asp:linkbutton id="lbNext" runat="server" onclick="lbNext_Click">Next</asp:linkbutton>
                </td>
                <td>
                    <asp:linkbutton id="lbLast" runat="server" onclick="lbLast_Click">Last</asp:linkbutton>
                </td>
                <td>
                    <asp:label id="lblpage" runat="server" text=""></asp:label>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
