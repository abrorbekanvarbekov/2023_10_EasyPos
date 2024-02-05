<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="homeMain"/>
<c:set var="pageName" value="메인메뉴"/>
<%@include file="../common/PayCashTotalSalesHead.jsp" %>

<section class="main-manu-container">
    <div class="mainManu-top-part">
        <div class="mainMain-topPart-left">
            <a href="/?floor=1">
                <img src="/resource/images/2020637362_B.jpg" alt="">
            </a>
        </div>
        <div class="mainMain-topPart-right">
            <div onclick="location.replace('/usr/main/salesSummary')">
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">monitoring</span>
                </div>
                <span>메출요약</span>
            </div>
            <div onclick="location.replace('/usr/home/salesHistory')">
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">quick_reference_all</span>
                </div>
                <span>판매내역조회</span>
            </div>
            <div onclick="location.replace('/usr/home/receiptReturn')">
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">article_shortcut</span>
                </div>
                <span>연수증반품</span>
            </div>
            <div>
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">contract</span>
                </div>
                <span>원격자료조회</span>
            </div>
            <div>
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">screen_search_desktop</span>
                </div>
                <span>포스자료조희</span>
            </div>
            <div>
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">calculate</span>
                </div>
                <span>마감정산</span>
            </div>
            <div>
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">system_update_alt</span>
                </div>
                <span>기초정보수신</span>
            </div>
            <div>
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">desktop_mac</span>
                </div>
                <span>영업정보관리</span>
            </div>
            <div>
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">account_balance</span>
                </div>
                <span>영업준비금</span>
            </div>
        </div>
    </div>
    <div class="main-manu-head">
        <c:forEach begin="1" end="20" varStatus="status">
            <span></span>
        </c:forEach>
    </div>
    <div class="mainManu-bottom-part">
        <c:forEach begin="1" end="12">
            <div>1</div>
        </c:forEach>
    </div>
</section>
<%@include file="../common/footer.jsp" %>