<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite/Admin.Master" AutoEventWireup="true" CodeBehind="CategoriesDet.aspx.cs" Inherits="eCommerce.AdminSite.WebForm1" %>
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
            <div class="col-md-12 col-lg-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col text-center">
                               <h4>Category List</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:SqlDataSource ID="sqldsCategoryDet" runat="server" ConnectionString="<%$ ConnectionStrings:eCommerceConnectionString %>" SelectCommand="SELECT [LocaCode],[CatCode],[CatBCode],[CatName],[Remark],[CreateDate],[CreateBy] FROM [tbl_Catdet]">
                                </asp:SqlDataSource>
                                <div class="col">
                                    <asp:GridView class="table table-striped table-bordered " ID="grdCategoryDet" runat="server" AutoGenerateColumns="False" DataKeyNames="CatBCode" DataSourceID="sqldsCategoryDet" >
                                        <Columns>
                                            <asp:BoundField DataField="CatBCode" HeaderText="ID" ReadOnly="True" SortExpression="CatBCode" >
                                            <ItemStyle Font-Bold="True" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CatName" HeaderText="Category Name" SortExpression="CatName" />
                                            <asp:BoundField DataField="CreateBy" HeaderText="CreateBy" SortExpression="CreateBy" />
                                            <asp:BoundField DataField="CreateDate" HeaderText="Date" SortExpression="Date" />
                                            <asp:ImageField DataImageUrlField="Remark" HeaderText="Img">
                                                <ControlStyle Height="30px" Width="30px" />
                                            </asp:ImageField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
</asp:Content>
