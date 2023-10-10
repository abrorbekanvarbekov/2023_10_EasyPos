<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Home"/>

<%@include file="../common/head.jsp" %>

<div class="floors">
    <a href="/?floor=1" class="hover:bg-blue-400 ${param.floor == 1 ? "bg-blue-400" : ""}">1층</a>
    <a href="/?floor=2" class="hover:bg-blue-400 ${param.floor == 2 ? "bg-blue-400" : ""}">2층</a>
    <a href="/?floor=3" class="hover:bg-blue-400 ${param.floor == 3 ? "bg-blue-400" : ""}">3층</a>
</div>
<div class="container-">
    <div>
        <c:forEach var="table" items="${tables}">
            <a href="usr/tables/detail?tabId=${table.number}" class="tables" id="${table.id}" draggable="true"
               style="width: ${table.width}; height: ${table.height}; top: ${table.top}; left: ${table.left}">
                <span>${table.number}번</span>
            </a>
        </c:forEach>
    </div>
</div>
<%@include file="../common/foot.jsp" %>
