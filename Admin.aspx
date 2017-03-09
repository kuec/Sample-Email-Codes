<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="ROW_DB.ROW.WebForm1" %>

<!DOCTYPE html>
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<html>
<head runat="server">
    <title>Admin Page</title>

    <link href="../style/ROW/TestStyle2.css" rel="stylesheet" />
    <%--<link href="../style/ROW/MenuUI.css" rel="stylesheet" />--%>
    <script src="../scripts/jquery-2.1.4.js"></script>
    <script src="../scripts/activatables.js" type="text/javascript"></script>

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

        //HIGHLIGHT ACTIVE PAGE LINK FEATURE

        function offclass(id)

        { document.getElementById(id).className = 'class_off'; }

        function onclass(id)

        { document.getElementById(id).className = 'class_on'; }



</script>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />



</head>
<body>
    <form id="form1" runat="server">
<%-- MAIN BODY WRAPPER --%>
        <div class="mainContainer-Admin">
<%--HEADER--%>
        <div class="HeaderDiv">
            <div class="HeaderTop">
                <%--<div class="IconButtonBox">
                    <a class="SmallButton" style="background-image:url('../images/Options.png')" href="Select.html"></a>
                </div>--%>
                <div class="IconButtonBox">
                    <%--<a class="SmallButton" style="background-image:url('../images/Options.png')" href="Select.html"></a>--%>
                    <a href="Select.html"><img src='../images/Options.png' style="border: none;" /></a>
                </div>
                <div class="TitlePageBox-Admin">
                    <div class="TitlePage-Admin">ADMIN PAGE</div>
                </div>
                <div class="searcharea">
                    <div class="SearchBox">
                        Search:
                        <input class="SearchField" type="text" id="txt_Smart" />
                        <div id="SearchResults" class="searchResults"></div>
                    </div>
                </div>
                <div class="clear"></div>
            </div>
            <div class="HeaderNav">
                <a id="link1" class="class_off" href="PermitsTable.aspx" target="TableFrame" onclick="onclass('link1'); offclass('link2'); offclass('link3');offclass('link4');">ADMIN</a>
                <a id="link2" class="class_off" href="PermitsTable2.aspx" target="TableFrame" onclick="onclass('link2'); offclass('link1'); offclass('link3');offclass('link4');">ENGINEER</a>
                <a id="link3" class="class_off" href="PermitsTable3.aspx" target="TableFrame" onclick="onclass('link3'); offclass('link1'); offclass('link2');offclass('link4');">INSPECTOR</a>
                <a id="link4" class="class_off" href="PermitsTable4.aspx" target="TableFrame" onclick="onclass('link4'); offclass('link1'); offclass('link2');offclass('link3')">TCP</a>
                <a class="class_off" href="PermitMap.aspx" target="_blank">MAP</a>
                <%--<ul id="viewLinks">
                    <li><a id="Link1" href="PermitsTable.aspx" target="TableFrame">ADMIN</a></li>
                    <li><a id="Link2" href="PermitsTable2.aspx" target="TableFrame">ENGINEER</a></li>
                    <li><a id="Link3" href="PermitsTable3.aspx" target="TableFrame">INSPECTOR</a></li>
                    
                </ul>--%>
            </div>
        </div>
<%--BODY--%>
    <div class="MainBody-Admin">
        <div class="MainBodyLeft-Admin">
            <ul id="FormLinks">
               <li><a href="AddPermit.aspx" target="_blank">START ROW PERMIT</a></li>
                <li><a href="AddTCP_Form.aspx" target="_blank">ADD TCP FORM</a></li>
               <li><a href="AddContractor.aspx" target="_blank">ADD CONTRACTOR</a></li>
                <%--<li><a href="AddSP.aspx" target="TableFrame">ADD SERVICE PROVIDER</a></li>--%>
            </ul>
        </div>
        <div class="MainBodyRight">
            <%--<div class="BodyRightNav">
                <ul id="RecordLinks">
                <li><a href="PermitsTable.aspx" target="TableFrame">Permits</a></li>
                <li><a  href="SP_Table.aspx" target="TableFrame">Service Providers</a></li>
                <li><a href="contractor_Table.aspx" target="TableFrame">Contractors</a></li>
                </ul>
            </div>--%>
            <div class="clear"></div>
            <div class="TableWrapper-Admin">
                <iframe id="TableFrame" src="PermitsTable.aspx" name="TableFrame" scrolling="yes"></iframe>
            </div>
        </div>
        <div class="clear"></div>
    </div>
    
<%--FOOTER--%>
    <div>

    </div>
        <asp:Button runat="server" />
    </div>
    </form>
</body>
</html>
