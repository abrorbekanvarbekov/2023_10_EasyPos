<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../common/head.jsp" %>
<c:set var="pageName" value="개점처리"/>
<%@include file="../common/PayCashTotalSalesHead.jsp" %>
<c:set var="pageTitle" value="employeeListPage"/>

<section class="employeePage">
    <div class="employeePage-top-part">
        <div class="top-part-left">
            <ul>
                <li>
                    <span>영업일자</span>
                    <span>
                        <span class="business-date">${todayDate}</span>
                        <span class="material-symbols-outlined" id="calendar_month">calendar_month</span>
                    </span>
                </li>
                <li>
                    <span>시스템일자</span>
                    <span>${todayDate}</span>
                </li>
                <li>
                    <span>사원코드</span>
                    <span><input class="employeeCode" type="button"></span>
                </li>
                <li>
                    <span>사원명</span>
                    <span><input class="employeeName" type="button"></span>
                </li>
                <li>
                    <span>비밀번호</span>
                    <span><input class="employeePw" type="button"></span>
                </li>
                <li>
                    <span>준비금</span>
                    <span></span>
                </li>
            </ul>
            <div>
                <button class="btn  btn-info" id="open-btn">개점</button>
                <button class="btn btn-outline btn-info">환전</button>
            </div>
        </div>
        <div class="top-part-right">
            <div class="flex flex-row w-full h-4/1">
                <span class="material-symbols-outlined pr-2 text-8xl text-blue-400">swipe_right_alt</span>
                <h1>사원리스트</h1>
            </div>
            <ul class="employeeList-box">
                <c:forEach var="employee" items="${employeeList}" varStatus="employeeIdx">
                    <li id="${employee.employeeCode}" data-value="${employee.name}">
                        <button class="">${employee.name}</button>
                    </li>
                </c:forEach>
                <c:forEach begin="${employeeList.size() + 1}" end="${12}" varStatus="status">
                    <li id="" data-value="">
                        <button class=""></button>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="employeePage-bottom-part">
        <div>
            <ul>
                <li class="bg-blue-400">123</li>
                <li class="bg-blue-400" id="clearEmployeePw" onclick="clearEmployeePw()">Clear</li>
                <li class="bg-blue-400">abc</li>
                <li class="bg-blue-400">ABC</li>
                <c:forEach begin="1" end="9" varStatus="status">
                    <li>${status.index <= 9 ? status.index : ''}</li>
                </c:forEach>
                <li>0</li>
                <li>00</li>
                <li>000</li>
                <c:forEach begin="1" end="16" varStatus="status">
                    <li></li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div class="openStore-msg-box home-msg-box">
        <span class="material-symbols-outlined">volume_up</span>
        <span class="msg-tag text-red-600"></span>
    </div>
</section>

<script>
    document.querySelectorAll(".employeeList-box li").forEach((element) => {

        if (element.id != "") {
            element.addEventListener("click", (event) => {
                let businessDate = document.querySelector(".business-date").innerHTML
                let employeeCode = document.querySelector(".employeeCode")
                employeeCode.value = element.id;
                let employeeName = document.querySelector(".employeeName")
                employeeName.value = element.dataset.value
                let employeePw = document.querySelector(".employeePw")
                employeePw.type = "password"
                employeePw.focus();

                //     ==================================       //
                $("#open-btn").click(() => {
                    $.get("/usr/member/getEmployee", {
                        businessDate: businessDate,
                        employeeCode: employeeCode.value,
                        employeePw: employeePw.value
                    }, function (data) {

                        if (data.resultCode === "S-1") {
                            location.replace(data.msg)
                        } else {
                            $(".openStore-msg-box > .msg-tag").html(data.msg)
                        }

                    }, "json")
                })

                // =============================================================================== //

                document.querySelectorAll(".employeePage-bottom-part > div > ul li:not(:nth-child(-n + 4))").forEach((element) => {
                    element.addEventListener("click", (e) => {
                        employeePw.value += element.innerText
                    })
                })

            })
        }
    })

    function clearEmployeePw() {
        let employeePw = document.querySelector(".employeePw")
        employeePw.value = "";
    }
</script>

<%@include file="../common/footer.jsp" %>