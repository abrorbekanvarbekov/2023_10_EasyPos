<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="head.jsp"%>
<div class="header-detail">
    <a class="px-3 flex items-center justify-center cursor-default" >
        <span class="text-red-500">Easy</span>
        <span>Pos</span>
        <span>&nbsp; &#183; &nbsp;</span>
        <span class="text-xl">${pageName}</span>
    </a>
    <ul class="header-box-detail">
        <li>
            <a href="/?floor=" + ${rq.floor} >
                <span class="material-symbols-outlined text-4xl">close</span>
            </a>
        </li>
    </ul>
</div>
