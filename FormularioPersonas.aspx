<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormularioPersonas.aspx.cs" Inherits="ProyectoExtnet.FormularioPersonas" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
   
    <form id="form1" runat="server">
        <div>
             <ext:ResourceManager ID="ResourceManager1" runat="server">
    </ext:ResourceManager>
            <ext:Hidden ID="hiddenId" runat="server" Text="OriginalId"></ext:Hidden>
            <ext:Panel ID="Panel1" runat="server" Height="300" Title="Crud tareas">
                <Items>
                    <ext:FormPanel ID="FormPanel1" runat="server" ButtonAlign="Left" PaddingSummary="10px 10px 10px" Border="false" MonitorValid="true">
                        <Items>
                            <ext:TextField ID="Nombre" runat="server" AnchorHorizontal="100%" FieldLabel="nombre" AllowBlank="false">
                            </ext:TextField>
                            <ext:TextField ID="Email" runat="server" AnchorHorizontal="100%" FieldLabel="email" AllowBlank="false">
                            </ext:TextField>


                        </Items>
                        <Buttons>
                            <ext:Button ID="guardar" runat="server" Icon="Disk" Text="Guardar">
                                <DirectEvents>
                                    <Click OnEvent="AgregarTarea">
                                        <EventMask ShowMask="true" Msg="Por favor espera" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Buttons>
                        <Listeners>
                            <ClientValidation Handler="#{submit}.setDisabled(!valid);" />
                        </Listeners>
                    </ext:FormPanel>
                </Items>
                <%-- Para mensajes de validacion --%>
                <BottomBar>
                    <ext:StatusBar ID="StatusBar1" runat="server" DefaultText="listo">
                        <Plugins>
                            <ext:ValidationStatus runat="server" FormPanelID="FormPanel1" ValidIcon="Accept" ErrorIcon="Exclamation"></ext:ValidationStatus>
                        </Plugins>
                    </ext:StatusBar>
                </BottomBar>
                <%-- Fin Para mensajes de validacion --%>
            </ext:Panel>

            <%-- Listar --%>
            <ext:FormPanel ID="FormPanel2" runat="server" ButtonAlign="Right" Height="300" Padding="5" Title="Listado personas" Width="1040">
                <Items>
                    <ext:BorderLayout ID="BorderLayout1" runat="server">
                       
                        <South Collapsible="true" Split="true">
                            <ext:GridPanel ID="GridPanel1" runat="server" Height="200"  >
                                <Store>
                                    <ext:Store runat="server" ID="TiendaStore" AutoLoad="true" RemoteSort="true">
                                        <Reader>
                                            <ext:ArrayReader>
                                                <Fields>
                                                    <ext:RecordField Name="id" Mapping="id" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="nombre" Mapping="nombre" Type="String">
                                                    </ext:RecordField>
                                                    <ext:RecordField Name="email" Mapping="email" Type="String">
                                                    </ext:RecordField>
                                                </Fields>
                                            </ext:ArrayReader>
                                        </Reader>

                                    </ext:Store>
                                </Store>
                                <ColumnModel runat="server">
                                    <Columns>
                                        <ext:RowNumbererColumn></ext:RowNumbererColumn>
                                       
                                        <ext:Column Header="id" ColumnID="id" DataIndex="id"></ext:Column>
                                        <ext:Column Header="nombre" ColumnID="nombre" DataIndex="nombre"></ext:Column>
                                        <ext:Column Header="email" ColumnID="email" DataIndex="email"></ext:Column>
                                          <ext:CommandColumn>
                                             <Commands>
                                                 <ext:GridCommand CommandName="Editar" Icon="BookEdit"></ext:GridCommand>
                                                 <ext:CommandSeparator />
                                                  
                                                 <ext:GridCommand CommandName="Eliminar" Icon="Delete"> </ext:GridCommand>
                                             </Commands>
                                        </ext:CommandColumn>
                                    </Columns>
                                </ColumnModel>
                                 <Listeners>
                                     <Command Handler="
                                                       if(command=='Editar'){
                                                          
                                                          Ext.net.DirectMethods.EditarPersona(record.data.id);
                                                        }else if(command=='Eliminar'){
                                                         Ext.net.DirectMethods.EliminarPersonaConfirmacion(record.data.id);
                                                       }"
                                         />
                                 </Listeners>
                            </ext:GridPanel>
                             
                        </South>
                    </ext:BorderLayout>
                </Items>

            </ext:FormPanel>
        </div>
    </form>
</body>
</html>
