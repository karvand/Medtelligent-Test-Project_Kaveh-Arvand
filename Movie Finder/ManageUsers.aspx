<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="Movie_Finder.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-info">
        <div class="panel-heading" style="text-align: center;">
            <h3 class="panel-title">Manage Users</h3>
        </div>
        <p></p>
        <ul>
            <li>To edit a user information, click on <b>Edit</b> button and after inserting the information, click on <b>Update</b> button.</li>
            <li>To cancel the changes, click on <b>Cancel</b> button.</li>
            <li>To delete a movie, click on <b>Delete</b> button.</li>
        </ul>
        <br />
        <div class="row">
            <div class="col-sm-2">
                <asp:Label ID="Message" runat="server" ForeColor="Red" EnableViewState="true" Visible="true"></asp:Label>
            </div>
            <div class="col-sm-7">
                <div runat="server" class="panel " style="border: thin solid #4A3C8C; overflow-x: auto;">
                    <div runat="server" class="panel-heading" style="border: thin solid #4A3C8C; text-align: center; background-color: #4A3C8C; color: #FFFFFF;">
                        <h3 class="panel-title">List of Users</h3>
                    </div>
                    <div class="table-responsive">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="UserId"
                            OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
                            OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" BorderStyle="None" Width="649px" GridLines="Both" ShowHeader="True">
                            <Columns>
                                <asp:TemplateField HeaderText="Username">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUsername" runat="server" Width="85" Text='<%# Eval("UserName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="First Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFistName" runat="server" Width="120" Text='<%# Eval("FirstName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="FirstName" runat="server" Text='<%# Eval("FirstName") %>' Height="20px" Width="130px" EnableViewState="False"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="**" Display="Dynamic" ControlToValidate="FirstName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Last Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLastName" runat="server" Width="120" Text='<%# Eval("LastName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="LastName" runat="server" Text='<%# Eval("LastName") %>' Height="20px" Width="130px" EnableViewState="False"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="**" Display="Dynamic" ControlToValidate="LastName" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-info" ShowEditButton="true" ItemStyle-HorizontalAlign="Center">
                                    <ItemStyle HorizontalAlign="Center" Width="150px" />
                                </asp:CommandField>
                                <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-danger" ShowDeleteButton="true">
                                    <ItemStyle HorizontalAlign="Center" Width="75px" />
                                </asp:CommandField>
                            </Columns>
                            <EmptyDataTemplate>
                                No data found
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div class="col-sm-3"></div>
        </div>
    </div>
</asp:Content>
