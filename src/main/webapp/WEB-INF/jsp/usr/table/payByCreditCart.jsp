<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="신용카드"/>
<c:set var="pageName" value="신용카드"/>

<%@include file="../common/PayCashTotalSalesHead.jsp" %>
<div class="byCreditCartPage">
    <div class="byCreditCartLeftPage">
        <div>
            <span>카드번호</span>
            <span></span>
        </div>
        <div>
            <span>카드사</span>
            <span></span>
        </div>
        <div>
            <span>유효기간</span>
            <span>
                <p class="pr-12"></p>
                <p></p>
            </span>
        </div>
        <div>
            <span>할부개월수</span>
            <span><input class="w-20 h-10 installment" type="text"></span>
        </div>
        <div>
            <span>승인금액</span>
            <span class="text-4xl text-blue-500 "
                  id="amountPay">${splitAmount != 0 ? splitAmount : amountToBeReceivedCart}</span>
        </div>
        <div>
            <span>총금액</span>
            <span class="totalAmount">${splitAmount != 0 ? splitAmount : amountToBeReceivedCart}</span>
        </div>
        <div>
            <span>받은금액</span>
            <span class="amountReceived">${splitAmount}</span>
        </div>
        <div>
            <span>받을금액</span>
            <span class="amountToBeReceived">${amountToBeReceivedCart}</span>
        </div>
        <div></div>
        <div class="flex justify-center mt-6 w-full">
            <button class="btn btn-outline btn-success w-1/4 border">전지서명입력</button>
        </div>
    </div>
    <div class="byCreditCartRightPage">
        <div>
            <div>
                <span class="material-symbols-outlined text-5xl">memory</span>
                <span class="pl-10">RF/IC</span>
            </div>
        </div>
        <div>
            <div class="bg-yellow-200">
                <span class="pl-10">KB Ogood!</span>
            </div>
            <div class="bg-red-400">
                <span class="pl-10">KB Ogood!</span>
            </div>
        </div>
        <div>
            <div class="installmentCalc-box">
                <div class="flex">
                    <span class="btn w-3/5 text-xm" onclick="clearInput();">Clear</span>
                    <span class="material-symbols-outlined btn w-2/5 text-2xl" onclick="arrow_back();">arrow_back</span>
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

    function insertComma() {
        let amountPay = $("#amountPay").html()
        let totalAmount = $(".totalAmount").html()
        let amountReceived = $(".amountReceived").html()
        let amountToBeReceived = $(".amountToBeReceived").html()
        $("#amountPay").html(Number(amountPay).toLocaleString())
        $(".totalAmount").html(Number(totalAmount).toLocaleString())
        $(".amountReceived").html(Number(amountReceived).toLocaleString())
        $(".amountToBeReceived").html(Number(amountToBeReceived).toLocaleString())
    }

    insertComma();



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


    <%--    =========== 카드 결제 ===============--%>
    setTimeout(function () {
        document.querySelector(".byCreditCartLeftPage > div > span:last-child").innerHTML = "${CreditCartNumber}";
        document.querySelector(".byCreditCartLeftPage > div:nth-child(2) > span:last-child").innerHTML = "${CreditCartCompany}";
        document.querySelector(".byCreditCartLeftPage > div:nth-child(3) > span:last-child > p:first-child").innerHTML = "${CreditCartValidYear}년";
        document.querySelector(".byCreditCartLeftPage > div:nth-child(3) > span:last-child > p:last-child").innerHTML = "${CreditCartValidMonth}월";

        let amountPay = document.querySelector("#amountPay").textContent.replace(",", "")
        let amountToBeReceived = ${amountToBeReceivedCart};

        if (amountPay < amountToBeReceived == true) {
            setTimeout(function () {
                $.get("/usr/tables/orderPage/paymentCreditCart", {
                    tabId:${tabId},
                    floor: ${floor},
                    totalAmount: ${totalAmount},
                    splitAmount: ${splitAmount == "" ? 0 : splitAmount},
                    CreditCartNumber: ${CreditCartNumber},
                    cartTotalSailAmount: ${cartTotalSailAmount},
                    amountToBeReceivedCart: ${amountToBeReceivedCart},
                    isPrintReceipt: 'false'
                }, function (data) {
                    location.replace(data.msg);
                }, "json")
            }, 1000)
        }else{
            setTimeout(function () {
                exampleFunction().then((result) => {
                    $.get("/usr/tables/orderPage/paymentCreditCart", {
                        tabId:${tabId},
                        floor: ${floor},
                        totalAmount: ${totalAmount},
                        splitAmount: ${splitAmount == "" ? 0 : splitAmount},
                        CreditCartNumber: ${CreditCartNumber},
                        cartTotalSailAmount: ${cartTotalSailAmount},
                        amountToBeReceivedCart: ${amountToBeReceivedCart},
                        isPrintReceipt: result
                    }, function (data) {
                        location.replace(data.msg);
                    }, "json")
                })
            }, 1000)
        }
    }, 1300)


    <%--    =========== MSG box open close functions ===============--%>

    function openMsgBox() {
        $('.layer').show();
        $('.layer-bg').show();
    }

    function closeMsgBox() {
        $('.layer').hide();
        $('.layer-bg').hide();
    }

    <%--    =========== 계산기에 값 입력 ===============--%>
    document.querySelectorAll(".installmentCalc-box > div:not(:nth-child(1)) > span").forEach((element) => {
        element.addEventListener("click", (e) => {
            let calInput = document.querySelector(".installment")
            calInput.value += e.target.innerText
        })
    })

    <%--    =========== 계산기 모든 값 삭제 ===============--%>

    function clearInput() {
        let calInput = document.querySelector(".installment")
        calInput.value = "";
    }

    <%--    =========== 계산기 값을 하나씩 삭제 ===============--%>

    function arrow_back() {
        let calInput = document.querySelector(".installment")
        let inputText = calInput.value
        let inputArray = inputText.split("")
        inputArray.pop();

        let updatedText = inputArray.join("");
        calInput.value = updatedText;
    }

</script>

<%@include file="../common/footer.jsp" %>