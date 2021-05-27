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
        <!--Top Header-->
        <div class="row pl-3">
            <div class="section-title">
                <h3 class="title pr-3">Category Records</h3>
                <asp:LinkButton ID="btlGridView" Style="width: 40px; height: 40px; cursor: pointer;" runat="server" CssClass="btn btn-primary"><i class="fas fa-th-large"></i></asp:LinkButton>
                <asp:LinkButton ID="btnTableView" Style="width: 40px; height: 40px; cursor: pointer;" runat="server" CssClass="btn btn-primary"><i class="fas fa-list"></i></asp:LinkButton>
            </div>
        </div>
        <!--Top Header-->
        <!--Category Records-->
        <div class="card" style="margin-top: 10px;">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12">
                        <asp:SqlDataSource ID="sqldsCategoryDet" runat="server"></asp:SqlDataSource>
                        <div class="col">
                            <asp:GridView class="table table-striped table-bordered " ID="grdCategoryDet" runat="server" AutoGenerateColumns="False" DataKeyNames="CatBCode">
                                <Columns>
                                    <asp:BoundField DataField="CatBCode" HeaderText="ID" ReadOnly="True" SortExpression="CatBCode">
                                        <ItemStyle Font-Bold="True" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CatName" HeaderText="Category Name" SortExpression="CatName" />
                                    <asp:BoundField DataField="CreateBy" HeaderText="CreateBy" SortExpression="CreateBy" />
                                    <asp:BoundField DataField="CreateDate" HeaderText="Date" SortExpression="Date" />
                                    <asp:ImageField DataImageUrlField="Remark" HeaderText="Img">
                                        <ControlStyle Height="5px" Width="5px" />
                                    </asp:ImageField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <!--Category Records-->
            </div>
    </div>
    </div>
</asp:Content>
