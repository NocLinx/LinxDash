using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Windows.Forms;
using System.Data;
using System.Data.SqlClient;

public partial class _primo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Date.Text = DateTime.Now.ToString();

        if (!IsPostBack)
        {
            SetaComando();
        }

    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        SetaComando();
        Date.Text = DateTime.Now.ToString();
    }
    protected void setTimerByUser_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void Matriz0_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    // Executa durante preenchimento da Grid
    protected void Manipula(Object sender, GridViewRowEventArgs e)
    {
        GridView Grid = (GridView)sender;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            bool prioridadeAlta = false;
            string DataAlerta = e.Row.Cells[3].Text.ToString();

            // ###########################################//
            // Colori campo DOWN baseado no tempo         //
            // ###########################################//
            TimeSpan df = (DateTime.Now - Convert.ToDateTime(e.Row.Cells[3].Text));

            int tempoDown = int.Parse(Convert.ToString(Math.Round(df.TotalMinutes)));
            if (tempoDown >= 0)
            {
                e.Row.Cells[3].CssClass = "bgAmarelo";
                e.Row.Cells[3].ForeColor = System.Drawing.Color.Black;
            }
            if (tempoDown == 4)
            {
                e.Row.Cells[3].CssClass = "bgLaranja";
                e.Row.Cells[3].ForeColor = System.Drawing.Color.White;
            }
            if (tempoDown >= 5)
            {
                e.Row.Cells[3].CssClass = "bgVermelho";
                e.Row.Cells[3].ForeColor = System.Drawing.Color.White;

            }
            if (tempoDown >= 15)
            {
                e.Row.Cells[3].CssClass = "bgAzul";
            }

            if (tempoDown >= 30)
            {
                e.Row.Cells[3].CssClass = "bgPreto";
                e.Row.Cells[3].ForeColor = System.Drawing.Color.White;
            }
            // ###########################################//
            //  Conversão tempo huamno alerta             //
            // ###########################################//



            if (tempoDown > 60)
                e.Row.Cells[3].Text = df.Hours.ToString() + "h" + df.Minutes.ToString();
            else
                e.Row.Cells[3].Text = df.Minutes.ToString();
            if (df.TotalHours > 24)
            {
                String dd = "1";
                if (dd == Convert.ToString(Math.Round(df.TotalDays)))
                    e.Row.Cells[3].Text = Convert.ToString(Math.Round(df.TotalDays)) + " dia " + df.Hours.ToString() + "h" + df.Minutes.ToString() + "m";
                else
                    e.Row.Cells[3].Text = Convert.ToString(Math.Round(df.TotalDays)) + " dias " + df.Hours.ToString() + "h" + df.Minutes.ToString() + "m";
            }




            // ###########################################//
            // Conversão de caracter httputility          //
            // ###########################################//
            StringWriter camaradinha = new StringWriter();

            HttpUtility.HtmlDecode(e.Row.Cells[1].Text.ToString(), camaradinha);
            String Icone = RecuperaImgPrAc(camaradinha.ToString(), Grid.ClientID.ToString());

            e.Row.Cells[0].Style.Add("background-Image", Icone);
            e.Row.Cells[0].Style.Add("background-position", "center");
            e.Row.Cells[0].Text = "";
            e.Row.Cells[0].Attributes.Add("align", "center");
            e.Row.Cells[0].Style.Add("background-repeat", "no-repeat");

            if (Icone == "url('img/prioridades/AP24-7.png')")
            {
                e.Row.Cells[0].Attributes.Add("Title", "Alta Prioridade - Acionamento 24/7");
                prioridadeAlta = true;
            }

            else if (Icone == "url('img/prioridades/AP8-5.png')")
            {
                e.Row.Cells[0].Attributes.Add("Title", "Alta Prioridade - Acionamento 8/5");
                prioridadeAlta = true;
            }

            else if (Icone == "url('img/prioridades/PN24-7.png')")
            {
                e.Row.Cells[0].Attributes.Add("Title", "Prioridade Normal - Acionamento 24/7");
                prioridadeAlta = false;
            }

            else if (Icone == "url('img/prioridades/PN8-5.png')")
            {
                e.Row.Cells[0].Attributes.Add("Title", "Prioridade Normal - Acionamento 8/5");
                prioridadeAlta = false;
            }

            if (prioridadeAlta)
            {
                if (tempoDown >= 60 && tempoDown < 119) // Verifica escalonamento N1
                {
                    e.Row.Cells[3].CssClass = "blink";
                    if (VerificaEscalonamento(camaradinha.ToString(), "1",DataAlerta)) // Se for verdadeiro quer dizer que o operador ja escalonou
                    {
                        e.Row.Cells[3].CssClass = "bgPreto";
                     }


                }
                else if (tempoDown >= 120 && tempoDown < 180)   // Verifica escalonamento N2
                {
                    e.Row.Cells[3].CssClass = "blink";

                    if (VerificaEscalonamento(camaradinha.ToString(), "2", DataAlerta) && VerificaEscalonamento(camaradinha.ToString(), "1", DataAlerta)) // Se for verdadeiro quer dizer que o operador ja escalonou
                        e.Row.Cells[3].CssClass = "bgPreto";
                }
                else if (tempoDown >= 180)// Verifica escalonamento N3
                {
                    e.Row.Cells[3].CssClass = "blink"; 
                    if (VerificaEscalonamento(camaradinha.ToString(), "3", DataAlerta) && VerificaEscalonamento(camaradinha.ToString(), "2", DataAlerta) && VerificaEscalonamento(camaradinha.ToString(), "1", DataAlerta)) // Se for verdadeiro quer dizer que o operador ja escalonou
                        e.Row.Cells[3].CssClass = "bgPreto";

                }

       
            }
        }
    }

    
    protected void alterarRefresh(object sender, EventArgs e)
        {
            if (alterarRefreshuser.SelectedIndex == 0)
            {
                Timer1.Enabled = false;
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

    // Executa durante o criação da Grid
    protected void GrdMergeHeader_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            GridView HeaderGrid = (GridView)sender;
            GridViewRow HeaderGridRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableHeaderCell HeaderCell = new TableHeaderCell();
            if (HeaderGrid.ClientID.ToString() == "MatrizGrid")
            {

                HeaderCell.Text = "Matriz";
                HeaderCell.ColumnSpan = 4;
                HeaderGridRow.Cells.Add(HeaderCell);
                HeaderCell.CssClass = "HeaderGrid";
                HeaderCell.Attributes.Add("OnClick", "window.location.href = 'Detalhes.aspx?Matriz';"); // Usar uma página apenas e passar paremetros da consulta
                MatrizGrid.Controls[0].Controls.AddAt(0, HeaderGridRow); // Futuramente trocar pela referencia da grid que estiver chamando a função ou não
            }
            else if (HeaderGrid.ClientID.ToString() == "FiliaisGrid")
            {
                HeaderCell.Text = "Filiais";
                HeaderCell.ColumnSpan = 4;
                HeaderGridRow.Cells.Add(HeaderCell);
                HeaderCell.CssClass = "HeaderGrid";
                HeaderCell.Attributes.Add("OnClick", "window.location.href = 'Detalhes.aspx?Filiais';");
                FiliaisGrid.Controls[0].Controls.AddAt(0, HeaderGridRow);
            }
            else if (HeaderGrid.ClientID.ToString() == "SaasGrid")
            {
                HeaderCell.Text = "SaaS";
                HeaderCell.ColumnSpan = 4;
                HeaderGridRow.Cells.Add(HeaderCell);
                HeaderCell.CssClass = "HeaderGrid";
                HeaderCell.Attributes.Add("OnClick", "window.location.href = 'Detalhes.aspx?SaaS';");
                SaasGrid.Controls[0].Controls.AddAt(0, HeaderGridRow);
            }
            else if (HeaderGrid.ClientID.ToString() == "CyberGrid")
            {
                HeaderCell.Text = "Cyber";
                HeaderCell.ColumnSpan = 4;
                HeaderGridRow.Cells.Add(HeaderCell);
                HeaderCell.CssClass = "HeaderGrid";
                HeaderCell.Attributes.Add("OnClick", "window.location.href = 'Detalhes.aspx?Cyber';");
                CyberGrid.Controls[0].Controls.AddAt(0, HeaderGridRow);

            }
            else if (HeaderGrid.ClientID.ToString() == "TicGrid")
            {
                HeaderCell.Text = "Telecom";
                HeaderCell.ColumnSpan = 4;
                HeaderGridRow.Cells.Add(HeaderCell);
                HeaderCell.CssClass = "HeaderGrid";
                HeaderCell.Attributes.Add("OnClick", "window.location.href = 'Detalhes.aspx?Telecom';");
                TicGrid.Controls[0].Controls.AddAt(0, HeaderGridRow);

            }
            else if (HeaderGrid.ClientID.ToString() == "PoaGrid")
            {
                HeaderCell.Text = "Porto Alegre";
                HeaderCell.ColumnSpan = 4;
                HeaderGridRow.Cells.Add(HeaderCell);
                HeaderCell.CssClass = "HeaderGrid";
                HeaderCell.Attributes.Add("OnClick", "window.location.href = 'Detalhes.aspx?Poa';");
                PoaGrid.Controls[0].Controls.AddAt(0, HeaderGridRow);

            }
            else if (HeaderGrid.ClientID.ToString() == "UberGrid")
            {
                HeaderCell.Text = "Uberlândia";
                HeaderCell.ColumnSpan = 4;
                HeaderGridRow.Cells.Add(HeaderCell);
                HeaderCell.CssClass = "HeaderGrid";
                HeaderCell.Attributes.Add("OnClick", "window.location.href = 'Detalhes.aspx?Uber';");
                UberGrid.Controls[0].Controls.AddAt(0, HeaderGridRow);

            }



        }

    }

    // Queries basica 
    protected void SetaComando()
    {

        int SQLMatriz = 1;
        int SQLSaaS = 2;
        int SQLUber = 3;
        int SQLCyber = 4;
        int SQLTic = 5;
        int SQLPoa = 6;
        int SQLFiliais = 7;


        if (setTimerByUser.SelectedItem.Value == "1 Hora")
        {

            this.Matriz.SelectCommand = SelectCommand("< 119", SQLMatriz);
            this.SaaS.SelectCommand = SelectCommand("< 119", SQLSaaS);
            this.Uberlandia.SelectCommand = SelectCommand("< 119", SQLUber);
            this.Cyber.SelectCommand = SelectCommand("< 119", SQLCyber);
            this.Telecom.SelectCommand = SelectCommand("< 119", SQLTic);
            this.POA.SelectCommand = SelectCommand("< 119", SQLPoa);
            this.Filiais.SelectCommand = SelectCommand("< 119", SQLFiliais);

            try
            {
                MatrizGrid.DataBind();
                SaasGrid.DataBind();
                UberGrid.DataBind();
                CyberGrid.DataBind();
                TicGrid.DataBind();
                PoaGrid.DataBind();
                Filiais.DataBind();

            }
            catch (System.Data.SqlClient.SqlException ex) //Detecta SqlException
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
            catch (Exception ex) //Detecta outro tipo de exceção
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
        }
        else if (setTimerByUser.SelectedItem.Value == "2 Horas")
        {

            this.Matriz.SelectCommand = SelectCommand("< 179", SQLMatriz);
            this.SaaS.SelectCommand = SelectCommand("< 179", SQLSaaS);
            this.Uberlandia.SelectCommand = SelectCommand("< 179", SQLUber);
            this.Cyber.SelectCommand = SelectCommand("< 179", SQLCyber);
            this.Telecom.SelectCommand = SelectCommand("< 179", SQLTic);
            this.POA.SelectCommand = SelectCommand("< 179", SQLPoa);
            this.Filiais.SelectCommand = SelectCommand("< 179", SQLFiliais);
            try
            {
                MatrizGrid.DataBind();
                SaasGrid.DataBind();
                UberGrid.DataBind();
                CyberGrid.DataBind();
                TicGrid.DataBind();
                PoaGrid.DataBind();
                Filiais.DataBind();
            }
            catch (System.Data.SqlClient.SqlException ex)  
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
            catch (Exception ex)  
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
        }
        else if (setTimerByUser.SelectedItem.Value == "3 Horas")
        {

            this.Matriz.SelectCommand = SelectCommand("< 239", SQLMatriz);
            this.SaaS.SelectCommand = SelectCommand("< 239", SQLSaaS);
            this.Uberlandia.SelectCommand = SelectCommand("< 239", SQLUber);
            this.Cyber.SelectCommand = SelectCommand("< 239", SQLCyber);
            this.Telecom.SelectCommand = SelectCommand("< 239", SQLTic);
            this.POA.SelectCommand = SelectCommand("< 239", SQLPoa);
            this.Filiais.SelectCommand = SelectCommand("< 239", SQLFiliais);
            try
            {
                MatrizGrid.DataBind();
                SaasGrid.DataBind();
                UberGrid.DataBind();
                CyberGrid.DataBind();
                TicGrid.DataBind();
                PoaGrid.DataBind();
                Filiais.DataBind();


            }
            catch (System.Data.SqlClient.SqlException ex)  
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
            catch (Exception ex)  
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
        }
        else if (setTimerByUser.SelectedItem.Value == "4 Horas")
        {

            this.Matriz.SelectCommand = SelectCommand("< 299", SQLMatriz);
            this.SaaS.SelectCommand = SelectCommand("< 299", SQLSaaS);
            this.Uberlandia.SelectCommand = SelectCommand("< 299", SQLUber);
            this.Cyber.SelectCommand = SelectCommand("< 299", SQLCyber);
            this.Telecom.SelectCommand = SelectCommand("< 299", SQLTic);
            this.POA.SelectCommand = SelectCommand("< 299", SQLPoa);
            this.Filiais.SelectCommand = SelectCommand("< 299", SQLFiliais);
            try
            {
                MatrizGrid.DataBind();
                SaasGrid.DataBind();
                UberGrid.DataBind();
                CyberGrid.DataBind();
                TicGrid.DataBind();
                PoaGrid.DataBind();
                Filiais.DataBind();


            }
            catch (System.Data.SqlClient.SqlException ex)  
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
            catch (Exception ex)  
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
        }
        else if (setTimerByUser.SelectedItem.Value == "Todos")
        {

            this.Matriz.SelectCommand = SelectCommand("> 2", SQLMatriz);
            this.SaaS.SelectCommand = SelectCommand("> 2", SQLSaaS);
            this.Uberlandia.SelectCommand = SelectCommand("> 2", SQLUber);
            this.Cyber.SelectCommand = SelectCommand("> 2", SQLCyber);
            this.Telecom.SelectCommand = SelectCommand("> 2", SQLTic);
            this.POA.SelectCommand = SelectCommand("> 2", SQLPoa);
            this.Filiais.SelectCommand = SelectCommand("> 2", SQLFiliais);
            try
            {
                MatrizGrid.DataBind();
                SaasGrid.DataBind();
                UberGrid.DataBind();
                CyberGrid.DataBind();
                TicGrid.DataBind();
                PoaGrid.DataBind();
                Filiais.DataBind();


            }

            catch (System.Data.SqlClient.SqlException ex)  
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
            catch (Exception ex)  
            {
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
        }
        else
        {
            this.Matriz.SelectCommand = SelectCommand("> 2", SQLMatriz);
            this.SaaS.SelectCommand = SelectCommand("> 2", SQLSaaS);
            this.Uberlandia.SelectCommand = SelectCommand("> 2", SQLUber);
            this.Cyber.SelectCommand = SelectCommand("> 2", SQLCyber);
            this.Telecom.SelectCommand = SelectCommand("> 2", SQLTic);
            this.POA.SelectCommand = SelectCommand("> 2", SQLPoa);
            this.Filiais.SelectCommand = SelectCommand(" > 2", SQLFiliais);
            try
            {
                MatrizGrid.DataBind();
                SaasGrid.DataBind();
                UberGrid.DataBind();
                CyberGrid.DataBind();
                TicGrid.DataBind();
                PoaGrid.DataBind();
                Filiais.DataBind();


            }
            catch (System.Data.SqlClient.SqlException ex)  
            {
               // Response.Write(ex.Message); Ideia era pegar o erro e apresentar na tela para os usuários
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
            catch (Exception ex)   
            {
                // Response.Write(ex.Message);
                Response.Write("Erro de rede ou específico à instância ao estabelecer conexão com o SQL Server. O servidor não foi encontrado ou não estava acessível. As grids depedentes do servidor inacessivel poderão não ser exibidas.");
            }
        }
       
    }
    protected String SelectCommand(String where, int quem)
    {
        /*
        int SQLMatriz = 1;
        int SQLSaaS = 2;
        int SqlUber = 3;
        int SQLCyber = 4;
        int SQLTic = 5;
        int SQLPoa = 6;
        int SQLFiliais = 7;
         */
        String retorno = null;
        // Querie original antes de tentar ordenar pelo tempo está na raiz "Queries" - Alias não esquecer de tirar dessa pasta também

        if (quem == 1)
        {
            String comando = "SELECT sDisplayname,  COUNT (sDisplayName)as total, MIN(nInternalStateTime) as tempoDown, MAX(dLastInternalStateTime) as inicio "+
                "FROM (" +
"SELECT DISTINCT DeviceAttribute.sName " +
                ", DeviceAttribute.sValue " +
                ", Device.sDisplayName " +
                ", NetworkInterface.sNetworkAddress " +
                ", ActiveMonitorType.sMonitorTypeName " +
                ", PivotActiveMonitorTypeToDevice.sComment " +
                ", PivotActiveMonitorTypeToDevice.dLastInternalStateTime " +
                ", ActiveMonitorStateChangeLog.sResult " +
                ", MonitorState.nInternalMonitorState " +
                ", MonitorState.nInternalStateTime " +
                ", PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +


           "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)  " +
                          "INNER JOIN PivotActiveMonitorTypeToDevice  " +
                          "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID  " +
                          "INNER JOIN MonitorState WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID  " +
                          "INNER JOIN Device WITH (NOLOCK)   " +
                          "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID  " +
                          "INNER JOIN ActiveMonitorType WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID  " +
                          "INNER JOIN PivotDeviceToGroup WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID  " +
                          "INNER JOIN DeviceGroup WITH (NOLOCK)  " +
                          "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID  " +
                          "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = DeviceAttribute.nDeviceID  " +
                          "INNER JOIN NetworkInterface WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = NetworkInterface.nDeviceID  " +
           "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)  " +
                          "AND (Device.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0)  " +
                          "AND (ActiveMonitorType.bRemoved = 0)  " +
                          "AND (datediff(MI, dLastInternalStateTime, getdate())  " + where + ")  " +
                          "AND (MonitorState.nInternalMonitorState = 1)  " +
                          "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)  " +
                          "AND (  " +
                                "  DeviceAttribute.sName = N'Prioridade'  " +
                               "OR DeviceAttribute.sName = N'Acionamento'  " +
                               "OR DeviceAttribute.sName = N'DC'  " +
                               "OR DeviceAttribute.sName = N'WUG'  " +
                               "OR DeviceAttribute.sName = N'Produto_Footprint'  " +
                               "OR DeviceAttribute.sName = N'KBOPM'  " +
                               ")  " +
                          ") AS a  " +
           "PIVOT (  " +
                   "max(sValue)  " +
                  "FOR sName IN ([Prioridade], [Acionamento], [Produto_Footprint], [DC], [WUG], [KBOPM]) " +
                 ") AS pvt  " +  
"group by sDisplayName " +
    "ORDER BY  inicio desc";
            retorno = comando;
        }

        else if (quem == 7)
        {
            String comando = "SELECT sDisplayname,  COUNT (sDisplayName)as total, MIN(nInternalStateTime) as tempoDown, MAX(dLastInternalStateTime) as inicio " +
                "FROM (" +
"SELECT DISTINCT DeviceAttribute.sName " +
                ", DeviceAttribute.sValue " +
                ", Device.sDisplayName " +
                ", NetworkInterface.sNetworkAddress " +
                ", ActiveMonitorType.sMonitorTypeName " +
                ", PivotActiveMonitorTypeToDevice.sComment " +
                ", PivotActiveMonitorTypeToDevice.dLastInternalStateTime " +
                ", ActiveMonitorStateChangeLog.sResult " +
                ", MonitorState.nInternalMonitorState " +
                ", MonitorState.nInternalStateTime " +
                ", PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +


           "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)  " +
                          "INNER JOIN PivotActiveMonitorTypeToDevice  " +
                          "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID  " +
                          "INNER JOIN MonitorState WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID  " +
                          "INNER JOIN Device WITH (NOLOCK)   " +
                          "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID  " +
                          "INNER JOIN ActiveMonitorType WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID  " +
                          "INNER JOIN PivotDeviceToGroup WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID  " +
                          "INNER JOIN DeviceGroup WITH (NOLOCK)  " +
                          "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID  " +
                          "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = DeviceAttribute.nDeviceID  " +
                          "INNER JOIN NetworkInterface WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = NetworkInterface.nDeviceID  " +
           "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)  " +
                          "AND (Device.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0)  " +
                          "AND (ActiveMonitorType.bRemoved = 0)  " +
                          "AND (datediff(MI, dLastInternalStateTime, getdate())  " + where + ")  " +
                          "AND (MonitorState.nInternalMonitorState = 1)  " +
                          "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)  " +
                          "AND (  " +
                                "  DeviceAttribute.sName = N'Prioridade'  " +
                               "OR DeviceAttribute.sName = N'Acionamento'  " +
                               "OR DeviceAttribute.sName = N'DC'  " +
                               "OR DeviceAttribute.sName = N'WUG'  " +
                               "OR DeviceAttribute.sName = N'Produto_Footprint'  " +
                               "OR DeviceAttribute.sName = N'KBOPM'  " +
                               ")  " +
                          ") AS a  " +
           "PIVOT (  " +
                   "max(sValue)  " +
                  "FOR sName IN ([Prioridade], [Acionamento], [Produto_Footprint], [DC], [WUG], [KBOPM]) " +
                 ") AS pvt  " +
"group by sDisplayName " +
    "ORDER BY  inicio desc";
            retorno = comando;
        }

        else if (quem == 2)
        {

            String comando = "SELECT sDisplayname,  COUNT (sDisplayName)as total, MIN(nInternalStateTime) as tempoDown, MAX(dLastInternalStateTime) as inicio " +
                        "FROM ( " +
"SELECT DISTINCT DeviceAttribute.sName " +
                ", DeviceAttribute.sValue " +
                ", Device.sDisplayName " +
                ", NetworkInterface.sNetworkAddress " +
                ", ActiveMonitorType.sMonitorTypeName " +
                ", PivotActiveMonitorTypeToDevice.sComment " +
                ", PivotActiveMonitorTypeToDevice.dLastInternalStateTime " +
                ", ActiveMonitorStateChangeLog.sResult " +
                ", MonitorState.nInternalMonitorState " +
                ", MonitorState.nInternalStateTime " +
                ", PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +


           "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)  " +
                          "INNER JOIN PivotActiveMonitorTypeToDevice  " +
                          "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID  " +
                          "INNER JOIN MonitorState WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID  " +
                          "INNER JOIN Device WITH (NOLOCK)   " +
                          "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID  " +
                          "INNER JOIN ActiveMonitorType WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID  " +
                          "INNER JOIN PivotDeviceToGroup WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID  " +
                          "INNER JOIN DeviceGroup WITH (NOLOCK)  " +
                          "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID  " +
                          "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = DeviceAttribute.nDeviceID  " +
                          "INNER JOIN NetworkInterface WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = NetworkInterface.nDeviceID  " +
           "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)  " +
                          "AND (Device.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0)  " +
                          "AND (ActiveMonitorType.bRemoved = 0)  " +
                          "AND (sDisplayName NOT LIKE '%DataSync%Processamento%')  " +
                          "AND (sDisplayName NOT LIKE 'ETL%')  " +
                          "AND (datediff(MI, dLastInternalStateTime, getdate())  " + where + ")  " +
                          "AND (MonitorState.nInternalMonitorState = 1)  " +
                          "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)  " +
                          "AND (  " +
                                "  DeviceAttribute.sName = N'Prioridade'  " +
                               "OR DeviceAttribute.sName = N'Acionamento'  " +
                               "OR DeviceAttribute.sName = N'DC'  " +
                               "OR DeviceAttribute.sName = N'WUG'  " +
                               "OR DeviceAttribute.sName = N'Produto_Footprint'  " +
                               "OR DeviceAttribute.sName = N'KBOPM'  " +
                               ")  " +
                          ") AS a  " +
           "PIVOT (  " +
                   "max(sValue) " +
                   "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                 ") AS pvt " +
"group by sDisplayName " +
    "ORDER BY  inicio desc";

            retorno = comando;
        }
        else if (quem == 3)
        {

            String comando = "SELECT sDisplayname,  COUNT (sDisplayName)as total, MIN(nInternalStateTime) as tempoDown, MAX(dLastInternalStateTime) as inicio " +
                        "FROM ( " +
"SELECT DISTINCT DeviceAttribute.sName " +
                ", DeviceAttribute.sValue " +
                ", Device.sDisplayName " +
                ", NetworkInterface.sNetworkAddress " +
                ", ActiveMonitorType.sMonitorTypeName " +
                ", PivotActiveMonitorTypeToDevice.sComment " +
                ", PivotActiveMonitorTypeToDevice.dLastInternalStateTime " +
                ", ActiveMonitorStateChangeLog.sResult " +
                ", MonitorState.nInternalMonitorState " +
                ", MonitorState.nInternalStateTime " +
                ", PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +


           "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)  " +
                          "INNER JOIN PivotActiveMonitorTypeToDevice  " +
                          "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID  " +
                          "INNER JOIN MonitorState WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID  " +
                          "INNER JOIN Device WITH (NOLOCK)   " +
                          "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID  " +
                          "INNER JOIN ActiveMonitorType WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID  " +
                          "INNER JOIN PivotDeviceToGroup WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID  " +
                          "INNER JOIN DeviceGroup WITH (NOLOCK)  " +
                          "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID  " +
                          "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = DeviceAttribute.nDeviceID  " +
                          "INNER JOIN NetworkInterface WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = NetworkInterface.nDeviceID  " +
           "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)  " +
                          "AND (Device.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0)  " +
                          "AND (ActiveMonitorType.bRemoved = 0)  " +
                          "AND (datediff(MI, dLastInternalStateTime, getdate())  " + where + ")  " +
                          "AND (MonitorState.nInternalMonitorState = 1)  " +
                          "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)  " +
                          "AND (  " +
                                "  DeviceAttribute.sName = N'Prioridade'  " +
                               "OR DeviceAttribute.sName = N'Acionamento'  " +
                               "OR DeviceAttribute.sName = N'DC'  " +
                               "OR DeviceAttribute.sName = N'WUG'  " +
                               "OR DeviceAttribute.sName = N'Produto_Footprint'  " +
                               "OR DeviceAttribute.sName = N'KBOPM'  " +
                               ")  " +
                          ") AS a  " +
           "PIVOT (  " +
                   "max(sValue) " +
                   "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                 ") AS pvt " +
           "group by sDisplayName " +
           "ORDER BY  inicio desc";

            retorno = comando;
        }
        else if (quem == 4)
        {
            String comando = "SELECT sDisplayname,  COUNT (sDisplayName)as total, MIN(nInternalStateTime) as tempoDown, MAX(dLastInternalStateTime) as inicio " +
              "FROM (" +
"SELECT DISTINCT DeviceAttribute.sName " +
                ", DeviceAttribute.sValue " +
                ", Device.sDisplayName " +
                ", NetworkInterface.sNetworkAddress " +
                ", ActiveMonitorType.sMonitorTypeName " +
                ", PivotActiveMonitorTypeToDevice.sComment " +
                ", PivotActiveMonitorTypeToDevice.dLastInternalStateTime " +
                ", ActiveMonitorStateChangeLog.sResult " +
                ", MonitorState.nInternalMonitorState " +
                ", MonitorState.nInternalStateTime " +
                ", PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +


           "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)  " +
                          "INNER JOIN PivotActiveMonitorTypeToDevice  " +
                          "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID  " +
                          "INNER JOIN MonitorState WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID  " +
                          "INNER JOIN Device WITH (NOLOCK)   " +
                          "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID  " +
                          "INNER JOIN ActiveMonitorType WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID  " +
                          "INNER JOIN PivotDeviceToGroup WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID  " +
                          "INNER JOIN DeviceGroup WITH (NOLOCK)  " +
                          "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID  " +
                          "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = DeviceAttribute.nDeviceID  " +
                          "INNER JOIN NetworkInterface WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = NetworkInterface.nDeviceID  " +
           "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)  " +
                          "AND (Device.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0)  " +
                          "AND (ActiveMonitorType.bRemoved = 0)  " +
                          "AND (datediff(MI, dLastInternalStateTime, getdate())  " + where + ")  " +
                          "AND (MonitorState.nInternalMonitorState = 1)  " +
                          "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)  " +
                          "AND (  " +
                                "  DeviceAttribute.sName = N'Prioridade'  " +
                               "OR DeviceAttribute.sName = N'Acionamento'  " +
                               "OR DeviceAttribute.sName = N'DC'  " +
                               "OR DeviceAttribute.sName = N'WUG'  " +
                               "OR DeviceAttribute.sName = N'Produto_Footprint'  " +
                               "OR DeviceAttribute.sName = N'KBOPM'  " +
                               ")  " +
                          ") AS a  " +
           "PIVOT (  " +
      "max(sValue) " +
      "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
    ") AS pvt " +
"group by sDisplayName " +
           "ORDER BY  inicio desc";
            retorno = comando;
        }
        else if (quem == 5)
        {
            String comando = "SELECT sDisplayname,  COUNT (sDisplayName)as total, MIN(nInternalStateTime) as tempoDown , MAX(dLastInternalStateTime) as inicio " +
                "FROM (" +
"SELECT DISTINCT DeviceAttribute.sName " +
                ", DeviceAttribute.sValue " +
                ", Device.sDisplayName " +
                ", NetworkInterface.sNetworkAddress " +
                ", ActiveMonitorType.sMonitorTypeName " +
                ", PivotActiveMonitorTypeToDevice.sComment " +
                ", PivotActiveMonitorTypeToDevice.dLastInternalStateTime " +
                ", ActiveMonitorStateChangeLog.sResult " +
                ", MonitorState.nInternalMonitorState " +
                ", MonitorState.nInternalStateTime " +
                ", PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +


           "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)  " +
                          "INNER JOIN PivotActiveMonitorTypeToDevice  " +
                          "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID  " +
                          "INNER JOIN MonitorState WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID  " +
                          "INNER JOIN Device WITH (NOLOCK)   " +
                          "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID  " +
                          "INNER JOIN ActiveMonitorType WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID  " +
                          "INNER JOIN PivotDeviceToGroup WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID  " +
                          "INNER JOIN DeviceGroup WITH (NOLOCK)  " +
                          "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID  " +
                          "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = DeviceAttribute.nDeviceID  " +
                          "INNER JOIN NetworkInterface WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = NetworkInterface.nDeviceID  " +
           "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)  " +
                          "AND (Device.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0)  " +
                          "AND (ActiveMonitorType.bRemoved = 0)  " +
                          "AND (datediff(MI, dLastInternalStateTime, getdate())  " + where + ")  " +
                          "AND (MonitorState.nInternalMonitorState = 1)  " +
                          "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)  " +
                          "AND (  " +
                                "  DeviceAttribute.sName = N'Prioridade'  " +
                               "OR DeviceAttribute.sName = N'Acionamento'  " +
                               "OR DeviceAttribute.sName = N'DC'  " +
                               "OR DeviceAttribute.sName = N'WUG'  " +
                               "OR DeviceAttribute.sName = N'Produto_Footprint'  " +
                               "OR DeviceAttribute.sName = N'KBOPM'  " +
                               ")  " +
                          ") AS a  " +
           "PIVOT (  " +
        "max(sValue) " +
        "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
      ") AS pvt " +
"group by sDisplayName " +
           "ORDER BY  inicio desc";
            retorno = comando;
        }
        else if (quem == 6)
        {

            String comando = "SELECT sDisplayname,  COUNT (sDisplayName)as total, MIN(nInternalStateTime) as tempoDown, MAX(dLastInternalStateTime) as inicio " +
                        "FROM ( " +
"SELECT DISTINCT DeviceAttribute.sName " +
                ", DeviceAttribute.sValue " +
                ", Device.sDisplayName " +
                ", NetworkInterface.sNetworkAddress " +
                ", ActiveMonitorType.sMonitorTypeName " +
                ", PivotActiveMonitorTypeToDevice.sComment " +
                ", PivotActiveMonitorTypeToDevice.dLastInternalStateTime " +
                ", ActiveMonitorStateChangeLog.sResult " +
                ", MonitorState.nInternalMonitorState " +
                ", MonitorState.nInternalStateTime " +
                ", PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID " +


           "FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)  " +
                          "INNER JOIN PivotActiveMonitorTypeToDevice  " +
                          "ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID  " +
                          "INNER JOIN MonitorState WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID  " +
                          "INNER JOIN Device WITH (NOLOCK)   " +
                          "ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID  " +
                          "INNER JOIN ActiveMonitorType WITH (NOLOCK)  " +
                          "ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID  " +
                          "INNER JOIN PivotDeviceToGroup WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID  " +
                          "INNER JOIN DeviceGroup WITH (NOLOCK)  " +
                          "ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID  " +
                          "LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = DeviceAttribute.nDeviceID  " +
                          "INNER JOIN NetworkInterface WITH (NOLOCK)  " +
                          "ON Device.nDeviceID = NetworkInterface.nDeviceID  " +
           "WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)  " +
                          "AND (Device.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0)  " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0)  " +
                          "AND (ActiveMonitorType.bRemoved = 0)  " +
                          "AND (datediff(MI, dLastInternalStateTime, getdate())  " + where + ")  " +
                          "AND (MonitorState.nInternalMonitorState = 1)  " +
                          "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)  " +
                          "AND (  " +
                                "  DeviceAttribute.sName = N'Prioridade'  " +
                               "OR DeviceAttribute.sName = N'Acionamento'  " +
                               "OR DeviceAttribute.sName = N'DC'  " +
                               "OR DeviceAttribute.sName = N'WUG'  " +
                               "OR DeviceAttribute.sName = N'Produto_Footprint'  " +
                               "OR DeviceAttribute.sName = N'KBOPM'  " +
                               ")  " +
                          ") AS a  " +
           "PIVOT (  " +
                   "max(sValue) " +
                   "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                 ") AS pvt " +
           "group by sDisplayName " +
           "ORDER BY  inicio desc";

            retorno = comando;
        }

        return retorno;


    }
    
    // Recupera e exibe na pagina o Downtime do monitor DOWN mais recente
    protected String ColunasAdicionais(String NomeDevice, String DB)
    {
        String Resultado = "";

        if (DB == "MatrizGrid")
            {
                    String comando = "SELECT nInternalStateTime " +
                            "FROM (" +
                            "SELECT DISTINCT DeviceAttribute.sName," +
                            "DeviceAttribute.sValue," +
                            "Device.sDisplayName," +
                            "NetworkInterface.sNetworkAddress," +
                            "DeviceGroup.sGroupName," +
                            "DeviceGroup.nParentGroupID, " +
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

                        "WHERE   (ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                            "AND (Device.bRemoved = 0) " +
                            "AND (sGroupName NOT LIKE '%Discovery%') " +
                            "AND (sDisplayName = '" + NomeDevice + "') " +
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
                        "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                        ") AS pvt " +
                        "ORDER BY dLastInternalStateTime DESC";
      
                        this.Matriz2.SelectCommand = comando;
                        DataView test = (DataView)Matriz2.Select(DataSourceSelectArguments.Empty);
                        test = (DataView)Matriz2.Select(DataSourceSelectArguments.Empty);

                        int record = test.Count;
                        if (record != 0)  //  OK
                        {
                            Resultado = test[0][0].ToString();
                        }

             }

        if (DB == "FiliaisGrid")
        {
            String comando = "SELECT nInternalStateTime " +
                    "FROM (" +
                    "SELECT DISTINCT DeviceAttribute.sName," +
                    "DeviceAttribute.sValue," +
                    "Device.sDisplayName," +
                    "NetworkInterface.sNetworkAddress," +
                    "DeviceGroup.sGroupName," +
                    "DeviceGroup.nParentGroupID, " +
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

                "WHERE   (ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                    "AND (Device.bRemoved = 0) " +
                    "AND (sGroupName NOT LIKE '%Discovery%') " +
                    "AND (sDisplayName = '" + NomeDevice + "') " +
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
                "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                ") AS pvt " +
                "ORDER BY dLastInternalStateTime DESC";

            this.Filiais2.SelectCommand = comando;
            DataView test = (DataView)Filiais2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Filiais2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                Resultado = test[0][0].ToString();
            }

        }

        if (DB == "SaasGrid")
            {
                String comando = "SELECT nInternalStateTime " +
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
                                   "AND (sDisplayName NOT LIKE '%DataSync%Processamento%') " +
                                   "AND (sDisplayName NOT LIKE 'ETL%') " +
                                   "AND (sDisplayName =  '" + NomeDevice + "') " +
                                   "AND (nInternalStateTime > 2) " +
                                   "AND (MonitorState.nInternalMonitorState = 1) " +
                                   "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +

                                   "AND ( " +
                                           "DeviceAttribute.sName = N'Prioridade' " +
                                        "OR DeviceAttribute.sName = N'Acionamento' " +

                                        "OR DeviceAttribute.sName = N'DC' " +
                                        "OR DeviceAttribute.sName = N'WUG' " +
                                        "OR DeviceAttribute.sName = N'VerSQLTical' " +
                                        "OR DeviceAttribute.sName = N'Produto' " +
                                        "OR DeviceAttribute.sName = N'KBOPM' " +
                                        "OR DeviceAttribute.sName = N'KBOPP' " +
                                        "OR DeviceAttribute.sName = N'Excecao' " +
                                        "OR DeviceAttribute.sName = N'Filial' " +
                                        ") " +
                                   ") AS a " +

                   "PIVOT ( " +
                           "max(sValue) " +
                           "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                         ") AS pvt " +
                   "ORDER BY dLastInternalStateTime DESC";

                    this.SaaS2.SelectCommand = comando;
                    DataView test = (DataView)SaaS2.Select(DataSourceSelectArguments.Empty);
                    test = (DataView)SaaS2.Select(DataSourceSelectArguments.Empty);

                    int record = test.Count;
                    if (record != 0)  //  OK
                    {
                        Resultado = test[0][0].ToString();
                    }

             }
        if (DB == "CyberGrid")
        {
            String comando = "SELECT nInternalStateTime " +
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

                        "WHERE " +          	
                        "(ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                          "AND (Device.bRemoved = 0) " +
                          "AND (sGroupName NOT LIKE '%Discovery%') " +
                          "AND (nInternalStateTime > 2) " +
                          "AND (sDisplayName =  '" + NomeDevice + "') " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) " +
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
                        "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                        ") AS pvt " +
                        "ORDER BY dLastInternalStateTime DESC";

            this.Cyber2.SelectCommand = comando;
            DataView test = (DataView)Cyber2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Cyber2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                Resultado = test[0][0].ToString();
            }

        }
        if (DB == "TicGrid")
        {
            String comando = "SELECT nInternalStateTime " +
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
                            "AND (nInternalStateTime > 2) " +
                            "AND (sDisplayName =  '" + NomeDevice + "') " +
                            "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) " +
                            "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) " +
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
                        "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                        ") AS pvt " +
                        "ORDER BY dLastInternalStateTime DESC";
            this.Telecom2.SelectCommand = comando;
            DataView test = (DataView)Telecom2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Telecom2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                Resultado = test[0][0].ToString();
            }

        }

        if (DB == "PoaGrid")
        {
            String comando = "SELECT nInternalStateTime " +
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
                                           "AND (nInternalStateTime > 2) " +
                                           "AND (sDisplayName =  '" + NomeDevice + "') " +
                                           "AND (MonitorState.nInternalMonitorState = 1) " +
                                           "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +

                                           "AND ( " +
                                                "DeviceAttribute.sName = N'Prioridade' " +
                                                "OR DeviceAttribute.sName = N'Acionamento' " +
                                                "OR DeviceAttribute.sName = N'DC' " +
                                                "OR DeviceAttribute.sName = N'WUG' " +
                                                "OR DeviceAttribute.sName = N'VerSQLTical' " +
                                                "OR DeviceAttribute.sName = N'Produto' " +
                                                "OR DeviceAttribute.sName = N'KBOPM' " +
                                                "OR DeviceAttribute.sName = N'KBOPP' " +
                                                "OR DeviceAttribute.sName = N'Excecao' " +
                                                "OR DeviceAttribute.sName = N'Filial' " +
                                                ") " +
                                           ") AS a " +

                            "PIVOT ( " +
                                   "max(sValue) " +
                                   "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                                 ") AS pvt " +
                            "ORDER BY dLastInternalStateTime DESC";


            this.POA2.SelectCommand = comando;
            DataView test = (DataView)POA2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)POA2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                Resultado = test[0][0].ToString();
            }

        }
        if (DB == "UberGrid")
        {
            String comando = "SELECT nInternalStateTime " +
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
                           "AND (nInternalStateTime > 2) " +
                           "AND (sDisplayName =  '" + NomeDevice + "') " +
                           "AND (MonitorState.nInternalMonitorState = 1) " +
                           "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +

                           "AND ( " +
                                   "DeviceAttribute.sName = N'Prioridade' " +
                                "OR DeviceAttribute.sName = N'Acionamento' " +

                                "OR DeviceAttribute.sName = N'DC' " +
                                "OR DeviceAttribute.sName = N'WUG' " +
                                "OR DeviceAttribute.sName = N'VerSQLTical' " +
                                "OR DeviceAttribute.sName = N'Produto' " +
                                "OR DeviceAttribute.sName = N'KBOPM' " +
                                "OR DeviceAttribute.sName = N'KBOPP' " +
                                "OR DeviceAttribute.sName = N'Excecao' " +
                                "OR DeviceAttribute.sName = N'Filial' " +
                                ") " +
                           ") AS a " +

           "PIVOT ( " +
                   "max(sValue) " +
                   "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                 ") AS pvt " +
           "ORDER BY dLastInternalStateTime DESC";

            this.Uberlandia2.SelectCommand = comando;
            DataView test = (DataView)Uberlandia2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Uberlandia2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                Resultado = test[0][0].ToString();
            }


        }




        return Resultado;        
    }
    protected String RecuperaImgPrAc(String NomeDevice, String DB)
    {
        String Resultado = "";
       

        if (DB == "MatrizGrid")
        {
            String comando = "SELECT Prioridade, Acionamento " +
                    "FROM (" +
                    "SELECT DISTINCT DeviceAttribute.sName," +
                    "DeviceAttribute.sValue," +
                    "Device.sDisplayName," +
                    "NetworkInterface.sNetworkAddress," +
                    "DeviceGroup.sGroupName," +
                    "DeviceGroup.nParentGroupID, " +
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

                "WHERE   (ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                    "AND (Device.bRemoved = 0) " +
                    "AND (sGroupName NOT LIKE '%Discovery%') " +
                    "AND (sDisplayName = '" + NomeDevice + "') " +
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
                "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                ") AS pvt " +
                "ORDER BY dLastInternalStateTime DESC";

            this.Matriz2.SelectCommand = comando;
            DataView test = (DataView)Matriz2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Matriz2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                if (test[0][0].ToString() == "1" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/AP24-7.png')";
                }
                else if (test[0][0].ToString() == "1" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/AP8-5.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/PN24-7.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/PN8-5.png')";
                }
                
            }

        }

        if (DB == "FiliaisGrid")
        {
            String comando = "SELECT Prioridade, Acionamento " +
                    "FROM (" +
                    "SELECT DISTINCT DeviceAttribute.sName," +
                    "DeviceAttribute.sValue," +
                    "Device.sDisplayName," +
                    "NetworkInterface.sNetworkAddress," +
                    "DeviceGroup.sGroupName," +
                    "DeviceGroup.nParentGroupID, " +
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

                "WHERE   (ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                    "AND (Device.bRemoved = 0) " +
                    "AND (sGroupName NOT LIKE '%Discovery%') " +
                    "AND (sDisplayName = '" + NomeDevice + "') " +
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
                "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                ") AS pvt " +
                "ORDER BY dLastInternalStateTime DESC";

            this.Filiais2.SelectCommand = comando;
            DataView test = (DataView)Filiais2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Filiais2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                if (test[0][0].ToString() == "1" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/AP24-7.png')";
                }
                else if (test[0][0].ToString() == "1" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/AP8-5.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/PN24-7.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/PN8-5.png')";
                }

            }

        }
        if (DB == "SaasGrid")
        {
            String comando = "SELECT Prioridade, Acionamento " +
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
                               "AND (sDisplayName NOT LIKE '%DataSync%Processamento%') " +
                               "AND (sDisplayName NOT LIKE 'ETL%') " +
                               "AND (sDisplayName =  '" + NomeDevice + "') " +
                               "AND (nInternalStateTime > 2) " +
                               "AND (MonitorState.nInternalMonitorState = 1) " +
                               "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +

                               "AND ( " +
                                       "DeviceAttribute.sName = N'Prioridade' " +
                                    "OR DeviceAttribute.sName = N'Acionamento' " +

                                    "OR DeviceAttribute.sName = N'DC' " +
                                    "OR DeviceAttribute.sName = N'WUG' " +
                                    "OR DeviceAttribute.sName = N'VerSQLTical' " +
                                    "OR DeviceAttribute.sName = N'Produto' " +
                                    "OR DeviceAttribute.sName = N'KBOPM' " +
                                    "OR DeviceAttribute.sName = N'KBOPP' " +
                                    "OR DeviceAttribute.sName = N'Excecao' " +
                                    "OR DeviceAttribute.sName = N'Filial' " +
                                    ") " +
                               ") AS a " +

               "PIVOT ( " +
                       "max(sValue) " +
                       "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                     ") AS pvt " +
               "ORDER BY dLastInternalStateTime DESC";

            this.SaaS2.SelectCommand = comando;
            DataView test = (DataView)SaaS2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)SaaS2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                if (test[0][0].ToString() == "1" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/AP24-7.png')";
                }
                else if (test[0][0].ToString() == "1" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/AP8-5.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/PN24-7.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/PN8-5.png')";
                }
            }

        }
        if (DB == "CyberGrid")
        {
            String comando = "SELECT Prioridade, Acionamento " +
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

                        "WHERE " +
                        "(ActiveMonitorStateChangeLog.dEndTime IS NULL) " +
                          "AND (Device.bRemoved = 0) " +
                          "AND (sGroupName NOT LIKE '%Discovery%') " +
                          "AND (nInternalStateTime > 2) " +
                          "AND (sDisplayName =  '" + NomeDevice + "') " +
                          "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) " +
                          "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) " +
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
                        "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                        ") AS pvt " +
                        "ORDER BY dLastInternalStateTime DESC";

            this.Cyber2.SelectCommand = comando;
            DataView test = (DataView)Cyber2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Cyber2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                if (test[0][0].ToString() == "1" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/AP24-7.png')";
                }
                else if (test[0][0].ToString() == "1" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/AP8-5.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/PN24-7.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/PN8-5.png')";
                }
            }

        }
        if (DB == "TicGrid")
        {
            String comando = "SELECT Prioridade, Acionamento " +
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
                            "AND (nInternalStateTime > 2) " +
                            "AND (sDisplayName =  '" + NomeDevice + "') " +
                            "AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) " +
                            "AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) " +
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
                        "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao]) " +
                        ") AS pvt " +
                        "ORDER BY dLastInternalStateTime DESC";
            this.Telecom2.SelectCommand = comando;
            DataView test = (DataView)Telecom2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Telecom2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                if (test[0][0].ToString() == "1" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/AP24-7.png')";
                }
                else if (test[0][0].ToString() == "1" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/AP8-5.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/PN24-7.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/PN8-5.png')";
                }
            }

        }

        if (DB == "PoaGrid")
        {
            String comando = "SELECT Prioridade, Acionamento " +
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
                                           "AND (nInternalStateTime > 2) " +
                                           "AND (sDisplayName =  '" + NomeDevice + "') " +
                                           "AND (MonitorState.nInternalMonitorState = 1) " +
                                           "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +

                                           "AND ( " +
                                                "DeviceAttribute.sName = N'Prioridade' " +
                                                "OR DeviceAttribute.sName = N'Acionamento' " +
                                                "OR DeviceAttribute.sName = N'DC' " +
                                                "OR DeviceAttribute.sName = N'WUG' " +
                                                "OR DeviceAttribute.sName = N'VerSQLTical' " +
                                                "OR DeviceAttribute.sName = N'Produto' " +
                                                "OR DeviceAttribute.sName = N'KBOPM' " +
                                                "OR DeviceAttribute.sName = N'KBOPP' " +
                                                "OR DeviceAttribute.sName = N'Excecao' " +
                                                "OR DeviceAttribute.sName = N'Filial' " +
                                                ") " +
                                           ") AS a " +

                            "PIVOT ( " +
                                   "max(sValue) " +
                                   "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                                 ") AS pvt " +
                            "ORDER BY dLastInternalStateTime DESC";


            this.POA2.SelectCommand = comando;
            DataView test = (DataView)POA2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)POA2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                if (test[0][0].ToString() == "1" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/AP24-7.png')";
                }
                else if (test[0][0].ToString() == "1" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/AP8-5.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/PN24-7.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/PN8-5.png')";
                }
            }

        }
        if (DB == "UberGrid")
        {
            String comando = "SELECT Prioridade, Acionamento " +
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
                           "AND (nInternalStateTime > 2) " +
                           "AND (sDisplayName =  '" + NomeDevice + "') " +
                           "AND (MonitorState.nInternalMonitorState = 1) " +
                           "AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID) " +

                           "AND ( " +
                                   "DeviceAttribute.sName = N'Prioridade' " +
                                "OR DeviceAttribute.sName = N'Acionamento' " +

                                "OR DeviceAttribute.sName = N'DC' " +
                                "OR DeviceAttribute.sName = N'WUG' " +
                                "OR DeviceAttribute.sName = N'VerSQLTical' " +
                                "OR DeviceAttribute.sName = N'Produto' " +
                                "OR DeviceAttribute.sName = N'KBOPM' " +
                                "OR DeviceAttribute.sName = N'KBOPP' " +
                                "OR DeviceAttribute.sName = N'Excecao' " +
                                "OR DeviceAttribute.sName = N'Filial' " +
                                ") " +
                           ") AS a " +

           "PIVOT ( " +
                   "max(sValue) " +
                   "FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [VerSQLTical], [Produto], [KBOPM], [KBOPP], [Excecao], [Filial]) " +
                 ") AS pvt " +
           "ORDER BY dLastInternalStateTime DESC";

            this.Uberlandia2.SelectCommand = comando;
            DataView test = (DataView)Uberlandia2.Select(DataSourceSelectArguments.Empty);
            test = (DataView)Uberlandia2.Select(DataSourceSelectArguments.Empty);

            int record = test.Count;
            if (record != 0)  //  OK
            {
                if (test[0][0].ToString() == "1" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/AP24-7.png')";
                }
                else if (test[0][0].ToString() == "1" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/AP8-5.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "24x07")
                {
                    Resultado = "url('img/prioridades/PN24-7.png')";
                }
                else if (test[0][0].ToString() == "2" && test[0][1].ToString() == "08x05")
                {
                    Resultado = "url('img/prioridades/PN8-5.png')";
                }
            }


        }




        return Resultado;
    }

    // Necessário para fazer o Paging 
    protected void SaasGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        SaasGrid.PageIndex = e.NewPageIndex;
        // now get the DataSource(f.e. from database) and assign it
        SetaComando();
    }

    //Verifica se alerta foi escalonado

    protected bool VerificaEscalonamento(String Nome, String Nivel, String Inicio)
    {
        /*
         * O alerta deve ter TP
         * O alerta deve ser prioridade Alta
         * Anuncia que deve ser efetuado o escalonamento no alerta. Até que o operador marque o Checkbox de escalonamento
         */

            

        bool resultado = false;
        string comando = "set dateformat dmy " +
                         "select top 1 * from Alertas where nomeDevice = '" + Nome + "' " +
                         "AND Inicio = '" + Inicio +"' " +
                         "order by TP desc";
        LinxDashNoc.SelectCommand = comando;
        DataView test = (DataView)LinxDashNoc.Select(DataSourceSelectArguments.Empty);
        int record = test.Count;
        if (record != 0 && Nivel == "1")  // NV1; 
        {
            if (test[0][8].ToString() == "True")
                resultado = true;

            else
                resultado = false;

        }
        else if (record != 0 && Nivel == "2")
        {
            if (test[0][9].ToString() == "True")
                resultado = true;

            else
                resultado = false;
        }
        else if (record != 0 && Nivel == "3")
        {
            if (test[0][10].ToString() == "True")
                resultado = true;

            else
                resultado = false;
        }
        return resultado;

    }
    protected bool excecao(String input)
    {
        String resultado = null;
        resultado = procuraEmString(input, "- ", "%");
        if (resultado == "20")
            return true;

        return false;
    }
    protected string procuraEmString(string strOrigem, string strStart, string strEnd)
    {
        int Start, End;
        if (strOrigem.Contains(strStart) && strOrigem.Contains(strEnd))
        {
            Start = strOrigem.IndexOf(strStart, 0) + strStart.Length;
            End = strOrigem.IndexOf(strEnd, Start);
            return strOrigem.Substring(Start, End - Start);
        }
        else
        {
            return "";
        }
    }


}


