<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="homeMain"/>
<c:set var="pageName" value="메인메뉴"/>
<%@include file="../common/somePageHead.jsp" %>

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
            <div onclick="location.replace('/usr/home-main/salesHistory')">
                <div>
                    <span class="material-symbols-outlined text-white text-7xl">quick_reference_all</span>
                </div>
                <span>판매내역조회</span>
            </div>
            <div onclick="location.replace('/usr/home-main/receiptReturn')">
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
            <div onclick="location.replace('/usr/home-main/deadlineSettlement')">
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
        <div>
            <div>
                <span class="material-symbols-outlined">diversity_3</span>
            </div>
            <span>고객조회</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">search</span>
            </div>
            <span>주문내역조회</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">sync</span>
            </div>
            <span>수신입출금</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">currency_bitcoin</span>
            </div>
            <span>외상입금</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">manufacturing</span>
            </div>
            <span>환경설정</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">captive_portal</span>
            </div>
            <span>원격지원</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">transfer_within_a_station</span>
            </div>
            <span>담당자변경</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">task_alt</span>
            </div>
            <span>근태등록</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">print</span>
            </div>
            <span>간이영수증인쇄</span>
        </div>
        <div>
           <div>
               <span class="material-symbols-outlined">redeem</span>
           </div>
            <span>상품권판매</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">add_circle</span>
            </div>
            <span>부가기능</span>
        </div>
        <div>
            <div>
                <span class="material-symbols-outlined">music_note</span>
            </div>
            <span>매장음악설치</span>
        </div>
    </div>
</section>
<%@include file="../common/footer.jsp" %>