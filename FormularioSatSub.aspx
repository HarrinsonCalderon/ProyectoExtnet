<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormularioSatSub.aspx.cs" Inherits="ProyectoExtnet.FormularioSatSub" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <ext:resourcemanager id="ResourceManager1" runat="server">
    </ext:resourcemanager>
    <form id="form1" runat="server">
       <div>
              <ext:Hidden ID="hiddenId" runat="server" Text="OriginalId"></ext:Hidden>
               <ext:FormPanel ID="FormPanel2" runat="server" ButtonAlign="Right" Height="500" Padding="5" Title="Listado personas" Width="1020" >
                <Items>
                    
                    <%-- Boton agregar --%>
                    <ext:Toolbar ID="Toolbar1" runat="server">
                        <Items>
                            <ext:Button ID="btnAgregarNuevo" runat="server" Text="Agregar" Icon="BasketAdd">
                                 <DirectEvents>
                                    <Click OnEvent="agregarNuevo">
                                        <EventMask ShowMask="true" Msg="Por favor espera" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>

                     

                             <ext:GridPanel ID="GridPanel1" runat="server" Height="400"  >
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
                                        <ext:CommandColumn>
                                             <Commands>
                                                 <ext:GridCommand CommandName="Editar" Icon="BookEdit"></ext:GridCommand>
                                                 <ext:CommandSeparator />
                                                 <ext:GridCommand CommandName="Eliminar" Icon="Delete"> </ext:GridCommand>
                                             </Commands>
                                        </ext:CommandColumn>
                                        <ext:Column Header="id" ColumnID="id" DataIndex="id"></ext:Column>
                                        <ext:Column Header="nombre" ColumnID="nombre" DataIndex="nombre"></ext:Column>
                                        <ext:Column Header="email" ColumnID="email" DataIndex="email"></ext:Column>
                                    </Columns>
                                </ColumnModel>

                                 <Listeners>
                                     <Command Handler="
                                                       if(command=='Editar'){
                                                        Ext.net.DirectMethods.EditarPersona(record.data.id);
                                                        }else{
                                                        Ext.net.DirectMethods.EliminarPersona(record.data.id);
                                                       }"
                                         />
                                 </Listeners>
                            </ext:GridPanel>
                   
                </Items>

            </ext:FormPanel>

           <%-- Ventana emergente --%>
           <ext:Window ID="WindowAgregar" runat="server" Collapsible="true" Height="185" Icon="Application" Title="Title" Width="350" Hidden="true">
               <Items>
                     <ext:FormPanel ID="FormPanel1" runat="server" ButtonAlign="Left" PaddingSummary="10px 10px 10px" Border="false" MonitorValid="true">
                        <Items>
                            <ext:TextField ID="Nombre" runat="server" AnchorHorizontal="100%" FieldLabel="nombre" AllowBlank="false">
                            </ext:TextField>
                            <ext:TextField ID="Email" runat="server" AnchorHorizontal="100%" FieldLabel="email" AllowBlank="false">
                            </ext:TextField>


                        </Items>
                        <Buttons>
                            <ext:Button ID="guardar" runat="server" Icon="Disk" Text="Submit">
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
           </ext:Window>


       </div>
    </form>
</body>
</html>
