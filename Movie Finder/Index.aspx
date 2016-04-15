<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Movie_Finder.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <div class="container-fluid">
        <div class="jumbotron">
            <h2>Welcome to Movie Finder!
            </h2>
            <br />
            <div class="row">
                <div class="col-sm-4"></div>
                <div class="col-sm-4">
                    <table>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search for movies..." EnableViewState="False" Width="292px"></asp:TextBox>
                                <ajaxToolkit:AutoCompleteExtender ID="autoCompleteMovies" runat="server"
                                    MinimumPrefixLength="1"
                                    EnableCaching="false" CompletionSetCount="10" Enabled="True" TargetControlID="txtSearch" ServiceMethod="SearchMovies"
                                    ServicePath="~/AutoComplete.asmx" CompletionInterval="100">
                                </ajaxToolkit:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 98px">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="**" ControlToValidate="txtSearch" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:Button runat="server" ID="btnSearch" class="btn btn-lg btn-success" Text="Search" OnClick="SearchMovie" Width="104px"></asp:Button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-sm-4"></div>
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True">
            <ContentTemplate>
                <div runat="server" id="SearchResult" class="row ">
                    <div class="col-sm-2"></div>
                    <div class="col-sm-8">
                        <div class="panel panel-success" style="overflow-x: auto;">
                            <div class="panel-heading" style="text-align: center;">
                                <h3 class="panel-title">Search Results</h3>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView ID="GridView1" runat="server"
                                    EmptyDataText="No Data Found"
                                    AllowPaging="True" Width="748px" AutoGenerateColumns="False">
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
                                        <asp:TemplateField HeaderText="Release Year" ItemStyle-Width="130">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_ReleaseYear" runat="server" Text='<%#Eval("ReleaseYear")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Genre" ItemStyle-Width="150">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_Genre" runat="server" Text='<%#Eval("GenreName")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        No data found
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-2"></div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearch" />
            </Triggers>
        </asp:UpdatePanel>
        <div class="panel panel-primary">
            <div class="panel-heading" style="text-align: center;">
                <h3 class="panel-title">Most Recent Movies</h3>
            </div>
            <p></p>
            <ul>
                <li>Below is the list of most recent added movies to Movie Finder, categorized be genre.</li>
                <li>To view the list of all movies in a particular genre, click on genre name's link.</li>
            </ul>
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </div>
                <div class="col-sm-1"></div>
            </div>
        </div>
    </div>
</asp:Content>
