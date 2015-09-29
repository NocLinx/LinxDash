<%@ Page Language="C#" AutoEventWireup="true" CodeFile="second.aspx.cs" Inherits="_second" uiCulture="pt-BR" Debug="true" Culture="pt-BR" %>

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
    <title>Dashboard - Versão: 2.0.0</title>
    <style type="text/css">
        .auto-style2
        {
        }
        .auto-style3
         {
            text-align: center;
        }
        .auto-style4 
        {
            text-align: right;
        }
         .auto-resize
        {
            height: 100%;
            width: 100%;
            left: 50%;
            right: 50%;
            top: 100%;
        }
        .auto-style6 {
            width: 15%;
            left: auto;
            right: 20%;
            text-align: center;
        }
    </style>
    <link rel="shortcut icon" href="img/Linx.ico" >
</head>
<body>
    
    <form id="form1" runat="server">
         
         <div class="auto-style3">
         
         <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="60000">

        </asp:Timer>
 
        <asp:SqlDataSource ID="Telecom" runat="server" ConnectionString="<%$ ConnectionStrings:TicWhatsUpConnectionString %>" SelectCommand="SELECT *
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
				ActiveMonitorStateChangeLog.sResult		
				
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
				AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) 
				AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) 
				AND (ActiveMonitorType.bRemoved = 0) 
				AND (ActiveMonitorType.bRemoved = 0) 
                AND (nInternalStateTime > 2)
				AND (MonitorState.nInternalMonitorState = 1)
				AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)
				AND (
					 DeviceAttribute.sName = N'Prioridade'
					 OR DeviceAttribute.sName = N'Acionamento'
					-- OR DeviceAttribute.sName = N'DASH_Diretoria01'
					-- OR DeviceAttribute.sName = N'DC'
					-- OR DeviceAttribute.sName = N'WUG'
					-- OR DeviceAttribute.sName = N'Vertical'
					-- OR DeviceAttribute.sName = N'Produto'
					-- OR DeviceAttribute.sName = N'KBOPM'
					-- OR DeviceAttribute.sName = N'KBOPP'
					-- OR DeviceAttribute.sName = N'Excecao'
					 )
		 ) AS a
												
PIVOT (
		max(sValue) 
		FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Vertical], [Produto], [KBOPM], [KBOPP], [Excecao]) 
	  ) AS pvt
ORDER BY dLastInternalStateTime DESC"></asp:SqlDataSource>


             <div class="auto-style4">

             </div>
        <table align="center" class="auto-resize">
            <tr>
                <td class="auto-style4" colspan="4"  > 
         
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style4" colspan="4"  > 
         
        <table align="center" class="auto-resize">
            <tr>
                <td class="auto-style6" style="font-family: 'Arial Narrow'">
    
                    Refresh:
    
                    <asp:DropDownList AutoPostBack="true" ID="alterarRefreshuser" runat="server" OnSelectedIndexChanged="alterarRefresh">
                        <asp:ListItem>Padrao</asp:ListItem>
                        <asp:ListItem>1 min</asp:ListItem>
                        <asp:ListItem>5 min</asp:ListItem>
                        <asp:ListItem>10 min</asp:ListItem>
                        <asp:ListItem>30 min</asp:ListItem>
                    </asp:DropDownList>
 
                </td>
                <td class="auto-style6" style="font-family: 'Arial Narrow'">
    
                        Mostrar Devices:
    
                        <asp:DropDownList AutoPostBack="true" ID="setTimerByUser" runat="server" OnSelectedIndexChanged="setTimerByUser_SelectedIndexChanged">
                        <asp:ListItem>Padrao</asp:ListItem>
                        <asp:ListItem>1 Hora</asp:ListItem>
                        <asp:ListItem>2 Horas</asp:ListItem>
                        <asp:ListItem>3 Horas</asp:ListItem>
                        <asp:ListItem>4 Horas</asp:ListItem>
                        <asp:ListItem>Todos</asp:ListItem>
                    </asp:DropDownList>
      
                </td>
            </tr>
        </table>
    
                </td>
            </tr>
            <tr>
                <td  > 
         
        <asp:Button ID="Button5" runat="server" title="Clique aqui para mais detalhes" OnClick="Button1_Click" Text="Telecom" BackColor="#284775" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" CssClass="auto-style2" Font-Bold="False" Font-Names="Arial Narrow" Font-Size="18pt" ForeColor="White" Height="35px" Width="300px" />
 
                </td>
                <td  >
         
                    &nbsp;</td>
                <td  >
         
                    &nbsp;</td>
                <td  >
         
                    &nbsp;</td>
                  <td  > 
         
                      &nbsp;</td>
                  <td  > 
         
                      &nbsp;</td>

            </tr>
            <!-- title="Click para mais detalhes Telecom" onclick="window.location='TelecomDetalhes.aspx'"    Mostra texto em cima do botão e torna Onclick vai para local/Site 
                    <td class="auto-style2" draggable="false" style="border-style: groove; border-width: 20%; margin: 0px; background-color: #284775; font-family: 'Arial Narrow'; color: #ffffff; font-style: normal; font-size: x-large;">Telecom </td>
                <td class="auto-style2" style="border-style: groove; border-width: 20%; margin: 0px; background-color: #284775; font-family: 'Arial Narrow'; color: #ffffff; font-style: normal; font-size: x-large;">SAAS</td>
                <td class="auto-style2" style="border-style: groove; border-width: 20%; margin: 0px; background-color: #284775; font-family: 'Arial Narrow'; color: #ffffff; font-style: normal; font-size: x-large;">ITAIM</td>
                <td class=
                
             -->
            <tr style="margin-top: 0px;">
                <td valign="top" class="auto-style3">
        <asp:GridView ID="GridView1" runat="server"  OnRowDataBound="Manipula"  AutoGenerateColumns="False" CellPadding="4" DataSourceID="Telecom" ForeColor="#333333" style="text-align:match-parent" BorderColor="Black" BorderWidth="2px" Caption=" " HorizontalAlign="Center" ShowHeaderWhenEmpty="True" Font-Names="Arial Narrow" Width="300px"  >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Prioridade" HeaderText="Pr" ReadOnly="True" SortExpression="Prioridade" />
                <asp:BoundField DataField="Acionamento" HeaderText="Ac" ReadOnly="True" SortExpression="Acionamento" />
                <asp:BoundField DataField="sDisplayName" HeaderText="Dispositivo" SortExpression="Dispositivo" />
                <asp:BoundField DataField="nInternalStateTime" HeaderText="Down" SortExpression="Down(Min.)" NullDisplayText="Agora" />

             </Columns>
            <EditRowStyle BackColor="#999999" />
            <EmptyDataRowStyle  HorizontalAlign="Center" VerticalAlign="Top" />
            <EmptyDataTemplate>
                Em breve           
            </EmptyDataTemplate>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" VerticalAlign="Top" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
        </asp:GridView>
                    <asp:Label ID="FalhaTelecom" runat="server" Enabled="false" Text=" "></asp:Label>
                </td>
                <td valign="top" class="auto-style3">
                    <asp:Label ID="FalhaSaas" runat="server" Enabled="false" Text=" "></asp:Label>
                    
 
                </td>
                <td valign="top" class="auto-style3">
                    <asp:Label ID="FalhaItaim" runat="server" Enabled="false" Text=" "></asp:Label>
                </td>
                <td valign="top" class="auto-style3">
                    <asp:Label ID="FalhaCyber" runat="server" Enabled="false" Text=" "></asp:Label>
                </td>
                <td valign="top" class="auto-style3">
                    <asp:Label ID="Label2" runat="server" Enabled="false" Text=" "></asp:Label>
                </td>   
                   <td valign="top" class="auto-style3">
                    <asp:Label ID="Label3" runat="server" Enabled="false" Text=" "></asp:Label>

            </tr>
            <tr>
                <td class="auto-style2">
         
                    &nbsp;</td>
                <td class="auto-style2">
         
                    &nbsp;</td>
                <td class="auto-style2">
         
                    &nbsp;</td>
                <td class="auto-style2">
         
                    &nbsp;</td>
            </tr>
        </table>
        <br />
          <br />
         </div>
         </form>
    
</body>
</html>
