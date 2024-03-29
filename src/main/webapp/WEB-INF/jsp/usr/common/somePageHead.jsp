<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="head.jsp" %>
<script src="/resource/pay.js" defer="defer"></script>
<c:set var="scriptRoute" value="/resource/pay.js"/>
<div class="header-detail">
    <a class="px-3 flex items-center justify-center cursor-default">
        <span class="text-red-500">Easy</span>
        <span>Pos</span>
        <span>&nbsp; &#183; &nbsp;</span>
        <span class="text-xl">${pageName}</span>
    </a>
    <ul class="header-box-detail">
        <li>
            <a>
                <c:if test="${pageName == '메인메뉴' }">
                    <span class="material-symbols-outlined text-4xl"
                          onclick="doWindowClose();">power_settings_new</span>
                </c:if>
                <c:if test="${pageName != '메인메뉴'}">
                    <span class="material-symbols-outlined text-5xl" onclick="history.back();">close</span>
                </c:if>
            </a>
        </li>
    </ul>
</div>

<script>
    function doWindowClose() {
        location.replace("https://www.google.com/")
    }
</script>