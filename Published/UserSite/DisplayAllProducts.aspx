<%@ Page Title="" Language="C#" MasterPageFile="~/UserSite/User.Master" AutoEventWireup="true" CodeBehind="DisplayAllProducts.aspx.cs" Inherits="eCommerce.UserSite.WebForm1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--Styles For Repeater-->
    <style type="text/css">
        .auto-style1 {
            width: 40px;
            left: 0px;
            top: 7px;
        }
    </style>
<%--    <style type="text/css">
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
    </style>--%>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- BREADCRUMB -->
	<div id="breadcrumb" style="padding-top: 70px;">
		<div class="container-fluid">
			<ul class="breadcrumb">
				<li><a href="Default.aspx">Home</a></li>
				<li class="active">Products</li>
			</ul>
		</div>
	</div>
	<!-- /BREADCRUMB -->
	<!-- section -->
	<div class="section">
		<!-- container -->
		<div class="container-fluid">
			<!-- row -->
            <div class="row">
                <!-- ASIDE -->
                <div id="aside" class="col-sm-2 DesktopContent">
                    <!-- aside widget -->
                    <div class="aside">
                        <h3 class="aside-title">Filter by Category</h3>
                        <div class="row" style="padding-bottom: 3px;">
                            <div class="col-md-12">
                                <asp:TextBox ID="txtSearchCategory" runat="server" AutoCompleteType="Disabled" Style="width: 185px; height: 35px; border-radius: 5px;" class="input search-input" type="text" placeholder="Enter your keyword" OnkeyUp=" txtSearchSubCategory_TextChanged();"></asp:TextBox>
                                <asp:LinkButton ID="btnSearchCategory" Style="width: 40px; height: 35px; cursor: pointer;" runat="server" class="btn btn-primary" OnClick="btnSearchCategory_Click"><i class="fa fa-search"></i></asp:LinkButton>
                            </div>
                            <div class="col-md-12">
                                <asp:Label ID="lblFilteredCategory" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div id="changeHeight" style="position: relative; padding-top: 5px; overflow-y: scroll; overflow-x: hidden; width: 220px; height: 280px" class="scrollbar scrollbar-primary">
                            <asp:CheckBoxList Width="300px" Style="border-width: 1px;" ID="lstCategoryName" runat="server" Font-Size="Medium" Class="ChkBoxClass" Font-Bold="False" Font-Overline="True" CellPadding="1" CellSpacing="1" Font-Strikeout="False" Font-Underline="False" Font-Names="Corbel">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <!-- /aside widget -->

                    <!-- aside widget -->
                    <div class="aside">
                        <h3 class="aside-title">Filter by Sub Category</h3>
                        <div class="row" style="padding-bottom: 3px;">
                            <div class="col-md-12">
                                <asp:TextBox ID="txtSearchSubCategory" runat="server" AutoCompleteType="Disabled" Style="width: 185px; height: 35px; border-radius: 5px;" class="input search-input" type="text" placeholder="Enter your keyword"></asp:TextBox>
                                <asp:LinkButton ID="btnSearchSubCategory" Style="width: 40px; height: 35px;" runat="server" class="btn btn-primary" OnClick="btnSearchSubCategory_Click"><i class="fa fa-search"></i></asp:LinkButton>
                            </div>
                            <div class="col-md-12">
                                <asp:Label ID="lblFilteredSubCategory" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div style="padding-top: 5px; overflow-y: scroll; overflow-x: hidden; width: 220px; height: 230px" class="scrollbar scrollbar-primary">
                            <asp:CheckBoxList Width="230px" Style="border-width: 1px; cursor: pointer;" ID="lstSubCategoryName" runat="server" Font-Size="Medium" Class="ChkBoxClass" Font-Bold="False" Font-Overline="True" CellPadding="1" CellSpacing="1" Font-Strikeout="False" Font-Underline="False" Font-Names="Corbel"></asp:CheckBoxList>
                        </div>
                    </div>
                    <!-- /aside widget -->
                </div>
                <!-- /ASIDE -->

                <!-- MAIN -->
                <div id="main" class="col-sm-10">
                    <!-- store top filter -->
<%--                    <div class="store-filter clearfix" style="margin-left: 20px; margin-bottom: 15px;">
                        <div class="pull-left">
                            <div class="row">
                                <div class="row-filter">
                                    <a href="#"><i class="fa fa-th-large"></i></a>
                                    <a href="#" class="active"><i class="fa fa-bars"></i></a>
                                </div>
                                <div class="sort-filter">
                                    <select class="input">
                                        <option value="0">Position</option>
                                        <option value="0">Price</option>
                                        <option value="0">Rating</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>--%>
                    <hr />
					<!-- /store top filter -->

					<!-- STORE -->
						<!-- row -->
					<div class="row DesktopContent" style="margin-left: 20px;">
                            <!-- Product Single -->
                            <asp:Repeater ID="Repeater2" runat="server"></asp:Repeater>
                            <asp:DataList ID="dtlProductRecords" runat="server" RepeatColumns="5" pagesize="2" CssClass="auto-style1" OnItemCommand="dtlProductRecords_ItemCommand" OnItemDataBound="dtlProductRecords_ItemDataBound">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="product product-single" style="width:230px;height:400px;overflow: hidden;margin-left: 13px; margin-right: 10px;">
                                            <div class="product-thumb" style="width:230px;height:200px;overflow: hidden;">
                                                <div class="product-label">
                                                    <asp:Label ID="lblItemCode" runat="server" Visible="False"><%#Eval("ItemCode") %></asp:Label>
                                                    <asp:Label ID="lblProductType" runat="server" Visible='<%# Convert.ToString(Eval("ItemSaleType"))=="NEW"? true:false %>'><%#Eval("ItemSaleType") %></asp:Label>
                                                    <asp:Label class="sale" ID="lblDicountValue" runat="server" DataFormatString="{0:c}" Visible='<%# Convert.ToDecimal(Eval("ItemDPrice"))>0? true:false %>'><%#String.Format("{0:#,#.00}",(Convert.ToDecimal(Eval("ItemSPrice"))-Convert.ToDecimal(Eval("ItemDPrice"))))%> Off</asp:Label>
                                                </div>
<%--                                                <asp:LinkButton style="font-size:12px;top:70%;" ID="btnQuickView" runat="server" class="main-btn quick-view" CommandName="QuickView" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-search-plus"></i> View</asp:LinkButton>--%>
                                                <div style="height:250px;width:230px;overflow: hidden;">
                                                    <asp:Image Width="200px" Height="200px" ID="imgProductImage" runat="server" src='<%#"."+Eval("imgPath")%>' />
                                                </div>                                              
                                            </div>
<%--                                            <div class=" row product-rating" style="width:230px;height:30px;overflow: hidden;">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o empty"></i>
                                            </div>--%>
                                            <div class="row" style="height: 10px;"></div>
                                            <div class="product-body" style="width:230px;height:200px;overflow: hidden;">
                                                <div style="width:230px;overflow: hidden;">
                                                    <asp:Label ID="lblItemDPrice" runat="server">
                                                        <h5 class="product-price" style="font-size:18px;color: #F8694A;" >Rs. <%#Convert.ToDecimal(Eval("ItemDPrice"))>0?  String.Format("{0:#,#.00}",Eval("ItemDPrice")):String.Format("{0:#,#.00}",Eval("ItemSPrice")) %></h5>
                                                    </asp:Label>             
                                                </div>
                                                <div style="width:230px;margin-top:-10px; overflow: hidden;">
                                                    <asp:Label ID="lblItemSPrice" runat="server" >
                                                        <h3 class="product-price" style="font-size:18px;color: grey;"><del class="product-old-price"> <%#Convert.ToDecimal(Eval("ItemDPrice"))>0?  "Rs."+String.Format("{0:#,#.00}",Eval("ItemSPrice")):"" %></del></h3>
                                                    </asp:Label>
                                                </div>
                                                <div class="row" style="width:230px;height:60px;overflow: hidden;">
                                                    <div class="col-md-12">
                                                        <p style="font-size:14px;text-transform:uppercase;" class="product-name"><%#Eval("ItemName") %></p>
                                                    </div>
                                                </div>
                                                <div class="row product-btns">
                                                    <button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
                                                    <button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
                                                    <%--<asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))>0? true:false %>' CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-shopping-cart"></i> Add to Cart</asp:LinkButton>
                                                    <asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Comming Soon</asp:LinkButton>--%>

                                                    <asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard"  CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-shopping-cart"></i> Add</asp:LinkButton>
                                                    <%--<asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Comming Soon</asp:LinkButton>--%>
                                                    <asp:LinkButton style="font-size:12px;" class="main-btn icon-btn" ID="btnQuickView" runat="server"  CommandName="QuickView" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-search-plus"></i></asp:LinkButton>

                                                    <asp:LinkButton ID="btnMinus" Style="width: 40px;" runat="server" class="btn btn-danger btn-number glyphicon glyphicon-minus" data-type="minus" Visible="false" CommandName="MinusQty" CommandArgument='<%#Eval("ItemCode") %>'></asp:LinkButton>
                                                    <asp:TextBox ID="txtQty" runat="server" Style="width: 30px; height: 30px; margin-left: 10px; margin-right: 10px; text-align: center;" BorderStyle="None" Font-Size="Larger" Font-Bold="True" Visible="false">1</asp:TextBox>
                                                    <asp:LinkButton ID="btnPlus" Style="width: 40px;" runat="server" class="btn btn-success btn-number glyphicon glyphicon-plus" data-type="plus" Visible="false" CommandName="PlusQty" CommandArgument='<%#Eval("ItemCode") %>'></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:DataList>
							<!-- /Product Single -->
							<div class="clearfix visible-sm visible-xs"></div>
                        </div>
                    <div class="row TabContent">
                        <!-- Product Single -->
                        <asp:DataList ID="dtlProductRecordsTab" runat="server" RepeatColumns="4" pagesize="2" CssClass="auto-style1" OnItemCommand="dtlProductRecords_ItemCommand" OnItemDataBound="dtlProductRecords_ItemDataBound">
                            <ItemTemplate>
                                <div class="row">
                                    <div class="product product-single" style="width: 180px; height: 400px; overflow: hidden; margin-left: 13px; margin-right: 10px;">
                                        <div class="product-thumb" style="width: 180px; height: 200px; overflow: hidden;">
                                            <div class="product-label">
                                                <asp:Label ID="lblItemCode" runat="server" Visible="False"><%#Eval("ItemCode") %></asp:Label>
                                                <asp:Label ID="lblProductType" runat="server" Visible='<%# Convert.ToString(Eval("ItemSaleType"))=="NEW"? true:false %>'><%#Eval("ItemSaleType") %></asp:Label>
                                                <asp:Label class="sale" ID="lblDicountValue" runat="server" Visible='<%# Convert.ToDecimal(Eval("ItemDPrice"))>0? true:false %>'><%#String.Format("{0:#,#.00}",(Convert.ToDecimal(Eval("ItemSPrice"))-Convert.ToDecimal(Eval("ItemDPrice"))))%> Off</asp:Label>
                                            </div>
                                            <div style="height: 250px; width: 180px; overflow: hidden;">
                                                <asp:Image Width="180px" Height="180px" ID="imgProductImage" runat="server" src='<%#"."+Eval("imgPath")%>' />
                                            </div>
                                        </div>
                                        <div class="row" style="height: 10px;"></div>
                                        <div class="product-body" style="width: 180px; height: 200px; overflow: hidden;">
                                            <div style="width: 180px; height: 40px; overflow: hidden;">
                                                <asp:Label ID="lblItemDPrice" runat="server">
                                                        <h5 class="product-price" style="font-size:18px;color: #F8694A;">Rs. <%#Convert.ToDecimal(Eval("ItemDPrice"))>0?  String.Format("{0:#,#.00}",Eval("ItemDPrice")):String.Format("{0:#,#.00}",Eval("ItemSPrice")) %></h5>
                                                </asp:Label>
                                            </div>
                                            <div style="width: 180px; margin-top: -10px; overflow: hidden;">
                                                <asp:Label ID="lblItemSPrice" runat="server">
                                                        <h3 class="product-price" style="font-size:18px;color: grey;"><del class="product-old-price"> <%#Convert.ToDecimal(Eval("ItemDPrice"))>0?  "Rs."+String.Format("{0:#,#.00}",Eval("ItemSPrice")):"" %></del></h3>
                                                </asp:Label>
                                            </div>
                                            <div class="row" style="width: 180px; height: 60px; overflow: hidden;">
                                                <div class="col-md-12">
                                                    <p style="font-size: 14px; text-transform: uppercase;" class="product-name"><%#Eval("ItemName") %></p>
                                                </div>
                                            </div>
                                            <div class="row product-btns">
                                                <button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
                                                <button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
                                                <%--<asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))>0? true:false %>' CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-shopping-cart"></i> Add to Cart</asp:LinkButton>
                                                    <asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Comming Soon</asp:LinkButton>--%>

                                                <asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-shopping-cart"></i></asp:LinkButton>
                                                <%--<asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Comming Soon</asp:LinkButton>--%>
                                                <asp:LinkButton Style="font-size: 12px;" class="main-btn icon-btn" ID="btnQuickView" runat="server" CommandName="QuickView" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-search-plus"></i></asp:LinkButton>

                                                <asp:LinkButton ID="btnMinus" Style="width: 40px;" runat="server" class="btn btn-danger btn-number glyphicon glyphicon-minus" data-type="minus" Visible="false" CommandName="MinusQty" CommandArgument='<%#Eval("ItemCode") %>'></asp:LinkButton>
                                                <asp:TextBox ID="txtQty" runat="server" Style="width: 30px; height: 30px; margin-left: 10px; margin-right: 10px; text-align: center;" BorderStyle="None" Font-Size="Larger" Font-Bold="True" Visible="false">1</asp:TextBox>
                                                <asp:LinkButton ID="btnPlus" Style="width: 40px;" runat="server" class="btn btn-success btn-number glyphicon glyphicon-plus" data-type="plus" Visible="false" CommandName="PlusQty" CommandArgument='<%#Eval("ItemCode") %>'></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                        <!-- /Product Single -->
                        <div class="clearfix visible-sm visible-xs"></div>
                    </div>
                    <div class="row MobileContent">
                        <!-- Product Single -->
                        <asp:DataList ID="dtlProductRecordsMob" runat="server" RepeatColumns="2" pagesize="2" CssClass="auto-style1" OnItemCommand="dtlProductRecords_ItemCommand" OnItemDataBound="dtlProductRecords_ItemDataBound">
                            <ItemTemplate>
                                <div class="row">
                                    <div class="product product-single border" style="width: 180px; height: 340px; overflow: hidden; margin-left: 13px; margin-right: 10px;">
                                        <div class="product-thumb" style="width: 180px; height: 150px; overflow: hidden;">
                                            <div class="product-label">
                                                <asp:Label ID="lblItemCode" runat="server" Visible="False"><%#Eval("ItemCode") %></asp:Label>
                                                <asp:Label ID="lblProductType" runat="server" Visible='<%# Convert.ToString(Eval("ItemSaleType"))=="NEW"? true:false %>'><%#Eval("ItemSaleType") %></asp:Label>
                                                <asp:Label class="sale" ID="lblDicountValue" runat="server" Visible='<%# Convert.ToDecimal(Eval("ItemDPrice"))>0? true:false %>'><%#String.Format("{0:#,#.00}",(Convert.ToDecimal(Eval("ItemSPrice"))-Convert.ToDecimal(Eval("ItemDPrice"))))%> Off</asp:Label>
                                            </div>

                                            <div style="height: 180px; width: 180px; overflow: hidden;">
                                                <asp:Image Width="150px" Height="150px" ID="imgProductImage" runat="server" src='<%#"."+Eval("imgPath")%>' />
                                            </div>
                                        </div>

                                        <div class="product-body" style="width: 180px; height: 200px; overflow: hidden;">
                                            <div style="width: 180px; height: 40px; overflow: hidden;">
                                                <asp:Label ID="lblItemDPrice" runat="server">
                                                        <h5 class="product-price" style="font-size:20px;color: #F8694A;">Rs. <%#String.Format("{0:#,#.00}",(Eval("ItemSPrice"))) %></h5>
                                                </asp:Label>
                                            </div>
                                            <div style="width: 180px; margin-top: -10px; overflow: hidden;">
                                                <asp:Label ID="lblItemSPrice" runat="server">
                                                        <h3 class="product-price" style="font-size:18px;color: grey;"><del class="product-old-price"> <%#Convert.ToDecimal(Eval("ItemDPrice"))>0?  "Rs."+String.Format("{0:#,#.00}",Eval("ItemSPrice")):"" %></del></h3>
                                                </asp:Label>
                                            </div>
                                            <div class="row" style="width: 180px; height: 60px; overflow: hidden;">
                                                <div class="col-md-12">
                                                    <p style="font-size: 12px; text-transform: uppercase;" class="product-name"><%#Eval("ItemName") %></p>
                                                </div>
                                            </div>
                                            <div class="row product-btns">
                                                <button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
                                                <button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
                                                <%--<asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))>0? true:false %>' CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-shopping-cart"></i> Add to Cart</asp:LinkButton>
                                                    <asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Comming Soon</asp:LinkButton>--%>

                                                <asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-shopping-cart"></i></asp:LinkButton>
                                                <%--<asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Comming Soon</asp:LinkButton>--%>
                                                <asp:LinkButton Style="font-size: 12px;" class="main-btn icon-btn" ID="btnQuickView" runat="server" CommandName="QuickView" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCatName")+ ";" +Eval("ItemSubCatName1") %>'><i class="fa fa-search-plus"></i></asp:LinkButton>

                                                <asp:LinkButton ID="btnMinus" Style="width: 40px;" runat="server" class="btn btn-danger btn-number glyphicon glyphicon-minus" data-type="minus" Visible="false" CommandName="MinusQty" CommandArgument='<%#Eval("ItemCode") %>'></asp:LinkButton>
                                                <asp:TextBox ID="txtQty" runat="server" Style="width: 30px; height: 30px; margin-left: 10px; margin-right: 10px; text-align: center;" BorderStyle="None" Font-Size="Larger" Font-Bold="True" Visible="false">1</asp:TextBox>
                                                <asp:LinkButton ID="btnPlus" Style="width: 40px;" runat="server" class="btn btn-success btn-number glyphicon glyphicon-plus" data-type="plus" Visible="false" CommandName="PlusQty" CommandArgument='<%#Eval("ItemCode") %>'></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                        <!-- /Product Single -->
                        <div class="clearfix visible-sm visible-xs"></div>
                    </div>
                    <!-- /STORE -->

                    <!--Pagination Repetaer-->
                    <div class="container-fluid store-filter clearfix">
                        <div class="row col-sm-12" style="text-align: center;">
                            <ul class="store-pages">
                                <li>
                                    <asp:LinkButton CssClass="form-control" Style="margin-top: 1px; width: 40px; cursor: pointer;" ID="lbFirst" runat="server" OnClick="lbFirst_Click">
                                        <i class="fa fa-fast-backward" aria-hidden="true"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton  CssClass="form-control" Style="margin-top: 8px; width: 40px; cursor: pointer;" ID="lbPrevious" runat="server" OnClick="lbPrevious_Click">
                                        <i class="fa fa-step-backward" aria-hidden="true"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:DataList ID="rptPaging" runat="server" OnItemCommand="rptPaging_ItemCommand" OnItemDataBound="rptPaging_ItemDataBound" RepeatDirection="Horizontal">
                                        <ItemTemplate>
                                            <asp:LinkButton CssClass="form-control" Style="margin-top: 8px; width: 40px; cursor: pointer;" ID="lbPaging" runat="server" CommandArgument='<%# Eval("PageIndex") %>' CommandName="newPage"
                                                Text='<%# Eval("PageText") %> '>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </li>
                                <li>
                                    <asp:LinkButton  CssClass="form-control" Style="margin-top: 8px; width: 40px; cursor: pointer;" ID="lbNext" runat="server" OnClick="lbNext_Click"><i class="fa fa-step-forward" aria-hidden="true"></i></asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton  CssClass="form-control" Style="margin-top: 8px; width: 40px; cursor: pointer;" ID="lbLast" runat="server" OnClick="lbLast_Click"><i class="fa fa-fast-forward" aria-hidden="true"></i></asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                        <div class="row col-sm-12" style="text-align: center;margin-top:10px;">
                            <ul class="store-pages">
                                <li>
                                    <asp:Label ID="lblpage" runat="server" Text=""></asp:Label>
                                </li>
                            </ul>
                        </div>
                    </div>
<%--					<div class="store-filter clearfix">
						<div class="pull-right">
							<div class="page-filter">
								<span class="text-uppercase">Show:</span>
								<select class="input">
										<option value="0">10</option>
										<option value="1">20</option>
										<option value="2">30</option>
									</select>
                            </div>
                            <ul class="store-pages">
                                <li>
                                    <asp:LinkButton ID="Linkbutton1" runat="server" OnClick="lbFirst_Click"><i class="fa fa-fast-backward" aria-hidden="true"></i></asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="Linkbutton2" runat="server" OnClick="lbPrevious_Click"><i class="fa fa-step-backward" aria-hidden="true"></i></asp:LinkButton>
                                </li>
                                <li>
                                    <asp:DataList ID="Datalist1" runat="server" OnItemCommand="rptPaging_ItemCommand" OnItemDataBound="rptPaging_ItemDataBound" RepeatDirection="Horizontal">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbPaging" runat="server" CommandArgument='<%# Eval("PageIndex") %>' CommandName="newPage"
                                                Text='<%# Eval("PageText") %> ' Width="20px">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </li>
                                <li>
                                    <asp:LinkButton ID="Linkbutton3" runat="server" OnClick="lbNext_Click"><i class="fa fa-step-forward" aria-hidden="true"></i></asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="Linkbutton4" runat="server" OnClick="lbLast_Click"><i class="fa fa-fast-forward" aria-hidden="true"></i></asp:LinkButton>
                                </li>
                                <li>
                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                </li>
                            </ul>
						</div>
					</div>--%>
                    <!--Pagination Repetaer-->

<%--                    <div style="text-align: center">
                        <asp:Repeater ID="RepeaterPgNoFooter" runat="server" OnItemCommand="RepeaterPgNoFooter_ItemCommand">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkPage"
                                    Style="padding: 8px; margin: 2px; background: lightgray; border: solid 1px #666; color: black; font-weight: bold"
                                    CommandName="Page" CommandArgument="<%# Container.DataItem %>" runat="server" Font-Bold="True"><%# Container.DataItem %>  
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>--%>

					<!-- store bottom filter -->
					<!-- /store bottom filter -->
				</div>
				<!-- /MAIN -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
	<!-- /section -->
</asp:Content>
