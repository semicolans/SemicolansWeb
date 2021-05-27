<%@ Page Title="" Language="C#" MasterPageFile="~/UserSite/User.Master" AutoEventWireup="true" CodeBehind="ShoppingCard.aspx.cs" Inherits="eCommerce.UserSite.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
       /*.MobileContent{display:none;}
        @media only screen
        and (min-width:0px) and (max-width:375px){
            .DesktopContent {display:none;}
        } 
        @media only screen
        and (min-width:0px) and (max-width:375px){
            .MobileContent {display:inline;}
        } 
        @media only screen
        and (min-device-width:0px) and (max-device-width:375px){
            .DesktopContent {display:none;}
        } 
        @media only screen
        and (min-device-width:0px) and (max-device-width:375px){
            .MobileContent {display:inline;}
        }*/ 
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- BREADCRUMB -->
    <div id="breadcrumb" style="padding-top: 70px;">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="Default.aspx">Home</a></li>
                <li class="active">View Card</li>
            </ul>
        </div>
    </div>
    <!-- /BREADCRUMB -->

    <!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
            <div class="row">
                <div class="col-sm-6">
                    <div class="order-summary clearfix">
                        <div class="section-title">
                            <h3 class="title">Order Review</h3>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3 pt-4">
                    <div class="order-summary clearfix" style="margin-bottom: 15px;margin-top: 15px;">
                        <asp:LinkButton ID="btnRemoveAll" runat="server" class="btn btn-large btn-block btn-danger" Style="width: 100%; height: 37px;font-size:20px;">
                                REMOVE ALL
                        </asp:LinkButton>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="order-summary clearfix" style="margin-bottom: 15px;margin-top: 15px;">
                        <asp:LinkButton ID="btnShopping" runat="server" class="btn btn-large btn-block btn-primary" Style="width: 100%; height: 37px;font-size:20px;" OnClick="btnShopping_Click1">
                                CONTINUE TO SHOPPING
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-lg-9">
                    <div class="row DesktopContent">
                        <div class="col-md-12">
                            <div>
                                <div class="col-xs-5" style="background-color:#f1f2f6;border-radius:10px 0px 0px 10px">
                                    <p Style="font-size:18px;text-align:left;">Product</p>
                                </div>
                                <div class="col-xs-2" style="background-color:#f1f2f6;">
                                    <p Style="font-size:18px;text-align:center;">Quantity</p>
                                </div>
                                <div class="col-xs-2" style="background-color:#f1f2f6;">
                                    <p Style="font-size:18px;text-align:center;">Price</p>
                                </div>
                                <div class="col-xs-2" style="background-color:#f1f2f6;">
                                    <p Style="font-size:18px;text-align:center;">Total</p>
                                </div>
                                <div class="col-xs-1" style="background-color:#f1f2f6;border-radius:0px 10px 10px 0px">
                                    <p Style="font-size:18px;text-align:center;">Del</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="row DesktopContent">
                        <asp:GridView ID="grdShoppingCard" runat="server" AutoGenerateColumns="False" Width="858px" BorderWidth="0px" AllowCustomPaging="True" AllowPaging="True" CellSpacing="1" ShowHeader="False" OnRowCommand="grdShoppingCard_RowCommand">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="row>">
                                            <div class="col-md-1" style="text-align: left;">
                                                <asp:Image ID="Image1" Style="text-align: left;" Height="80px" Width="80px" runat="server" class="img-fluid p-2 thumb" ImageUrl='<%# "."+Eval("imgPath") %>'></asp:Image>
                                            </div>
                                            <div class="col-md-4" style="margin-top: 10px;">
                                                <p style="font-size: 16px; margin-left: 30px;"><%# Eval("ItemName") %></p>
                                            </div>
                                            <div class="col-md-2" style="margin-top: 20px;">
                                                <div>
                                                    <asp:LinkButton ID="btnMinus" Style="width: 30px; height: 30px" runat="server" class="btn btn-danger btn-number glyphicon glyphicon-minus" data-type="minus" Visible="True" CommandName="MinusQty" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                                                    <asp:TextBox ID="txtQty" runat="server" Style="width: 30px; height: 30px; text-align: center;" BorderStyle="None" Font-Size="Larger" Font-Bold="True" Text='<%# Eval("Qty") %>'></asp:TextBox>
                                                    <asp:LinkButton ID="btnPlus" Style="width: 30px; height: 30px;" runat="server" class="btn btn-success btn-number glyphicon glyphicon-plus" data-type="plus" Visible="True" CommandName="PlusQty" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                                                </div>
                                            </div>
                                            <div class="col-md-2 text-right" style="margin-top: 20px;">
                                                <div class="row">
                                                    <asp:Label ID="lblItemDPrice" runat="server" Font-Bold="True" Font-Size="Larger" Text='<%# Convert.ToDecimal(Eval("ItemDPrice"))>0?  String.Format("{0:#.00}",Eval("ItemDPrice")):String.Format("{0:#.00}",Eval("ItemSPrice")) %>' >
                                                    </asp:Label></h4>
                                                </div>
                                                <div class="row">
                                                    <del>
                                                        <asp:Label ID="lblItemSPrice" class="font-weak" runat="server" Style="color: #F8694A;" Font-Bold="True" Text='<%# String.Format("{0:#,#.00}",Eval("ItemSPrice")) %>' Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'>
                                                        </asp:Label></del></h5>
                                                </div>
                                            </div>
                                            <div class="col-md-2 text-right" style="margin-top: 20px;">
                                                <p>
                                                    <asp:Label ID="lblTotalPrice" runat="server" Font-Bold="True" Style="color: #F8694A;" Font-Size="Larger" Text='<%# Eval("TotalPrice") %>'></asp:Label>
                                                </p>
                                            </div>
                                            <div class="col-md-1 text-right" style="margin-top: 20px;">
                                                <asp:LinkButton ID="btnDeleteShoppingItem" runat="server" class="cancel-btn" CommandName="DeleteShoppingItem" CommandArgument='<%# Container.DataItemIndex %>'>
                                                                <i class="fa fa-trash"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle BorderColor="Silver" />
                        </asp:GridView>
                        <div style="margin-left:15px">
                            <asp:Label ID="lblEmptyShoppingCard" runat="server" Font-Bold="True" Style="color: #F8694A;" Font-Size="Larger" Text="Shopping Card is Empty."></asp:Label>
                        </div>
                    </div>
                    <div class="row MobileContent TabContent">
                        <asp:GridView ID="grdShoppingCardMob" runat="server" AutoGenerateColumns="False" Width="100%" BorderWidth="0px" AllowCustomPaging="True" AllowPaging="True" CellSpacing="1" ShowHeader="False" OnRowCommand="grdShoppingCard_RowCommand">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="product product-widget">
                                            <div class="row" style="margin-left:10px;margin-right:10px;">
                                                <div class="col-xs-5">
                                                    <div class="product-thumb">
                                                        <asp:Image ID="Image1" Style="text-align: left;" Height="80px" Width="80px" runat="server" class="img-fluid p-2 thumb" ImageUrl='<%# "."+Eval("imgPath") %>'></asp:Image>
                                                    </div>
                                                </div>
                                                <div class="col-xs-7" style="margin-left:10px;margin-right:10px;">
                                                    <div class="product-body">
                                                        <div class="row">
                                                            <h2 class="product-name"><a href="#"><%# Eval("ItemName") %></a></h2>
                                                        </div>
                                                        <div class="row">
                                                            <h3 class="product-price" ><%# Convert.ToDecimal(Eval("ItemDPrice"))>0?  String.Format("{0:#,#.00}",Eval("ItemDPrice")):String.Format("{0:#,#.00}",Eval("ItemSPrice")) %><span class="qty"> x<%# String.Format("{0:#,#.00}",Eval("Qty")) %></span></h3>
                                                        </div> 
                                                        <div class="row">
                                                            <del>
                                                        <asp:Label ID="lblItemSPrice" class="font-weak" runat="server" Style="color: #F8694A;" Font-Bold="True" Text='<%# String.Format("{0:#,#.00}",Eval("ItemSPrice")) %>' Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'>
                                                        </asp:Label></del></h5>
                                                        </div> 
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row pull-right" style="margin-right:10px;">
                                                <div>
                                                    <asp:LinkButton ID="btnMinusMob" Style="width: 30px; height: 30px" runat="server" class="btn btn-danger btn-number glyphicon glyphicon-minus" data-type="minus" Visible="True" CommandName="MinusQty" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                                                    <asp:TextBox ID="txtQtyMob" runat="server" Style="width: 30px; height: 30px; text-align: center;" BorderStyle="None" Font-Size="Larger" Font-Bold="True" Text='<%# String.Format("{0:#,#.00}",Eval("Qty")) %>'></asp:TextBox>
                                                    <asp:LinkButton ID="btnPlusMob" Style="width: 30px; height: 30px;" runat="server" class="btn btn-success btn-number glyphicon glyphicon-plus" data-type="plus" Visible="True" CommandName="PlusQty" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                                                </div>
                                                <div>
                                                    <asp:LinkButton ID="btnDeleteShoppingItem" runat="server" class="cancel-btn" CommandName="DeleteShoppingItem" CommandArgument='<%# Container.DataItemIndex %>'>
                                                       <i class="fa fa-trash"></i>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <%--<RowStyle BorderColor="Silver" />--%>
                        </asp:GridView>
                        <div style="margin-left:10px">
                            <asp:Label ID="lblEmptyShoppingCardMob" runat="server" Font-Bold="True" Style="color: #F8694A;" Font-Size="Larger" Text="Shopping Card is Empty."></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-12 col-lg-3">
                    <div class="row pull-right" style="margin-left:1px;width:260px;margin-right:1px;">
                        <table class="shopping-cart-table table" style="border:0px;">
                            <tfoot>
                                <tr style="border:0px;">
                                    <th style="border:0px;font-size:16px;border-radius: 10px 0px 0px 0px;">SUBTOTAL</th>
                                    <td style="text-align:right;font-size:16px; border:0px;border-radius: 0px 10px 0px 0px;"><asp:Label ID="lblSubTotal" runat="server" Font-Bold="True" class="sub-total" Text='<%# Eval("TotalPrice") %>'></asp:Label></td>
                                </tr>
                                <tr style="border:0px;">
                                    <th style="border:0px;font-size:16px;">SHIPING</th>
                                    <td colspan="2" style="text-align:right;font-size:16px;border:0px;">Free Shipping</td>
                                </tr>
                                <tr style="border:0px;">
                                    <th style="border:0px;font-size:20px;border-radius: 0px 0px 0px 10px;">TOTAL</th>
                                    <td style="text-align:right;font-size:20px;border:0px;border-radius: 0px 0px 10px 0px;"><asp:Label ID="lblNetTotal" runat="server" Font-Bold="True" class="total" style="color: #F8694A;" Font-Size="Larger" Text='<%# Eval("TotalPrice") %>'></asp:Label></td>
                                </tr>
                            </tfoot>
                        </table>
                        <br />
                        <div class="pull-right">
                            <asp:LinkButton ID="btnCheckOut" runat="server" class="btn primary-btn" Style="font-size:16px;" OnClick="btnCheckOut_Click">
                                 CHECKOUT<i class="fa fa-arrow-circle-right"></i>
                            </asp:LinkButton>                            
                        </div>
                    </div>
                </div>
            </div>
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->
</asp:Content>
