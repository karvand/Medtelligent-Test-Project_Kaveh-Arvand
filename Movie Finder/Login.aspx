<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Main.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Movie_Finder.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 213px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-info">
        <div class="panel-heading" style="text-align: center;">
            <h3 class="panel-title">Log in</h3>
        </div>
        <p></p>
        <ul>
            <li>Please enter your username and password and click <b>Sign in</b> button</li>
        </ul>
        <br />
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-4">
                <table>
                    <tr>
                        <td class="auto-style1">
                            <asp:TextBox class="form-control" placeholder="Username" runat="server" ID="Username" Width="190px"
                                EnableViewState="False" ViewStateMode="Disabled"></asp:TextBox>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="**" ControlToValidate="Username" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <asp:TextBox class="form-control" placeholder="Password" runat="server" ID="Password" Width="190px"
                                EnableViewState="False" ViewStateMode="Disabled" TextMode="Password"></asp:TextBox>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="**" ControlToValidate="Password" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="auto-style1">
                            <asp:Button ID="LoginButton" runat="server" class="btn btn-lg btn-primary" OnClick="LoginUser" Text="Sign in" Width="120px" />
                        </td>
                        <td>
                            <asp:Label ID="LoginMessage" runat="server" ForeColor="Red" EnableViewState="False" ViewStateMode="Disabled"></asp:Label>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </div>
        </div>
    </div>
</asp:Content>
