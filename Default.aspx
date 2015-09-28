<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" uiCulture="pt-BR" Debug="true" Culture="pt-BR" %>

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
    <title>Dashboard - Versão: 1.1.1</title>
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
        <asp:SqlDataSource ID="Uberlandia" runat="server" ConnectionString="<%$ ConnectionStrings:WhatsUpUberlandia %>" SelectCommand="SELECT *
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
                AND (nInternalStateTime >2)
				AND (ActiveMonitorType.bRemoved = 0) 
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
        <asp:SqlDataSource ID="SaaS" runat="server" ConnectionString="<%$ ConnectionStrings:WhatsUpSaaS %>" SelectCommand="SELECT *
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
                     OR DeviceAttribute.sName = N'Produto_Footprint'
					 OR DeviceAttribute.sName = N'Produto'
					 OR DeviceAttribute.sName = N'KBOPM'
					 OR DeviceAttribute.sName = N'KBOPP'
					 OR DeviceAttribute.sName = N'Excecao'
					 )
		 ) AS a
												
PIVOT (
		max(sValue) 
		FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Produto_Footprint], [Produto], [KBOPM], [KBOPP], [Excecao]) 
	  ) AS pvt
ORDER BY dLastInternalStateTime DESC"></asp:SqlDataSource>
        <asp:SqlDataSource ID="Itaim" runat="server" ConnectionString="<%$ ConnectionStrings:WhatsUpItaim %>" SelectCommand="SELECT *
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
				--	 OR DeviceAttribute.sName = N'DASH_Diretoria01'
					 OR DeviceAttribute.sName = N'DC'
					 OR DeviceAttribute.sName = N'WUG'
				--	 OR DeviceAttribute.sName = N'Vertical'
				--	 OR DeviceAttribute.sName = N'Produto'
					 OR DeviceAttribute.sName = N'KBOPM'
					 OR DeviceAttribute.sName = N'KBOPP'
					 OR DeviceAttribute.sName = N'Excecao'
					 )
		 ) AS a
												
PIVOT (
		max(sValue) 
		FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Vertical], [Produto], [KBOPM], [KBOPP], [Excecao]) 
	  ) AS pvt
ORDER BY dLastInternalStateTime DESC">

        </asp:SqlDataSource>
        <asp:SqlDataSource ID="Cyber" runat="server" ConnectionString="<%$ ConnectionStrings:WhatsUpCyber %>" SelectCommand="SELECT *
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
                AND (nInternalStateTime >2 )
				AND (ActiveMonitorType.bRemoved = 0) 
				AND (MonitorState.nInternalMonitorState = 1)
				AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)
				AND (
					 DeviceAttribute.sName = N'Prioridade'
					 OR DeviceAttribute.sName = N'Acionamento'
				--	 OR DeviceAttribute.sName = N'DASH_Diretoria01'
					 OR DeviceAttribute.sName = N'DC'
					 OR DeviceAttribute.sName = N'WUG'
				--	 OR DeviceAttribute.sName = N'Vertical'
				--	 OR DeviceAttribute.sName = N'Produto'
					 OR DeviceAttribute.sName = N'KBOPM'
					 OR DeviceAttribute.sName = N'KBOPP'
					 OR DeviceAttribute.sName = N'Excecao'
					 )
		 ) AS a
												
PIVOT (
		max(sValue) 
		FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Vertical], [Produto], [KBOPM], [KBOPP], [Excecao]) 
	  ) AS pvt
ORDER BY dLastInternalStateTime DESC">

        </asp:SqlDataSource>
        <asp:SqlDataSource ID="POA" runat="server" ConnectionString="<%$ ConnectionStrings:PoaWhatsUpConnectionString %>" SelectCommand="SELECT *
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
				AND (sGroupName NOT LIKE '%Layer 2%' )
				AND (sGroupName NOT LIKE '%Rangescan%')
				AND (PivotActiveMonitorTypeToDevice.bRemoved = 0) 
				AND (PivotActiveMonitorTypeToDevice.bDisabled = 0) 
				AND (ActiveMonitorType.bRemoved = 0) 
                AND (nInternalStateTime >2 )
				AND (ActiveMonitorType.bRemoved = 0) 
				AND (MonitorState.nInternalMonitorState = 1)
				AND (Device.nDefaultNetworkInterfaceID = NetworkInterface.nNetworkInterfaceID)
				AND (
					 DeviceAttribute.sName = N'Prioridade'
					 OR DeviceAttribute.sName = N'Acionamento'
				--	 OR DeviceAttribute.sName = N'DASH_Diretoria01'
					 OR DeviceAttribute.sName = N'DC'
					 OR DeviceAttribute.sName = N'WUG'
				--	 OR DeviceAttribute.sName = N'Vertical'
				--	 OR DeviceAttribute.sName = N'Produto'
					 OR DeviceAttribute.sName = N'KBOPM'
					 OR DeviceAttribute.sName = N'KBOPP'
					 OR DeviceAttribute.sName = N'Excecao'
					 )
		 ) AS a
												
PIVOT (
		max(sValue) 
		FOR sName IN ([Prioridade], [Acionamento], [DASH_Diretoria01], [DC], [WUG], [Vertical], [Produto], [KBOPM], [KBOPP], [Excecao]) 
	  ) AS pvt
ORDER BY dLastInternalStateTime DESC">

        </asp:SqlDataSource>


             <div class="auto-style4">

                    Dashboard - Versão: <a href="ver.html">1.1.1</a><br />
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>

         <br />
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
         
        <asp:Button ID="Button5" runat="server" title="Clique aqui para mais detalhes" OnClick="Button1_Click" Text="MATRIZ" BackColor="#284775" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" CssClass="auto-style2" Font-Bold="False" Font-Names="Arial Narrow" Font-Size="18pt" ForeColor="White" Height="35px" Width="300px" />
 
                </td>
                <td  >
         
        <asp:Button ID="Button6" runat="server" title="Clique aqui para mais detalhes" OnClick="Button2_Click" Text="SAAS" BackColor="#284775" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" CssClass="auto-style2" Font-Bold="False" Font-Names="Arial Narrow" Font-Size="18pt" ForeColor="White" Height="35px" Width="300px" />
 
                </td>
                <td  >
         
        <asp:Button ID="Button7" runat="server" title="Clique aqui para mais detalhes" OnClick="Button3_Click" Text="ITAIM" BackColor="#284775" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" CssClass="auto-style2" Font-Bold="False" Font-Names="Arial Narrow" Font-Size="18pt" ForeColor="White" Height="35px" Width="300px" />
 
                </td>
                <td  >
         
        <asp:Button ID="Button8" runat="server" title="Clique aqui para mais detalhes" OnClick="Button4_Click" Text="CYBER" BackColor="#284775" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" CssClass="auto-style2" Font-Bold="False" Font-Names="Arial Narrow" Font-Size="18pt" ForeColor="White" Height="35px" Width="328px" />
 
                </td>
                  <td  > 
         
        <asp:Button ID="Button9" runat="server" title="Clique aqui para mais detalhes" OnClick="Button5_Click" Text="UBERLÂNDIA" BackColor="#284775" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" CssClass="auto-style2" Font-Bold="False" Font-Names="Arial Narrow" Font-Size="18pt" ForeColor="White" Height="35px" Width="300px" />
 
                </td>
                  <td  > 
         
        <asp:Button ID="Button10" runat="server" title="Clique aqui para mais detalhes" OnClick="Button6_Click" Text="POA" BackColor="#284775" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" CssClass="auto-style2" Font-Bold="False" Font-Names="Arial Narrow" Font-Size="18pt" ForeColor="White" Height="35px" Width="300px" />
 
                </td>

            </tr>
            <!-- title="Click para mais detalhes Matriz" onclick="window.location='MatrizDetalhes.aspx'"    Mostra texto em cima do botão e torna Onclick vai para local/Site 
                    <td class="auto-style2" draggable="false" style="border-style: groove; border-width: 20%; margin: 0px; background-color: #284775; font-family: 'Arial Narrow'; color: #ffffff; font-style: normal; font-size: x-large;">MATRIZ </td>
                <td class="auto-style2" style="border-style: groove; border-width: 20%; margin: 0px; background-color: #284775; font-family: 'Arial Narrow'; color: #ffffff; font-style: normal; font-size: x-large;">SAAS</td>
                <td class="auto-style2" style="border-style: groove; border-width: 20%; margin: 0px; background-color: #284775; font-family: 'Arial Narrow'; color: #ffffff; font-style: normal; font-size: x-large;">ITAIM</td>
                <td class=
                
             -->
            <tr style="margin-top: 0px;">
                <td valign="top" class="auto-style3">
        <asp:GridView ID="GridView1" runat="server"  OnRowDataBound="Manipula"  AutoGenerateColumns="False" CellPadding="4" GridLines="Both" DataSourceID="Matriz" ForeColor="#333333" style="text-align:match-parent" BorderColor="Black" BorderWidth="2px" Caption=" " HorizontalAlign="Center" ShowHeaderWhenEmpty="True" Font-Names="Arial Narrow"  >
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
                Nenhum incidente detectado. OK <br />           
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
                    <asp:Label ID="FalhaMatriz" runat="server" Enabled="false" Text=" "></asp:Label>
                </td>
                <td valign="top" class="auto-style3">
        <asp:GridView ID="GridView2" runat="server"  OnRowDataBound="Manipula" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SaaS" ForeColor="#333333" style="text-align:match-parent" BorderColor="Black" BorderWidth="2px" HorizontalAlign="Center" ShowHeaderWhenEmpty="True" Font-Names="Arial Narrow" >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Prioridade" HeaderText="Pr" ReadOnly="True" SortExpression="Prioridade" />
                <asp:BoundField DataField="Acionamento" HeaderText="Ac" ReadOnly="True" SortExpression="Acionamento" />
                <asp:BoundField DataField="sDisplayName" HeaderText="Dispositivo" SortExpression="Dispositivo" />
                <asp:BoundField DataField="nInternalStateTime" HeaderText="Down" SortExpression="Down(Min.)" NullDisplayText="Agora" />
             </Columns>
            <EditRowStyle BackColor="#999999" />
            <EmptyDataTemplate>
                 Nenhum incidente detectado. OK. <br />
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
                    <asp:Label ID="FalhaSaas" runat="server" Enabled="false" Text=" "></asp:Label>
                    
 
                </td>
                <td valign="top" class="auto-style3">
        <asp:GridView ID="GridView3" runat="server"  OnRowDataBound="Manipula"  AutoGenerateColumns="False" CellPadding="4" DataSourceID="Itaim" ForeColor="#333333" style="text-align:match-parent" BorderColor="Black" BorderWidth="2px" HorizontalAlign="Center" ShowHeaderWhenEmpty="True" Font-Names="Arial Narrow"  >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Prioridade" HeaderText="Pr" ReadOnly="True" SortExpression="Prioridade" />
                <asp:BoundField DataField="Acionamento" HeaderText="Ac" ReadOnly="True" SortExpression="Acionamento" />
                <asp:BoundField DataField="sDisplayName" HeaderText="Dispositivo" SortExpression="Dispositivo" />
                <asp:BoundField DataField="nInternalStateTime" HeaderText="Down" SortExpression="Down(Min.)" NullDisplayText="Agora" />
             </Columns>
            <EditRowStyle BackColor="#999999" />
            <EmptyDataTemplate>
                Nenhum incidente detectado. OK <br />
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
                    <asp:Label ID="FalhaItaim" runat="server" Enabled="false" Text=" "></asp:Label>
                </td>
                <td valign="top" class="auto-style3">
        <asp:GridView ID="GridView4" runat="server"  OnRowDataBound="Manipula"  AutoGenerateColumns="False" CellPadding="4"  DataSourceID="Cyber" ForeColor="#333333" style="text-align:match-parent; margin-left: 0px;" BorderColor="Black" BorderWidth="2px" HorizontalAlign="Center" ShowHeaderWhenEmpty="True"  >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Prioridade" HeaderText="Pr" ReadOnly="True" SortExpression="Prioridade" />
                <asp:BoundField DataField="Acionamento" HeaderText="Ac" ReadOnly="True" SortExpression="Acionamento" />
                <asp:BoundField DataField="sDisplayName" HeaderText="Dispositivo" SortExpression="Dispositivo" />
                <asp:BoundField DataField="nInternalStateTime" HeaderText="Down" SortExpression="Down(Min.)" NullDisplayText="Agora" />
             </Columns>
            <EditRowStyle BackColor="#999999" />
            <EmptyDataTemplate>
                  Nenhum incidente detectado. OK <br />
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
                    <asp:Label ID="FalhaCyber" runat="server" Enabled="false" Text=" "></asp:Label>
                </td>
                <td valign="top" class="auto-style3">
        <asp:GridView ID="UberGrid" runat="server"  OnRowDataBound="Manipula"  AutoGenerateColumns="False" CellPadding="4"  DataSourceID="Uberlandia" ForeColor="#333333" style="text-align:match-parent; margin-left: 0px;" BorderColor="Black" BorderWidth="2px" HorizontalAlign="Center" ShowHeaderWhenEmpty="True"  >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Prioridade" HeaderText="Pr" ReadOnly="True" SortExpression="Prioridade" />
                <asp:BoundField DataField="Acionamento" HeaderText="Ac" ReadOnly="True" SortExpression="Acionamento" />
                <asp:BoundField DataField="sDisplayName" HeaderText="Dispositivo" SortExpression="Dispositivo" />
                <asp:BoundField DataField="nInternalStateTime" HeaderText="Down" SortExpression="Down(Min.)" NullDisplayText="Agora" />
             </Columns>
            <EditRowStyle BackColor="#999999" />
            <EmptyDataTemplate>
                  OK! <br />
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
                    <asp:Label ID="Label2" runat="server" Enabled="false" Text=" "></asp:Label>
                </td>   
                   <td valign="top" class="auto-style3">
        <asp:GridView ID="GridPOA" runat="server"  OnRowDataBound="Manipula"  AutoGenerateColumns="False" CellPadding="4"  DataSourceID="POA" ForeColor="#333333" style="text-align:match-parent; margin-left: 0px;" BorderColor="Black" BorderWidth="2px" HorizontalAlign="Center" ShowHeaderWhenEmpty="True"  >
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="Prioridade" HeaderText="Pr" ReadOnly="True" SortExpression="Prioridade" />
                <asp:BoundField DataField="Acionamento" HeaderText="Ac" ReadOnly="True" SortExpression="Acionamento" />
                <asp:BoundField DataField="sDisplayName" HeaderText="Dispositivo" SortExpression="Dispositivo" />
                <asp:BoundField DataField="nInternalStateTime" HeaderText="Down" SortExpression="Down(Min.)" NullDisplayText="Agora" />
             </Columns>
            <EditRowStyle BackColor="#999999" />
            <EmptyDataTemplate>
                  OK! <br />
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
