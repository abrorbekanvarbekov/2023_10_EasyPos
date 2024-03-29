<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../common/head.jsp" %>
<c:set var="pageName" value="개점처리"/>
<%@include file="../common/somePageHead.jsp" %>
<c:set var="pageTitle" value="employeeListPage"/>
<section class="employeePage">
    <div class="employeePage-top-part">
        <div class="top-part-left">
            <ul>
                <li>
                    <span>영업일자</span>
                    <span>
                        <input type="date" class="business-date" date-value="${todayDate}" onchange="changeDate();"
                               value="${todayDate}">
                    </span>
                </li>
                <li>
                    <span>시스템일자</span>
                    <span><input type="date" value="${todayDate}"></span>
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
    <div class="messagePage-msg-box">
        <div class="layer-bg"></div>
        <div class="layer">
            <div class="confirm-message"></div>
            <button id="check-btn" value="true" class="btn btn-active btn-info  mt-2 confirm-button">확인</button>
            <button id="cancel-btn" value="false" class="btn btn-active btn-ghost mt-2 cancel-button">취소</button>
        </div>
    </div>
</section>

<script>

    function showConfirmDialog(message) {
        return new Promise((resolve, reject) => {
            let confirmMessage = document.querySelector(".confirm-message");
            let confirmButton = document.querySelector(".confirm-button");
            let cancelButton = document.querySelector(".cancel-button");

            confirmMessage.textContent = message;

            confirmButton.onclick = function () {
                closeMsgBox();
                resolve("true");
            };

            cancelButton.onclick = function () {
                closeMsgBox();
                reject("false");
            };

            openMsgBox();
        });
    }

    function openMsgBox() {
        $('.layer-bg').show();
        $('.layer').show();
    }

    function closeMsgBox() {
        $('.layer').hide();
        $('.layer-bg').hide();
    }


    document.querySelectorAll(".employeeList-box li").forEach((element) => {

        if (element.id != "") {
            element.addEventListener("click", (event) => {
                let employeeCode = document.querySelector(".employeeCode")
                employeeCode.value = element.id;
                let employeeName = document.querySelector(".employeeName")
                employeeName.value = element.dataset.value
                let employeePw = document.querySelector(".employeePw")
                employeePw.type = "password"
                employeePw.focus();
                // ==================================       //
                $("#open-btn").click(() => {
                    let businessDate = document.querySelector(".business-date").value
                    $.ajax({
                        url: "/usr/home-main/getDeadlineSettlement",
                        data: {openingDate: businessDate},
                        method: "GET",
                        success: async function (data) {
                            let result = await showConfirmDialog("이미 마감정산 된 날짜 입니다. 장사를 이어서 하시겠습니까?");
                            if (result == "true") {
                                $.get("/usr/member/doLoginEmployee", {
                                    employeeCode: employeeCode.value,
                                    employeePw: employeePw.value,
                                    openingDate: businessDate
                                }, function (data) {
                                    if (data.success == true) {
                                        location.replace(data.msg)
                                    } else if (data.success == false) {
                                        $(".openStore-msg-box > .msg-tag").html(data.msg)
                                    }
                                }, "json")
                            }
                        },
                        error: function (request, status, error) {
                            $.get("/usr/member/doLoginEmployee", {
                                employeeCode: employeeCode.value,
                                employeePw: employeePw.value,
                                openingDate: businessDate
                            }, function (data) {
                                if (data.success == true) {
                                    location.replace(data.msg)
                                } else if (data.success == false) {
                                    $(".openStore-msg-box > .msg-tag").html(data.msg)
                                }
                            }, "json")
                        },
                        complete: function () {
                        }
                    })
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

    function changeDate() {
        let employeeCode = document.querySelector(".employeeCode")
        let employeeName = document.querySelector(".employeeName")
        employeeCode.value = "";
        employeeName.value = "";
    }

    function clearEmployeePw() {
        let employeePw = document.querySelector(".employeePw")
        employeePw.value = "";
    }
</script>

<%@include file="../common/footer.jsp" %>