﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" uiCulture="pt-BR" Debug="true" Culture="pt-BR" %>

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
 

             <div class="auto-style4">

                    Dashboard - Versão: <a href="ver.html">2.0.0</a><br />
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
         
       
        </table>
    
                </td>
            </tr>
            <tr>
              
            </tr>
            <tr style="margin-top: 0px;">
                <td valign="top" class="auto-style3">
                          <iframe src="primo.aspx" align="center" width="100%" height="500"></iframe>
                </td>
                <td valign="top" class="auto-style3">
                      <iframe src="second.aspx" align="center" width="100%" height="500"></iframe>
                </td>
             
      
        <br />
          <br />
         </div>
         </form>
 </body>
</html>
