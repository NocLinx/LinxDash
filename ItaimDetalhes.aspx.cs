using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Collections;

/*
 
    Desenvolvido por:

 ▓██   ██▓ █    ██  ██▀███   ██▓     █████▒▄▄▄       ██▀███   ██▓ ▄▄▄        ██████ 
 ▒██  ██▒ ██  ▓██▒▓██ ▒ ██▒▓██▒   ▓██   ▒▒████▄    ▓██ ▒ ██▒▓██▒▒████▄    ▒██    ▒ 
  ▒██ ██░▓██  ▒██░▓██ ░▄█ ▒▒██▒   ▒████ ░▒██  ▀█▄  ▓██ ░▄█ ▒▒██▒▒██  ▀█▄  ░ ▓██▄   
  ░ ▐██▓░▓▓█  ░██░▒██▀▀█▄  ░██░   ░▓█▒  ░░██▄▄▄▄██ ▒██▀▀█▄  ░██░░██▄▄▄▄██   ▒   ██▒
  ░ ██▒▓░▒▒█████▓ ░██▓ ▒██▒░██░   ░▒█░    ▓█   ▓██▒░██▓ ▒██▒░██░ ▓█   ▓██▒▒██████▒▒
   ██▒▒▒ ░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░░▓      ▒ ░    ▒▒   ▓▒█░░ ▒▓ ░▒▓░░▓   ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░
 ▓██ ░▒░ ░░▒░ ░ ░   ░▒ ░ ▒░ ▒ ░    ░       ▒   ▒▒ ░  ░▒ ░ ▒░ ▒ ░  ▒   ▒▒ ░░ ░▒  ░ ░
 ▒ ▒ ░░   ░░░ ░ ░   ░░   ░  ▒ ░    ░ ░     ░   ▒     ░░   ░  ▒ ░  ░   ▒   ░  ░  ░  
 ░ ░        ░        ░      ░                  ░  ░   ░      ░        ░  ░      ░  
 ░ ░                                                                               
 
 Maio / 2015 
 Yuri Farias
 yuri.root@gmail.com
 relampagomagico.com.br

 
 */

public partial class ItaimDetalhes : System.Web.UI.Page
{
    public static Hashtable hashtableNomeDevice;
    public static Hashtable hashTableDataAlerta;
    public static Hashtable hashTableMonitor;
    public static Hashtable hashTableDuração;
    public static Hashtable hashTableComment;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridView1.DataBind();
        }
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        GridView1.DataBind();

    }

    protected void Manipula(Object sender, GridViewRowEventArgs e)
    {

        if (GridView1.Rows.Count == 0)
        {
            hashtableNomeDevice = new Hashtable();
            hashTableDataAlerta = new Hashtable();
            hashTableMonitor = new Hashtable();
            hashTableDuração = new Hashtable();
            hashTableComment = new Hashtable();
        }

        System.Drawing.Color OrangeRed = System.Drawing.ColorTranslator.FromHtml("#FF4500");
        System.Drawing.Color Amarelo = System.Drawing.ColorTranslator.FromHtml("#FFFF99");
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if ((int.Parse(e.Row.Cells[11].Text) >= 0))
            {
                e.Row.Cells[11].BackColor = Amarelo;
                e.Row.Cells[11].ForeColor = System.Drawing.Color.Black;
            }
            if ((int.Parse(e.Row.Cells[11].Text) == 4))
            {
                e.Row.Cells[11].BackColor = System.Drawing.Color.Orange;
            }
            if ((int.Parse(e.Row.Cells[11].Text) >= 5))
            {
                e.Row.Cells[11].BackColor = System.Drawing.Color.Red;
                e.Row.Cells[11].ForeColor = System.Drawing.Color.White;
            }
            if ((int.Parse(e.Row.Cells[11].Text) >= 15))
            {
                e.Row.Cells[11].BackColor = System.Drawing.Color.CadetBlue;
            }

            if ((int.Parse(e.Row.Cells[11].Text) >= 30))
            {
                e.Row.Cells[11].BackColor = System.Drawing.Color.Black;
            }

            // Tempo humano do alerta
            TimeSpan df = (DateTime.Now - Convert.ToDateTime(e.Row.Cells[13].Text));


            if (df.TotalMilliseconds > 1)
                e.Row.Cells[12].Text = Convert.ToString(Math.Round(df.TotalSeconds)) + " segundos";
            if (df.TotalSeconds > 60)
                e.Row.Cells[12].Text = Convert.ToString(Math.Round(df.TotalMinutes)) + " minutos";
            if (df.TotalMinutes > 60)
                e.Row.Cells[12].Text = Convert.ToString(Math.Round(df.TotalHours)) + " horas";
            if (df.TotalHours > 24)
                e.Row.Cells[12].Text = Convert.ToString(Math.Round(df.TotalDays)) + " dias";

            // Altera resultado das prioridades

            if (e.Row.Cells[1].Text.Contains("1"))
            {
                e.Row.Cells[1].Style.Add("background-Image", "url('img/red.png')");
                e.Row.Cells[1].Style.Add("background-position", "center");
                e.Row.Cells[1].Attributes.Add("title", "Prioridade Alta!");

            }
            if (e.Row.Cells[1].Text.Contains("2"))
            {
                e.Row.Cells[1].Style.Add("background-Image", "url('img/yellow.png')");
                e.Row.Cells[1].Style.Add("background-position", "center");
                e.Row.Cells[1].Attributes.Add("title", "Prioridade Normal");
            }

            e.Row.Cells[1].Style.Add("background-repeat", "no-repeat");
            e.Row.Cells[1].Text = "";
            e.Row.Cells[1].Attributes.Add("align", "center");
            // ###########################################//

            System.Web.UI.WebControls.TextBox inputext = (System.Web.UI.WebControls.TextBox)e.Row.FindControl("TextBox1");
            System.Web.UI.WebControls.Label DisplayText = (System.Web.UI.WebControls.Label)e.Row.FindControl("Label1");
            System.Web.UI.WebControls.Label StatusTP = (System.Web.UI.WebControls.Label)e.Row.FindControl("Label2");
            System.Web.UI.WebControls.Label DataCadastroTP = (System.Web.UI.WebControls.Label)e.Row.FindControl("Label3");
            System.Web.UI.WebControls.Label DiasTP = (System.Web.UI.WebControls.Label)e.Row.FindControl("Label4");
            System.Web.UI.WebControls.Label ProdutoFootPrint = (System.Web.UI.WebControls.Label)e.Row.FindControl("Label5");
            System.Web.UI.WebControls.Label Recurso = (System.Web.UI.WebControls.Label)e.Row.FindControl("Recurso");
            System.Web.UI.WebControls.Label MensagemText = (System.Web.UI.WebControls.Label)e.Row.FindControl("Mensagem");
            System.Web.UI.WebControls.Label mostraTP = (System.Web.UI.WebControls.Label)e.Row.FindControl("ExibiTP");
            
            string alerta = e.Row.Cells[16].Text.ToString();
            string nomeDevice = e.Row.Cells[4].Text.ToString();
            string monitor = e.Row.Cells[9].Text.ToString();
            string DlastTime = e.Row.Cells[11].Text.ToString();
            string comment = e.Row.Cells[10].Text.ToString();
            DateTime dataAlerta = Convert.ToDateTime(e.Row.Cells[13].Text);

            hashtableNomeDevice.Add(alerta, nomeDevice);
            hashTableDataAlerta.Add(alerta, dataAlerta);
            hashTableMonitor.Add(alerta, monitor);
            hashTableDuração.Add(alerta, DlastTime);
            hashTableComment.Add(alerta, comment);


            inputext.ToolTip = alerta;
            DisplayText.Text = SelectComand(e.Row.Cells[13].Text.ToString(), monitor, nomeDevice, comment, "2", alerta); // Recupera TP passa diferença hora como ultimo paremetro
            StatusTP.Text = recuperaInfoJupiter(DisplayText.Text.ToString(), "Status");
            DataCadastroTP.Text = recuperaInfoJupiter(DisplayText.Text.ToString(), "DataCadastro");
            DataCadastroTP.ToolTip = "Data em que a TP foi aberta no sistema (Visual Linx / WorkFlow Web)";
            DiasTP.Text = recuperaInfoJupiter(DisplayText.Text.ToString(), "DiasTP");
            DiasTP.ToolTip = "Total em dias que a TP foi aberta";
            ProdutoFootPrint.Text =  e.Row.Cells[16].Text.ToString();
            ProdutoFootPrint.ToolTip = "Produto_FootPrint";
            Recurso.Text = recuperaInfoJupiter(DisplayText.Text.ToString(), "ContatoRecurso");
            mostraTP.Text = DisplayText.Text;
            mostraTP.ToolTip = StatusTP.Text;
            // ###########################################//
 
            /*
             * Tratando erros da tela 
             */
            string input = e.Row.Cells[15].Text;
            int index = input.LastIndexOf("&#39;&#39; which does NOT");
            if (index > 0)
                input = input.Substring(0, index); // Apaga tudo depois do ultimo index

            int index2 = input.LastIndexOf("Failure occurred for the following record:");
            if (index2 > 0)
                input = input.Substring(0, index2);// Apaga tudo depois do ultimo index

            int index3 = input.LastIndexOf("which does NOT &#39;contains&#39");
            if (index3 > 0)
                input = input.Substring(0, index3);// Apaga tudo depois do ultimo index

            MensagemText.Text = input;

            // ###########################################//

            // apaga coluna alerta 

            e.Row.Cells[15].Visible = false; //Result
            e.Row.Cells[16].Visible = false;
            e.Row.Cells[17].Visible = false;
            GridView1.Columns[15].HeaderText = "";
            GridView1.Columns[16].HeaderText = "";
            GridView1.Columns[17].HeaderText = "";

            //GridView1.Columns[16].ControlStyle.CssClass = "ocultar";
            //GridView1.Columns[17].ControlStyle.CssClass = "ocultar";
            e.Row.Cells[15].CssClass = "ocultar";
            e.Row.Cells[16].CssClass = "ocultar";
            e.Row.Cells[17].CssClass = "ocultar";

            // Colocar templatefield  do lado de tarefa progamada e testar



        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        GridView1.DataBind();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }


    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {
        System.Web.UI.WebControls.TextBox objTextBox = (System.Web.UI.WebControls.TextBox)sender;

        string comando =
          "IF NOT EXISTS (Select * FROM TP WHERE (Alerta = '" + objTextBox.ToolTip.ToString() + "')) " +
          "BEGIN " +
           "INSERT INTO TP (nTP,Alerta,nomeDevice,DataAlerta,UserAgent,IP,HostName,LogonUser,Monitor,Duração,Status, Coment, Data ) VALUES ( " +
            " '" + objTextBox.Text.ToString() + "', " +
            " '" + objTextBox.ToolTip.ToString() + "', " +
            " '" + hashtableNomeDevice[objTextBox.ToolTip.ToString()] + "', " +
            " '" + hashTableDataAlerta[objTextBox.ToolTip] + "', " +
            " '" + HttpContext.Current.Request.UserAgent + "', " +
            " '" + System.Web.HttpContext.Current.Request.UserHostAddress + "', " +
            " '" + System.Web.HttpContext.Current.Request.UserHostName + "', " +
            " '" + HttpContext.Current.Request.LogonUserIdentity.Name + "', " +
            " '" + hashTableMonitor[objTextBox.ToolTip.ToString()] + "', " +
            " '" + hashTableDuração[objTextBox.ToolTip.ToString()] + "', " +
            " '" + recuperaInfoJupiter(objTextBox.Text.ToString(), "Status").Replace("Status: ", "") + "', " +
            " '" + hashTableComment[objTextBox.ToolTip.ToString()] + "'," +
            " '" + DateTime.Now + "')" +
            "END " +
            "ELSE " +
            "BEGIN " +
            " UPDATE TP set nTP = '" + objTextBox.Text.ToString() + "', " +
            " Data = '" + DateTime.Now + "', " +
            " Status = '" + recuperaInfoJupiter(objTextBox.Text.ToString(), "Status").Replace("Status: ", "") + "' " +
            "WHERE (Alerta = '" + objTextBox.ToolTip.ToString() + "' AND DataAlerta = '" + hashTableDataAlerta[objTextBox.ToolTip] + "' ) END";

        LinxDashNoc.InsertCommand = comando;
        LinxDashNoc.Insert();
        GridView1.DataBind();
    }

    protected string SelectComand(string DataAlerta, string Monitor, string NomeDevice, string Comentario, string diferençaHora, string alerta)
    {
        string resultado = "Novo";
        string comando = "set dateformat dmy " +
                         "SELECT top 1 nTP from TP where  DataAlerta = '" + DataAlerta + "' AND Monitor = '" + Monitor + "' " +
                         "AND nomeDevice = '" + NomeDevice + "' " +
                         "AND Coment = '" + Comentario + "' " +
                         "order by DataAlerta desc";
        LinxDashNoc.SelectCommand = comando;
        DataView test = (DataView)LinxDashNoc.Select(DataSourceSelectArguments.Empty);
        int record = test.Count;
        if (record != 0)  // Entrou e permance no DASH
        {
            resultado = test[0][0].ToString();
        }
        else // alerta reincidente possivelmente com DataAlerta diferente mas mesmo monitor, nomedevice  e comentario
        {
            comando = "set dateformat dmy " +
                              "SELECT top 1 Alerta from TP where  nomeDevice = '" + NomeDevice + "' " +
                              "AND Monitor = '" + Monitor + "' " +
                              "AND Coment = '" + Comentario + "' " +
                              "order by DataAlerta desc ";
            LinxDashNoc.SelectCommand = comando;
            test = (DataView)LinxDashNoc.Select(DataSourceSelectArguments.Empty);
            record = test.Count;
            if (record != 0)  // Encontrou o Alerta antigo vai checar diferença de 2 horas 
            {
                string alertaAntigo = test[0][0].ToString();
                comando = "set dateformat dmy " +
                        "select * from ActiveMonitorStateChangeLog where nActiveMonitorStateChangeLogID = '" + alertaAntigo + "' " +
                        "and  datediff(hh, dEndTime ,GETDATE()) < '" + diferençaHora + "' ";
                Itaim2.SelectCommand = comando;
                test = (DataView)Itaim2.Select(DataSourceSelectArguments.Empty);
                record = test.Count;
                if (record != 0)
                {
                    comando = "set dateformat dmy " +
                          "SELECT top 1 nTP from TP where  Alerta = '" + alertaAntigo + "' AND Monitor = '" + Monitor + "' " +
                          "AND nomeDevice = '" + NomeDevice + "' " +
                          "AND Coment = '" + Comentario + "' " +
                          "order by DataAlerta desc";
                    LinxDashNoc.SelectCommand = comando;
                    test = (DataView)LinxDashNoc.Select(DataSourceSelectArguments.Empty);
                    record = test.Count;
                    if (record != 0)
                    {
                        resultado = test[0][0].ToString();
                        comando = "INSERT INTO TP (nTP,Alerta,nomeDevice,DataAlerta,UserAgent,IP,HostName,LogonUser,Monitor,Duração,Status, Coment, Data ) VALUES ( " +
                                          " '" + resultado + "', " +
                                          " '" + alerta + "', " +
                                          " '" + hashtableNomeDevice[alerta] + "', " +
                                          " '" + hashTableDataAlerta[alerta] + "', " +
                                          " '" + HttpContext.Current.Request.UserAgent + "', " +
                                          " '" + System.Web.HttpContext.Current.Request.UserHostAddress + "', " +
                                          " '" + System.Web.HttpContext.Current.Request.UserHostName + "', " +
                                          " '" + HttpContext.Current.Request.LogonUserIdentity.Name + "', " +
                                          " '" + hashTableMonitor[alerta] + "', " +
                                          " '" + hashTableDuração[alerta] + "', " +
                                          " '" + recuperaInfoJupiter(alerta, "Status").Replace("Status: ", "") + "', " +
                                          " '" + hashTableComment[alerta] + "'," +
                                          " '" + DateTime.Now + "')";
                        LinxDashNoc.InsertCommand = comando;
                        LinxDashNoc.Insert();
                        GridView1.DataBind();


                    }

                }

            }
        }

        return resultado;
    }
    protected string recuperaInfoJupiter(string tp, string tipo)
    {
        string resultado = " ";
        int nTP;
        string comando;

        if (tipo == "Status")
        {
            if (int.TryParse(tp.Replace("TP: ", ""), out nTP))
            {
                comando = "SELECT  DESC_STATUS_TAREFA " +
                                "FROM   W_CRM_TAREFA_PROGRAMADA " +
                                "WHERE  PORC_CONCLUIDA like '%' " +
                                "AND OBJETO_ID = '" + nTP.ToString() + "' ";

                Jupiter.SelectCommand = comando;
                DataView jupiterina = (DataView)Jupiter.Select(DataSourceSelectArguments.Empty);
                int retorno = jupiterina.Count;
                if (retorno != 0)
                    resultado =  jupiterina[0][0].ToString();
                else
                    resultado = "Indefinido";
            }

        }
        else if (tipo == "DataCadastro")
        {
            if (int.TryParse(tp.Replace("TP: ", ""), out nTP))
            {
                comando = "SELECT  DATA_CADASTRO " +
                                "FROM   W_CRM_TAREFA_PROGRAMADA " +
                                "WHERE  PORC_CONCLUIDA like '%' " +
                                "AND OBJETO_ID = '" + nTP.ToString() + "' ";

                Jupiter.SelectCommand = comando;
                DataView jupiterina = (DataView)Jupiter.Select(DataSourceSelectArguments.Empty);
                int retorno = jupiterina.Count;
                if (retorno != 0)
                    resultado =  jupiterina[0][0].ToString();
                else
                    resultado = "Indefinido";
            }
        }
        else if (tipo == "ContatoRecurso")
        {
            if (int.TryParse(tp.Replace("TP: ", ""), out nTP))
            {
                comando = "SELECT  NOME_CONTATO_RECURSO " +
                                "FROM   W_CRM_TAREFA_PROGRAMADA " +
                                "WHERE  PORC_CONCLUIDA like '%' " +
                                "AND OBJETO_ID = '" + nTP.ToString() + "' ";

                Jupiter.SelectCommand = comando;
                DataView jupiterina = (DataView)Jupiter.Select(DataSourceSelectArguments.Empty);
                int retorno = jupiterina.Count;
                if (retorno != 0)
                    resultado = jupiterina[0][0].ToString();
                else
                    resultado = "Indefinido";
            }
        }

        else if (tipo == "DiasTP")
        {
            if (int.TryParse(tp.Replace("TP: ", ""), out nTP))
            {
                comando = "SELECT  Datediff(day, DATA_CADASTRO, getdate())  " +
                                 "AS DIAS_TP " +
                                 "FROM   W_CRM_TAREFA_PROGRAMADA " +
                                 "WHERE  PORC_CONCLUIDA like '%' " +
                                 "AND OBJETO_ID = '" + nTP.ToString() + "' ";

                Jupiter.SelectCommand = comando;
                DataView jupiterina = (DataView)Jupiter.Select(DataSourceSelectArguments.Empty);
                int retorno = jupiterina.Count;
                if (retorno != 0)
                {
                    if (int.Parse(jupiterina[0][0].ToString()) >= 2)
                        resultado = jupiterina[0][0].ToString() + " dias";

                    else
                        resultado =  jupiterina[0][0].ToString() + " dia";

                }
                else
                    resultado = "Indefinido";
            }
        }
        resultado = resultado.Trim();
        return resultado;
    }
    protected string recuperaFootPrint(string tp, string tipo)
    {
        string resultado = " ";
        int nTP;
        string comando;

        if (tipo == "Vertical")
        {
            if (int.TryParse(tp.Replace("TP: ", ""), out nTP))
            {
                comando = "SELECT  DESC_STATUS_TAREFA " +
                                "FROM   W_CRM_TAREFA_PROGRAMADA " +
                                "WHERE  PORC_CONCLUIDA like '%' " +
                                "AND OBJETO_ID = '" + nTP.ToString() + "' ";

                Itaim.SelectCommand = comando;
                DataView jupiterina = (DataView)Jupiter.Select(DataSourceSelectArguments.Empty);
                int retorno = jupiterina.Count;
                if (retorno != 0)
                    resultado = jupiterina[0][0].ToString();
                else
                    resultado = "Indefinido";
            }

        }
        else if (tipo == "Produto")
        {
            if (int.TryParse(tp.Replace("TP: ", ""), out nTP))
            {
                comando = "SELECT  DATA_CADASTRO " +
                                "FROM   W_CRM_TAREFA_PROGRAMADA " +
                                "WHERE  PORC_CONCLUIDA like '%' " +
                                "AND OBJETO_ID = '" + nTP.ToString() + "' ";

                Jupiter.SelectCommand = comando;
                DataView jupiterina = (DataView)Jupiter.Select(DataSourceSelectArguments.Empty);
                int retorno = jupiterina.Count;
                if (retorno != 0)
                    resultado = jupiterina[0][0].ToString();
                else
                    resultado = "Indefinido";
            }
        }


        return resultado;
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}

