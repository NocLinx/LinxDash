using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class error : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Session["time"] = DateTime.Now.AddSeconds(5);
       
        }
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {

        TimeSpan time1 = new TimeSpan();
        time1 = (DateTime)Session["time"] - DateTime.Now;
        if (time1.Seconds <= 0)
        {
            Response.Redirect("Default.aspx");
        }
        else
        {
            Temporizador.Text = "Tentando reconexão em: " + time1.Seconds.ToString();
        }
        
    }        
    

}