<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Movie_Finder.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function RefreshUpdatePanel1() {
            window.__doPostBack('<%= UpdatePanel1.ClientID %>', '');
        };
    </script>
    <style type="text/css">
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="panel panel-info">
        <div class="panel-heading" style="text-align: center;">
            <h3 class="panel-title">Sign up</h3>
        </div>
        <p></p>
        <ul>
            <li>In order to sign up as admin user, please fill out the following form and click <b>Sign Up</b> button</li>
        </ul>
        <br />
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-4">
                <table>
                    <tr>
                        <td>
                            <asp:TextBox class="form-control" placeholder="Username" runat="server" ID="Username" Width="190px"
                                onkeyup="RefreshUpdatePanel1()" OnTextChanged="CheckUsernameAvailability" EnableViewState="False" ViewStateMode="Disabled"></asp:TextBox>
                        </td>
                        <td></td>
                    </tr>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True">
                        <ContentTemplate>
                            <tr>
                                <td>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="**" ForeColor="Red"
                                        ControlToValidate="UserName" EnableViewState="False"></asp:RequiredFieldValidator>

                                    <asp:Label ID="duplicateUsername" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
                                </td>
                            </tr>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <tr>
                        <td>
                            <asp:TextBox class="form-control" placeholder="Password" runat="server" ID="Password" Width="191px"
                                EnableViewState="False" TextMode="Password"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox class="form-control" placeholder="Confirm Password" runat="server" ID="ConfirmPassword" Width="190px"
                                EnableViewState="False" TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="**" ForeColor="Red"
                                ControlToValidate="Password" EnableViewState="False"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="should be 6 to 8 characters" ControlToValidate="Password" ForeColor="Red" ValidationExpression="^.{6,8}$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="**" ForeColor="Red"
                                ControlToValidate="ConfirmPassword" EnableViewState="False"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match" ControlToValidate="ConfirmPassword" ControlToCompare="Password" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox class="form-control" placeholder="First Name" runat="server" ID="FirstName" Width="190px"
                                EnableViewState="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox class="form-control" placeholder="Last Name" runat="server" ID="LastName" Width="192px"
                                EnableViewState="False"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="**" ForeColor="Red"
                                ControlToValidate="FirstName" EnableViewState="False"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="**" ForeColor="Red"
                                ControlToValidate="LastName" EnableViewState="False"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td align="right">
                            <asp:Button ID="AddButton" runat="server" class="btn btn-lg btn-primary" OnClick="AddUser" Text="Sign up" Width="118px" ViewStateMode="Disabled" />
                        </td>
                        <td>
                            <asp:Label ID="SignUpMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
            </div>
        </div>
    </div>
</asp:Content>
