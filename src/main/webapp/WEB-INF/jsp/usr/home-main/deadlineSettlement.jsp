<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageName" value="마감정산"/>
<c:set var="pageTitle" value="마감정산"/>

<%@include file="../common/somePageHead.jsp" %>
<div class="deadlineSettlement-container">
    <div class="deadlineSettlement-top">
        <span>영업일자</span>
        <span>${businessDate}</span>
        <span>개점일시</span>
        <span>${openingTime}</span>
        <span>담당자</span>
        <span>${rq.getLoginedEmployee().getName()}</span>
    </div>
    <div class="deadlineSettlement-main">
        <div class="deadline-mainLeft">
            <ul class="settlementDetails">
                <div>
                    <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
                    <span>매출요약</span>
                </div>
                <li>
                    <span>총매출액</span>
                    <span>${payedTotalAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
                </li>
                <li>
                    <span>할인금액</span>
                    <span>${payedTotalDiscountAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
                </li>
                <li>
                    <span>순매출액</span>
                    <span>${payedTotalAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
                </li>
                <li>
                    <span>부가세액</span>
                    <span>${VAT_Amount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
                </li>
                <li>
                    <span>NET매출액</span>
                    <span>${NETsaleAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
                </li>
                <li>
                    <span>봉사료액</span>
                    <span>0</span>
                </li>
                <li>
                    <span>반품금액</span>
                    <span>${amountOfReturns.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
                </li>
            </ul>
            <ul class="settlementDetails">
                <div>
                    <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
                    <span>매출내역</span>
                    <span class="material-symbols-outlined ml-2 text-blue-400 text-3xl cursor-pointer">expand_circle_right</span>
                </div>
                <li>
                    <span>현금</span>
                    <span>${payedCashSumAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
                </li>
                <li>
                    <span>신용카드</span>
                    <span>${payedCartSumAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
                </li>
                <li>
                    <span>상품권</span>
                    <span>0</span>
                </li>
                <li>
                    <span>포인트결제</span>
                    <span>0</span>
                </li>
                <li>
                    <span>캐쉬백</span>
                    <span>0</span>
                </li>
                <li>
                    <span>선불카드</span>
                    <span>0</span>
                </li>
                <li>
                    <span>기타결제</span>
                    <span>0</span>
                </li>
            </ul>
            <ul class="settlementDetails">
                <div>
                    <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
                    <span>입출금내역</span>
                    <span class="material-symbols-outlined ml-2 text-blue-400 cursor-pointer text-3xl">expand_circle_right</span>
                </div>
                <li>
                    <span>영업준비금</span>
                    <span>0</span>
                </li>
                <li>
                    <span>수시입금액</span>
                    <span>0</span>
                </li>
                <li>
                    <span>수시출금액</span>
                    <span>0</span>
                </li>
                <li>
                    <span>선불 외 현금 환불액</span>
                    <span>0</span>
                </li>
                <li>
                    <span>선불 외 현금판매</span>
                    <span>0</span>
                </li>
                <li>
                    <span>선불 외 카드판매</span>
                    <span>0</span>
                </li>
                <li>
                    <span>외상입금액</span>
                    <span>0</span>
                </li>
                <li>
                    <span>전자화패 충전금액</span>
                    <span>0</span>
                </li>
            </ul>
            <ul class="settlementDetails">
                <div>
                    <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
                    <span>할인내역</span>
                </div>
                <li>
                    <span>일반할인</span>
                    <span>0</span>
                </li>
                <li>
                    <span>고객할인</span>
                    <span>0</span>
                </li>
                <li>
                    <span>제휴할인</span>
                    <span>0</span>
                </li>
                <li>
                    <span>쿠폰할인</span>
                    <span>0</span>
                </li>
                <li>
                    <span>서비스할인</span>
                    <span>0</span>
                </li>
            </ul>
            <ul class="settlementDetails">
                <div>
                    <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
                    <span>시재내역</span>
                    <span class="material-symbols-outlined ml-2 cursor-pointer text-blue-400 text-3xl">expand_circle_right</span>
                </div>
                <li>
                    <span>현금 및 수표시재</span>
                    <span>0</span>
                </li>
                <li>
                    <span>상품권시재</span>
                    <span>0</span>
                </li>
                <li>
                    <span>쿠폰시재</span>
                    <span>0</span>
                </li>
            </ul>
            <ul class="settlementDetails">
                <div>
                    <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
                    <span>과부족</span>
                </div>
                <li>
                    <span>현금과부족</span>
                    <span>0</span>
                </li>
                <li>
                    <span>상품권과부족</span>
                    <span>0</span>
                </li>
                <li>
                    <span>쿠폰과부족</span>
                    <span>0</span>
                </li>
            </ul>
        </div>
        <div class="deadline-mainRight">
            <div class="calc-box">
                <div>
                    <span class="btn w-3/5 text-xs">Clear</span>
                    <span class="material-symbols-outlined btn flex items-center text-2xl">arrow_back</span>
                </div>
                <div>
                    <span class="btn w-auto">7</span>
                    <span class="btn w-auto">8</span>
                    <span class="btn w-auto">9</span>
                </div>
                <div>
                    <span class="btn w-auto">4</span>
                    <span class="btn w-auto">5</span>
                    <span class="btn w-auto">6</span>
                </div>
                <div>
                    <span class="btn w-auto">1</span>
                    <span class="btn w-auto">2</span>
                    <span class="btn w-auto">3</span>
                </div>
                <div>
                    <span class="btn w-auto">0</span>
                    <span class="btn w-auto">00</span>
                    <span class="btn w-auto">000</span>
                </div>
            </div>
            <hr>
            <div>
                <button class="btn btn-outline bg-blue-500 text-white" id="deadline-btn">마감</button>
                <button class="btn btn-outline text-blue-400">이전내역 재발행</button>
                <button class="btn btn-outline text-blue-400">마감 정산지 출력</button>
            </div>
        </div>
    </div>
    <div class="home-msg-box">
        <span class="material-symbols-outlined">volume_up</span>
        <span class="msg-tag"></span>
    </div>
</div>
<div class="messagePage-msg-box">
    <div class="layer-bg"></div>
    <div class="layer">
        <div class="confirm-message"></div>
        <button id="check-btn" value="true" class="btn btn-active btn-info  mt-2 confirm-button">확인</button>
        <button id="cancel-btn" value="false" class="btn btn-active btn-ghost mt-2 cancel-button">취소</button>
    </div>

    <div class="layer-bg-1"></div>
    <div class="layer-1">
        <div class="confirm-message-1"></div>
        <hr>
        <button id="check-btn-1" class="btn btn-active btn-info  mt-2 confirm-button-1">확인</button>
    </div>

    <div class="program-exit-layer-bg">
        <div class="program-exit-layer">
            <div class="program-exit-message"></div>
            <hr>
            <span class="program-exit-timer">10</span>
            <button id="program-exit-btn" class="btn btn-active btn-info  mt-2 confirm-button-1">확인</button>
        </div>
    </div>
</div>


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

    //  ============================================ //
    function showMsgBoxOnlyCheckBtn(message) {
        return new Promise((resolve, reject) => {
            let programExitMsg = document.querySelector(".program-exit-message");
            let programExitTimer = document.querySelector(".program-exit-timer");
            let confirmButton = document.querySelector("#program-exit-btn");
            let timer = 10
            programExitMsg.textContent = message;


            let interval = setInterval(function () {
                programExitTimer.textContent = timer;
                timer--;
                if (timer <= -1) {
                    closeMsgBoxOnlyCheckBtn();
                    clearInterval(interval);
                    resolve("true");
                }
            }, 1000)

            confirmButton.onclick = function () {
                closeMsgBoxOnlyCheckBtn();
                resolve("true");
            };

            openMsgBoxOnlyCheckBtn();
        });
    }

    function closeMsgBoxOnlyCheckBtn() {
        $('.program-exit-layer').hide();
        $('.program-exit-layer-bg').hide();
    }

    function openMsgBoxOnlyCheckBtn() {
        $('.program-exit-layer').show();
        $('.program-exit-layer-bg').show();
    }

    $("#deadline-btn").click(async function () {
        let result = "true";
        let outstandingTables = ${outstandingTables};
        try {
            if (outstandingTables > 0) {
                result = await showConfirmDialog("미결제된 테이블이 ${outstandingTables}건 있습니다. 그대로 마감을 진행하시겠습니까?");
            }

            if (result == "true") {
                const result2 = await showConfirmDialog("${businessDateToFormat} 영업을 마감하시겠습니까?");
                if (result2 == "true") {
                    const result3 = await showConfirmDialog("현금 시재 입력되지 않았습니다. 현금 시재를 입력하지 않은 채로 마감을 진행하시겠습니까?");
                    if (result3 == "true") {
                        $.get("/usr/home-main/setDeadlineSettlement", {
                            openingDate: '${businessDate}',
                            openEmployeeName: '${rq.getLoginedEmployee().getName()}',
                            openEmployeeCode: '${rq.getLoginedEmployee().getEmployeeCode()}',
                            closeEmployeeName: '${rq.getLoginedEmployee().getName()}',
                            closeEmployeeCode: '${rq.getLoginedEmployee().getEmployeeCode()}',
                            totalSales: ${payedTotalAmount},
                            totalSalesCount: ${payedCartCnt},
                            discountAmount: ${payedTotalDiscountAmount},
                            VAT: ${VAT_Amount},
                            NETSales: ${NETsaleAmount},
                            amountOfReturns: ${amountOfReturns},
                            paidByCash: ${payedCashSumAmount},
                            paidByCart: ${payedCartSumAmount}
                        }, async function (data) {
                            const exit = await showMsgBoxOnlyCheckBtn("프로그램 종료합니다.")
                            if (exit == "true") location.replace(data.msg);
                        }, "json")
                    }
                }
            }
        } catch (error) {
        }
    });

</script>

<%@include file="../common/footer.jsp" %>