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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <!--Filter Categories-->
    <script type="text/javascript">
        function SearchCategory(txtSearchCategory, lstCategoryName) {
            if ($(txtSearchCategory).val() != "") {
                var count = 0;
                $(lstCategoryName).children('tbody').children('tr').each(function () {
                    var match = false;
                    $(this).children('td').children('label').each(function () {
                        if ($(this).text().toUpperCase().indexOf($(txtSearchCategory).val().toUpperCase()) > -1)
                            match = true;
                    });
                    if (match) {
                        $(this).show();
                        count++;
                    }
                    else { $(this).hide(); }
                });
                $('#spnCountMatchCategory').html((count) + ' match');
            }
            else {
                $(lstCategoryName).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
                $('#spnCountMatchCategory').html('');
            }
        }
    </script>
    <!--Filter Categories-->
    <!--Filter Sub Categories-->
    <script type="text/javascript">
        function SearchSubCategory(txtSearchSubCategory, lstSubCategoryName) {
            if ($(txtSearchSubCategory).val() != "") {
                var count = 0;
                $(lstSubCategoryName).children('tbody').children('tr').each(function () {
                    var match = false;
                    $(this).children('td').children('label').each(function () {
                        if ($(this).text().toUpperCase().indexOf($(txtSearchSubCategory).val().toUpperCase()) > -1)
                            match = true;
                    });
                    if (match) {
                        $(this).show();
                        count++;
                    }
                    else { $(this).hide(); }
                });
                $('#spnCountMatchSubCategory').html((count) + ' match');
            }
            else {
                $(lstSubCategoryName).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
                $('#spnCountMatchSubCategory').html('');
            }
        }
    </script>
    <!--Filter Sub Categories-->
    <!--Filter Make-->
    <script type="text/javascript">
        function SearchMake(txtSearchMake, lstMakeName) {
            if ($(txtSearchMake).val() != "") {
                var count = 0;
                $(lstMakeName).children('tbody').children('tr').each(function () {
                    var match = false;
                    $(this).children('td').children('label').each(function () {
                        if ($(this).text().toUpperCase().indexOf($(txtSearchMake).val().toUpperCase()) > -1)
                            match = true;
                    });
                    if (match) {
                        $(this).show();
                        count++;
                    }
                    else { $(this).hide(); }
                });
                $('#spnCountMatchMake').html((count) + ' match');
            }
            else {
                $(lstMakeName).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
                $('#spnCountMatchMake').html('');
            }
        }
    </script>
    <!--Filter Make-->
    <!--Filter Model-->
    <script type="text/javascript">
        function SearchModel(txtSearchModel, lstModelName) {
            if ($(txtSearchModel).val() != "") {
                var count = 0;
                $(lstModelName).children('tbody').children('tr').each(function () {
                    var match = false;
                    $(this).children('td').children('label').each(function () {
                        if ($(this).text().toUpperCase().indexOf($(txtSearchModel).val().toUpperCase()) > -1)
                            match = true;
                    });
                    if (match) {
                        $(this).show();
                        count++;
                    }
                    else { $(this).hide(); }
                });
                $('#spnCountMatchModel').html((count) + ' match');
            }
            else {
                $(lstModelName).children('tbody').children('tr').each(function () {
                    $(this).show();
                });
                $('#spnCountMatchModel').html('');
            }
        }
    </script>
    <!--Filter Model-->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="Scriptmanager1" runat="server" EnablePageMethods="true" EnablePartialRendering="true">
        <asp:Services>
            <asp:ServiceReference Path="TradeService.asmx" />
        </asp:Services>
    </asp:ScriptManager>
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
            <div class="row" style="margin-top: -30px;">
                <div id="aside" class="col-sm-2 DesktopContent">
                    <!-- aside widget Category -->
                    <div class="aside" id="FilterCatSection" runat="server">
                        <h4 class="aside-title" style="padding-bottom: 1px; width: 225px;">Category</h4>
                        <div class="row" style="padding-bottom: 3px;">
                            <div class="col-md-12">
                                <asp:TextBox ID="txtSearchCategory" runat="server" AutoCompleteType="Disabled" Style="width: 170px; height: 35px; border-radius: 5px;"
                                    class="input search-input" type="text" placeholder="Enter your keyword"
                                    onkeyup="SearchCategory(this,'#lstCategoryName');"></asp:TextBox>
                                <asp:LinkButton ID="btnClearCategory" Style="width: 40px; height: 35px; cursor: pointer;" runat="server" class="btn btn-primary" OnClick="btnClearCategory_Click"><i class="fa fa-trash-o" aria-hidden="true"></i></asp:LinkButton>
                                <span id="spnCountMatchCategory" style="font-size: small; font-family: Corbel"></span>
                            </div>
                            <div class="col-md-12">
                                <asp:Label Width="230px" placeholder="Selected Categories" Font-Size="small" Font-Names="Corbel" ID="lblFilteredCategory" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div id="changeHeight" style="position: relative; padding-top: 5px; overflow-y: scroll; overflow-x: hidden; width: 220px; max-height: 130px" class="scrollbar scrollbar-primary">
                            <asp:CheckBoxList AutoPostBack="true" Width="250px" RepeatColumns="1" Style="border-width: 1px;" ID="lstCategoryName" runat="server" ClientIDMode="Static"
                                Font-Size="small" Class="ChkBoxClass" Font-Bold="False" Font-Overline="false" CellPadding="1" CellSpacing="1" Font-Strikeout="False" Font-Underline="False" OnSelectedIndexChanged="lstCategoryName_SelectedIndexChanged">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <!-- /aside widget Category-->

                    <!-- aside widget Sub Category-->
                    <div class="aside" id="FilterSubCatSection" runat="server">
                        <h4 class="aside-title" style="padding-bottom: 1px; width: 225px;">Sub Category</h4>
                        <div class="row" style="padding-bottom: 3px;">
                            <div class="col-md-12">
                                <asp:TextBox ID="txtSearchSubCategory" runat="server" AutoCompleteType="Disabled" Style="width: 170px; height: 35px; border-radius: 5px;"
                                    class="input search-input" type="text" placeholder="Enter your keyword"
                                    onkeyup="SearchSubCategory(this,'#lstSubCategoryName');"></asp:TextBox>
                                <asp:LinkButton ID="btnSearchSubCategory" Style="width: 40px; height: 35px; cursor: pointer;" runat="server" class="btn btn-primary" OnClick="btnSearchSubCategory_Click"><i class="fa fa-trash-o" aria-hidden="true"></i></asp:LinkButton>
                                <span id="spnCountMatchSubCategory" style="font-size: small; font-family: Corbel"></span>
                            </div>
                            <div class="col-md-12">
                                <asp:Label Width="230px" Font-Size="small" Font-Names="Corbel" ID="lblFilteredSubCategory" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div id="changeHeightSubCat" style="position: relative; padding-top: 5px; overflow-y: scroll; overflow-x: hidden; width: 220px; max-height: 130px" class="scrollbar scrollbar-primary">
                            <asp:CheckBoxList AutoPostBack="true" Width="250px" RepeatColumns="1" Style="border-width: 1px;" ID="lstSubCategoryName" runat="server" ClientIDMode="Static"
                                Font-Size="small" Class="ChkBoxClass" Font-Bold="False" Font-Overline="false" CellPadding="1" CellSpacing="1" Font-Strikeout="False" Font-Underline="False" OnSelectedIndexChanged="lstSubCategoryName_SelectedIndexChanged">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <!-- /aside widget Sub Category-->

                    <!-- aside widget ItemMake-->
                    <div class="aside" id="FilterMakeSection" runat="server">
                        <h4 class="aside-title" style="padding-bottom: 1px; width: 225px;">Item Make</h4>
                        <div class="row" style="padding-bottom: 3px;">
                            <div class="col-md-12">
                                <asp:TextBox ID="txtSearchMake" runat="server" AutoCompleteType="Disabled" Style="width: 170px; height: 35px; border-radius: 5px;"
                                    class="input search-input" type="text" placeholder="Enter your keyword"
                                    onkeyup="SearchMake(this,'#lstMakeName');"></asp:TextBox>
                                <asp:LinkButton ID="btnSearchMake" Style="width: 40px; height: 35px; cursor: pointer;" runat="server" class="btn btn-primary" OnClick="btnSearchMake_Click"><i class="fa fa-trash-o" aria-hidden="true"></i></asp:LinkButton>
                                <span id="spnCountMatchMake" style="font-size: small; font-family: Corbel"></span>
                            </div>
                            <div class="col-md-12">
                                <asp:Label Width="230px" Font-Size="small" Font-Names="Corbel" ID="lblFilteredMake" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div id="changeHeightMake" style="position: relative; padding-top: 5px; overflow-y: scroll; overflow-x: hidden; width: 220px; max-height: 130px;" class="scrollbar scrollbar-primary">
                            <asp:CheckBoxList AutoPostBack="true" Width="250px" RepeatColumns="1" Style="border-width: 1px;" ID="lstMakeName" runat="server" ClientIDMode="Static"
                                Font-Size="small" Class="ChkBoxClass" Font-Bold="False" Font-Overline="false" CellPadding="1" CellSpacing="1" Font-Strikeout="False" Font-Underline="False" OnSelectedIndexChanged="lstMakeName_SelectedIndexChanged">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <!-- /aside widget ItemMake-->

                    <!-- aside widget ItemModel-->
                    <div class="aside" id="FilterModelSection" runat="server">
                        <h4 class="aside-title" style="padding-bottom: 1px; width: 225px;">Item Model</h4>
                        <div class="row" style="padding-bottom: 3px;">
                            <div class="col-md-12">
                                <asp:TextBox ID="txtSearchModel" runat="server" AutoCompleteType="Disabled" Style="width: 170px; height: 35px; border-radius: 5px;"
                                    class="input search-input" type="text" placeholder="Enter your keyword"
                                    onkeyup="SearchModel(this,'#lstModelName');"></asp:TextBox>
                                <asp:LinkButton ID="btnSearchModel" Style="width: 40px; height: 35px; cursor: pointer;" runat="server" class="btn btn-primary" OnClick="btnSearchModel_Click"><i class="fa fa-trash-o" aria-hidden="true"></i></asp:LinkButton>
                                <span id="spnCountMatchMode" style="font-size: small; font-family: Corbel"></span>
                            </div>
                            <div class="col-md-12">
                                <asp:Label Width="230px" Font-Size="small" Font-Names="Corbel" ID="lblFilteredModel" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                        <div id="changeHeightMode" style="position: relative; padding-top: 5px; overflow-y: scroll; overflow-x: hidden; width: 220px; max-height: 130px;" class="scrollbar scrollbar-primary">
                            <asp:CheckBoxList AutoPostBack="true" Width="250px" RepeatColumns="1" Style="border-width: 1px;" ID="lstModelName" runat="server" ClientIDMode="Static"
                                Font-Size="small" Class="ChkBoxClass" Font-Bold="False" Font-Overline="false" CellPadding="1" CellSpacing="1" Font-Strikeout="False" Font-Underline="False" OnSelectedIndexChanged="lstModelName_SelectedIndexChanged">
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <!-- /aside widget ItemMake-->
                    <!-- /ASIDE -->
                </div>
                <!-- MAIN -->
                <div id="main" class="col-sm-10">
					<!-- STORE -->
                    <div class="row" style="margin-top:24px;">
                        <div class="col-sm-4">
                            <div class="header-search" style="width:100%;">
                                <asp:TextBox ID="txtSearchProduct" runat="server" AutoCompleteType="Disabled" Style="width: 100%; height: 35px; border-radius: 5px;"
                                    class="input search-input" type="text" placeholder="Enter your keyword">
                                </asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="header-search" style="width:100%;">
                                <asp:DropDownList CssClass="form-control input search-categories" style="height: 35px; border-radius: 5px;" 
                                    ID="cboCategoryName" runat="server" placeholder="Categories">
                                </asp:DropDownList>
<%--                                <select class="input search-categories" style="height: 35px; border-radius: 5px;">
                                    <option value="0">All Categories</option>
                                    <option value="1">Category 01</option>
                                    <option value="1">Category 02</option>
                                </select>--%>
                            </div>
                        </div>
                    </div>

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
                                                    <asp:Label class="sale" ID="lblDicountValue" runat="server" Visible='<%# Convert.ToDecimal(Eval("ItemDPrice"))>0? true:false %>'>Rs. <%#String.Format("{0:#,#.00}",(Convert.ToDecimal(Eval("ItemSPrice"))-Convert.ToDecimal(Eval("ItemDPrice"))))%> Off</asp:Label>
                                                </div>
                                                <div style="height:200px;width:200px;overflow: hidden;">
                                                    <asp:Image Width="200px" Height="200px" ID="imgProductImage" runat="server" src='<%#"."+Eval("imgPath")%>' />
                                                </div>                                              
                                            </div>
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
