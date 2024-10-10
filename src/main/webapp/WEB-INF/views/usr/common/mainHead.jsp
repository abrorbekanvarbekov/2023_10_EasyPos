<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="head.jsp" %>
<%--<script src="/resource/home.js" defer="defer"></script>--%>
<div class="header">
    <a class="px-3 flex items-center cursor-default">
        <span class="text-red-500">Easy</span>
        <span>Pos</span>
    </a>
    <ul class="header-box">
        <li class="btn-last-receipt">
            <a class="">
                <span class="material-symbols-outlined text-3xl">print</span>
                <div><span class="material-symbols-outlined ">undo</span></div>
                <span>직전 영수증</span>
            </a>
        </li>
        <li class="btn-menu-on-off">
            <a class="">
                <span class="material-symbols-outlined text-2xl">format_align_right</span>
                <span>메뉴 ON/OFF</span>
            </a>
        </li>
        <li class="btn-many-exchange">
            <a href="">
                <span class="material-symbols-outlined text-2xl">currency_exchange</span>
                <span>환전</span>
            </a>
        </li>
        <li class="">
            <a href="">
                <span class="material-symbols-outlined text-2xl">calendar_month</span>
                <span>예약현황</span>
            </a>
        </li>
        <li class="btn-go-wallpapers">
            <a href="/usr/common/messagePage">
                <span class="material-symbols-outlined text-2xl">desktop_windows</span>
                <span>바탕화면</span>
            </a>
        </li>
        <li class="btn-total-sales">
            <a href="/usr/main/salesSummary">
                <span class="material-symbols-outlined text-2xl">currency_exchange</span>
                <span>총매출</span>
            </a>
        </li>
        <li class="btn-close">
            <a href="/usr/home-main/homeMainPage">
                <span class="material-symbols-outlined text-3xl">close</span>
            </a>
        </li>
    </ul>
</div>
<script>
    //  ============ Home smg box ============== //
    $(".btn-last-receipt").click(function () {
        $(".msg-tag").html("인쇄 내용이 존재하지 않습니다.")
        setTimeout(function () {
            $(".msg-tag").html("")
        }, 5000)
    })
</script>