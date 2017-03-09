<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermitsTable.aspx.cs" Inherits="ROW_DB.PermitsTable" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <link href="../style/ROW/MenuUI.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../style/ROW/Style.css" />
    <link rel="stylesheet" type="text/css" href="../style/ROW/TestStyle2.css" />
    <%--<link rel="stylesheet" href="../style/ROW/TestStyle2.css" />--%>

    <%--<link rel="stylesheet" media="only screen and (max-width: 1290px) and (min-width: 510px)" href="../style/ROW/TestStyle.css" />--%>

<script src="../scripts/jquery-2.1.4.js"></script>

<script id="SearchBoxScript">
    function PopulateResults(ResultsArray, filterVal) {
        $('#SearchResults').empty();
        $.each(ResultsArray, function (index, element) {
            $('#SearchResults')
            .append($("<a class=\"SearchLink\"href=\"javascript:openPermit(\'Details.aspx?ID=" + element.ID + "',800,800);\">"
            + "<div class=\"SearchResultID\">" + element.Application + "</div>"
            + "<div class=\"ResultsBox\">"
            + "<div class=\"SearchResultField\">" + element.FieldName + "</div>"
            + element.FieldValue
            + "</div></a>"));
        });
        $("#loadingGif").hide();
    }
    function Bolden(InputString, BoldenString) {
        return InputString.html().replace(BoldenString, '<b>' + BoldenString + '</b>');
    }

    function GetPermits() {
        var url = "../api/LocationSearch/SearchPermits";
        var filterVal = document.getElementById("txt_Smart").value;
        if (filterVal.length > 0) {
            var PermitParam = {
                SearchText: filterVal
            }
            $.ajax({
                url: url,
                method: "POST",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify(PermitParam),
                dataType: 'json',
                success: function (response) {
                    PopulateResults(response, filterVal);
                }
            }).error(function (error) {
                PopulateResultes(JSON.stringify(error));
            });
        } else { $('#SearchResults').empty(); }
    };
    $(document).ready(function () {
        $("#txt_Smart").keyup(function () {
            GetPermits();
        });
        $("#txt_Smart").mouseup(function () {
            setTimeout(function () {
                GetPermits();
            }, 1);



        });
    })
</script>
    <script src="../scripts/CookieManager.js"></script>
<script>
    function ClearCookie() {
        $.cookie("ROW_Permits_Cookie", 'Select');
        CookieWork();
    }
    function CookieWork() {
        switch ($.cookie("ROW_Permits_Cookie")) {
            case undefined:
                window.open('Select.html', '_self');
                break;
            case 'Select':
                window.open('Select.html', '_self');
                break;
            case 'Admin':
                window.open('Admin.aspx', '_self');
                break;
            case 'Engineer':
                window.open('Engineer.aspx', '_self')
                break;
            case 'Inspector':
                window.open('Inspector.aspx', '_self')
                break;

        }

    }
    $(document).ready(function () {
        if ($('#statusFilter').val() == '%') { $('#statusFilter').css('backgroundColor', 'white'); }
        else { $('#statusFilter').css('backgroundColor', '#fff4bf'); }
        if ($('#ProviderFilterList').val() == '%') { $('#ProviderFilterList').css('backgroundColor', 'white'); }
        else { $('#ProviderFilterList').css('backgroundColor', '#fff4bf'); }
        if ($('#ContractorFilterList').val() == '%') { $('#ContractorFilterList').css('backgroundColor', 'white'); }
        else { $('#ContractorFilterList').css('backgroundColor', '#fff4bf'); }
    })

</script>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <title>ROW Database</title>
    
    

</head>
<body>

        <div id="subFormLinkBox-Admin">
            <ul id="SubFormLinks">
                <li><a class="current" href="#">Permits</a></li>
                <li><a href="SP_Table.aspx">Service Provider</a></li>
                <li><a href="contractor_Table.aspx">Contractors</a></li>
            </ul>
        </div>

<!---------- PERMIT FILTER ---------->
        <form id="permitForm" runat="server">
       <div class="PermitFilterBox">
           <div class="DDLbox1">
               Status
               <br />
               <asp:DropDownList CssClass="DDLStyle" ID="statusFilter" runat="server" AutoPostBack="true">
                        <asp:ListItem Text="All permits" Value="%" Selected="False"></asp:ListItem>
                        <asp:ListItem Text="TCP Review" Value="TCP Review" Selected="False"></asp:ListItem>
                        <asp:ListItem Text="Permits wating for Engineer review" Value="Review" Selected="False"></asp:ListItem>
                        <asp:ListItem Text="Permits waiting for pickup" Value="Accepted" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Picked up permits" Value="Active" Selected="False"></asp:ListItem>
                        <asp:ListItem Text="Closed permits" Value="Closed" Selected="False"></asp:ListItem>
                        <asp:ListItem Text="Cancelled permits" Value="Cancelled" Selected="False"></asp:ListItem>
                        <asp:ListItem Text="Expired" Value="Expired" Selected="False"></asp:ListItem>
                </asp:DropDownList>
           </div>
           <div class="DDLbox2">
               Service Providers
               <br />
               <asp:DropDownList CssClass="DDLStyle" ID="ProviderFilterList" AppendDataBoundItems="true" runat="server" 
                    AutoPostBack="true" DataSourceID="SPlistDataSource" DataTextField="Name" DataValueField="ServiceProviderID">
                    <asp:ListItem Text="All Service Providers" Value="%" Selected="True"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="SPlistDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ROW_PermitsConnectionString %>" 
                SelectCommand="SELECT ServiceProviderID, Name FROM ROW.All_Service_Provider_Names">
                </asp:SqlDataSource>
           </div>
           <div class="DDLbox3">
               Contractors
               <br />
               <asp:DropDownList CssClass="DDLStyle" ID="ContractorFilterList" AppendDataBoundItems="true" runat="server" 
                    AutoPostBack="true" DataSourceID="contractorDataSource" DataTextField="Company" DataValueField="ContractorID">
                    <asp:ListItem Text="All Contractors" Value="%" Selected="True"></asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="contractorDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ROW_PermitsConnectionString %>" 
                    SelectCommand="SELECT ContractorID, Company FROM ROW.All_Contractor_Names">
                </asp:SqlDataSource>
           </div>
<br />
            <label>Search by</label>
                <asp:DropDownList ID="searchList" runat="server" AutoPostBack="true">
                    <asp:ListItem Value="[PermitID]">Permit ID</asp:ListItem>
                    <asp:ListItem Value="[Project]">Project</asp:ListItem>
                    <asp:ListItem Value="[Start_Address]">Street</asp:ListItem>
                    <asp:ListItem Value="[Name]">Service Provider</asp:ListItem>
                    <asp:ListItem Value="[Company]">Contractor</asp:ListItem>
                </asp:DropDownList> =

            <asp:TextBox ID="searchBox" runat="server"></asp:TextBox>
        </div>

        <div class="PermitTableContainer-Admin">
<!--- PERMIT DATA SOURCE --->
            
        <asp:SqlDataSource ID="permitDBsource" runat="server" ConnectionString="<%$ ConnectionStrings:ROW_PermitsConnectionString %>" 
            SelectCommand="SELECT ID, Start_Address, End_Address, Remarks, InROW, InEsmt, Project, Date_Start, 
                Date_End, Status, TrafficManagementPlan, Name, Company, Review, Date_Submit, Purpose,
                ServiceProviderID, ContractorID, CAST(ID AS varchar(500)) AS PermitID, 
                CAST(ServiceProviderID AS varchar(500)) AS ServiceProviderID, AfterDate,
                CAST(ContractorID AS varchar(500)) AS ContractorID 
                FROM ROW.All_Permits 
                WHERE (Status LIKE @Status + '%') AND (ServiceProviderID LIKE @ServiceProviderID) AND 
                (ContractorID LIKE @ContractorID)
                ORDER BY ID DESC"
            FilterExpression="{0} LIKE '%{1}%'">


            <FilterParameters>
                <asp:ControlParameter ControlID="searchList" Name="SearchCategory" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="searchBox" Name="Company" PropertyName="Text" />
                <asp:ControlParameter ControlID="ProviderFilterList" Name="ServiceProviderID" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ContractorFilterList" Name="ContractorID" PropertyName="SelectedValue" />
            </FilterParameters>

            <SelectParameters>
                <asp:ControlParameter ControlID="searchBox" DefaultValue="%" Name="ID" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="statusFilter" DefaultValue="%" Name="Status" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="searchBox" DefaultValue="%" Name="Project" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="searchBox" DefaultValue="%" Name="Start_Address" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="searchList" DefaultValue="%" Name="Company" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="searchBox" DefaultValue="%" Name="Name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="ContractorFilterList" DefaultValue="%" Name="ContractorID" PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="ProviderFilterList" DefaultValue="%" Name="ServiceProviderID" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>

        </asp:SqlDataSource>
<!--- GRIDVIEW --->
        <div id="GridBox_Admin">
        <asp:GridView ID="permitList" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="permitDBsource" BorderWidth="0px" PageSize="25">
         
            <Columns>         
                <asp:TemplateField HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                    <HeaderTemplate>
                        <div class="TableField" style="border:0px;margin-left:2px;height:20px;"></div>
                        <div class="LinkButton" style="background:#535353;color:white;height:25px;margin-bottom:0px;margin-top:0px;position:fixed;z-index:9999;overflow:hidden">
                        <div class="TableField" style="width:60px;">Permit #</div>
                        <div class="TableField"  style="width:75px;">Status</div>
                        <div class="TableField"  style="width:150px;">Address</div>
                        <div class="TableField"  style="width:230px;">Permit Notes</div>
                        <div class="TableField"  style="width:145px;">Service Provider</div>
                        <div class="TableField"  style="width:145px;">Contractor</div>
                        </div>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <%--<a class="LinkButton AdminDate<%# Eval("AfterDate") %>" id="editPermLK" href="javascript:openPermit('Details.aspx?ID=<%# Eval("ID") %>',765,800);">--%>
                        <a class="LinkButton AdminDate<%# Eval("AfterDate") %>" id="editPermLK" target="_blank" href="Details.aspx?ID=<%# Eval("ID") %>">
                        <div class="TableField" style="width:60px;font-weight:bold;"><%# Eval("ID") %></div>
                        <div class="TableField"  style="width:75px;"><%# Eval("Status") %></div>
                        <div class="TableField"  style="width:150px;text-align:left;"><%# Eval("Start_Address") %></div>
                        <div class="TableField"  style="width:230px;text-align:left;"><%# Eval("Remarks") %></div>
                        <div class="TableField"  style="width:145px;text-align:left;"><%# Eval("Name") %></div>
                        <div class="TableField"  style="width:145px;text-align:left;"><%# Eval("Company") %></div>
                        </a>
                        <%--<a class="TabbBTN" id="inspectLK" href="pickupForm.aspx?ID=<%# Eval("ID") %>" onclick="window.open(this.href,'child','height=300, width=375, scrollbars=1'); return false">Pick Up</a>--%>
                        <a class="TabbBTN" id="inspectLK" href="pickupForm.aspx?ID=<%# Eval("ID") %>">Pick Up</a>
                        <a class="TabbBTN" href="MapModule.aspx?ID=<%# Eval("ID") %>" onclick="window.open(this.href,'child','height=750, width=600, scrollbars'); return false">Map</a>
                        <asp:LinkButton BackColor="#990000" CssClass="TabbBTN" ID="closeButton" runat="server" CommandArgument= '<%# Eval("ID") %>' OnCommand="closeButton_Command" OnClientClick="return confirm ('Are you certain you want to cancel this permit?');" >Cancel</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        </div>
            <br />
        </div>
        
    </form>
</body>
</html>
