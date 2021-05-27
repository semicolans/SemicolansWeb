<%@ Page Title="" Language="C#" MasterPageFile="~/AdminSite/Admin.Master" AutoEventWireup="true" CodeBehind="SupplierDet.aspx.cs" Inherits="SemicolansWeb.SupplierDet" %>
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
                <h3 class="title pr-3">Supplier Records</h3>
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
                        <div class="col">
                            <asp:GridView class="table table-striped table-bordered " ID="grdSupplierDet" runat="server" AutoGenerateColumns="False" DataKeyNames="SupUniqID">
                                <Columns>
                                    <asp:BoundField DataField="SupUniqID" HeaderText="ID" ReadOnly="True">
                                        <ItemStyle />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="row">
                                                <div class="col-md-9">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label Style="text-transform: uppercase;" runat="server" Text='<%# Eval("SupName") %>' ></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Small"
                                                                Text='<%# Eval("SupAddress").ToString() + " " + Eval("SupAddress2").ToString() %>'>
                                                            </asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label ID="Label1" runat="server" Font-Bold="true" ForeColor="#FF9933" Text-Align="Right"
                                                                Text='<%# "B/L Rs. " +  String.Format("{0:#,#.00}",(Convert.ToDecimal(Eval("OpeningBalance"))+Convert.ToDecimal(Eval("DueAmount"))+Convert.ToDecimal(Eval("CreditAdjust"))-Convert.ToDecimal(Eval("DebitAdjust"))-Convert.ToDecimal(Eval("AdvanceAmount")))) %>'></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
<%--                                    <asp:BoundField DataField="SupName" HeaderText="Supplier Name" />
                                    <asp:BoundField DataField="Outstanding" HeaderText="Outstanding" />
                                    <asp:BoundField DataField="SupMob1" HeaderText="Contact Details" />--%>

                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Category Records-->
    </div>
</asp:Content>
