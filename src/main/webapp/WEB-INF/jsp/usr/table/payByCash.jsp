<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="현금영수증처리"/>
<c:set var="pageName" value="현금영수증처리"/>

<%@include file="../common/PayCashTotalSalesHead.jsp" %>
<div class="payByCash">
    <div class="byCashLeftPage">
        <div>
            <div>분류선택</div>
            <div>
                <span class="bg-blue-400">소득공제용</span>
                <span class="bg-gray-300 ">지출증방용</span>
            </div>
        </div>
        <div>
            <div>
                <span class="pl-16 py-8">식별번호</span>
                <input class="w-3/4 h-11 ml-16 mt-52 authorizedNumber" type="text">
                <span class="btn w-3/4 h-11 ml-16 bg-blue-400 btn-info my-8">인식번호입력</span>
            </div>
            <div class="calc-box">
                <div class="flex justify-between">
                    <span class="btn w-3/5 text-xm" onclick="clearInput();">Clear</span>
                    <span class="material-symbols-outlined btn flex items-center"
                          onclick="arrow_back();">arrow_back</span>
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
        </div>
    </div>
    <div class="byCashRightPage">
        <div class="payPriceFeed">
            <span>승인금액</span>
            <span>${splitAmount.length() != 0 ? splitAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",") : amountToBeReceivedCash.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
        </div>
        <hr>
        <div>
            <button class="bg-blue-400 authorizedPayment">승인/자진발급</button>
            <button class="unauthorizedPayment">승인하지 말고 결제</button>
        </div>
    </div>
</div>
<div class="messagePage-msg-box">
    <div class="layer-bg"></div>
    <div class="layer">
        <div class="confirm-message"></div>
        <button id="check-btn" value="true" class="btn btn-active btn-info  mt-2 confirm-button">
            <span>예</span>
        </button>
        <button id="cancel-btn" value="false" class="btn btn-active btn-ghost mt-2 cancel-button">
            <span>아니요</span>
        </button>
    </div>
</div>
<script>

    <%--    =========== MSG box open close functions ===============--%>

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

    async function exampleFunction() {
        try {
            const result = await showConfirmDialog("영수증을 발행하시겠습니까?");
            return result;
        } catch (error) {
            return error;
        }
    }

    function openMsgBox() {
        $('.layer').show();
        $('.layer-bg').show();
    }

    function closeMsgBox() {
        $('.layer').hide();
        $('.layer-bg').hide();
    }

    <%--    =========== 승인 없이 현금 결제 ===============--%>
    $(".unauthorizedPayment").click(async function () {
        setTimeout(function () {
            exampleFunction().then((result) => {
                $.get("/usr/tables/orderPage/paymentCash", {
                    tabId: ${tabId},
                    floor: ${floor},
                    totalAmount: ${totalAmount},
                    splitAmount: ${splitAmount.length() != 0 ? splitAmount : 0},
                    cashTotalSailAmount: ${cashTotalSailAmount},
                    amountToBeReceivedCartS: ${amountToBeReceivedCash},
                    isPrintReceipt: result,
                }, function (data) {
                    location.replace(data.msg);
                }, "json")
            })
        }, 1300)
    })

    <%--    =========== 승인하고 현금 결제 ===============--%>
    $(".authorizedPayment").click(function () {
        let authorizedNumber = document.querySelector(".authorizedNumber")
        authorizedNumber.focus()
        if (authorizedNumber.value.length == 0 || authorizedNumber.value.length < 11){
            alert("등록번호를 입력해주세요")
        }else{
            setTimeout(function () {
                exampleFunction().then((result) => {
                    $.get("/usr/tables/orderPage/paymentCash", {
                        tabId: ${tabId},
                        floor: ${floor},
                        totalAmount: ${totalAmount},
                        splitAmount: ${splitAmount.length() != 0 ? splitAmount : 0},
                        cashTotalSailAmount: ${cashTotalSailAmount},
                        amountToBeReceivedCartS: ${amountToBeReceivedCash},
                        isPrintReceipt: result,
                        authorizedNumber: authorizedNumber.value
                    }, function (data) {
                        location.replace(data.msg);
                    }, "json")
                })
            }, 1300)
        }
    })


    <%--    =========== 계산기에 값 입력 ===============--%>
    document.querySelectorAll(".calc-box > div:not(:nth-child(1)) > span").forEach((element) => {
        element.addEventListener("click", (e) => {
            let calInput = document.querySelector(".authorizedNumber")
            calInput.value += e.target.innerText
        })
    })

    <%--    =========== 계산기 모든 값 삭제 ===============--%>

    function clearInput() {
        let calInput = document.querySelector(".authorizedNumber")
        calInput.value = "";
    }

    <%--    =========== 계산기 값을 하나씩 삭제 ===============--%>

    function arrow_back() {
        let calInput = document.querySelector(".authorizedNumber")
        let inputText = calInput.value
        let inputArray = inputText.split("")
        inputArray.pop();

        let updatedText = inputArray.join("");
        calInput.value = updatedText;
    }

</script>