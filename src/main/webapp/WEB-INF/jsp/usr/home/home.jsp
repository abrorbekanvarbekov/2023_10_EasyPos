<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Home"/>
<%@include file="../common/head.jsp" %>

<div class="floors">
    <a href="/?floor=1" class="hover:bg-blue-400 ${param.floor == 1 ? "bg-blue-400" : ""}">1층</a>
    <a href="/?floor=2" class="hover:bg-blue-400 ${param.floor == 2 ? "bg-blue-400" : ""}">2층</a>
    <a href="/?floor=3" class="hover:bg-blue-400 ${param.floor == 3 ? "bg-blue-400" : ""}">3층</a>
</div>
<div class="container- homeRightFeed">
    <div>
        <c:forEach var="table" items="${tables}">
            <a href="usr/tables/detail?tabId=${table.number}&floor=${param.floor}"
               class="tables text-sm" id="${table.id}"
               draggable="true"
               style="width: ${table.width}; height: ${table.height}; top: ${table.top}; left: ${table.left}">
                <div class="flex flex-col h-full w-full items-center mt-2 overflow-hidden">
                    <span class="${cartItems != null ? "text-red-400" : ""}">${table.number}번</span>
                    <c:forEach var="priceSum" items="${priceSumList}">
                        <c:if test="${priceSum.table_id == table.number}">
                            <span class="text-blue-400">${priceSum.priceSum}</span>
                        </c:if>
                    </c:forEach>
                    <c:forEach var="cartItem" items="${cartItems}">
                        <c:if test="${cartItem.table_id==table.number}">
                            <div>
                                <span class="pr-2">${cartItem.name}</span>
                                <span>${cartItem.quantity}</span>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </a>
        </c:forEach>
    </div>
</div>
<div class="homeLeftFeed">
    <div class="miniWindow"></div>
    <div class="clock">
        <span id="hours" class="large_text"></span>
        <span class="colon">:</span>
        <span id="minute" class="large_text"></span>
    </div>
    <div class="tableFunctions">
        <div class="order" >
            <span>주문</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
        <div class="division"  >
            <span>분할</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
        <div class="movement" >
            <span>이동</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
        <div class="group" >
            <span>그룹</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
        <div class="summary" >
            <span>요약</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
    </div>
    <div class="productInfo">
        <div>주문정보</div>
        <div>
            <span>주문테이블수</span>
            <span>0</span>
        </div>
        <div>
            <span>전체고객수</span>
            <span>0</span>
        </div>
        <div>
            <span>담당자</span>
            <span>아브로르</span>
        </div>
        <div>
            <span>식사미제공</span>
            <span>0</span>
        </div>
    </div>
</div>
<script>
    function watchClock() {
        const hours = $("#hours")
        const minutes = $("#minute")
        const present = new Date();
        let hour = present.getHours();
        let minute = present.getMinutes();
        if (hour < 10){
            hour = "0" + hour
        }
        if(minute < 10){
            minute = "0" + minute
        }
        hours.html(hour)
        minutes.html(minute)
    }

    watchClock();
    const clockInterval = setInterval(watchClock, 1000);
    // #######################################################

    let prevSelectedFunc = document.querySelector(".order");
    prevSelectedFunc.style.backgroundColor = "#50bcdf"
    document.querySelectorAll(".tableFunctions div").forEach((element) =>{
        element.addEventListener("click", function (){
            prevSelectedFunc.style.backgroundColor = "inherit"
            prevSelectedFunc = element
            element.style.backgroundColor = "#50bcdf";
        })
    })

</script>
<%@include file="../common/foot.jsp" %>
