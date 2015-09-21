using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            SetaComando();
            Label1.Text = "Atualizado em: " + DateTime.Now.ToString();
            
        }

    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        SetaComando();
        Label1.Text = "Atualizado em: " + DateTime.Now.ToString();
    }
    protected void Manipula(Object sender, GridViewRowEventArgs e)
    {
        System.Drawing.Color OrangeRed =   System.Drawing.ColorTranslator.FromHtml("#FF4500");
        System.Drawing.Color Amarelo = System.Drawing.ColorTranslator.FromHtml("#FFFF99");
        


            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                    
                if ((int.Parse(e.Row.Cells[3].Text) >= 0))
                {
                    e.Row.Cells[3].BackColor = Amarelo;
                    e.Row.Cells[3].ForeColor = System.Drawing.Color.Black;
                }
                if ((int.Parse(e.Row.Cells[3].Text) == 4))
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Orange;
                }
                if ((int.Parse(e.Row.Cells[3].Text) >= 5))
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
                    e.Row.Cells[3].ForeColor = System.Drawing.Color.White;
                }
                if ((int.Parse(e.Row.Cells[3].Text) >= 15))
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.CadetBlue;
                }

                if ((int.Parse(e.Row.Cells[3].Text) >= 30))
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Black;
                }
                

                /* Tempo humano do alerta
                TimeSpan df = (DateTime.Now - Convert.ToDateTime(e.Row.Cells[3].Text));

 
                if (df.TotalMilliseconds > 1)
                    e.Row.Cells[3].Text = Convert.ToString(Math.Round(df.TotalSeconds)) + " segundos";
                if (df.TotalSeconds > 60)
                    e.Row.Cells[3].Text = Convert.ToString(Math.Round(df.TotalMinutes)) + " minutos";
                if (df.TotalMinutes >60)
                    e.Row.Cells[3].Text = Convert.ToString(Math.Round(df.TotalHours)) + " horas";
                if (df.TotalHours > 24)
                    e.Row.Cells[3].Text = Convert.ToString(Math.Round(df.TotalDays)) + " dias";
                */
   

                // Altera resultado das prioridades

                if(e.Row.Cells[0].Text.Contains("1"))
                {
                    e.Row.Cells[0].Style.Add("background-Image", "url('img/red.png')");
                    e.Row.Cells[0].Attributes.Add("title", "Prioridade Alta!");
                     
                }
                if (e.Row.Cells[0].Text.Contains("2"))
                {
                    e.Row.Cells[0].Style.Add("background-Image", "url('img/yellow.png')");
                    e.Row.Cells[0].Attributes.Add("title", "Prioridade Normal");
                }

                e.Row.Cells[0].Style.Add("background-repeat", "no-repeat");
                e.Row.Cells[0].Text = "";
                e.Row.Cells[0].Attributes.Add("align", "center");

            }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("MatrizDetalhes.aspx");
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("SaasDetalhes.aspx");
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("ItaimDetalhes.aspx");
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        Response.Redirect("CyberDetalhes.aspx");
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        Response.Redirect("PoaDetalhes.aspx");
    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        Response.Redirect("UberlandiaDetalhes.aspx");
    }
    protected void Matriz0_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected String SelectCommand(String where, int quem)
    {
        String retorno = null;

        if (quem == 1)
        {
            String comando = "SELECT *" +
                "FROM (" +
                "SELECT DISTINCT DeviceAttribute.sName," +
                "DeviceAttribute.sValue," +
                "Device.sDisplayName," +
                "NetworkInterface.sNetworkAddress," +
                "DeviceGroup.sGroupName," +
                "ActiveMonitorType.sMonitorTypeName," +
                "PivotActiveMonitorTypeToDevice.sComment," +
                "MonitorState.nInternalStateTime," +
                "PivotActiveMonitorTypeToDevice.dLastInternalStateTime," +
                "ActiveMonitorStateChangeLog.sResult, " +
                "MonitorState.nInternalMonitorState " +

"FROM            ActiveMonitorStateChangeLog WITH (NOLOCK) " +
                "INNER JOIN PivotActiveMonitorTypeToDevice " +
                "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +
                "INNER JOIN MonitorState WITH (NOLOCK) " +
                "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID " +
                "INNER JOIN Device WITH (NOLOCK) " +
                "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID " +
                "INNER JOIN ActiveMonitorType WITH (NOLOCK) " +
                "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID " +
                "INNER JOIN PivotDeviceToGroup WITH (NOLOCK) " +
                "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID " +
                "INNER JOIN DeviceGroup WITH (NOLOCK) " +
                "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID " +
                "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK) " +
                "ON Device.nDeviceID = DeviceAttribute.nDeviceID " +
                "INNER JOIN NetworkInterface WITH (NOLOCK) " +
                "ON Device.nDeviceID = NetworkInterface.nDeviceID " +

"WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                "AND (Device.bRemoved = 0) " +
                "AND (sGroupName NOT LIKE '%Discovery%') " +
                "AND (nInternalStateTime " + where + ") " +
                "AND (dLastInternalStateTime > 2) " +
                "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) " +
                "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) " +
                "AND (ActiveMonitorType.bRemoved = 0) " +
                "AND (ActiveMonitorType.bRemoved = 0) " +
                "AND (MonitorState.nInternalMonitorState = 1) " +
                "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +
                "AND ( " +
                     "DeviceAttribute.sName = N'Prioridade' " +
                     "OR DeviceAttribute.sName = N'Acionamento' " +
                     "OR DeviceAttribute.sName = N'DC' " +
                     "OR DeviceAttribute.sName = N'WUG' " +
                     "OR DeviceAttribute.sName = N'KBOPM' " +
                     "OR DeviceAttribute.sName = N'KBOPP' " +
                     "OR DeviceAttribute.sName = N'Excecao' " +
                     ") " +
         ") AS a " +

"PIVOT ( " +
        "max(sValue) " +
        "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Vertical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
      ") AS pvt " +
"ORDER BY dLastInternalStateTime DESC";
            retorno = comando;
        }
        else if (quem == 2)
        {

            String comando = "SELECT * " +
                        "FROM ( " +
                        "SELECT DISTINCT DeviceAttribute.sName, " +
                        "DeviceAttribute.sValue, " +
                        "DeviceAttribute.nDeviceID, " +
                        "Device.sDisplayName, " +
                        "NetworkInterface.sNetworkAddress, " +
                        "DeviceGroup.sGroupName, " +
                        "ActiveMonitorType.sMonitorTypeName, " +
                        "PivotActiveMonitorTypeToDevice.sComment, " +
                        "MonitorState.nInternalStateTime, " +
                        "PivotActiveMonitorTypeToDevice.dLastInternalStateTime, " +
                        "ActiveMonitorStateChangeLog.sResult, " +
                        "MonitorState.nInternalMonitorState " +

           "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK) " +
                           "INNER JOIN PivotActiveMonitorTypeToDevice " +
                           "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +
                           "INNER JOIN MonitorState WITH (NOLOCK) " +
                           "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID " +
                           "INNER JOIN Device WITH (NOLOCK) " +
                           "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID " +
                           "INNER JOIN ActiveMonitorType WITH (NOLOCK) " +
                           "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID " +
                           "INNER JOIN PivotDeviceToGroup WITH (NOLOCK) " +
                           "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID " +
                           "INNER JOIN DeviceGroup WITH (NOLOCK) " +
                           "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID " +
                           "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK) " +
                           "ON Device.nDeviceID = DeviceAttribute.nDeviceID " +
                           "INNER JOIN NetworkInterface WITH (NOLOCK) " +
                           "ON Device.nDeviceID = NetworkInterface.nDeviceID " +
           "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                           "AND (Device.bRemoved = 0) " +
                           "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) " +
                           "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) " +
                           "AND (ActiveMonitorType.bRemoved = 0) " +
                           "AND (ActiveMonitorType.bRemoved = 0) " +
                           "AND (sGroupName NOT LIKE '%Discovery%') " +
                           "AND (nInternalStateTime " + where + ") " +
                           "AND (nInternalStateTime > 2) " +
                           "AND (MonitorState.nInternalMonitorState = 1) " +
                           "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +

                           "AND ( " +
                                   "DeviceAttribute.sName = N'Prioridade' " +
                                "OR DeviceAttribute.sName = N'Acionamento' " +

                                "OR DeviceAttribute.sName = N'DC' " +
                                "OR DeviceAttribute.sName = N'WUG' " +
                                "OR DeviceAttribute.sName = N'Vertical' " +
                                "OR DeviceAttribute.sName = N'Produto' " +
                                "OR DeviceAttribute.sName = N'KBOPM' " +
                                "OR DeviceAttribute.sName = N'KBOPP' " +
                                "OR DeviceAttribute.sName = N'Excecao' " +
                                "OR DeviceAttribute.sName = N'Filial' " +
                                ") " +
                           ") AS a " +

           "PIVOT ( " +
                   "max(sValue) " +
                   "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Vertical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                 ") AS pvt " +
           "ORDER BY sGroupName, dLastInternalStateTime, sDisplayName  DESC";

            retorno = comando;
        }
        else if (quem == 3)
        {
            String comando = "SELECT *" +
                          "FROM (" +
                          "SELECT DISTINCT DeviceAttribute.sName," +
                          "DeviceAttribute.sValue," +
                          "Device.sDisplayName," +
                          "NetworkInterface.sNetworkAddress," +
                          "DeviceGroup.sGroupName," +
                          "ActiveMonitorType.sMonitorTypeName," +
                          "PivotActiveMonitorTypeToDevice.sComment," +
                          "MonitorState.nInternalStateTime," +
                          "PivotActiveMonitorTypeToDevice.dLastInternalStateTime," +
                          "ActiveMonitorStateChangeLog.sResult, " +
                          "MonitorState.nInternalMonitorState " +

          "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK) " +
                          "INNER JOIN PivotActiveMonitorTypeToDevice " +
                          "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +
                          "INNER JOIN MonitorState WITH (NOLOCK) " +
                          "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID " +
                          "INNER JOIN Device WITH (NOLOCK) " +
                          "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID " +
                          "INNER JOIN ActiveMonitorType WITH (NOLOCK) " +
                          "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID " +
                          "INNER JOIN PivotDeviceToGroup WITH (NOLOCK) " +
                          "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID " +
                          "INNER JOIN DeviceGroup WITH (NOLOCK) " +
                          "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID " +
                          "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK) " +
                          "ON Device.nDeviceID = DeviceAttribute.nDeviceID " +
                          "INNER JOIN NetworkInterface WITH (NOLOCK) " +
                          "ON Device.nDeviceID = NetworkInterface.nDeviceID " +

          "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                          "AND (Device.bRemoved = 0) " +
                          "AND (sGroupName NOT LIKE '%Discovery%') " +
                          "AND (nInternalStateTime " + where + ") " +
                          "AND (nInternalStateTime > 2) " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) " +
                          "AND (ActiveMonitorType.bRemoved = 0) " +
                          "AND (ActiveMonitorType.bRemoved = 0) " +
                          "AND (MonitorState.nInternalMonitorState = 1) " +
                          "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +
                          "AND ( " +
                               "DeviceAttribute.sName = N'Prioridade' " +
                               "OR DeviceAttribute.sName = N'Acionamento' " +
                               "OR DeviceAttribute.sName = N'DC' " +
                               "OR DeviceAttribute.sName = N'WUG' " +
                               "OR DeviceAttribute.sName = N'KBOPM' " +
                               "OR DeviceAttribute.sName = N'KBOPP' " +
                               "OR DeviceAttribute.sName = N'Excecao' " +
                               ") " +
                   ") AS a " +

          "PIVOT ( " +
                  "max(sValue) " +
                  "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Vertical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                ") AS pvt " +
          "ORDER BY dLastInternalStateTime DESC";
            retorno = comando;
        }
        else if (quem == 4)
        {
            String comando = "SELECT *" +
              "FROM (" +
              "SELECT DISTINCT DeviceAttribute.sName," +
              "DeviceAttribute.sValue," +
              "Device.sDisplayName," +
              "NetworkInterface.sNetworkAddress," +
              "DeviceGroup.sGroupName," +
              "ActiveMonitorType.sMonitorTypeName," +
              "PivotActiveMonitorTypeToDevice.sComment," +
              "MonitorState.nInternalStateTime," +
              "PivotActiveMonitorTypeToDevice.dLastInternalStateTime," +
              "ActiveMonitorStateChangeLog.sResult, " +
              "MonitorState.nInternalMonitorState " +

"FROM            ActiveMonitorStateChangeLog WITH (NOLOCK) " +
              "INNER JOIN PivotActiveMonitorTypeToDevice " +
              "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +
              "INNER JOIN MonitorState WITH (NOLOCK) " +
              "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID " +
              "INNER JOIN Device WITH (NOLOCK) " +
              "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID " +
              "INNER JOIN ActiveMonitorType WITH (NOLOCK) " +
              "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID " +
              "INNER JOIN PivotDeviceToGroup WITH (NOLOCK) " +
              "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID " +
              "INNER JOIN DeviceGroup WITH (NOLOCK) " +
              "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID " +
              "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK) " +
              "ON Device.nDeviceID = DeviceAttribute.nDeviceID " +
              "INNER JOIN NetworkInterface WITH (NOLOCK) " +
              "ON Device.nDeviceID = NetworkInterface.nDeviceID " +

"WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
              "AND (Device.bRemoved = 0) " +
              "AND (sGroupName NOT LIKE '%Discovery%') " +
              "AND (nInternalStateTime " + where + ") " +
              "AND (nInternalStateTime > 2) " +
              "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) " +
              "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) " +
              "AND (ActiveMonitorType.bRemoved = 0) " +
              "AND (ActiveMonitorType.bRemoved = 0) " +
              "AND (MonitorState.nInternalMonitorState = 1) " +
              "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +
              "AND ( " +
                   "DeviceAttribute.sName = N'Prioridade' " +
                   "OR DeviceAttribute.sName = N'Acionamento' " +
                   "OR DeviceAttribute.sName = N'DC' " +
                   "OR DeviceAttribute.sName = N'WUG' " +
                   "OR DeviceAttribute.sName = N'KBOPM' " +
                   "OR DeviceAttribute.sName = N'KBOPP' " +
                   "OR DeviceAttribute.sName = N'Excecao' " +
                   ") " +
       ") AS a " +

"PIVOT ( " +
      "max(sValue) " +
      "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Vertical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
    ") AS pvt " +
"ORDER BY dLastInternalStateTime DESC";
            retorno = comando;
        }

        return retorno;


    }
    protected void SetaComando()
    {
        int SQLSaaS = 2;
        int SQLMatriz = 1;
        int SQLItaim = 3;
        int SQLCyber = 4;

        if (setTimerByUser.SelectedItem.Value == "1 Hora")
        {
            this.SaaS.SelectCommand = SelectCommand("< 119", SQLSaaS);
            this.Matriz.SelectCommand = SelectCommand("< 119", SQLMatriz);
            this.Itaim.SelectCommand = SelectCommand("< 119", SQLItaim);
            this.Cyber.SelectCommand = SelectCommand("< 119", SQLCyber);
            try
            {
                GridView1.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();
                GridView4.DataBind();
            }
            catch (System.Data.SqlClient.SqlException ex) //Detecta SqlException
            {
                Response.Write(ex.Message);
            }
            catch (Exception ex) //Detecta outro tipo de exceção
            {
                Response.Write(ex.Message);
            }
        }
        else if (setTimerByUser.SelectedItem.Value == "2 Horas")
        {
            this.SaaS.SelectCommand = SelectCommand("< 179", SQLSaaS);
            this.Matriz.SelectCommand = SelectCommand("< 179", SQLMatriz);
            this.Itaim.SelectCommand = SelectCommand("< 179", SQLItaim);
            this.Cyber.SelectCommand = SelectCommand("< 179", SQLCyber);
            try
            {
                GridView1.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();
                GridView4.DataBind();
            }
            catch (System.Data.SqlClient.SqlException ex) //Catch SqlException
            {
                Response.Write(ex.Message);
            }
            catch (Exception ex) //Catch Other Exception
            {
                Response.Write(ex.Message);
            }
        }
        else if (setTimerByUser.SelectedItem.Value == "3 Horas")
        {
            this.SaaS.SelectCommand = SelectCommand("< 239", SQLSaaS);
            this.Matriz.SelectCommand = SelectCommand("< 239", SQLMatriz);
            this.Itaim.SelectCommand = SelectCommand("< 239", SQLItaim);
            this.Cyber.SelectCommand = SelectCommand("< 239", SQLCyber);

            try
            {
                GridView1.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();
                GridView4.DataBind();
            }
            catch (System.Data.SqlClient.SqlException ex) //Catch SqlException
            {
                Response.Write(ex.Message);
            }
            catch (Exception ex) //Catch Other Exception
            {
                Response.Write(ex.Message);
            }
        }
        else if (setTimerByUser.SelectedItem.Value == "4 Horas")
        {
            this.SaaS.SelectCommand = SelectCommand("< 299", SQLSaaS);
            this.Matriz.SelectCommand = SelectCommand("< 299", SQLMatriz);
            this.Itaim.SelectCommand = SelectCommand("< 299", SQLItaim);
            this.Cyber.SelectCommand = SelectCommand("< 299", SQLCyber);

            try
            {
                GridView1.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();
                GridView4.DataBind();
            }
            catch (System.Data.SqlClient.SqlException ex) //Catch SqlException
            {
                Response.Write(ex.Message);
            }
            catch (Exception ex) //Catch Other Exception
            {
                Response.Write(ex.Message);
            }
        }
        else if (setTimerByUser.SelectedItem.Value == "Todos")
        {
            this.SaaS.SelectCommand = SelectCommand("> 0", SQLSaaS);
            this.Matriz.SelectCommand = SelectCommand("> 0", SQLMatriz);
            this.Itaim.SelectCommand = SelectCommand("> 0", SQLItaim);
            this.Cyber.SelectCommand = SelectCommand("> 0", SQLCyber);
            try
            {
                GridView1.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();
                GridView4.DataBind();
            }
            catch (System.Data.SqlClient.SqlException ex) //Catch SqlException
            {
                Response.Write(ex.Message);
            }
            catch (Exception ex) //Catch Other Exception
            {
                Response.Write(ex.Message);
            }
        }
        else
        {
            try
            {
                GridView1.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();
                GridView4.DataBind();              
            }
            catch (System.Data.SqlClient.SqlException ex) //Catch SqlException
            {
                Response.Write(ex.Message);
            }
            catch (Exception ex) //Catch Other Exception
            {
                Response.Write(ex.Message);
            }
        }

    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        SetaComando();
    }
    protected void setTimerByUser_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetaComando();
    }
    protected void alterarRefresh(object sender, EventArgs e)
    {
        if (alterarRefreshuser.SelectedIndex == 0)
        {
            //Timer1.Enabled = false;
        }
        else
        {
            Timer1.Enabled = true;
            if (alterarRefreshuser.SelectedIndex == 1)
            {
                Timer1.Interval = 60000;
            }
            if (alterarRefreshuser.SelectedIndex == 2)
            {
                Timer1.Interval = 300000;
            }
            if (alterarRefreshuser.SelectedIndex == 3)
            {
                Timer1.Interval = 600000;
            }
            if (alterarRefreshuser.SelectedIndex == 1)
            {
                Timer1.Interval = 1800000;
            }
        }
    }
 

}
  

