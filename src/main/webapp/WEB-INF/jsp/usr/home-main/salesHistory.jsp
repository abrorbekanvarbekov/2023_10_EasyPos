<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="homeMain"/>
<c:set var="pageName" value="판매내역조회"/>
<%@include file="../common/somePageHead.jsp" %>

<section class="sales-history-page">
    <div class="sales-history-top-part">
        <div>
            <span>조회일자</span>
            <input type="date" class="beginDate">
            <span class="text-2xl  text-center w-8">~</span>
            <input type="date" class="endDate">
            <span>포스</span>
            <input type="text" value="01" class="floorId">
            <span>테이블그룹</span>
            <select name="" id="123">
                <option value="">천제</option>
                <option value="">1층</option>
                <option value="">2층</option>
                <option value="">3층</option>
            </select>
        </div>
        <div>
            <span>영수증번호</span>
            <input type="number">
            <span>바코드/상품코드</span>
            <input type="number">
            <span>테이블</span>
            <select name="" id="1234">
                <option value="">천제</option>
                <option value="">1층</option>
                <option value="">2층</option>
                <option value="">3층</option>
            </select>
        </div>
        <div>
            <span></span>
            <span>결제/할인 수단</span>
            <select name="" id="12345">
                <option value="">천제</option>
                <option value="">1층</option>
                <option value="">2층</option>
                <option value="">3층</option>
            </select>
        </div>
        <div>
            <div>
                <button class="btn btn-outline">고객포인트</button>
                <button class="btn btn-outline">국세청 현금연수증</button>
            </div>
            <div>
                <button class="btn btn-outline w-28" id="lookUp">조회</button>
                <button class="btn btn-outline w-28">결제변경</button>
                <button class="btn btn-outline w-28" id="printReceipt">인쇄</button>
            </div>
        </div>
    </div>
    <div class="sales-history-bottom-part">
        <div class="sales-history-list">
            <ul class="sales-history-list-head">
                <li>NO</li>
                <li>영업일자</li>
                <li>영수증번호</li>
                <li>POS</li>
                <li>판매금액</li>
                <li>판매시간</li>
                <li>테이블</li>
                <li>현금매출</li>
                <li>카드매출</li>
            </ul>
            <ul class="sales-history-list-body">
                <c:forEach var="paymentCartAndCash" items="${paymentCartAndCashList}" varStatus="status">
                    <c:set var="date" value="${rq.businessDate.split(' ')}"/>
                    <c:set var="time" value="${paymentCartAndCash.regDate.split(' ')}"/>
                    <li class="list-item ${paymentCartAndCash.isReturn == 1? "text-red-400" : ""} ${paymentCartAndCash.isReturn == 2? "text-blue-400" : ""}"
                        data-value="${paymentCartAndCash.cart_id}"
                        id="itemId_${status.index + 1}" isreturn="${paymentCartAndCash.isReturn}">
                        <span>${status.index + 1}</span>
                        <span>${date[0].replaceAll("-", "")}</span>
                        <span>00000${status.index + 1}</span>
                        <span data-value="${paymentCartAndCash.floor}">0${paymentCartAndCash.floor}</span>
                        <span data-value="${paymentCartAndCash.cartAmountPaid + paymentCartAndCash.cashAmountPaid}">
                                ${paymentCartAndCash.totalAmount - paymentCartAndCash.discountAmount}
                        </span>
                        <span>${time[1]}</span>
                        <span>${paymentCartAndCash.tabId}</span>
                        <span data-value="${paymentCartAndCash.sumCashAmountPaid}">${paymentCartAndCash.sumCashAmountPaid}</span>
                        <span data-value="${paymentCartAndCash.sumCartAmountPaid}">${paymentCartAndCash.sumCartAmountPaid}</span>
                    </li>
                </c:forEach>
                <c:if test="${paymentCartAndCashList.size() <= 24}">
                    <c:forEach begin="${paymentCartAndCashList.size() + 1}" end="12" varStatus="asd">
                        <li>
                            <c:forEach begin="1" end="9" varStatus="dsa">
                                <span class="${asd.index == asd.index ? dsa.index : ''}">${dsa.index == 1 ? asd.index : ''}</span>
                            </c:forEach>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
            <div class="extend-buttons-box">
                <button onclick="moveUp();"><span class="material-symbols-outlined text-4xl">expand_less</span>
                </button>
                <button class="" onclick="moveArrowUp();"><span
                        class="material-symbols-outlined text-4xl">keyboard_double_arrow_up</span></button>
                <button onclick="moveDown();"><span class="material-symbols-outlined text-4xl">expand_more</span>
                </button>
                <button onclick="moveArrowDown();"><span class="material-symbols-outlined text-4xl">keyboard_double_arrow_down</span>
                </button>
            </div>
        </div>
        <div class="sales-history-receipt">
            <c:if test="${paymentCartAndCashList.size() != 0}">
                <span>[ 재발행 정상 ]</span>
                <span>(주) 이프유원트모모의기묘한모험 838-85-00722 TEL: 02)2038-3182 아브로르 서울특별시 용산구 이대원로 273길 51, (이태원동)</span>
                <br>
                <span class="receipt-table-floor"></span>
                <span class="receipt-date-POS-BILL"></span>
                <div class="receipt-head-bar">
                    <span>메뉴</span> <span>단가</span> <span>수량</span> <span>금액</span>
                </div>
                <div class="receipt-body-bar">

                </div>
                <div class="receipt-footer-bar">
                    <span class="whitespace">부가세 과세 물품가액 :       54,000원</span>
                    <span class="whitespace">부          가         세 :       5,400원</span>
                    <br>
                    <span class="whitespace">합        계 :    54,000</span>
                    <span class="whitespace">받 을 금 액 :    54,000</span>
                    <span class="whitespace">받 은 금 액 :    54,000</span>
                    <br>
                    <span class="whitespace">결제수단별 결제 내역</span>
                    <div class="receipt-payment-details">
                        <span class="whitespace">01.  신용크드 :                           73,000</span>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</section>
<div class="home-msg-box sales-history-msg-box">
    <span class="material-symbols-outlined">volume_up</span>
    <span class="msg-tag w-full text-center "></span>
</div>


<script>

    function PutComma() {
        document.querySelectorAll(".list-item").forEach((el) => {
            let salePrice = el.children[4]
            let cashPrice = el.children[7]
            let cartPrice = el.children[8]
            salePrice.innerHTML = Number(salePrice.innerHTML).toLocaleString();
            cashPrice.innerHTML = Number(cashPrice.innerHTML).toLocaleString();
            cartPrice.innerHTML = Number(cartPrice.innerHTML).toLocaleString();
        })
    }

    PutComma();

    document.addEventListener('DOMContentLoaded', function () {
        let beginDateInput = document.querySelector('.beginDate');
        let endDateInput = document.querySelector('.endDate');

        let date = new Date();
        let today = new Date(date.getTime() - (date.getTimezoneOffset() * 60000)).toISOString().split('T')[0];

        beginDateInput.value = '${rq.businessDate.split(" ")[0]}';
        endDateInput.value = today;
    });

    function scrollMoveUp() {
        let listContainer = document.querySelector(".sales-history-list-body")
        let selectedItem = listContainer.querySelector(".checked")
        scrollToSelectedItem(selectedItem);
    }

    function scrollMoveDown() {
        let listContainer = document.querySelector(".sales-history-list-body")
        let selectedItem = listContainer.querySelector(".checked")
        scrollToSelectedItem(selectedItem);
    }

    function scrollToSelectedItem(selectedItem) {
        // 선택된 항목의 위치로 스크롤 이동
        selectedItem.scrollIntoView({
            behavior: 'smooth',
            block: 'nearest'
        });
    }

    function scrollToLower() {
        let listContainer = document.querySelector(".sales-history-list-body")
        listContainer.scrollTop = listContainer.scrollHeight;
    }

    let listLength = ${paymentCartAndCashList.size()};

    let liIndex = 0;
    if (listLength != 0) {
        let listItemLastItem = document.querySelector(`.sales-history-list-body li:nth-child(\${listLength})`)
        let cart_id = listItemLastItem.dataset.value
        liIndex = listItemLastItem.id.substring(listItemLastItem.id.indexOf("_") + 1)
        setReceipt(cart_id, liIndex)
    }

    function moveUp() {
        if (liIndex > 1 && liIndex != 0) {
            let beforeLi = document.getElementById("itemId_" + liIndex)
            beforeLi.style.backgroundColor = "inherit"
            beforeLi.classList.remove("checked")
            liIndex--;
            let afterLi = document.getElementById("itemId_" + liIndex)
            afterLi.style.backgroundColor = "aqua"
            afterLi.classList.add("checked")

            let cartId = afterLi.dataset.value
            let itemId = afterLi.id.substring(afterLi.id.indexOf("_") + 1)
            setReceipt(cartId, itemId);
            scrollMoveUp();
        }
    }

    function moveDown() {
        if (liIndex < listLength && liIndex != 0) {
            let beforeLi = document.getElementById("itemId_" + liIndex)
            beforeLi.style.backgroundColor = "inherit"
            beforeLi.classList.remove("checked")
            liIndex++;
            let afterLi = document.getElementById("itemId_" + liIndex)
            afterLi.style.backgroundColor = "aqua"
            afterLi.classList.add("checked")

            let cartId = afterLi.dataset.value
            let itemId = afterLi.id.substring(afterLi.id.indexOf("_") + 1)
            setReceipt(cartId, itemId);
            scrollMoveDown();
        }
    }

    function moveArrowUp() {
        if (liIndex <= 12 && liIndex != 0) {
            let beforeLi = document.getElementById("itemId_" + liIndex)
            beforeLi.style.backgroundColor = "inherit"
            beforeLi.classList.remove("checked")
            liIndex = 1
            let afterLi = document.getElementById("itemId_" + liIndex)
            afterLi.style.backgroundColor = "aqua"
            afterLi.classList.add("checked")
            let cartId = afterLi.dataset.value
            let itemId = afterLi.id.substring(afterLi.id.indexOf("_") + 1)
            setReceipt(cartId, itemId);
            scrollMoveUp();
        } else if (liIndex != 0) {
            let beforeLi = document.getElementById("itemId_" + liIndex)
            beforeLi.style.backgroundColor = "inherit"
            beforeLi.classList.remove("checked")
            liIndex -= 12
            let afterLi = document.getElementById("itemId_" + liIndex)
            afterLi.style.backgroundColor = "aqua"
            afterLi.classList.add("checked")
            let cartId = afterLi.dataset.value
            let itemId = afterLi.id.substring(afterLi.id.indexOf("_") + 1)
            setReceipt(cartId, itemId);
            scrollMoveUp();
        }
    }

    function moveArrowDown() {
        if (liIndex < 12 && liIndex != 0 && liIndex != listLength) {
            let beforeLi = document.getElementById("itemId_" + liIndex)
            beforeLi.style.backgroundColor = "inherit"
            beforeLi.classList.remove("checked")
            liIndex = parseInt(listLength - liIndex <= 12 ? listLength - liIndex : 12) + parseInt(liIndex);
            let afterLi = document.getElementById("itemId_" + liIndex)
            afterLi.style.backgroundColor = "aqua"
            afterLi.classList.add("checked")
            let cartId = afterLi.dataset.value
            let itemId = afterLi.id.substring(afterLi.id.indexOf("_") + 1)
            setReceipt(cartId, itemId);
            scrollMoveDown();
        } else if (liIndex != 0 && liIndex != listLength) {
            let beforeLi = document.getElementById("itemId_" + liIndex)
            beforeLi.style.backgroundColor = "inherit"
            beforeLi.classList.remove("checked")
            liIndex = parseInt(listLength - liIndex <= 12 ? listLength - liIndex : 12) + parseInt(liIndex);
            let afterLi = document.getElementById("itemId_" + liIndex)
            afterLi.style.backgroundColor = "aqua"
            afterLi.classList.add("checked")
            let cartId = afterLi.dataset.value
            let itemId = afterLi.id.substring(afterLi.id.indexOf("_") + 1)
            setReceipt(cartId, itemId);
            scrollMoveDown();
        }
    }

    document.querySelectorAll(".list-item").forEach((element, idx) => {
        let childIdx = ${paymentCartAndCashList.size()};
        let listItemLastItem = document.querySelector(`.sales-history-list-body li:nth-child(\${childIdx})`)
        let cart_id = listItemLastItem.dataset.value
        let itemId = listItemLastItem.id.substring(listItemLastItem.id.indexOf("_") + 1)
        scrollToLower();
        listItemLastItem.style.backgroundColor = "aqua"
        listItemLastItem.classList.add("checked")
        element.addEventListener("click", function () {
            let lastCheckedEl = document.querySelector(".checked")
            lastCheckedEl.style.backgroundColor = "inherit"
            lastCheckedEl.classList.remove("checked")

            element.style.backgroundColor = "aqua"
            element.classList.add("checked")
            cart_id = element.dataset.value
            setReceipt(cart_id, element.id.substring(element.id.indexOf("_") + 1))

            liIndex = element.id.substring(element.id.indexOf("_") + 1)
        })


    })

    function setReceipt(cart_id, itemId) {
        if (cart_id != 0 && itemId != 0) {
            $.get("/usr/home-main/getCartItemByCart_id", {
                cart_id: cart_id
            }, function (data) {
                let cartItems = data.data1;
                let receipt_body_bar_div = "";
                let receipt_footer_bar_div = "";
                let cartItemsSumPrice = 0;
                let receipt_main = "";
                let itemIsReturnValue = document.querySelector("#itemId_" + itemId).getAttribute("isreturn")

                $.each(cartItems, (idx, cartItem) => {
                    cartItemsSumPrice += cartItem.productSumPrice
                    let changeAmount = (cartItem.cashAmountPaid + cartItem.cartAmountPaid) - (cartItem.totalAmount - cartItem.discountAmount);
                    let VATAmount = parseInt(cartItemsSumPrice / 100 * 9.89)
                    let date = "${rq.businessDate.split(' ')[0]}";
                    let time = cartItem.regDate.split(" ")[1]

                    receipt_main = `
                        <span>[ 재발행 정상 ]</span>
                        <span>(주) 이프유원트모모의기묘한모험 838-85-00722 TEL: 02)2038-3182 아브로르 서울특별시 용산구 이대원로 273길 51, (이태원동)</span>
                        <br>
                        <span class="receipt-table-floor">테이블   :  [\${cartItem.floor_id}층]  \${cartItem.table_id}번</span>
                        <span class="receipt-date-POS-BILL">\${date} \${time}  POS : \${cartItem.floor_id} BILL:00000\${itemId}</span>
                        <div class="receipt-head-bar">
                            <span>메뉴</span> <span>단가</span> <span>수량</span> <span>금액</span>
                        </div>
                        <div class="receipt-body-bar"></div>
                        <div class="receipt-footer-bar">
                            <div class="receipt-payment-details"></div>
                        </div>
                    `

                    receipt_body_bar_div += `
                    <div>
                        <span>\${cartItem.productName}</span>
                        <span>\${cartItem.productPrice.toLocaleString()}</span>
                        <span>\${itemIsReturnValue == 1? -cartItem.quantity : cartItem.quantity}</span>
                        <span>\${itemIsReturnValue == 1? Number(-cartItem.productSumPrice).toLocaleString() : cartItem.productSumPrice.toLocaleString()}</span>
                    </div>
                     `

                    receipt_footer_bar_div = `
                    <span class="whitespace">부가세 과세 물품가액 :       \${cartItemsSumPrice.toLocaleString()}</span>
                    <span class="whitespace">부          가         세 :       \${VATAmount.toLocaleString()}</span>
                    <br>
                `
                    let receiptSumPricePart = ``
                    if (cartItem.cartAmountPaid != 0 && cartItem.cashAmountPaid == 0) {
                        receiptSumPricePart = `
                            <span class="whitespace">합        계 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : cartItemsSumPrice.toLocaleString()}</span>
                            <span class="whitespace">받 을 금 액 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : cartItemsSumPrice.toLocaleString()}</span>
                            <span class="whitespace">받 은 금 액 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : cartItem.cartAmountPaid.toLocaleString()}</span>
                            <span class="whitespace">\${changeAmount > 0 ? '거 스 름 돈 :   ' + changeAmount.toLocaleString() : ''}</span>
                            <br>
                            <span class="whitespace">결제수단별 결제 내역</span>
                        `
                    } else if (cartItem.cartAmountPaid == 0 && cartItem.cashAmountPaid != 0) {
                        receiptSumPricePart = `
                            <span class="whitespace">합        계 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : cartItemsSumPrice.toLocaleString()}</span>
                            <span class="whitespace">받 을 금 액 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : cartItemsSumPrice.toLocaleString()}</span>
                            <span class="whitespace">받 은 금 액 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : cartItem.cashAmountPaid.toLocaleString()}</span>
                            <span class="whitespace">\${changeAmount > 0 ? '거 스 름 돈 :    ' + changeAmount.toLocaleString() : ''}</span>
                            <br>
                            <span class="whitespace">결제수단별 결제 내역</span>
                        `
                    } else {
                        receiptSumPricePart = `
                            <span class="whitespace">합        계 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : cartItemsSumPrice.toLocaleString()}</span>
                            <span class="whitespace">받 을 금 액 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : cartItemsSumPrice.toLocaleString()}</span>
                            <span class="whitespace">받 은 금 액 :    \${itemIsReturnValue == 1? Number(-cartItemsSumPrice).toLocaleString() : (cartItem.cashAmountPaid + cartItem.cartAmountPaid).toLocaleString()}</span>
                            <span class="whitespace">\${changeAmount > 0 ? '거 스 름 돈 :    ' + changeAmount.toLocaleString() : ''}</span>
                            <br>
                            <span class="whitespace">결제수단별 결제 내역</span>
                        `
                    }

                    let receiptPaymentDetails = ``
                    if (cartItem.cartAmountPaid != 0 && cartItem.cashAmountPaid == 0) {
                        receiptPaymentDetails = `
                          <div class="receipt-payment-details">
                            <span class="whitespace">01.  신용카드 :                           \${cartItem.cartAmountPaid.toLocaleString()}</span>
                         </div>`
                    } else if (cartItem.cartAmountPaid == 0 && cartItem.cashAmountPaid != 0) {
                        receiptPaymentDetails = `
                         <div class="receipt-payment-details">
                            <span class="whitespace">02.  현금결제 :                           \${cartItem.cashAmountPaid.toLocaleString()}</span>
                         </div>`
                    } else {
                        receiptPaymentDetails = `
                         <div class="receipt-payment-details">
                            <span class="whitespace">01.  신용카드 :                           \${cartItem.cartAmountPaid.toLocaleString()}</span>
                            <span class="whitespace">02.  현금결제 :                           \${cartItem.cashAmountPaid.toLocaleString()}</span>
                         </div>`
                    }

                    receipt_footer_bar_div += receiptSumPricePart;
                    receipt_footer_bar_div += receiptPaymentDetails;

                    $(".sales-history-receipt").html(receipt_main);
                    $(".receipt-body-bar").html(receipt_body_bar_div);
                    $(".receipt-footer-bar").html(receipt_footer_bar_div);
                })

            }, "json")
        } else {
            $(".sales-history-receipt").empty();
        }
    }

    $("#lookUp").click((el) => {
        let beginDate = $(".beginDate")[0].value
        let endDate = $(".endDate")[0].value
        let floorId = $(".floorId")[0].value.replaceAll("0", "")

        $.get("/usr/home-main/getPaymentCartList", {
            beginDate: beginDate,
            endDate: endDate,
            floor: floorId
        }, function (data) {
            let paymentCartAndCashList = data.data1
            if (paymentCartAndCashList.length != 0) {

                let listContainer = document.querySelector('.sales-history-list-body')

                while (listContainer.firstChild) {
                    listContainer.removeChild(listContainer.firstChild);
                }

                $.each(paymentCartAndCashList, (idx, value) => {

                    let date = value.regDate.split(" ")[0].replaceAll("-", "")
                    let time = value.regDate.split(" ")[1]

                    let listItem = document.createElement("li");
                    if (value.isReturn == 1) {
                        listItem.classList.add("text-red-400");
                    } else if (value.isReturn == 2) {
                        listItem.classList.add("text-blue-400");
                    }

                    listItem.classList.add("list-item");
                    listItem.setAttribute("data-value", value.cart_id)
                    listItem.setAttribute("id", "itemId_" + (idx + 1))
                    listItem.setAttribute("isreturn", value.isReturn)

                    let span1 = document.createElement('span');
                    span1.textContent = idx + 1;
                    listItem.appendChild(span1);

                    let span2 = document.createElement('span');
                    span2.textContent = date;
                    listItem.appendChild(span2);

                    let span3 = document.createElement('span');
                    span3.textContent = '00000' + (idx + 1);
                    listItem.appendChild(span3);

                    let span4 = document.createElement('span');
                    span4.textContent = "0" + value.floor;
                    listItem.appendChild(span4);

                    let span5 = document.createElement('span');
                    span5.textContent = (value.sumCashAmountPaid + value.sumCartAmountPaid).toLocaleString();
                    listItem.appendChild(span5);

                    let span6 = document.createElement('span');
                    span6.textContent = time;
                    listItem.appendChild(span6);

                    let span7 = document.createElement('span');
                    span7.textContent = value.tabId;
                    listItem.appendChild(span7);

                    let span8 = document.createElement('span');
                    span8.textContent = value.sumCashAmountPaid.toLocaleString();
                    listItem.appendChild(span8);

                    let span9 = document.createElement('span');
                    span9.textContent = value.sumCartAmountPaid.toLocaleString();
                    listItem.appendChild(span9);

                    setTimeout(function () {
                        listContainer.appendChild(listItem);
                        let list = document.querySelectorAll(".sales-history-list-body li")
                        list[idx].style.backgroundColor = "aqua"
                        list[idx].classList.add("checked")
                        if (idx != 0) {
                            list[idx - 1].style.backgroundColor = "inherit"
                            list[idx - 1].classList.remove("checked")
                        }

                        scrollToLower();

                        let cart_id = list[idx].dataset.value
                        setReceipt(cart_id, list[idx].id.substring(list[idx].id.indexOf("_") + 1))

                        document.querySelectorAll(".list-item").forEach((element, idx) => {
                            element.addEventListener("click", function () {
                                let lastCheckedEl = document.querySelector(".checked")
                                lastCheckedEl.style.backgroundColor = "inherit"
                                lastCheckedEl.classList.remove("checked")
                                element.style.backgroundColor = "aqua"
                                element.classList.add("checked")
                                cart_id = element.dataset.value
                                setReceipt(cart_id, element.id.substring(element.id.indexOf("_") + 1))

                                listLength = $(".sales-history-list-body .list-item").length
                                liIndex = element.id.substring(element.id.indexOf("_") + 1)
                            })
                        })

                        listLength = $(".sales-history-list-body .list-item").length
                        liIndex = $(".sales-history-list-body .checked")[0].id.substring($(".sales-history-list-body .checked")[0].id.indexOf("_") + 1)
                    }, (idx + 1) * 50)
                })
            } else {
                let str = `
                    <c:forEach begin="1" end="12" varStatus="asd">
                        <li>
                            <c:forEach begin="1" end="9" varStatus="dsa">
                                <span class="${asd.index == asd.index ? dsa.index : ''}">${dsa.index == 1 ? asd.index : ''}</span>
                            </c:forEach>
                        </li>
                    </c:forEach>
                `
                $(".sales-history-list-body").html(str);
                setReceipt(0, 0)
                $(".sales-history-msg-box .msg-tag").html("해당 내역이 존재하지 않습니다");
            }
        }, "json")
    })

</script>
<%@include file="../common/footer.jsp" %>