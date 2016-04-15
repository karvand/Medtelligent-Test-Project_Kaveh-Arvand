<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="AdminMain.aspx.cs" Inherits="Movie_Finder.AdminMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="panel panel-info">
        <div class="panel-heading" style="text-align: center;">
            <h3 class="panel-title">Welcome to Movie Finder</h3>
        </div>
        <p></p>
        <ul>
            <li>To manage genres click on <b>Manage Genres</b> tab</li>
            <li>To manage movies click on <b>Manage Movies</b> tab</li>
            <li>To manage user accounts click on <b>Manage Users</b> tab</li>
        </ul>
    </div>
</asp:Content>
