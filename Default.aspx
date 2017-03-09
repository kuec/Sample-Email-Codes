<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BiddersWebVersion.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="en">
<head runat="server">
    
    <title>Database: Home</title>
    <link href="main.css" rel="stylesheet" />
    <link href="home.css" rel="stylesheet" />
    
</head>
<body onload="ShowHide()">
    
    <script type="text/jscript" src="JavaScript1.js"></script>

        <form id="form1" runat="server" submitdisabledcontrols="False">
        <div id="box1" class="MenuAndTitleBox" style="height:205px;width:651px;padding-top:0px;padding:5px;margin:0px;">
            <h1 style="margin-bottom:10px;margin-top:2px;">Prequalified Contractor's Database</h1>
            <p style="margin-top:0px;margin-left:0px;margin-bottom:20px;padding:2px;">
            <asp:LinkButton ID="AddBidder" runat="server" Text="Add New" CssClass="ExportLinks" OnClick="AddBidder_Click"/>
            <%--<asp:Button ID="openWindow" runat="server" Text="Add New" OnClick="openWindow_Click"/>--%> 
           <%-- <asp:Button ID="ActiveExport" runat="server" Text="Active List" OnClick="ActiveList_Click" />--%>
            <a href="ReportModule.aspx?Export=yes&Stemplate=ListwPreq" target="ReportFrame" class="ExportLinks">All Contractors Report</a>
            <a href="ReportModule.aspx?Sstatus=Active&Export=yes&Stemplate=ListwPreq" target="ReportFrame" class="ExportLinks">Active Contractors Report</a>
            <asp:LinkButton ID="resetBtn" runat="server" OnClick="resetForm" Text="Reset Query" CssClass="ExportLinks"></asp:LinkButton>
            </p>  
            <div id="ListControls">
                <%--<asp:ControlParameter ControlID="WorkList" Name="Description" PropertyName="SelectedValue" />--%>
            <%--</FilterParameters>
            </asp:SqlDataSource>--%>

                <%--<asp:SqlDataSource ID="Preqs_Detail" runat="server">
                </asp:SqlDataSource>--%>

            <asp:SqlDataSource ID="PreqsDetail" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BiddersDBconnection %>" 
                SelectCommand="SELECT_DefaultContractors" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchBox" Name="Name" PropertyName="Text" Type="String" DefaultValue="%" />
                    <asp:ControlParameter ControlID="SearchBox" DefaultValue="%" Name="City" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="DDLStatus" DefaultValue="%" Name="Status" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="WorkList" DefaultValue="%" Name="WorkID" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        <p><label class="field">Search by 
            <asp:DropDownList ID="searchList" runat="server" AutoPostBack="true">
                <asp:ListItem>Name</asp:ListItem>
                <asp:ListItem>City</asp:ListItem>
            </asp:DropDownList>&nbsp;:
</label>
            &nbsp;<asp:TextBox ID="SearchBox" runat="server" OnTextChanged="SearchBox_TextChanged"></asp:TextBox>
            &nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click"/>
        &nbsp;<label class="field">Status:</label>
            <asp:DropDownList ID="DDLStatus" runat="server" AutoPostBack="True">
                <asp:ListItem Text="Active" Value="Active" Selected="True" />
                <asp:ListItem Text="Inactive" Value="Inactive" Selected="False" />
                <asp:ListItem Text="Denied" Value="Denied" Selected="False" />
                <asp:ListItem Text="All" Value="%" Selected="False" />
            </asp:DropDownList>
            
<br /><br /><label class="field">Worktype:</label>&nbsp;
            <asp:DropDownList ID="WorkList" AppendDataBoundItems="true" runat="server" AutoPostBack="True" DataSourceID="WorkTypes" DataTextField="Description" DataValueField="WorkID">
                <asp:ListItem Text="All" Value="%" Selected="True"/>
            </asp:DropDownList>
            <asp:SqlDataSource ID="WorkTypes" runat="server" ConnectionString="<%$ ConnectionStrings:BiddersDBconnection %>" SelectCommand="SELECT * FROM [SELECT_DefaultWork]"></asp:SqlDataSource>

            </p>
            </div>
          
            <br />
            <div style="margin-bottom: 20px">
            <a href="#" onclick="ShowDiv('ListGrid')" class="ButtonLink" style="position:relative;left:5px;">Home</a>
            <a href="#" onclick="ShowDiv('ReportModule')" class="ButtonLink" style="position:relative;left:-5px;">Reports</a>
            <a href="#" onclick="ShowDiv('AdminModule')" class="ButtonLink" style="position:relative;left:-5px;">Admin</a>
            <asp:HiddenField ID="StatusHolder" runat="server" Value="ListGrid" />
            </div>
            </div>
        <div id="box2">
                <img src="images/a_logo2.png" id="arlingtonLogo" alt="City of Arlington logo" />
                &nbsp;
                <img src="images/apwa2.png" id="apwaLogo" alt="APWA logo" />
 </div>
            
            <div id="ListGrid" class="CenterContent">

            <%-- NEW GRIDVIEW --%>
            <asp:GridView ID="NewBiddersGview" runat="server" AllowPaging="True" AllowSorting="True" 
                AutoGenerateColumns="False" CellPadding="4" DataSourceID="NewBiddersDBsource" DataKeyNames="Name" 
                ForeColor="#666666" GridLines="None" Width="1303px" style="margin-right: 0px" PageSize="25" 
                Font-Names="Arial" BorderColor="Black" Font-Size="Small" BackColor="White">
                <EditRowStyle BackColor="#18468C" Wrap="False" Font-Names="Arial" Font-Size="Small" ForeColor="#595959" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="Details">
                        <ItemTemplate>
                            <a href="Details.aspx?Id=<%# Eval("Id") %>" target="_blank">Select</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="Name" ItemStyle-Width="250px" ItemStyle-Wrap="false" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                    <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                    <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                    <asp:BoundField DataField="Zip" HeaderText="Zip" SortExpression="Zip" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                    <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="MWBE" HeaderText="MWBE" SortExpression="MWBE" />
                </Columns>
                <HeaderStyle BackColor="#0032A0" Font-Bold="True" ForeColor="White" Font-Names="Arial" />
                <PagerStyle BackColor="#0032A0" ForeColor="White" HorizontalAlign="Center" Font-Names="Arial" />
                <RowStyle BackColor="#EFF3FB" Wrap="False" />
                <SelectedRowStyle BackColor="#B3D4FC" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingHeaderStyle ForeColor="White" />
                <SortedDescendingHeaderStyle ForeColor="White" />
            </asp:GridView>

            <%-- NEW DATASOURCE MODIFIED --%>
                <asp:SqlDataSource ID="NewBiddersDBsource" runat="server" ConnectionString="<%$ ConnectionStrings:BiddersDBconnection %>" 
                SelectCommand="SELECT DISTINCT
		Bidders.Id, Bidders.Name, Bidders.Address, Bidders.City, Bidders.State,
		Bidders.Zip, Bidders.Phone, Bidders.Fax, Bidders.Email, Bidders.Status,
		Bidders.Denied, MWBE_Types.Code AS MWBE
	FROM 
		PW_Contractors.dbo.Bidders LEFT JOIN PW_Contractors.dbo.Preqs ON 
		PW_Contractors.dbo.Bidders.Id = PW_Contractors.dbo.Preqs.BidderID
		LEFT JOIN PW_Contractors.dbo.MWBE_Types ON PW_Contractors.dbo.Bidders.MWBE =
		PW_Contractors.dbo.MWBE_Types.MWBEID
	WHERE 
		Name LIKE '%' + @Name + '%' OR
		City LIKE '%' + @City + '%' AND Status LIKE '%' + @Status + '%' AND
		WorkID LIKE @WorkID  OR WorkID IS NULL ORDER BY Name ASC;" 
                    FilterExpression="{0} LIKE '%{1}%'"> 
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchBox" DefaultValue="%" Name="Name" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="SearchBox" DefaultValue="%" Name="City" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="DDLStatus" DefaultValue="%" Name="Status" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="WorkList" DefaultValue="%" Name="WorkID" PropertyName="Text" Type="String" />
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter ControlID="searchList" Name="SearchCategory" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="SearchBox" Name="SearchField" PropertyName="Text" />
                    <asp:ControlParameter ControlID="WorkList" Name="WorkID" PropertyName="SelectedValue" />
                </FilterParameters>
            </asp:SqlDataSource>


            <%-- NEW DATASOURCE --%>
            <%--<asp:SqlDataSource ID="NewBiddersDBsource" runat="server" ConnectionString="<%$ ConnectionStrings:BiddersDBconnection %>" 
                SelectCommand="SELECT_DefaultContractors" SelectCommandType="StoredProcedure" FilterExpression="{0} LIKE '%{1}%'"> 
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchBox" DefaultValue="%" Name="Name" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="SearchBox" DefaultValue="%" Name="City" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="DDLStatus" DefaultValue="%" Name="Status" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="WorkList" DefaultValue="%" Name="WorkID" PropertyName="Text" Type="String" />
                </SelectParameters>
                <FilterParameters>
                    <asp:ControlParameter ControlID="searchList" Name="SearchCategory" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="SearchBox" Name="SearchField" PropertyName="Text" />
                    <asp:ControlParameter ControlID="WorkList" Name="WorkID" PropertyName="SelectedValue" />
                </FilterParameters>
            </asp:SqlDataSource>--%>

            <%--GRID--%>
            <%--<asp:GridView runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                CellPadding="4" ID="GridView" DataSourceID="BiddersDatabase" ForeColor="#666666" GridLines="None" 
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="1303px" style="margin-right: 0px" 
                PageSize="25" Font-Names="Arial" BorderColor="Black" Font-Size="Small" DataKeyNames="Name" BackColor="White">
                <AlternatingRowStyle BackColor="Silver" BorderColor="#666666" BorderStyle="None" Font-Bold="False" Font-Names="Arial" Font-Overline="False" Font-Size="Small" ForeColor="#595959" HorizontalAlign="Left" Wrap="False" />
                <Columns>
                    <asp:TemplateField HeaderText="Details">
                        <ItemTemplate>
                            <a href="Details.aspx?Id=<%# Eval("Id") %>" target="_blank">Select</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="Name" ItemStyle-Width="250px" ItemStyle-Wrap="false" HeaderText="Name" SortExpression="Name" />
                        
                    <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                    <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                    <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                    <asp:BoundField DataField="Zip" HeaderText="Zip" SortExpression="Zip" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                    <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    <asp:BoundField DataField="MWBE" HeaderText="MWBE" SortExpression="MWBE" />
                </Columns>
                <EditRowStyle BackColor="#18468C" Wrap="False" Font-Names="Arial" Font-Size="Small" ForeColor="#595959" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#0032A0" Font-Bold="True" ForeColor="White" Font-Names="Arial" />
                <PagerStyle BackColor="#0032A0" ForeColor="White" HorizontalAlign="Center" Font-Names="Arial" />
                <RowStyle BackColor="#EFF3FB" Wrap="False" />
                <SelectedRowStyle BackColor="#B3D4FC" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingHeaderStyle ForeColor="White" />
                <SortedDescendingHeaderStyle ForeColor="White" />
            </asp:GridView>--%>

            </div>
            <div id="ReportModule" style="display:none" class="CenterContent">
                <iframe id="ReportFrame" width="1303px" height="650px" src="ReportModule.aspx" scrolling="no" frameborder="1" marginheight="0" marginwidth="0" ></iframe>
            </div>
            <div id="AdminModule" style="display:none" class="CenterContent">
                <iframe width="1303px" height="650px" src="AdminPanel.aspx" scrolling="no" frameborder="1" marginheight="0" marginwidth="0" ></iframe>
            </div>
            
            <asp:SqlDataSource ID="Details" runat="server" ConnectionString="<%$ ConnectionStrings:BiddersDBconnection %>" 
                DeleteCommand="DELETE_Bidders" 
                InsertCommand="INSERT_Bidders" 
                SelectCommand="SELECT_Bidders" 
                UpdateCommand="UPD_Bidders" DeleteCommandType="StoredProcedure" 
                InsertCommandType="StoredProcedure" SelectCommandType="StoredProcedure" 
                UpdateCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="NewBiddersGview" Name="Id" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="State" Type="String" />
                    <asp:Parameter Name="Zip" Type="String" />
                    <asp:Parameter Name="Phone" Type="String" />
                    <asp:Parameter Name="Fax" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Status" Type="String" />
                    <asp:Parameter Name="MWBE" Type="Int32" />
                    <asp:Parameter Name="Notes" Type="String" />
                    <asp:Parameter Name="Denied" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Address" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="State" Type="String" />
                    <asp:Parameter Name="Zip" Type="String" />
                    <asp:Parameter Name="Phone" Type="String" />
                    <asp:Parameter Name="Fax" Type="String" />
                    <asp:Parameter Name="Email" Type="String" />
                    <asp:Parameter Name="Status" Type="String" />
                    <asp:Parameter Name="MWBEID" Type="Int32" />
                    <asp:Parameter Name="Notes" Type="String" />
                    <asp:Parameter Name="Denied" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
             
        </form>
    <div class="clear"></div>    
    <%--<asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />--%>

<script id="NavigationScripts" language="javascript" type="text/javascript">

    function ShowDiv(id) {

        var v1 = document.getElementById(id);
        var Holder = document.getElementById("StatusHolder");
        var A = document.getElementById('ListGrid');
        var A2 = document.getElementById('ListControls');
        var A3 = document.getElementById('box1');
        var A4 = document.getElementById('arlingtonLogo');
        var A5 = document.getElementById('apwaLogo');
        var A6 = document.getElementById('box2');
        var B = document.getElementById('ReportModule');
        var C = document.getElementById('AdminModule');
        


        if (A == v1) {
            A.style.display = 'block';
            A2.style.display = 'block';
            A3.style.height = '205px';
            A4.style.height = 'auto';
            A5.style.height = 'auto';
            A6.style.height = '215px';
        } else {
            A.style.display = 'none';
            A2.style.display = 'none';
            A3.style.height = '125px';
            A4.style.height = '135px';
            A5.style.height = '135px';
            A6.style.height = '135px';
        }
        if (B == v1) { B.style.display = 'block'; } else { B.style.display = 'none'; }
        if (C == v1) { C.style.display = 'block'; } else { C.style.display = 'none'; }

        Holder.value = id;
    }
    function ShowHide() {
        var Holder = document.getElementById("StatusHolder");
        ShowDiv(Holder.value);
    }
    function ExpandDiv(id) {

        var v1 = document.getElementById(id);

        var A = document.getElementById('MergeWorkDiv');
        var B = document.getElementById('AddWorkType');
        var C = document.getElementById('AddLimitPopUp');
        var D = document.getElementById('AddMeasure');
        var E = document.getElementById('AddMWBE');

        if (A == v1) { A.style.height = 'auto'; } else { A.style.height = '55px'; }
        if (B == v1) { B.style.height = 'auto'; } else { B.style.height = '55px'; }
        if (C == v1) { C.style.height = 'auto'; } else { C.style.height = '55px'; }
        if (D == v1) { D.style.height = 'auto'; } else { D.style.height = '55px'; }
        if (E == v1) { E.style.height = 'auto'; } else { E.style.height = '55px'; }
    }
</script>    

</body>
</html>
