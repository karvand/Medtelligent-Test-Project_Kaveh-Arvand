<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageGenres.aspx.cs" Inherits="Movie_Finder.ManageGenres" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function RefreshUpdatePanel1() {
            window.__doPostBack('<%= UpdatePanel1.ClientID %>', '');
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="panel panel-info">
        <div class="panel-heading" style="text-align: center;">
            <h3 class="panel-title">Manage Genres</h3>
        </div>
        <p></p>
        <ul>
            <li>To add a new genre,insert the name of genre in the box and click on <b>Add Genre</b> button.</li>
            <li>To edit a genre, click on <b>Edit</b> button and after inserting the name, click on <b>Update</b> button.</li>
            <li>To cancel the changes, click on <b>Cancel</b> button.</li>
            <li>To delete a genre, click on <b>Delete</b> button.</li>
        </ul>
        <br />
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-3">
                <table>
                    <tr>
                        <td colspan="2">
                            <asp:TextBox class="form-control" placeholder="Name of Genre" runat="server" ID="nameOfGenre" Width="214px"
                                onkeyup="RefreshUpdatePanel1();" OnTextChanged="CheckGenreAvailability" EnableViewState="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True">
                                <ContentTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="**" ForeColor="Red"
                                                    ControlToValidate="nameOfGenre" EnableViewState="False" ValidationGroup="AddGenreGroup"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                                <asp:Label ID="duplicateGenre" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="AddButton" class="btn btn-lg btn-primary" runat="server" Text="Add Genre" OnClick="AddGenre" Width="121px" ValidationGroup="AddGenreGroup" />
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-sm-2">
                <asp:Label ID="redundantGenre" runat="server" ForeColor="Red" Visible="true"></asp:Label>
            </div>
            <div class="col-sm-4">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" ChildrenAsTriggers="True">
                    <ContentTemplate>
                        <div runat="server" class="panel " style="border: thin solid #4A3C8C; overflow-x: auto;">
                            <div runat="server" class="panel-heading" style="border: thin solid #4A3C8C; text-align: center; background-color: #4A3C8C; color: #FFFFFF;">
                                <h3 class="panel-title">List of Genres</h3>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="GenreId"
                                    OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
                                    OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" BorderStyle="None" Width="353px" GridLines="Horizontal" ShowHeader="False">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-Width="115">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("GenreName") %>'></asp:Label>
                                            </ItemTemplate>

                                            <EditItemTemplate>
                                                <asp:TextBox ID="genreName" runat="server" Text='<%# Eval("GenreName") %>' Height="20px" Width="130px" EnableViewState="False"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="**" Display="Dynamic" ControlToValidate="genreName" ValidationGroup="EditGenreGroup" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator ID="CustomValidator1" OnServerValidate="TextValidate" runat="server" FontColor="Red" Display="Dynamic" Text="genre already exists" ValidationGroup="EditGenreGroup" ControlToValidate="genreName"></asp:CustomValidator>
                                                <asp:Label ID="deletionError" runat="server" Visible="false" Text="The genre cannot be deleted"></asp:Label>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-info" ItemStyle-Width="150px" ShowEditButton="true" ItemStyle-HorizontalAlign="Center" ValidationGroup="EditGenreGroup"></asp:CommandField>
                                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-danger" ShowDeleteButton="true"></asp:CommandField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        No data found
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="AddButton" />
                    </Triggers>
                </asp:UpdatePanel>
            </div>
            <div class="col-sm-2">
            </div>
        </div>
    </div>
</asp:Content>
