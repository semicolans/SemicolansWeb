<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite/Admin.Master" AutoEventWireup="true" CodeBehind="ProductDet.aspx.cs" Inherits="eCommerce.AdminSite.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
       $(document).ready(function () {
           $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).dataTable();
       });

       function readURL(input) {
           if (input.files && input.files[0]) {
               var reader = new FileReader();

               reader.onload = function (e) {
                   $('#imgview').attr('src', e.target.result);
               };

               reader.readAsDataURL(input.files[0]);
           }
       }
   </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <div class="container-fluid pt-2">
        <div class="row pl-3">
            <div class="section-title">  
                <h3 class="title pr-3">Product Records</h3>
                <asp:LinkButton ID="btlGridView" Style="width:40px;height:40px;cursor:pointer;" runat="server" CssClass="btn btn-primary" OnClick="btlGridView_Click"><i class="fas fa-th-large"></i></asp:LinkButton>
                <asp:LinkButton ID="btnTableView" Style="width:40px;height:40px;cursor:pointer;" runat="server" CssClass="btn btn-primary" OnClick="btnTableView_Click"><i class="fas fa-list"></i></asp:LinkButton>            
            </div>
        </div>
        <div class="card pl-2 pt-2 bg-light">
            <div class="form-group">
            <div class="row">
                <div class="col-s-12 col-md-2">
                    <div class="form-group">
                        <label>Category</label>
                        <asp:DropDownList CssClass="form-control" ID="cboCategoryName" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-s-12 col-md-2">
                    <div class="form-group">
                        <label>Sub Category</label>
                        <asp:DropDownList CssClass="form-control" ID="cboSubCategoryName" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-s-12 col-md-2">
                    <div class="form-group">
                        <label>Supplier</label>
                        <asp:DropDownList CssClass="form-control" ID="cboSupplierName" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-s-12 col-md-2">
                    <div class="form-group">
                        <label>Stock Level</label>
                        <asp:DropDownList CssClass="form-control" ID="cboStockLevel" runat="server">
                                <asp:ListItem>All</asp:ListItem>
                                <asp:ListItem>Status Ok</asp:ListItem>
                                <asp:ListItem>Out Of Stock</asp:ListItem>
                                <asp:ListItem>Minus Stock</asp:ListItem>
                                <asp:ListItem>Re Order Stock</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div  class="col-s-12 col-md-2">
                    <div class="form-group">
                        <label>Dis/Offer/W.S</label>
                        <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server">
                                <asp:ListItem>All</asp:ListItem>
                                <asp:ListItem>Discounted Items</asp:ListItem>
                                <asp:ListItem>L.Discouted Items</asp:ListItem>
                                <asp:ListItem>Offer Items</asp:ListItem>
                                <asp:ListItem>Wholesale Items</asp:ListItem>
                        </asp:DropDownList>
                    </div>                
                </div>
                <div  class="col-s-12 col-md-2">
                    <div class="form-group">
                        <label></label>
                        <asp:LinkButton CssClass="form-control" ID="btnSearch" Style="margin-top:8px;width:40px;cursor:pointer;" runat="server" OnClick="btnSearch_Click">
                            <i class="fa fa-search"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        </div>
        <div class="row pt-2">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col" id="ProductDetGridView" runat="server" visible="false">
                                    <%--table-striped--%>
                                    <asp:gridview class="table table-bordered" id="grdProductDet" runat="server" AutoGenerateColumns="False" >
                                        <Columns>
                                            <asp:BoundField DataField="ItemBarcode" HeaderText="ID" SortExpression="ItemBarcode" >
                                            <ItemStyle Font-Bold="True" />
                                            </asp:BoundField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                     <div class="conteiner-fluid">
                                                         <div class="row">
                                                             <div class="col-md-9">
                                                                 <div class="row">
                                                                     <div class="col-md-12">
                                                                        <asp:Label  style="text-transform:uppercase;" runat="server" ID="lblDtGridItemName" Text='<%# Eval("ItemName") %>' Font-Bold="True" Font-Size="X-Large" ForeColor="#FF9933"></asp:Label>
                                                                     </div>
                                                                 </div>
                                                                 <div class="row">
                                                                     <div class="col-md-12">
                                                                         Supplier :<asp:Label ID="Label2" runat="server" Font-Bold="True" Text='<%# Eval("ItemSupName") %>' Font-Size="Small"></asp:Label>
                                                                         &nbsp; | Category :<asp:Label ID="Label3" runat="server" Font-Bold="True" Text='<%# Eval("ItemCatName") %>' Font-Size="Small"></asp:Label>
                                                                         &nbsp;| Sub Category :<asp:Label ID="Label4" runat="server" Font-Bold="True" Text='<%# Eval("ItemSubCatName1") %>' Font-Size="Small"></asp:Label>
                                                                     </div>
                                                                 </div>
                                                                 <div class="row">
                                                                     <div class="col-md-12">
                                                                         Cost Price :<asp:Label ID="Label8" runat="server" Font-Bold="True" Text='<%# String.Format("{0:#,#.00}",Eval("ItemUPrice")) %>' Font-Size="Small"></asp:Label>
                                                                         &nbsp;| Retail Price :<asp:Label ID="Label9" runat="server" Font-Bold="True" Text='<%# String.Format("{0:#,#.00}",Eval("ItemSPrice")) %>' Font-Size="Small"></asp:Label>
                                                                         &nbsp;| Discount Price :<asp:Label ID="Label10" runat="server" Font-Bold="True" Text='<%# String.Format("{0:#,#.00}",Eval("ItemDPrice")) %>' Font-Size="Small"></asp:Label>
                                                                         &nbsp;| Availability :<asp:Label ID="Label1" runat="server" Font-Bold="True" Text='<%# String.Format("{0:#,#.00}",Eval("QtyRemain")) %>' Font-Size="Small"></asp:Label>
                                                                     </div>
                                                                 </div>
                                                             </div>
                                                             <div class="col-md-3 align-items-center">
                                                                <asp:Image Width="150px" Height="150px" ID="imgGtGrid" runat="server" class="img-fluid p-2" ImageUrl='<%# "."+Eval("imgPath") %>'></asp:Image>
                                                                 <%--<asp:Image Width="200px" Height="200px" ID="imgGtGrid" runat="server" class="img-fluid p-2" ImageUrl="..\Reports\Images\Product\1902.jpg"></asp:Image>--%>
                                                             </div>
                                                         </div>
                                                     </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:gridview>
                                </div>

                                <div class="row" id="ProductDetTableView" runat="server" visible="true">
                                    <div class="col-md-12">
                                        <div class="col">
                                            <asp:GridView class="table table-striped table-bordered " ID="grdProductDetTableView" runat="server" AutoGenerateColumns="False" >
                                                <Columns>
                                                    <asp:BoundField DataField="ItemBarCode" HeaderText="ID" ReadOnly="True" >
                                                        <ItemStyle Font-Bold="True" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ItemName" HeaderText="Item Name" />
                                                    <asp:BoundField DataField="QtyRemain" HeaderText="Quantity" DataFormatString="{0:N2}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="ItemAvgCost" HeaderText="Cost Price" DataFormatString="{0:#,#0.00}" HtmlEncode="False"/>
                                                    <asp:BoundField DataField="ItemSPrice" HeaderText="MRP" DataFormatString="{0:#,#0.00}" HtmlEncode="False"/>
                                                    <asp:BoundField DataField="ItemCatName" HeaderText="Category" />
                                                    <asp:BoundField DataField="ItemSupName" HeaderText="Supplier" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <br>
            </div>
        </div>
    </div>

    <%--Fixed Footer--%>
    <div id="FixedFooter">
        <div class="conteiner">
            <div class="row" style="float: right;height:100px;">
<%--                    <div class="pt-2 pr-1">
                    <asp:LinkButton ID="btnAdd" class="btn btn-success" runat="server"><i class="far fa-save"></i> Save</asp:LinkButton>
                </div>
                <div class="pt-2 pr-1">
                    <asp:LinkButton ID="btnModify" class="btn btn-warning" runat="server" ><i class="fas fa-edit"></i> Update</asp:LinkButton>                      
                </div>
                <div class="pt-2 pr-1">
                    <asp:LinkButton ID="btnDel" class="btn btn-danger" runat="server" ><i class="fas fa-trash-alt"></i> Delete</asp:LinkButton>
                </div>
                <div class="pt-2 pr-3" style="margin-left:5px;margin-right:20px;">
                    <asp:LinkButton ID="btnCls" class="btn btn-danger" runat="server" ><i class="fas fa-backspace"></i> Clear</asp:LinkButton>
                </div>--%>
            </div>
        </div>
    </div>
    </div>
</asp:Content>
