<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="MovieByGenre.aspx.cs" Inherits="Movie_Finder.MovieByGenre" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-3"></div>
        <div class="col-sm-6">
            <div class="panel panel-primary" style="overflow-x: auto;">
                <div class="panel-heading" style="text-align: center;">
                    <h3 class="panel-title">List of <%= Request.QueryString["g"] %> Movies</h3>
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="GridView1" runat="server"
                        EmptyDataText="No Data Found"
                        AllowPaging="True" Width="553px" AutoGenerateColumns="False" EnableSortingAndPagingCallbacks="False">
                        <Columns>
                            <asp:TemplateField HeaderText="Title">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Title" runat="server" Text='<%#Eval("Title")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Director">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Director" runat="server" Text='<%#Eval("Director")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Release Year" ItemStyle-Width="100">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_ReleaseYear" runat="server" Text='<%#Eval("ReleaseYear")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            No data found
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
            <div class="col-sm-3"></div>
        </div>
    </div>
</asp:Content>
