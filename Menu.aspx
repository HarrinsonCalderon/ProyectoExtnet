<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="ProyectoExtnet.Menu" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style>
     
    </style>
    <script type="text/javascript">
        var loadPage = function (tabpanel,node) {
            var tab = tabpanel.getItem(node.id);
            if (!tab) {
                console.log(node.id);
                tab = tabpanel.add({
                    id: node.id,
                    title: node.text,
                    closable: true,
                    
                    autoLoad: {
                        showMask: true,
                        url: node.attributes.href,
                        mode: "iframe",
                        maskMsg: "Por favor espera."
                    },
                    listeners: {
                        update: {
                            fn: function (tab, cfg) {
                                cfg.iframe.setHeight(cfg.iframe.getSize().height - 20);
                            },
                            scope: this,
                            single: true
                        }
                    }
                });
             
            }
            tabpanel.setActiveTab(tab);
        }
    </script>

</head>
<body>
     <ext:ResourceManager ID="ResourceManager1" runat="server">
    </ext:ResourceManager>
   
   
    <form id="form1" runat="server">
         <ext:Viewport runat="server" Layout="border">
             <Items>
             <ext:TabPanel runat="server" Region="Center">
                  <Items>

             
            <ext:FormPanel ID="FormPanel1" runat="server"      Title="Aplicacion extnet" Width="1340" Height="650">
                <Items>
                    <ext:BorderLayout ID="BorderLayout1" runat="server">
                        <West Collapsible="true" Split="true" >
                           <%-- <ext:Panel ID="Panel1" runat="server" Title="West" Width="175">
                            </ext:Panel>--%>
                            <ext:TreePanel ID="TreePanel1" runat="server" width="300"  Collapsed="true">
                                <Root>
                                    <ext:TreeNode Text="Menu" Expanded="true">
                                        <Nodes>
                                            <ext:TreeNode Text="Menu satu" NodeID="MenuSatu">
                                                <Nodes>
                                                    <ext:TreeNode Text="Personas" NodeID="SubMenuSatu1" Href="FormularioPersonas.aspx"></ext:TreeNode>
                                                    <ext:TreeNode Text="Sub menu satu 2" NodeID="SubMenuSatu2" Href="FormularioSatSub.aspx"></ext:TreeNode>
                                                    <ext:TreeNode Text="Sub menu satu 3" NodeID="SubMenuSatu3"></ext:TreeNode>
                                                </Nodes>
                                            </ext:TreeNode>
                                              <ext:TreeNode Text="Menu dos" NodeID="MenuSatu2">
                                                <Nodes>
                                                    <ext:TreeNode Text="Sub menu satu 4" NodeID="SubMenuSatu1"></ext:TreeNode>
                                                    <ext:TreeNode Text="Sub menu satu 5" NodeID="SubMenuSatu2"></ext:TreeNode>
                                                    <ext:TreeNode Text="Sub menu satu 6" NodeID="SubMenuSatu3"></ext:TreeNode>
                                                </Nodes>
                                            </ext:TreeNode>
                                        </Nodes>
                                    </ext:TreeNode>

                                </Root>
                                <%-- oyente --%>
                                <Listeners>
                                    <Click Handler="if(node.attributes.href)
                                        {
                                          e.stopEvent();
                                          loadPage(#{tabMenu},node);
                                        }"/>
                                </Listeners>
                            </ext:TreePanel>

                        </West>
                        <Center>
                           <%-- <ext:Panel ID="Panel2" runat="server" Title="Center">
                            </ext:Panel>--%>
                            <ext:TabPanel runat="server" ID="tabMenu" EnableTabScroll="true"   > </ext:TabPanel>
                        </Center>
                       <%-- <East Collapsible="true" Split="true">
                            <ext:Panel ID="Panel3" runat="server" Title="East" Width="175">
                            </ext:Panel>
                        </East>
                        <South Collapsible="true" Split="true">
                            <ext:Panel ID="Panel4" runat="server" Height="150" Title="South">
                            </ext:Panel>
                        </South>--%>
                    </ext:BorderLayout>
                </Items>
              
            </ext:FormPanel>
            </Items>
                   </ext:TabPanel>
                 </Items>
 </ext:Viewport>
 
    </form>
       
</body>
</html>
