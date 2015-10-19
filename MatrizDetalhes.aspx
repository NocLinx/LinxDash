<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MatrizDetalhes.aspx.cs" Inherits="_MatrizDetalhes" EnableEventValidation="false" Culture="pt-BR" uiCulture="pt-BR" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>
<!--
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

    -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Matriz - Versão: 3.0.0</title>

        <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
        <script type="text/javascript" src="scripts/jquery.zclip.js"></script>
        <script type="text/javascript">

    $(document).ready(function () {

        $("#copy-button").zclip({

            path: "scripts/ZeroClipboard.swf",

            copy: function () { return $('#TextBox1').val(); },
            beforeCopy: function () { },

            afterCopy: function () {

                alert('Copiado para area de transferencia : \n' + $('#TextBox1').val());

            }

        });

    });

</script>    <script>

         function expandir(name)
         {
             var div = document.getElementById(name)
             var img = document.getElementById('img' + name);
             if (div.style.display == 'none')
             {
                 div.style.display = "inline";
                 img.src = "img/minus.gif";
           
             }
             else {
                 div.style.display = "none";
                 img.src = "img/plus.gif";
                  
             }
           
         }
         function CopyGridViewOriginal() {
             var div = document.getElementById('divGridView');
             div.contentEditable = 'true';
             var controlRange;
             if (document.body.createControlRange) {
                 controlRange = document.body.createControlRange();
                 controlRange.addElement(div);
                 controlRange.execCommand('Copy');
             }
             div.contentEditable = 'false';
         }

    </script>
    <style type="text/css">
    .auto-style2 {
            width: 77px;
        }
    .auto-style3 {
            width: 93%;
        }
    .oculto
        {
         display:none;
        }
    .Centraliza
        {
            text-align: center;
            display: ruby-text-container;
            overflow:inherit;
            list-style:outside;
            width:90%;
            top:90%;
           
                     
         }
    .row-highlight
    {
        background-color: Yellow;
    }
    .row-select
    {
        background-color: red;
    }
    .auto-resize
        {
            height: 100%;
            width: 100%;
            left: 50%;
            right: 50%;
            top: 100%;
        }
    .btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 20px;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
}
    .btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
            .ocultar{
            display:none;
        }
        .trimmer
   {
     height:100px;
    text-overflow: ellipsis;
    text-align: centeMatriz - Versão: 3.0.0</title>

     <script>
 
         function expandir(name)
         {
             var div = document.getElementById(name)
             var img = document.getElementById('img' + name);
             if (div.style.display == 'none')
             {
                 div.style.display = "inline";
                 img.src = "img/minus.gif";
           
             }
             else {
                 div.style.display = "none";
                 img.src = "img/plus.gif";
                  
             }
           
         }
    </script>
    <style type="text/css">
    .auto-style2 {
            width: 77px;
        }
    .auto-style3 {
            width: 93%;
        }
    .oculto
        {
         display:none;
        }
    .Centraliza
        {
            text-align: center;
            display: ruby-text-container;
            overflow:inherit;
            list-style:outside;
            width:90%;
            top:90%;
           
                     
         }
    .row-highlight
    {
        background-color: Yellow;
    }
    .row-select
    {
        background-color: red;
    }
    .auto-resize
        {
            height: 100%;
            width: 100%;
            left: 50%;
            right: 50%;
            top: 100%;
        }
    .btn {
  background: #3498db;
  background-image: -webkit-linear-gradient(top, #3498db, #2980b9);
  background-image: -moz-linear-gradient(top, #3498db, #2980b9);
  background-image: -ms-linear-gradient(top, #3498db, #2980b9);
  background-image: -o-linear-gradient(top, #3498db, #2980b9);
  background-image: linear-gradient(to bottom, #3498db, #2980b9);
  -webkit-border-radius: 28;
  -moz-border-radius: 28;
  border-radius: 28px;
  font-family: Arial;
  color: #ffffff;
  font-size: 20px;
  padding: 10px 20px 10px 20px;
  text-decoration: none;
}
    .btn:hover {
  background: #3cb0fd;
  background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -ms-linear-gradient(top, #3cb0fd, #3498db);
  background-image: -o-linear-gradient(top, #3cb0fd, #3498db);
  background-image: linear-gradient(to bottom, #3cb0fd, #3498db);
  text-decoration: none;
}
            .ocultar{
            display:none;
        }
        .trimmer
   {
     height:100px;
    text-overflow: ellipsis;
    text-align: center; 
     /* Tem que por tudo em uma mesma linha para acionar o overflow*/   
    overflow: hidden;
}
        .RowSyle
        {
            height: 50px;
        }
        .AlternativeRowStyle
        {
            height: 50px;
        }

    </style>
    <link rel="shortcut icon" href="img/Linx.ico" >
</head>
<body>
    <form id="form1" runat="server">
    <div id="divGridView">
    
    <div>
    
        <asp:SqlDataSource ID="Matriz" runat="server" ConnectionString="<%$ ConnectionStrings:WhatsUpMatriz %>" SelectCommand="SELECT *
FROM (
SELECT DISTINCT DeviceAttribute.sName,
				DeviceAttribute.sValue,
				Device.sDisplayName,
				NetworkInterface.sNetworkAddress,
				DeviceGroup.sGroupName,
				ActiveMonitorType.sMonitorTypeName,
				PivotActiveMonitorTypeToDevice.sComment,
				MonitorState.nInternalStateTime,
                PivotActiveMonitorTypeToDevice.dLastInternalStateTime,
				ActiveMonitorStateChangeLog.sResult,	
                PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID,
                ActiveMonitorStateChangeLog.nActiveMonitorStateChangeLogID,
            	ActiveMonitorType.nActiveMonitorTypeID

				
FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)
				INNER JOIN PivotActiveMonitorTypeToDevice 
				ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID
				INNER JOIN MonitorState WITH (NOLOCK)
				ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID 
				INNER JOIN Device WITH (NOLOCK) 
				ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID
				INNER JOIN ActiveMonitorType WITH (NOLOCK) 
				ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID 
				INNER JOIN PivotDeviceToGroup WITH (NOLOCK)
				ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID 
				INNER JOIN DeviceGroup WITH (NOLOCK) 
				ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID 
				LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK) 
				ON Device.nDeviceID = DeviceAttribute.nDeviceID
				INNER JOIN NetworkInterface WITH (NOLOCK) 
				ON Device.nDeviceID = NetworkInterface.nDeviceID
				
WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)
			    AND (Device.bRemoved = 0)
				AND (sGroupName NOT LIKE '%Discovery%') 
                AND (nInternalStateTime > 2)
                AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) 
				AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) 
				AND (ActiveMonitorType.bRemoved = 0) 
				AND (ActiveMonitorType.bRemoved = 0) 
				AND (MonitorState.nInternalMonitorState = 1)
				AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)
				AND (
					 DeviceAttribute.sName = N'Prioridade'
					 OR DeviceAttribute.sName = N'Acionamento'
					 OR DeviceAttribute.sName = N'DC'
					 OR DeviceAttribute.sName = N'WUG'
					 OR DeviceAttribute.sName = N'Produto'
					 OR DeviceAttribute.sName = N'KBOPM'
					 OR DeviceAttribute.sName = N'KBOPP'
					 OR DeviceAttribute.sName = N'Excecao'
                     OR DeviceAttribute.sName = N'Produto_Footprint'
					 )
		 ) AS a
												
PIVOT (
		max(sValue) 
		FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Produto_Footprint], [Produto], [KBOPM], [KBOPP], [Excecao]) 
	  ) AS pvt
ORDER BY dLastInternalStateTime DESC"></asp:SqlDataSource>
        <asp:SqlDataSource ID="Matriz2" runat="server" ConnectionString="<%$ ConnectionStrings:WhatsUpMatriz %>" SelectCommand="SELECT *
FROM (
SELECT DISTINCT DeviceAttribute.sName,
				DeviceAttribute.sValue,
				Device.sDisplayName,
				NetworkInterface.sNetworkAddress,
				DeviceGroup.sGroupName,
				ActiveMonitorType.sMonitorTypeName,
				PivotActiveMonitorTypeToDevice.sComment,
				MonitorState.nInternalStateTime,
                PivotActiveMonitorTypeToDevice.dLastInternalStateTime,
				ActiveMonitorStateChangeLog.sResult,	
                PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID,
                ActiveMonitorStateChangeLog.nActiveMonitorStateChangeLogID,
            	ActiveMonitorType.nActiveMonitorTypeID

				
FROM            ActiveMonitorStateChangeLog WITH (NOLOCK)
				INNER JOIN PivotActiveMonitorTypeToDevice 
				ON ActiveMonitorStateChangeLog.nPivotActiveMonitorTypeToDeviceID = PivotActiveMonitorTypeToDevice.nPivotActiveMonitorTypeToDeviceID
				INNER JOIN MonitorState WITH (NOLOCK)
				ON PivotActiveMonitorTypeToDevice.nMonitorStateID = MonitorState.nMonitorStateID 
				INNER JOIN Device WITH (NOLOCK) 
				ON PivotActiveMonitorTypeToDevice.nDeviceID = Device.nDeviceID
				INNER JOIN ActiveMonitorType WITH (NOLOCK) 
				ON PivotActiveMonitorTypeToDevice.nActiveMonitorTypeID = ActiveMonitorType.nActiveMonitorTypeID 
				INNER JOIN PivotDeviceToGroup WITH (NOLOCK)
				ON Device.nDeviceID = PivotDeviceToGroup.nDeviceID 
				INNER JOIN DeviceGroup WITH (NOLOCK) 
				ON PivotDeviceToGroup.nDeviceGroupID = DeviceGroup.nDeviceGroupID 
				LEFT OUTER JOIN DeviceAttribute WITH (NOLOCK) 
				ON Device.nDeviceID = DeviceAttribute.nDeviceID
				INNER JOIN NetworkInterface WITH (NOLOCK) 
				ON Device.nDeviceID = NetworkInterface.nDeviceID
				
WHERE          	(ActiveMonitorStateChangeLog.dEndTime IS NULL)
			    AND (Device.bRemoved = 0)
				AND (sGroupName NOT LIKE '%Discovery%') 
                AND (nInternalStateTime > 2)
                AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) 
				AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) 
				AND (ActiveMonitorType.bRemoved = 0) 
				AND (ActiveMonitorType.bRemoved = 0) 
				AND (MonitorState.nInternalMonitorState = 1)
				AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)
				AND (
					 DeviceAttribute.sName = N'Prioridade'
					 OR DeviceAttribute.sName = N'Acionamento'
					 OR DeviceAttribute.sName = N'DC'
					 OR DeviceAttribute.sName = N'WUG'
					 OR DeviceAttribute.sName = N'Produto'
					 OR DeviceAttribute.sName = N'KBOPM'
					 OR DeviceAttribute.sName = N'KBOPP'
					 OR DeviceAttribute.sName = N'Excecao'
                     OR DeviceAttribute.sName = N'Produto_Footprint'
					 )
		 ) AS a
												
PIVOT (
		max(sValue) 
		FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Produto_Footprint], [Produto], [KBOPM], [KBOPP], [Excecao]) 
	  ) AS pvt
ORDER BY dLastInternalStateTime DESC"></asp:SqlDataSource>

        <asp:SqlDataSource ID="LinxDashNoc" runat="server" ConnectionString="<%$ ConnectionStrings:LinxDashNocStr %>" SelectCommand="SELECT * FROM [tp]" ></asp:SqlDataSource>
    
        <asp:SqlDataSource ID="Jupiter" runat="server" ConnectionString="<%$ ConnectionStrings:JupiterConnectionString %>"  OnSelecting="LinxDashNoc0_Selecting" ></asp:SqlDataSource>
    
    </div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            <tr>
                <td>

                    <meta content="text/html; charset=windows-1252" http-equiv="Content-Type" />
                    <meta content="Microsoft Word 15 (filtered)" name="Generator" />
                    <style>

<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
 /* Style Definitions */
 div.MsoNormal
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:8.0pt;
	margin-left:0cm;
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
 li.MsoNormal
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:8.0pt;
	margin-left:0cm;
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
 p.MsoNormal
	{margin-top:0cm;
	margin-right:0cm;
	margin-bottom:8.0pt;
	margin-left:0cm;
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{font-family:"Calibri",sans-serif;}
.MsoPapDefault
	{margin-bottom:8.0pt;
	line-height:107%;}
 /* Page Definitions */
 @page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
                    <div style="page: WordSection1;">
                        <p class="MsoNormal" style="margin-bottom: 0cm; margin-bottom: .0001pt; line-height: normal; text-autospace: none; text-align: center; background-color: #5D7B9D;">
                            <span style="font-size: 46pt; font-family: 'Arial Narrow'; color: #FFFFFF; background-color: #5D7B9D; font-weight: lighter;">Matriz</span></p>
                    </div>

                </td>

                          <asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>

        <table align="center" class="auto-resize">
            <tr>
                <td class="auto-style2">
    
        <asp:Button ID="Button1" runat="server" OnClick="Button2_Click" Text="Voltar" Width="120px" />
                </td>
                <td class="auto-style3">
    
        <asp:Button ID="Button2" runat="server" OnClick="Button1_Click" Text="Atualizar" Width="120px" />
 
 
                </td>
                                <td class="auto-style3">
    
                                    &nbsp;</td>

            </tr>
            <tr>
                <td class="auto-resize" colspan="3">
    
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="Matriz" ForeColor="#333333"  OnRowDataBound="Manipula"  style="text-align: center" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" BorderWidth="2px" ShowHeaderWhenEmpty="True" 
            Font-Names="Arial Narrow" DataKeyNames ="nPivotActiveMonitorTypeToDeviceID,nActiveMonitorStateChangeLogID,nActiveMonitorTypeID" CssClass="auto-resize">

            <AlternatingRowStyle CssClass="AlternativeRowStyle" BackColor="White" ForeColor="#284775" />
             
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <a href="JavaScript:expandir('<%#Eval("nActiveMonitorStateChangeLogID") %>');">
                            <img src="http://a-srv121.linx-inves.com.br:8181/img/plus.gif" id='img<%#Eval("nActiveMonitorStateChangeLogID") %>' />
                        </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Prioridade" HeaderText="Pr" ReadOnly="True" SortExpression="Prioridade" />
                 <asp:BoundField DataField="Acionamento" HeaderText="Ac" ReadOnly="True" SortExpression="Acionamento" />
                <asp:BoundField DataField="KBOPM" HeaderText="KBN" ReadOnly="True" SortExpression="KBN" />
                <asp:BoundField DataField="sDisplayName" HeaderText="Dispositivo" SortExpression="Dispositivo" />
                <asp:BoundField DataField="sNetworkAddress" HeaderText="IP" SortExpression="IP" />
                <asp:BoundField DataField="DC" HeaderText="DC / Filial" ReadOnly="True" SortExpression="DC / Filial" />
                <asp:BoundField DataField="WUG" HeaderText="WUG" ReadOnly="True" SortExpression="WUG" />
                <asp:BoundField DataField="sGroupName" HeaderText="Diretório" SortExpression="Diretorio" />
                <asp:BoundField DataField="sMonitorTypeName" HeaderText="Monitor" SortExpression="Monitor" />
                <asp:BoundField DataField="sComment" HeaderText="Comentário" SortExpression="Comentario" />
                <asp:BoundField DataField="nInternalStateTime" HeaderText="Down(Min.)" SortExpression="Down(Min.)" NullDisplayText="Agora" />
                <asp:BoundField DataField="dLastInternalStateTime" HeaderText="Duração" SortExpression="Duração" />
                <asp:BoundField DataField="dLastInternalStateTime" HeaderText="Início" SortExpression="Inicio" />
                <asp:TemplateField HeaderText="Tarefa Programada">
                <ItemTemplate>
                       
                        <asp:Label ID="ExibiTP" runat="server" CssClass="trimmer" Text= '<%#Eval("sResult") %>'> </asp:Label> <br />
                        <asp:TextBox ID="TextBox1" OnTextChanged="TextBox1_TextChanged"  AutoPostBack="true" Width="100px" runat="server"></asp:TextBox>
                </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="sResult" HeaderText="Mensagem" ControlStyle-CssClass="trimmer" SortExpression="Mensagem" />  
                <asp:BoundField DataField="nActiveMonitorStateChangeLogID" HeaderText="ID"  SortExpression="Mensagem" />
                <asp:BoundField DataField="Produto_Footprint" HeaderText="Produto" Visible="true" SortExpression="Mensagem" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <div id='<%#Eval("nActiveMonitorStateChangeLogID") %>' class="Centraliza" style="display:none" />
                                 <table class="auto-resize" width="100%" cellpadding="2" cellspacing="2">
                        <tr>
                            <th>
                                TP
                            </th>
                            <th>
                                Status
                            </th>
                            <th>
                                Data Abertura
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server" CssClass="Centraliza" Text="Label"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label2" runat="server" CssClass="Centraliza" Text="Label"></asp:Label> 
                            </td>
                            <td>
                                <asp:Label ID="Label3" runat="server" CssClass="Centraliza" Text="Label"></asp:Label>  
                            </td>
                        </tr>
                        <tr>
                            <th>
                                Recusro Responsavel
                            </th>
                            <th>
                                 Duração da TP
                            </th>
                            <th>
                               Produto FootPrint
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Recurso" runat="server" Text="Nome Responsavel*"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="Label4" runat="server" CssClass="Centraliza" Text="Label"></asp:Label>  
                            </td>
                            <td>
                               <asp:Label ID="Label5" runat="server" CssClass="Centraliza" Text="Label"></asp:Label>  
                            </td>
                        </tr>
     
                    </table>
                        
                                <table class="auto-resize">
                                    <tr >
                                         <th> Mensagem</th>
                                     </tr>
                                     <tr >
                                         <td>
                                           <asp:Label ID="Mensagem" runat="server" CssClass="trimmer" Text= '<%#Eval("sResult") %>'> </asp:Label> 

                                         </td>
                                     </tr>
                                </table>
                            </td>
                        </tr>
                    </ItemTemplate>
                    
                </asp:TemplateField>
               
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle CssClass="RowSyle" BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    
        </asp:GridView>

                </td>
            </tr>
        </table>
    
    </div>
 <div>
     <a id="copy-button" > Copiar </a>

 </div>
    </form>
</body>
</html>
