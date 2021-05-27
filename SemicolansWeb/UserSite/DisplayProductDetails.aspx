<%@ Page Title="" Language="C#" MasterPageFile="~/UserSite/User.Master" AutoEventWireup="true" CodeBehind="DisplayProductDetails.aspx.cs" Inherits="eCommerce.UserSite.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
        function AutoExpandDescription(MyBox) {
            MyBox.style.height = "1px";
            MyBox.style.height = (25 + MyBox.scrollHeight) + "px";
        }
    </script>
    <%--<script>tinymce.init({ selector: 'textarea' });</script>--%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- BREADCRUMB -->
    <div id="breadcrumb">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="Default.aspx">Home</a></li>
                <li><a href="DisplayAllProducts.aspx">Products</a></li>
                <li><a href="#">Category</a></li>
                <li class="active">ProProduct Name Goes Here</li>
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
                <!--  Product Details -->
                <div class="product product-details clearfix">
                    <asp:DataList ID="dtlProductDetails" runat="server" RepeatColumns="1" OnItemCommand="dtlProductDetails_ItemCommand">
                        <ItemTemplate>
                            <div class="col-md-6 align-items-center">
                                <div id="product-main-view">
                                    <div class="product-view">
                                        <asp:Image Width="300px" Height="300px" class="img-fluid" ID="imgProductImageview1" runat="server" src='<%#Eval("imgPath")%>' />
                                    </div>
                                    <div class="product-view">
                                        <asp:Image Width="300px" Height="300px" class="img-fluid" ID="Image1" runat="server" src='<%#Eval("imgPath")%>' />
                                    </div>
                                </div>

                                <div id="product-view">
                                    <div class="product-view">
                                        <asp:Image Width="100px" Height="100px" ID="imgProductImagethumb1" runat="server" src='<%#Eval("imgPath")%>' />
                                    </div>
                                    <div class="product-view">
                                        <asp:Image Width="100px" Height="100px" ID="imgProductImagethumb2" Visible='<%# Convert.ToString(Eval("imgPath"))!=""? true:false %>' runat="server" src='<%#Eval("imgPath")%>' />
                                    </div>
                                    <div class="product-view">
                                        <asp:Image Width="100px" Height="100px" ID="Image2" Visible='<%# Convert.ToString(Eval("imgPath"))!=""? true:false %>' runat="server" src='<%#Eval("imgPath")%>' />
                                    </div>
                                </div>
                            </div>
                            </div>
                            <div class="col-md-6">
                                <div class="row" style="align-items: center;">
                                    <div class="product-body">
                                        <div class="product-label">
                                            <asp:Label ID="lblItemCodeSingle" runat="server" Visible="False"><%#Eval("ItemCode") %></asp:Label>
                                            <asp:Label ID="lblProductTypeSingle" runat="server" Visible='<%# Convert.ToString(Eval("ItemSaleType"))=="NEW"? true:false %>'><%#Eval("ItemSaleType") %></asp:Label>
                                            <asp:Label class="sale" ID="lblDicountValueSingle" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'><%#Eval("DiscountValue")%>%</asp:Label>
                                        </div>
                                        <h2 class="product-name"><%#Eval("ItemName") %></h2>
                                        <div>
                                            <span>
                                                <asp:Label ID="lblItemDPriceSingle" runat="server"><h1 class="product-price" style="color: #F8694A;">Rs. <%#Eval("ItemDPrice") %></h1></asp:Label></span>
                                            <asp:Label ID="lblItemSPriceSingle" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'><h3 class="product-price"><del class="product-old-price" style="color: black;">  Rs.<%#Eval("ItemSPrice") %></del></h3></asp:Label>
                                        </div>
                                        <div class="product-rating">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star-o empty"></i>
                                        </div>
                                        <a href="#">3 Review(s) / Add Review</a>
                                    </div>
                                    <asp:Label ID="Label1" runat="server" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))>0? true:false %>'><p style="color:green;"><strong>Availability: </strong> In Stock</p></asp:Label>
                                    <asp:Label ID="Label2" runat="server" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'><p style="color:red;"><strong>Availability: </strong> Out Of Stock</p></asp:Label>
                                    <asp:Label ID="Label3" runat="server" Visible='<%# Convert.ToString(Eval("ItemBrand"))!=""? true:false %>'><p><strong>Brand: </strong><%#Eval("ItemBrand") %></p></asp:Label>
                                    <p><%#Eval("Itemdescription") %></p>

                                    <div class="product-btns">
                                        <div class="qty-input">
                                            <asp:LinkButton ID="btnMinusSingle" Style="width: 40px; height: 40px" runat="server" class="btn btn-danger btn-number glyphicon glyphicon-minus" data-type="minus" Visible="True" CommandName="MinusQty"></asp:LinkButton>
                                            <asp:TextBox ID="txtQtySingle" runat="server" Style="width: 40px; height: 40px; text-align: center;" BorderStyle="None" Font-Size="Larger" Font-Bold="True" Text='1'></asp:TextBox>
                                            <asp:LinkButton ID="btnPlusSingle" Style="width: 40px; height: 40px;" runat="server" class="btn btn-success btn-number glyphicon glyphicon-plus" data-type="plus" Visible="True" CommandName="PlusQty"></asp:LinkButton>
                                        </div>
                                        <asp:LinkButton ID="btnAddToCardSingle" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))>0? true:false %>' CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCategory")+ ";" +Eval("ItemSubCategory") %>'><i class="fa fa-shopping-cart"></i> Add to Cart</asp:LinkButton>
                                        <div class="pull-right">
                                            <button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
                                            <button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
                                            <button class="main-btn icon-btn"><i class="fa fa-share-alt"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>

                            <div class="col-md-12">
                                <div class="product-tab">
                                    <ul class="tab-nav">
                                        <li class="active"><a data-toggle="tab" href="#tab1">Description</a></li>
                                        <li><a data-toggle="tab" href="#tab1">Details</a></li>
                                        <li><a data-toggle="tab" href="#tab2">Reviews (3)</a></li>
                                    </ul>
                                    <div class="tab-content">
                                        <div id="tab" class="tab-pane fade in active">
                                            <div><%#Eval("Itemdescription") %></div>
                                        </div>
                                        <div id="tab1" class="tab-pane fade in active">
                                            <div>Descriptions</div>
                                        </div>
                                        <div id="tab2" class="tab-pane fade in">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="product-reviews">
                                                        <div class="single-review">
                                                            <div class="review-heading">
                                                                <div><a href="#"><i class="fa fa-user-o"></i>John</a></div>
                                                                <div><a href="#"><i class="fa fa-clock-o"></i>27 DEC 2017 / 8:0 PM</a></div>
                                                                <div class="review-rating pull-right">
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star-o empty"></i>
                                                                </div>
                                                            </div>
                                                            <div class="review-body">
                                                                <p>
                                                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                                                                </p>
                                                            </div>
                                                        </div>

                                                        <div class="single-review">
                                                            <div class="review-heading">
                                                                <div><a href="#"><i class="fa fa-user-o"></i>John</a></div>
                                                                <div><a href="#"><i class="fa fa-clock-o"></i>27 DEC 2017 / 8:0 PM</a></div>
                                                                <div class="review-rating pull-right">
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star-o empty"></i>
                                                                </div>
                                                            </div>
                                                            <div class="review-body">
                                                                <p>
                                                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                                                                </p>
                                                            </div>
                                                        </div>

                                                        <div class="single-review">
                                                            <div class="review-heading">
                                                                <div><a href="#"><i class="fa fa-user-o"></i>John</a></div>
                                                                <div><a href="#"><i class="fa fa-clock-o"></i>27 DEC 2017 / 8:0 PM</a></div>
                                                                <div class="review-rating pull-right">
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star"></i>
                                                                    <i class="fa fa-star-o empty"></i>
                                                                </div>
                                                            </div>
                                                            <div class="review-body">
                                                                <p>
                                                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                                                                </p>
                                                            </div>
                                                        </div>

                                                        <ul class="reviews-pages">
                                                            <li class="active">1</li>
                                                            <li><a href="#">2</a></li>
                                                            <li><a href="#">3</a></li>
                                                            <li><a href="#"><i class="fa fa-caret-right"></i></a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <h4 class="text-uppercase">Write Your Review</h4>
                                                    <p>Your email address will not be published.</p>
                                                    <form class="review-form">
                                                        <div class="form-group">
                                                            <input class="input" type="text" placeholder="Your Name" />
                                                        </div>
                                                        <div class="form-group">
                                                            <input class="input" type="email" placeholder="Email Address" />
                                                        </div>
                                                        <div class="form-group">
                                                            <textarea class="input" placeholder="Your review"></textarea>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="input-rating">
                                                                <strong class="text-uppercase">Your Rating: </strong>
                                                                <div class="stars">
                                                                    <input type="radio" id="star5" name="rating" value="5" /><label for="star5"></label>
                                                                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4"></label>
                                                                    <input type="radio" id="star3" name="rating" value="3" /><label for="star3"></label>
                                                                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2"></label>
                                                                    <input type="radio" id="star1" name="rating" value="1" /><label for="star1"></label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <button class="primary-btn">Submit</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </div>
                <!-- /Product Details -->
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /section -->

    <!-- section -->
    <div class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <!-- section title -->
                <div class="col-md-12">
                    <div class="section-title">
                        <h2 class="title">
                        Related Products </h2>
                    </div>
                </div>
                <!-- section title -->
                <!-- STORE -->
                <!-- row -->
					<!-- STORE -->
						<!-- row -->
                        <div class="row DesktopContent">
                            <!-- Product Single -->
                            <asp:DataList ID="dtlProductRecords" runat="server" RepeatColumns="7" pagesize="2" CssClass="auto-style1" OnItemCommand="dtlProductRecords_ItemCommand">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="product product-single" style="width:180px;height:380px;overflow: hidden;margin-left: 13px; margin-right: 10px;">
                                            <div class="product-thumb" style="width:180px;height:180px;overflow: hidden;">
                                                <div class="product-label">
                                                    <asp:Label ID="lblItemCode" runat="server" Visible="False"><%#Eval("ItemCode") %></asp:Label>
                                                    <asp:Label ID="lblProductType" runat="server" Visible='<%# Convert.ToString(Eval("ItemType"))=="NEW"? true:false %>'><%#Eval("ItemType") %></asp:Label>
                                                    <asp:Label class="sale" ID="lblDicountValue" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'><%#Eval("DiscountValue")%>%</asp:Label>
                                                </div>
                                                <asp:LinkButton style="font-size:12px;top:70%;width:120px" ID="btnQuickView" runat="server" class="main-btn quick-view" CommandName="QuickView" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCategory")+ ";" +Eval("ItemSubCategory") %>'><i class="fa fa-search-plus"></i> Quick view</asp:LinkButton>
                                                <div style="width:180px;height:180px;overflow: hidden;">
                                                    <asp:Image Width="160px" Height="160px" ID="imgProductImage" runat="server" src='<%#Eval("imgLink1")%>' />
                                                </div>                                              
                                            </div>
                                            <div class=" row product-rating" style="width:180px;height:15px;overflow: hidden;">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o empty"></i>
                                            </div>
                                            <div class="row" style="height: 10px;"></div>
                                            <div class="product-body" style="width:180px;height:200px;overflow: hidden;">
                                                <div style="width:180px;height:40px;overflow: hidden;">
                                                    <asp:Label ID="lblItemDPrice" runat="server">
                                                        <h5 class="product-price" style="font-size:20px;color:#F8694A;margin-bottom:0px;">Rs. <%#Eval("ItemDPrice") %></h5>
                                                    </asp:Label>
                                                    <asp:Label ID="lblItemSPrice" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'>
                                                        <h3 class="product-price" style="font-size:18px;color:black;margin-top:0px;""><del class="product-old-price">  Rs.<%#Eval("ItemSPrice") %></del></h3>
                                                    </asp:Label>
                                                </div>
                                                <div class="row" style="width:180px;height:50px;overflow: hidden;">
                                                    <div class="col-md-12">
                                                        <p style="font-size:12px;text-transform:uppercase;" class="product-name"><%#Eval("ItemName") %></p>
                                                    </div>
                                                </div>
                                                <div class="row product-btns">
                                                    <button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
                                                    <button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
                                                    <asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))>0? true:false %>' CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCategory")+ ";" +Eval("ItemSubCategory") %>'><i class="fa fa-shopping-cart"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Z</asp:LinkButton>

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
                            <asp:DataList ID="dtlProductRecordsMob" runat="server" RepeatColumns="2" pagesize="2" CssClass="auto-style1" OnItemCommand="dtlProductRecords_ItemCommand">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="product product-single" style="width:180px;height:380px;overflow: hidden;margin-left: 13px; margin-right: 10px;">
                                            <div class="product-thumb" style="width:180px;height:180px;overflow: hidden;">
                                                <div class="product-label">
                                                    <asp:Label ID="lblItemCode" runat="server" Visible="False"><%#Eval("ItemCode") %></asp:Label>
                                                    <asp:Label ID="lblProductType" runat="server" Visible='<%# Convert.ToString(Eval("ItemType"))=="NEW"? true:false %>'><%#Eval("ItemType") %></asp:Label>
                                                    <asp:Label class="sale" ID="lblDicountValue" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'><%#Eval("DiscountValue")%>%</asp:Label>
                                                </div>
                                                <asp:LinkButton style="font-size:12px;top:70%;width:120px" ID="btnQuickView" runat="server" class="main-btn quick-view" CommandName="QuickView" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCategory")+ ";" +Eval("ItemSubCategory") %>'><i class="fa fa-search-plus"></i> Quick view</asp:LinkButton>
                                                <div style="width:180px;height:180px;overflow: hidden;">
                                                    <asp:Image Width="160px" Height="160px" ID="imgProductImage" runat="server" src='<%#Eval("imgLink1")%>' />
                                                </div>                                              
                                            </div>
                                            <div class=" row product-rating" style="width:180px;height:15px;overflow: hidden;">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o empty"></i>
                                            </div>
                                            <div class="row" style="height: 10px;"></div>
                                            <div class="product-body" style="width:180px;height:200px;overflow: hidden;">
                                                <div style="width:180px;height:40px;overflow: hidden;">
                                                    <asp:Label ID="lblItemDPrice" runat="server">
                                                        <h5 class="product-price" style="font-size:20px;color:#F8694A;margin-bottom:0px;">Rs. <%#Eval("ItemDPrice") %></h5>
                                                    </asp:Label>
                                                    <asp:Label ID="lblItemSPrice" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'>
                                                        <h3 class="product-price" style="font-size:18px;color:black;margin-top:0px;""><del class="product-old-price">  Rs.<%#Eval("ItemSPrice") %></del></h3>
                                                    </asp:Label>
                                                </div>
                                                <div class="row" style="width:180px;height:50px;overflow: hidden;">
                                                    <div class="col-md-12">
                                                        <p style="font-size:12px;text-transform:uppercase;" class="product-name"><%#Eval("ItemName") %></p>
                                                    </div>
                                                </div>
                                                <div class="row product-btns">
                                                    <button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
                                                    <button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
                                                    <asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))>0? true:false %>' CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCategory")+ ";" +Eval("ItemSubCategory") %>'><i class="fa fa-shopping-cart"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Z</asp:LinkButton>

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
                            <asp:DataList ID="dtlProductRecordsTab" runat="server" RepeatColumns="4" pagesize="2" CssClass="auto-style1" OnItemCommand="dtlProductRecords_ItemCommand">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="product product-single" style="width:180px;height:380px;overflow: hidden;margin-left: 13px; margin-right: 10px;">
                                            <div class="product-thumb" style="width:180px;height:180px;overflow: hidden;">
                                                <div class="product-label">
                                                    <asp:Label ID="lblItemCode" runat="server" Visible="False"><%#Eval("ItemCode") %></asp:Label>
                                                    <asp:Label ID="lblProductType" runat="server" Visible='<%# Convert.ToString(Eval("ItemType"))=="NEW"? true:false %>'><%#Eval("ItemType") %></asp:Label>
                                                    <asp:Label class="sale" ID="lblDicountValue" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'><%#Eval("DiscountValue")%>%</asp:Label>
                                                </div>
                                                <asp:LinkButton style="font-size:12px;top:70%;width:120px" ID="btnQuickView" runat="server" class="main-btn quick-view" CommandName="QuickView" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCategory")+ ";" +Eval("ItemSubCategory") %>'><i class="fa fa-search-plus"></i> Quick view</asp:LinkButton>
                                                <div style="width:180px;height:180px;overflow: hidden;">
                                                    <asp:Image Width="160px" Height="160px" ID="imgProductImage" runat="server" src='<%#Eval("imgLink1")%>' />
                                                </div>                                              
                                            </div>
                                            <div class=" row product-rating" style="width:180px;height:15px;overflow: hidden;">
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                                <i class="fa fa-star-o empty"></i>
                                            </div>
                                            <div class="row" style="height: 10px;"></div>
                                            <div class="product-body" style="width:180px;height:200px;overflow: hidden;">
                                                <div style="width:180px;height:40px;overflow: hidden;">
                                                    <asp:Label ID="lblItemDPrice" runat="server">
                                                        <h5 class="product-price" style="font-size:20px;color:#F8694A;margin-bottom:0px;">Rs. <%#Eval("ItemDPrice") %></h5>
                                                    </asp:Label>
                                                    <asp:Label ID="lblItemSPrice" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'>
                                                        <h3 class="product-price" style="font-size:18px;color:black;margin-top:0px;""><del class="product-old-price">  Rs.<%#Eval("ItemSPrice") %></del></h3>
                                                    </asp:Label>
                                                </div>
                                                <div class="row" style="width:180px;height:50px;overflow: hidden;">
                                                    <div class="col-md-12">
                                                        <p style="font-size:12px;text-transform:uppercase;" class="product-name"><%#Eval("ItemName") %></p>
                                                    </div>
                                                </div>
                                                <div class="row product-btns">
                                                    <button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
                                                    <button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
                                                    <asp:LinkButton ID="btnAddToCard" runat="server" class="primary-btn add-to-cart" CommandName="AddToCard" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))>0? true:false %>' CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCategory")+ ";" +Eval("ItemSubCategory") %>'><i class="fa fa-shopping-cart"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="btnComingSoon" runat="server" class="btn primary-btn" Style="background-color: darkblue;" Visible='<%# Convert.ToDecimal(Eval("QtyRemain"))<=0? true:false %>'>Z</asp:LinkButton>

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
						<!-- /row -->
					<!-- /STORE -->
                <!-- /row -->
                <!-- /STORE -->
                <%--                <div class="row">
                    <div class="col-md-2">
				        <!-- Product Single -->
                        <asp:DataList ID="dtlProductRecords" runat="server" RepeatColumns="6" CssClass="auto-style1" OnItemCommand="dtlProductRecords_ItemCommand">
                            <ItemTemplate>
                                <div class="product product-single">
                                    <div class="product-thumb">
                                        <div class="product-label">
                                            <asp:Label ID="lblProductTypeAll" runat="server" Visible='<%# Convert.ToString(Eval("ItemType"))=="NEW"? true:false %>'><%#Eval("ItemType") %></asp:Label>
                                            <asp:Label class="sale" ID="lblDicountValueAll" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'><%#Eval("DiscountValue")%>%</asp:Label>
                                        </div>
                                        <asp:LinkButton ID="btnQuickViewAll" Style="width: 130px;" runat="server" class="main-btn quick-view" CommandName="QuickViewAll" CommandArgument='<%#Eval("ItemCode")+ ";" +Eval("ItemCategory")+ ";" +Eval("ItemSubCategory") %>'><i class="fa fa-search-plus"></i>Quick View</asp:LinkButton>

                                        <asp:Image Width="150px" Height="150px" class="img-fluid" ID="imgProductImage" runat="server" src='<%#Eval("imgLink1")%>' />
                                    </div>
                                    <div class=" row product-rating" style="text-align: left;">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star-o empty"></i>
                                    </div>
                                    <div class="product-body">
                                        <asp:Label ID="lblItemDPriceAll" runat="server"><h3 class="product-price" style="color: #F8694A;">Rs. <%#Eval("ItemDPrice") %></h3></asp:Label>
                                        <asp:Label ID="lblItemSPriceAll" runat="server" Visible='<%# Convert.ToDecimal(Eval("DiscountValue"))>0? true:false %>'><h3 class="product-price" style="color:black;"><del class="product-old-price">  Rs.<%#Eval("ItemSPrice") %></del></h3></asp:Label>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <h2 class="product-name"><%#Eval("ItemName") %></h2>
                                            </div>
                                        </div>

                                        <div class="row product-btns">
                                            <button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
                                            <button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
                                            <button class="primary-btn add-to-cart"><i class="fa fa-shopping-cart"></i></button>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </div>--%>
            </div>

            <!-- /Product Single -->
        </div>
        <!-- /row -->
    </div>
    <!-- /container -->
    <!-- /section -->
</asp:Content>
