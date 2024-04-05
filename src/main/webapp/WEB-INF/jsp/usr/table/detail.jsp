<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Deatil"/>

<%@include file="../common/detailHead.jsp" %>

<div class="businessDate">
    <span>> 담당자: &nbsp;&nbsp; ${loginedEmployeeName}</span>
    <span>> 영업일자: &nbsp; &nbsp; ${businessDate}</span>
    <span>> 포스번호 : &nbsp; &nbsp; 1</span>
</div>

<div class="manuPage">
    <div class="manuPageLeft">
        <ul class="selectedManuList " id="selectedManuList-1">
            <li class="thead">
                <span></span>
                <span>상품명</span>
                <span>수량</span>
                <span>금액</span>
                <span>할일금액</span>
            </li>
            <ul class="tbody flex flex-col ">
                <c:forEach var="cartItem" items="${cartItemsList}" varStatus="status">
                    <li class="flex oldProduct " id="oldProduct_${cartItem.id}"
                        productId="${cartItem.id}">
                        <input type="submit" id="id_${status.count}" value="${status.count}">
                        <input type="submit" id="product-name_${status.count}" value="${cartItem.productName}"
                               class="productList_${status.count}">
                        <input type="submit" id="product-count_${status.count}" value="${cartItem.quantity}"
                               class="productCount_${status.count}">
                        <input type="submit" data-value="${cartItem.productPrice}" id="product-price_${status.count}"
                               value="${cartItem.productSumPrice}"
                               class="productPrice_${status.count}">
                        <input type="submit" id="product-discount_${status.count}" value="${cartItem.productSailPrice}">
                    </li>
                </c:forEach>
            </ul>
        </ul>
        <div class="buttons">
            <button onclick="productListAllSelect();" class="btn btn-xs">전체선택</button>
            <button onclick="CancelProduct();" class="btn btn-xs">취소</button>
            <button onclick="addProduct();" class="btn btn-xs text-blue-500 text-2l"><span
                    class="material-symbols-outlined">add</span></button>
            <button onclick="removeProduct();" class="btn btn-xs text-blue-500 text-2l"><span
                    class="material-symbols-outlined">remove</span>
            </button>
            <button class="btn btn-xs text-blue-500 text-2l"><span class="material-symbols-outlined">expand_less</span>
            </button>
            <button class="btn btn-xs text-blue-500 text-2l"><span class="material-symbols-outlined">expand_more</span>
            </button>
        </div>
        <div class="calculatePage">
            <div class="allProductInfo">
                <div>
                    <span>총수량</span>
                    <span class="ProductTotalQuantity">${totalQuantity}</span>
                </div>
                <div>
                    <span>총매출액</span>
                    <input type="submit" value="${totalPrice}" class="ProductsTotalSumPrice w-3/6">
                </div>
                <div>
                    <span>할인총액</span>
                    <span class="discountAmount">${discountSumAMount}</span>
                </div>
                <div>
                    <span>받을금액</span>
                    <span class="amountToPay">${receiveAmount - rq.leftAmount}</span>
                </div>
                <div>
                    <span>받은금액</span>
                    <span class="leftAmount">${rq.leftAmount}</span>
                </div>
                <div>
                    <span>거스름돈</span>
                    <span>0</span>
                </div>
                <div>
                    <span>${floor}층 ${tabId}번 </span> <br>
                    <c:forEach var="paymentCash" items="${paymentCashList}">
                        현금결제 : ${paymentCash.cashAmountPaid} <br>
                    </c:forEach>

                    <c:forEach var="paymentCart" items="${paymentCartList}">
                        카드결제 : ${paymentCart.cartAmountPaid} <br>
                    </c:forEach>
                </div>
            </div>
            <div class="calculator">
                <div class="numberFeed">
                    <input type="number" value="">
                    <div>
                        <span onclick="clearInput();" class="btn btn-xs w-full text-base">Clear</span>
                        <span onclick="arrow_back();"
                              class="material-symbols-outlined btn btn-xs text-4xl">arrow_back</span>
                    </div>
                    <div>
                        <span class="btn btn-xs">7</span>
                        <span class="btn btn-xs">8</span>
                        <span class="btn btn-xs">9</span>
                    </div>
                    <div>
                        <span class="btn btn-xs">4</span>
                        <span class="btn btn-xs">5</span>
                        <span class="btn btn-xs">6</span>
                    </div>
                    <div>
                        <span class="btn btn-xs">1</span>
                        <span class="btn btn-xs">2</span>
                        <span class="btn btn-xs">3</span>
                    </div>
                    <div>
                        <span class="btn btn-xs">0</span>
                        <span class="btn btn-xs">00</span>
                        <span class="btn btn-xs">000</span>
                    </div>
                </div>
                <div class="buttonsFeed">
                    <div>
                        <span class="btn btn-xs">상품조회</span>
                    </div>
                    <div>
                        <span onclick="amountDiscountFunc();" class="btn btn-xs">금액할인</span>
                    </div>
                    <div>
                        <span onclick="calSailFunc();" class="btn btn-xs">% 할인</span>
                    </div>
                    <div>
                        <span onclick="changeAmount();" class="btn btn-xs">금액변경</span>
                    </div>
                    <div>
                        <span onclick="changeQuantity();" class="btn btn-xs">수량변경</span>
                    </div>
                    <div>
                        <span class="btn btn-xs">Enter</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="order-msg-box">
            <span class="material-symbols-outlined">volume_up</span>
            <span class="msg-tag"></span>
        </div>
    </div>
    <script>

        <%--  ========= 등록된 상품 있으면 order-msg-box 에서 수량 보여주기 ===============--%>
        if (${cartItemsList.size() != 0}) {
            clickEvent();
            let productLastChild = $(".tbody li:last-child")
            productLastChild.css("border-bottom", "1px solid red")

            $(".msg-tag").html(`상품 총 수량 \${${cartItemsList.size()}}개`)
        }

        // ========== Close button 클릭시 주문한 상푼 있는지 확인 여부에 따라 문자 매세기 처리
        $(".btn-close").click(function () {
            let leftAmount = document.querySelector(".leftAmount").innerHTML
            if (leftAmount != 0) {
                $(".msg-tag").html("결제를 모두 마쳐주세요!")
            } else if (leftAmount == 0) {
                let getCartItemSumPrice = ${receiveAmount};
                let amountToPay = document.querySelector(".amountToPay").textContent

                if (amountToPay != getCartItemSumPrice) {
                    exampleFunction().then((result) => {
                        if (result == "true") {
                            $('form[name=do-insert-product-form]').submit();
                            location.replace("/?floor=" + ${rq.floor});
                        } else {
                            closeMsgBox();
                        }
                    })
                } else {
                    location.replace("/?floor=" + ${rq.floor});
                }
            }
        })

        // ========== 주문 개수나 총매출액 처리 ==========
        function totalPrice_TotalCnt_Calculate(price, disPrice) {
            let intPrice = parseInt(price)
            let intDisPrice = parseInt(disPrice)
            let totalQuantityNode = document.querySelector(".ProductTotalQuantity");
            let totalPriceNode = document.querySelector(".ProductsTotalSumPrice");
            let discountPriceNode = document.querySelector(".discountAmount");
            let receivePriceNode = document.querySelector(".amountToPay");

            let totalQuantity = $(".tbody li").length;
            let totalPrice = parseInt(totalPriceNode.value);
            let discountPrice = parseInt(discountPriceNode.textContent);
            let receivePrice = (totalPrice + intPrice) - (discountPrice + intDisPrice);

            totalQuantityNode.textContent = totalQuantity;
            totalPriceNode.value = totalPrice + intPrice;
            discountPriceNode.textContent = discountPrice + intDisPrice;
            receivePriceNode.textContent = receivePrice;
        }

        // ========== 메뉴 주문 함수 처리 ==========

        function selectMenuItem(element) {
            let productLen = $(".tbody li").length
            productLen++;
            let productId = element.id.substring(element.id.indexOf("_") + 1);
            let productName = element.children[0].textContent;
            let productPrice = element.children[1].dataset.value;
            let str = "";
            str += `
                    <li class="flex newProduct \${productLen == 1 ? 'checked' : ''}"
                            id="newProduct_\${productId}" productId="\${productId}" >
                         <input type="submit" id="id_\${productLen}" value="\${productLen}">
                         <input type="submit" id="product-name_\${productLen}" value="\${productName}" class="productList_\${productId}">
                         <input type="submit" id="product-count_\${productLen}" value="1" class="productCount_\${productLen}">
                         <input type="submit" data-value="\${productPrice}" id="product-price_\${productLen}" value="\${productPrice}" class="productPrice_\${productLen}">
                         <input type="submit" id="product-discount_\${productLen}" value="0">
                    </li>
                   `

            let isSameProduct = document.querySelector("#newProduct_" + productId);

            if (isSameProduct != null) {
                let sameProduct = isSameProduct.children[2];
                sameProduct.value++;
                doFocusToProductLi(productId);
                scrollToSelectedItem(document.querySelector("#newProduct_" + productId));
                clickEvent();
            } else {
                $(".tbody").append(str);
                doFocusToProductLi(productId);
                scrollToSelectedItem(document.querySelector("#newProduct_" + productId));
                clickEvent();

                if (productLen != 0) {
                    $(".msg-tag").html(`상품 총 수량 \${productLen}개`)
                }
            }
        }

        function doFocusToProductLi(productId) {
            document.querySelector(".tbody li.checked").style.backgroundColor = "inherit";
            document.querySelector(".tbody li.checked").classList.remove("checked");
            document.querySelector("#newProduct_" + productId).style.backgroundColor = "aqua";
            document.querySelector("#newProduct_" + productId).classList.add("checked");

            // 상품 갯수에 맞는 가격을 보여주기 //
            let currentItem = document.querySelector("#newProduct_" + productId)
            const productSumPrice = (currentItem.children[3].dataset.value * currentItem.children[2].value)
            currentItem.children[3].value = productSumPrice;

            // 총매출액에 추가 된 상품 금액 더하기 //
            let price = currentItem.children[3].dataset.value
            totalPrice_TotalCnt_Calculate(price, 0);
        }

        function scrollToSelectedItem(selectedItem) {
            selectedItem.scrollIntoView({
                behavior: 'smooth',
                block: 'end',
                inline: "nearest"
            });
        }

        function clickEvent() {
            document.querySelectorAll(`.tbody li`).forEach((element, idx) => {
                element.addEventListener("click", function () {
                    let lastCheckedEl = document.querySelector(`.tbody li.checked`)
                    lastCheckedEl.style.backgroundColor = "inherit"
                    lastCheckedEl.style.color = "black"
                    lastCheckedEl.classList.remove("checked")
                    element.style.backgroundColor = "aqua"
                    element.classList.add("checked")
                })
            })
        }

        let allSelectButton = document.querySelector(".buttons > button:first-child");

        function productListAllSelect() {
            if (allSelectButton.innerHTML != "전체선택해제") {
                allSelectButton.innerHTML = "전체선택해제";
                let productList = $(".tbody li");
                if (productList.length >= 1) {
                    for (let i = 0; i < productList.length; i++) {
                        productList[i].classList.add("checked");
                        productList[i].style.backgroundColor = "aqua";
                    }
                }
            } else if (allSelectButton.innerHTML != "전체선택") {
                allSelectButton.innerHTML = "전체선택";
                let productList = $(".tbody li");
                if (productList.length >= 1) {
                    for (let i = 0; i < productList.length; i++) {
                        productList[i].classList.remove("checked");
                        productList[i].style.backgroundColor = "inherit";
                    }
                    productList[productList.length - 1].classList.add("checked");
                    productList[productList.length - 1].style.backgroundColor = "aqua";
                }
            }
        }

        const checkedProductIds = [];
        const checkedProductNames = [];

        function CancelProduct() {
            if ($(".tbody li").length != 0) {
                let checkedProduct = $(".tbody li.checked")
                const checkedProductId = $('.tbody li.checked').map((index, el) => el.id).toArray();
                const checkedProductName = $('.tbody li.checked').map((index, el) => el.children[1].value).toArray();

                for (let i = 0; i < checkedProductId.length; i++) {
                    if (checkedProductId[i].startsWith("old")) {
                        checkedProductIds.push(checkedProductId[i].substring(checkedProductId[i].indexOf("_") + 1));
                        checkedProductNames.push(checkedProductName[i]);
                    }
                }

                for (let i = 0; i < checkedProduct.length; i++) {
                    checkedProduct.remove();
                    let cancelPrice = parseInt(checkedProduct[i].children[3].value);
                    let discountPrice = parseInt(checkedProduct[i].children[4].value);

                    if (discountPrice != 0) {
                        cancelPrice = cancelPrice + discountPrice
                        totalPrice_TotalCnt_Calculate(-cancelPrice, -discountPrice);
                    } else {
                        totalPrice_TotalCnt_Calculate(-cancelPrice, 0);
                    }

                    let selectManuListLastChild = document.querySelector("#selectedManuList-1 li:last-child")
                    if (selectManuListLastChild != null) {
                        selectManuListLastChild.style.backgroundColor = "aqua"
                        document.querySelector("#selectedManuList-1 li:last-child").classList.add("checked")
                    }
                }

                $('input[name=delProductList]').val(checkedProductIds.join(","))
                $('input[name=delProductNameList]').val(checkedProductNames.join(","))
            }
        }

        function addProduct() {
            let n = 1
            let checkedProduct = $(".tbody li.checked")

            if (checkedProduct.length != 0) {
                let productId = checkedProduct[0].id;
                let productQuantityInput = checkedProduct[0].children[2];
                let productSumPriceInput = checkedProduct[0].children[3];
                let beforeQuantity = productQuantityInput.value
                let productPrice = productSumPriceInput.dataset.value;

                if (beforeQuantity >= 1 && productSumPriceInput.value != 0) {
                    let afterQuantity = parseInt(beforeQuantity) + n
                    productQuantityInput.value = afterQuantity;
                    productSumPriceInput.value = parseInt(productSumPriceInput.value) + parseInt(productPrice);
                    totalPrice_TotalCnt_Calculate(productPrice, 0);

                    productId.startsWith("old") ? checkedProduct.addClass("updateProduct") : '';
                }
            }
        }

        function removeProduct() {
            let n = 1
            let checkedProduct = $(".tbody li.checked")

            if (checkedProduct.length != 0) {
                let productId = checkedProduct[0].id;
                let productQuantityInput = checkedProduct[0].children[2];
                let productSumPriceInput = checkedProduct[0].children[3];

                let productPrice = productSumPriceInput.dataset.value;
                let beforeQuantity = productQuantityInput.value

                if (beforeQuantity > 1 && productSumPriceInput.value != 0) {
                    let afterQuantity = parseInt(beforeQuantity) - n
                    productQuantityInput.value = afterQuantity;
                    productSumPriceInput.value = parseInt(productSumPriceInput.value) - parseInt(productPrice);
                    totalPrice_TotalCnt_Calculate(-productPrice, 0);

                    productId.startsWith("old") ? checkedProduct.addClass("updateProduct") : '';
                }
            }
        }

        document.querySelectorAll(".numberFeed div:not(:nth-child(2)) > span").forEach((element) => {
            element.addEventListener("click", (e) => {
                let calInput = document.querySelector(".numberFeed > input")
                calInput.value += e.target.innerText
            })
        })

        function clearInput() {
            let calInput = document.querySelector(".numberFeed > input")
            calInput.value = "";
        }

        function arrow_back() {
            let calInput = document.querySelector(".numberFeed > input")
            let inputText = calInput.value
            let inputArray = inputText.split("")
            inputArray.pop();

            let updatedText = inputArray.join("");
            calInput.value = updatedText;
        }

        // ============ 메뉴 분할 결제나 할인 처리 =========
        function amountDiscountFunc() {
            let discountAmount = document.querySelector(".numberFeed input").value

            if (discountAmount != 0) {
                let checkedProduct = $(".tbody > .checked")
                let discountAmountSumPrice = 0;
                let currPrice = 0;
                let disPrice = 0;

                for (let i = 0; i < checkedProduct.length; i++) {
                    let productId = checkedProduct[i].id
                    let oldPrice = parseInt(checkedProduct[i].children[3].value)
                    let productCnt = parseInt(checkedProduct[i].children[2].value)
                    let costPrice = parseInt(checkedProduct[i].children[3].dataset.value)
                    currPrice = parseInt(checkedProduct[i].children[3].value)

                    if (oldPrice != 0 && discountAmount <= (costPrice * productCnt)) {
                        disPrice += parseInt(checkedProduct[i].children[4].value)
                        discountAmountSumPrice += parseInt(discountAmount)
                        checkedProduct[i].children[4].value = parseInt(discountAmount)
                        checkedProduct[i].children[3].value = (costPrice * productCnt) - parseInt(discountAmount)

                        productId.startsWith("old") ? checkedProduct[i].classList.add("updateProduct") : '';
                    }
                }

                if (currPrice != 0 || checkedProduct.length > 1) {
                    const amountToPaySumPrice = document.querySelector(".amountToPay").textContent
                    const productsTotalSumPrice = document.querySelector(".ProductsTotalSumPrice").value
                    const discountAmount = document.querySelector(".discountAmount").innerHTML

                    if (discountAmount == 0) {
                        const amountToPay = (parseInt(amountToPaySumPrice) + disPrice) - parseInt(discountAmountSumPrice) - ${discountSumAMount};
                        const afterDiscountPrice = (parseInt(productsTotalSumPrice) - amountToPay) + ${discountSumAMount};
                        $(".amountToPay").html(amountToPay)
                        $(".discountAmount").html(afterDiscountPrice)
                    } else {
                        const amountToPay = (parseInt(amountToPaySumPrice) + disPrice) - parseInt(discountAmountSumPrice);
                        const afterDiscountPrice = (parseInt(productsTotalSumPrice) - amountToPay);
                        $(".amountToPay").html(amountToPay)
                        $(".discountAmount").html(afterDiscountPrice)
                    }

                }
                clearInput();

            } else {
                $(".msg-tag").html(`할인 금액을 확인해주세요!`)
            }
        }

        function calSailFunc() {
            let discountPercentage = document.querySelector(".numberFeed input").value
            if (discountPercentage != 0 && discountPercentage <= 100) {
                let checkedProduct = $(".tbody > .checked")
                let checkedProductSumPrice = 0;
                let disPrice = 0;
                let currPrice = 0

                for (let i = 0; i < checkedProduct.length; i++) {
                    let productId = checkedProduct[i].id
                    let costPrice = parseInt(checkedProduct[i].children[3].dataset.value)
                    let productCnt = parseInt(checkedProduct[i].children[2].value)
                    currPrice = parseInt(checkedProduct[i].children[3].value)

                    if (currPrice != 0) {
                        disPrice += parseInt(checkedProduct[i].children[4].value)
                        let eachSailPrice = (costPrice * productCnt) / 100 * discountPercentage
                        checkedProductSumPrice += (costPrice * productCnt)
                        checkedProduct[i].children[4].value = eachSailPrice
                        checkedProduct[i].children[3].value = (costPrice * productCnt) - eachSailPrice

                        productId.startsWith("old") ? checkedProduct[i].classList.add("updateProduct") : '';
                    }
                }


                if (currPrice != 0 || checkedProduct.length > 1) {
                    let allSailPrice = checkedProductSumPrice / 100 * discountPercentage
                    let amountToPaySumPrice = document.querySelector(".amountToPay").textContent
                    let productsTotalSumPrice = document.querySelector(".ProductsTotalSumPrice").value
                    let discountAmount = $(".discountAmount")[0].innerHTML

                    const amountToPay = (parseInt(amountToPaySumPrice) + parseInt(disPrice)) - allSailPrice;
                    $(".amountToPay").html(amountToPay);
                    $(".discountAmount").html(parseInt(productsTotalSumPrice) - amountToPay);

                }

                clearInput();

            } else {
                $(".msg-tag").html(`할인 금액을 확인해주세요!`)
            }
        }

        function changeAmount() {
            let changeAmount = document.querySelector(".numberFeed input").value

            if (changeAmount != 0) {
                let checkedProduct = $(".tbody > .checked")
                let changeAmountSumPrice = 0;
                let currDisPrice = 0;
                let oldPrice = 0;

                for (let i = 0; i < checkedProduct.length; i++) {
                    let productId = checkedProduct[i].id
                    currDisPrice = checkedProduct[i].children[4].value
                    oldPrice = checkedProduct[i].children[3].value

                    if (oldPrice != 0) {
                        changeAmountSumPrice += parseInt(oldPrice) - parseInt(changeAmount)
                        checkedProduct[i].children[3].value = parseInt(changeAmount)

                        if (currDisPrice != 0) {
                            let discountSumPrice = $(".discountAmount").html()
                            $(".discountAmount").html(discountSumPrice - currDisPrice)
                            checkedProduct[i].children[4].value = 0
                        }

                        productId.startsWith("old") ? checkedProduct[i].classList.add("updateProduct") : '';
                    }
                }

                let amountToPaySumPrice = document.querySelector(".amountToPay").innerHTML
                let productsTotalSumPrice = document.querySelector(".ProductsTotalSumPrice").value

                $(".amountToPay").html(amountToPaySumPrice - changeAmountSumPrice)

                if (oldPrice != 0) {
                    $(".ProductsTotalSumPrice").val(productsTotalSumPrice - changeAmountSumPrice - currDisPrice)
                } else {
                    $(".ProductsTotalSumPrice").val(productsTotalSumPrice - changeAmountSumPrice)
                }

                clearInput();

            } else {
                $(".msg-tag").html(`할인 금액을 확인해주세요!`)
            }
        }

        function changeQuantity() {
            let changeQuantity = document.querySelector(".numberFeed input").value

            if (changeQuantity != 0) {
                let checkedProduct = $(".tbody > .checked")
                let changeAmountSumPrice = 0;
                let oldSumPrice = 0;

                for (let i = 0; i < checkedProduct.length; i++) {
                    let productId = checkedProduct[i].id
                    let oldPrice = parseInt(checkedProduct[i].children[3].value)
                    oldSumPrice += parseInt(oldPrice)
                    let costPrice = checkedProduct[i].children[3].dataset.value

                    if (oldPrice != 0) {
                        changeAmountSumPrice += parseInt(changeQuantity) * parseInt(costPrice)
                        checkedProduct[i].children[2].value = changeQuantity
                        checkedProduct[i].children[3].value = parseInt(changeQuantity) * parseInt(costPrice)

                        productId.startsWith("old") ? checkedProduct[i].classList.add("updateProduct") : '';
                    }
                }

                let amountToPaySumPrice = document.querySelector(".amountToPay").innerHTML
                let productsTotalSumPrice = document.querySelector(".ProductsTotalSumPrice").value

                $(".amountToPay").html(parseInt(amountToPaySumPrice) + parseInt(changeAmountSumPrice) - parseInt(oldSumPrice))

                $(".ProductsTotalSumPrice").val(parseInt(productsTotalSumPrice) + parseInt(changeAmountSumPrice) - parseInt(oldSumPrice))

                clearInput();

            } else {
                $(".msg-tag").html(`할인 금액을 확인해주세요!`)
            }
        }

        // =============== 메뉴 서비스 처리 ====================
        function freeProduct() {
            let checkedProducts = document.querySelectorAll(".tbody > .checked");
            for (let i = 0; i < checkedProducts.length; i++) {
                let productId = checkedProducts[i].id
                let checkedProductName = checkedProducts[i].children[1].value;
                let checkedProductSumPrice = checkedProducts[i].children[3];
                let checkedProductSailPrice = checkedProducts[i].children[4];
                let amountToPay = document.querySelector(".amountToPay").innerHTML

                if (checkedProductSumPrice.value != 0) {
                    checkedProductSailPrice.value = checkedProductSumPrice.value;
                    checkedProductSumPrice.value = 0;
                    checkedProducts[i].children[1].value = "[S]" + checkedProductName;
                    let disCountAmount = $(".discountAmount").html()
                    $(".discountAmount").html(parseInt(disCountAmount) + parseInt(checkedProductSailPrice.value))
                    $(".amountToPay").html(parseInt(amountToPay) - parseInt(checkedProductSailPrice.value))

                    productId.startsWith("old") ? checkedProducts[i].classList.add("updateProduct") :
                        checkedProducts[i].classList.add("newProduct");
                } else {
                    checkedProducts[i].children[1].value = checkedProductName.substring(3);
                    checkedProductSumPrice.value = checkedProductSailPrice.value;
                    checkedProductSailPrice.value = 0;
                    let disCountAmount = $(".discountAmount").html()
                    $(".discountAmount").html(parseInt(disCountAmount) - parseInt(checkedProductSumPrice.value))
                    $(".amountToPay").html(parseInt(amountToPay) + parseInt(checkedProductSumPrice.value))

                    productId.startsWith("old") ? checkedProducts[i].classList.add("updateProduct") :
                        checkedProducts[i].classList.add("newProduct");
                }
            }
        }

    </script>
    <div class="manuPageRight">
        <ul class="productType-box">
            <c:forEach var="productType" items="${productTypes}" varStatus="idx">
                <li onclick="getProductByProTypeName(this, null);" class="${idx.index == 0 ? 'selected' : ''}"
                    name="${productType.korName}"
                    id="productType_${productType.code}">
                    <button style="background-color: ${productType.color}" class="">${productType.korName}</button>
                </li>
            </c:forEach>
            <c:if test="${productTypes.size() <= 13}">
                <c:forEach begin="${productTypes.size() + 1}" end="13" varStatus="idx">
                    <li id="productType_${idx.index + 1}"></li>
                    <c:if test="${idx.index == 13}">
                        <li id="productType_${idx.index + 1}">
                            <span class="material-symbols-outlined">arrow_back_ios</span>
                            <span class="material-symbols-outlined ${productTypes.size() > 13 ? 'bg-blue-600' : ''}">arrow_forward_ios</span>
                        </li>
                    </c:if>
                </c:forEach>
            </c:if>
        </ul>
        <ul class="product-box">
            <c:forEach var="product" items="${products}">
                <li id="productItem_${product.id}" style="background-color: ${product.color}"
                    onclick="selectMenuItem(this)"
                    class="productItems">
                    <span class="w-full h-3/5 text-center" name="productName">${product.productKorName}</span>
                    <span class="text-red-400 pt-2 h-2/5 price" data-value="${product.price}"
                          name="price">${product.price}원</span>
                </li>
            </c:forEach>
            <c:if test="${products.size() <= 27}">
                <c:forEach begin="${products.size() + 1}" end="27" varStatus="idx">
                    <li id="${idx.index}"
                        class="productItems ">
                    </li>
                    <c:if test="${idx.index == 27}">
                        <li id="${idx.index}"
                            class="productItems ">
                            <span onclick="${products.size() > 27 ? 'getProductByProTypeName(null, 1)' : ''}"
                                  class="material-symbols-outlined ">arrow_back_ios</span>
                            <span onclick="${products.size() > 27 ? 'getProductByProTypeName(null, 2)' : ''}"
                                  class="material-symbols-outlined ${totalPage > 1 ? 'bg-blue-600' : ''}">arrow_forward_ios</span>
                        </li>
                    </c:if>
                </c:forEach>
            </c:if>
        </ul>
    </div>

    <script>

        let page = 1;
        let totalPage = ${totalPage};

        function getProductByProTypeName(el, btnName) {
            let productTypeCode = "";
            let productTypeName = "";
            if (el != null) {
                let beforeProType = document.querySelector(".productType-box li.selected")
                beforeProType.classList.remove("selected");
                productTypeCode = el.id.substring(el.id.indexOf("_") + 1);
                productTypeName = el.getAttribute("name");
                el.classList.add("selected");

                page = 1;
            } else {
                let beforeProType = document.querySelector(".productType-box li.selected")
                productTypeCode = beforeProType.id.substring(beforeProType.id.indexOf("_") + 1);
                productTypeName = beforeProType.getAttribute("name");

                if (btnName == 1 && page > 1) {
                    page--;
                } else if (btnName == 2 && page < totalPage) {
                    page++;
                }
            }

            $.ajax({
                url: "/usr/tables/detail/getProduct",
                data: {
                    productTypeCode: productTypeCode,
                    productTypeName: productTypeName,
                    page: page
                },
                method: "GET",
                success: function (data) {
                    drawProductLi(data);
                    totalPage = data.totalPage;
                },
                error: function (request, status, error) {
                    console.log(error)
                },
                complete: function () {

                }
            })
        }

        function drawProductLi(data) {
            let productList = data.productList;
            let productCnt = data.productCnt;
            let totalPage = data.totalPage;
            let page = data.page;

            let liElement = "";
            if (productList.length != 0) {
                for (let i = 0; i < productList.length; i++) {
                    let product = productList[i];
                    liElement += `
                     <li id="productItem_\${product.id}" style="background-color: \${product.color}"  onclick="selectMenuItem(this)"
                        class="productItems flex flex-col justify-center items-center w-full h-full cursor-pointer p-4">
                        <span class="w-full h-3/5 text-center" name="productName">\${product.productKorName}</span>
                        <span class="text-red-400 pt-2 h-2/5 price" name="price" data-value="\${product.price}">\${product.price.toLocaleString()}원</span>
                    </li>
                `
                }

                if (productList.length <= 27) {
                    for (let i = productList.length + 1; i <= 27; i++) {
                        liElement += `
                         <li id="\${i}"
                            class="productItems ">
                         </li>
                        `
                        if (i == 27) {
                            liElement += `
                             <li id="\${i}"class="productItems ">
                                <span onclick="\${productCnt > 27 ? 'getProductByProTypeName(null, 1)' : ''}"
                                    class="material-symbols-outlined \${page > 1 ? 'bg-blue-600' : ''}" >arrow_back_ios</span>
                                <span onclick="\${productCnt > 27 ? 'getProductByProTypeName(null, 2)' : ''}"
                                    class="material-symbols-outlined \${totalPage > 1 ? 'bg-blue-600' : ''}">arrow_forward_ios</span>
                             </li>
                            `
                        }
                    }
                }
                $(".manuPageRight .product-box").html(liElement);

            } else {
                if (productList.length <= 27) {
                    for (let i = productList.length + 1; i <= 27; i++) {
                        liElement += `
                             <li id="\${i}"
                                class="productItems flex ">
                             </li>
                            `
                        if (i == 27) {
                            liElement += `
                             <li id="\${i}"class="productItems ">
                                <span class="material-symbols-outlined">arrow_back_ios</span>
                                <span class="material-symbols-outlined \${productCnt > 10 ? 'bg-blue-600' : ''}">arrow_forward_ios</span>
                             </li>
                            `
                        }
                    }
                }
                $(".manuPageRight .product-box").html(liElement);
            }
        }

        function PutComma() {
            document.querySelectorAll(".price").forEach((el) => {
                let num = el.innerHTML.replace("원", "")
                el.innerHTML = Number(num).toLocaleString() + "원";
            })
        }

        PutComma();
    </script>
</div>

<%@include file="../common/foot.jsp" %>

<%@include file="../common/footer.jsp" %>