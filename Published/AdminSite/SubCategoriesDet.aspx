<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite/Admin.Master" AutoEventWireup="true" CodeBehind="SubCategoriesDet.aspx.cs" Inherits="eCommerce.AdminSite.WebForm3" %>
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
        <!--Top Header-->
        <div class="row pl-3">
            <div class="section-title">
                <h3 class="title pr-3">Sub Category Records</h3>
                <asp:LinkButton ID="btlGridView" Style="width: 40px; height: 40px; cursor: pointer;" runat="server" CssClass="btn btn-primary"><i class="fas fa-th-large"></i></asp:LinkButton>
                <asp:LinkButton ID="btnTableView" Style="width: 40px; height: 40px; cursor: pointer;" runat="server" CssClass="btn btn-primary"><i class="fas fa-list"></i></asp:LinkButton>
            </div>
        </div>
        <!--Top Header-->
        <!--Sub category Details-->
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12">
                        <asp:SqlDataSource ID="sqldsSubCategoryDet" runat="server"></asp:SqlDataSource>
                        <div class="col">
                            <asp:GridView class="table table-striped table-bordered" ID="grdSubCategoryDet" runat="server" AutoGenerateColumns="False" DataKeyNames="SubCatBCode">
                                <Columns>
                                    <asp:BoundField DataField="SubCatBCode" HeaderText="ID" ReadOnly="True" SortExpression="SubCatBCode" InsertVisible="False"></asp:BoundField>
                                    <asp:BoundField DataField="CatBCode" HeaderText="Category ID" SortExpression="CatBCode" />
                                    <asp:BoundField DataField="CatName" HeaderText="Category" SortExpression="CatName" />
                                    <asp:BoundField DataField="SubCatBCode" HeaderText="Sub Category ID" SortExpression="SubCatBCode" />
                                    <asp:BoundField DataField="SubCatName" HeaderText="Sub Category" SortExpression="SubCatName" />
                                    <%--<asp:ImageField DataImageUrlField="SubcategoryImage" HeaderText="Img">
                                                <ControlStyle Height="30px" Width="30px" />
                                            </asp:ImageField>--%>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Sub category Details-->
    </div>
</asp:Content>
