﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Finder.MasterPages
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Index.aspx");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            LabelForUserName.Text = "Hello " + Session["username"] + ",";
        }
    }
}