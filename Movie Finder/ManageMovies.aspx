<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageMovies.aspx.cs" Inherits="Movie_Finder.ManageMovies" %>

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
            <h3 class="panel-title">Manage Movies</h3>
        </div>
        <p></p>
        <ul>
            <li>To add a new movie,insert the relevant information about the movie in the boxes and click on <b>Add Movie</b> button.</li>
            <li>To edit a movie, click on <b>Edit</b> button and after inserting the information, click on <b>Update</b> button.</li>
            <li>To cancel the changes, click on <b>Cancel</b> button.</li>
            <li>To delete a movie, click on <b>Delete</b> button.</li>
        </ul>
        <br />
        <div class="row">
            <div class="col-sm-4">
                <table>
                    <tr>
                        <td>
                            <asp:DropDownList ID="DropDownListForGenres" runat="server" CssClass="form-control"
                                DataTextField="GenreName" DataValueField="GenreId" AppendDataBoundItems="True" Width="170px">
                                <asp:ListItem Value="0" Selected="True">Choose a Genre</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownListForYears" runat="server" CssClass="form-control"
                                AppendDataBoundItems="True" Width="170px">
                                <asp:ListItem Value="0" Selected="True">Release Year</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RequiredFieldValidator InitialValue="0" ControlToValidate="DropDownListForGenres" ID="RequiredFieldValidator1"
                                Width="170" runat="server" ErrorMessage="**" ForeColor="Red" ValidationGroup="AddMovieGroup" />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator InitialValue="0" ControlToValidate="DropDownListForYears" ID="RequiredFieldValidator2"
                                Width="170" runat="server" ErrorMessage="**" ForeColor="Red" ValidationGroup="AddMovieGroup" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox class="form-control" placeholder="Movie Title" runat="server" ID="MovieTitle" Width="170px"
                                onkeyup="RefreshUpdatePanel1();" OnTextChanged="CheckMovieAvailability" EnableViewState="False" ViewStateMode="Disabled"></asp:TextBox>
                        </td>

                        <td>
                            <asp:TextBox class="form-control" placeholder="Name of Director" runat="server" ID="Director" Width="170px"
                                EnableViewState="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True">
                                <ContentTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="**" ForeColor="Red"
                                                    ControlToValidate="MovieTitle" EnableViewState="False" ValidationGroup="AddMovieGroup"></asp:RequiredFieldValidator>
                                                <asp:Label ID="duplicateMovie" runat="server" ForeColor="Red" EnableViewState="False" Width="173" ViewStateMode="Disabled"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="**" ForeColor="Red"
                                                    ControlToValidate="Director" EnableViewState="False" ValidationGroup="AddMovieGroup" Width="170"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="AddButton" runat="server" class="btn btn-lg btn-primary" OnClick="AddMovie" Text="Add Movie" ValidationGroup="AddMovieGroup" Width="120px" ViewStateMode="Disabled" />
                                            </td>

                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-sm-1">
                <asp:Label ID="redundantMovie" runat="server" ForeColor="Red" EnableViewState="true" Visible="true"></asp:Label>
            </div>
            <div class="col-sm-7">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" ChildrenAsTriggers="True">
                    <ContentTemplate>
                        <div runat="server" class="panel " style="border: thin solid #4A3C8C; overflow-x: auto;">
                            <div runat="server" class="panel-heading" style="border: thin solid #4A3C8C; text-align: center; background-color: #4A3C8C; color: #FFFFFF;">
                                <h3 class="panel-title">List of Movies</h3>
                            </div>
                            <div class="table-responsive">
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MovieId"
                                    OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
                                    OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" BorderStyle="None" Width="649px" GridLines="Both" ShowHeader="True">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Title">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTitle" runat="server" Width="120" Text='<%# Eval("Title") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="movieTitle" runat="server" Text='<%# Eval("Title") %>' Height="20px" Width="130px" EnableViewState="False"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="**" Display="Dynamic" ControlToValidate="movieTitle" ValidationGroup="EditMovieGroup" ForeColor="Red"></asp:RequiredFieldValidator>
                                                <asp:CustomValidator ID="CustomValidator1" OnServerValidate="TextValidate" runat="server" FontColor="Red" Display="Dynamic" Text="movie already exists" ValidationGroup="EditMovieGroup" ControlToValidate="movieTitle"></asp:CustomValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Director">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDirector" runat="server" Width="120" Text='<%# Eval("Director") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="movieDirector" runat="server" Text='<%# Eval("Director") %>' Height="20px" Width="130px" EnableViewState="False"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="**" Display="Dynamic" ControlToValidate="movieDirector" ValidationGroup="EditMovieGroup" ForeColor="Red"></asp:RequiredFieldValidator>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Year">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReleaseYear" Width="65" runat="server" Text='<%# Eval("ReleaseYear") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblReleaseYear" runat="server" Text='<%# Eval("ReleaseYear")%>' Visible="false"></asp:Label>
                                                <asp:DropDownList ID="movieReleaseYear" runat="server" Width="65px">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Genre">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGenre" Width="70" runat="server" Text='<%# Eval("GenreName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:Label ID="lblGenre" runat="server" Text='<%# Eval("GenreName")%>' Visible="false"></asp:Label>
                                                <asp:DropDownList ID="movieGenre" runat="server" Width="70px">
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-info" ShowEditButton="true" ValidationGroup="EditMovieGroup">
                                            <ControlStyle CssClass="btn btn-info" />
                                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                                        </asp:CommandField>
                                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-danger" ShowDeleteButton="true">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:CommandField>
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
        </div>
    </div>
</asp:Content>
