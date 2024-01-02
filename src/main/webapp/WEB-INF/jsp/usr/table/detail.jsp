<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Deatil"/>

<%@include file="../common/detailHead.jsp" %>

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
                    <li class="flex product-box-list product-box-list_${status.count}" id="product_${cartItem.id}"
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
            <button onclick="productListAllSelect();" class="btn btn-sm">전체선택</button>
            <button onclick="CancelProduct();" class="btn btn-sm">취소</button>
            <button onclick="addProduct();" class="btn btn-sm text-blue-500 text-2l"><span
                    class="material-symbols-outlined">add</span></button>
            <button onclick="removeProduct();" class="btn btn-sm text-blue-500 text-2l"><span
                    class="material-symbols-outlined">remove</span>
            </button>
            <button class="btn btn-sm text-blue-500 text-2l"><span class="material-symbols-outlined">expand_less</span>
            </button>
            <button class="btn btn-sm text-blue-500 text-2l"><span class="material-symbols-outlined">expand_more</span>
            </button>
        </div>
        <div class="calculatePage">
            <div class="allProductInfo">
                <div>
                    <span>총수량</span>
                    <span class="ProductTotalQuantity"></span>
                </div>
                <div>
                    <span>총매출액</span>
                    <input type="submit" value="" class="ProductsTotalSumPrice">
                </div>
                <div>
                    <span>할인총액</span>
                    <span class="discountAmount">${discountSumAMount}</span>
                </div>
                <div>
                    <span>받을금액</span>
                    <span class="amountToPay">0</span>
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
                    ${floor}층 ${tabId}번
                </div>
            </div>
            <div class="calculator">
                <div class="numberFeed">
                    <input type="text" value="">
                    <div>
                        <span onclick="clearInput();" class="btn w-full text-base">Clear</span>
                        <span onclick="arrow_back();" class="material-symbols-outlined btn text-4xl">arrow_back</span>
                    </div>
                    <div>
                        <span class="btn">7</span>
                        <span class="btn">8</span>
                        <span class="btn">9</span>
                    </div>
                    <div>
                        <span class="btn">4</span>
                        <span class="btn">5</span>
                        <span class="btn">6</span>
                    </div>
                    <div>
                        <span class="btn">1</span>
                        <span class="btn">2</span>
                        <span class="btn">3</span>
                    </div>
                    <div>
                        <span class="btn">0</span>
                        <span class="btn">00</span>
                        <span class="btn">000</span>
                    </div>
                </div>
                <div class="buttonsFeed">
                    <span class="btn">상품조회</span>
                    <span class="btn">금액할인</span>
                    <span onclick="calSailFunc();" class="btn">% 할인</span>
                    <span class="btn">금액변경</span>
                    <span class="btn">수량변경</span>
                    <span class="btn">Enter</span>
                </div>
            </div>
        </div>
        <div class="order-msg-box">
            <span class="material-symbols-outlined">volume_up</span>
            <span class="msg-tag"></span>
        </div>
    </div>
    <script>

        // ========== Close button 클릭시 주문한 상푼 있는지 확인 여부에 따라 문자 매세기 처리
        $(".btn-close").click(function () {
            let leftAmount = document.querySelector(".leftAmount").innerHTML
            if (leftAmount != 0) {
                $(".msg-tag").html("결제를 모두 마쳐주세요!")
            } else if (leftAmount == 0) {
                $.get("/usr/tables/getCartItemSumPrice", {
                    tabId: ${param.tabId},
                    floor: ${rq.floor}
                }, function (data) {
                    let getCartItemSumPrice = data.data1
                    let productsTotalSumPrice = document.querySelector(".ProductsTotalSumPrice").value
                    let discountAmount = document.querySelector(".discountAmount").innerHTML

                    if (getCartItemSumPrice != (parseInt(productsTotalSumPrice) - parseInt(discountAmount))) {
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
                }, "json")
            }
        })


        // ========== 주문 개수나 총매출액 처리 ==========
        let productSumPrice = 0;
        let currentAmount = -1;

        function getProductTotalSumPriceAndTotalQuantity__2(price) {
            if (price == null) {
                $.get("/usr/tables/getProductTotalSumPriceAndTotalQuantity", {
                    tabId: ${tabId},
                    floor: ${floor}
                }, function (data) {
                    if (data.data1 > 0 && data.data2 > 0) {
                        let disAmount = $(".discountAmount").html()
                        $(".ProductTotalQuantity").html(data.data1)
                        $(".ProductsTotalSumPrice").val(data.data2)
                        $(".amountToPay").html(data.data2 - parseInt(disAmount) - ${rq.leftAmount})
                    } else {
                        $(".ProductTotalQuantity").html(0)
                        $(".ProductsTotalSumPrice").val(0)
                        $(".amountToPay").html(0)
                    }
                }, "json")
            } else if (price != null) {
                if (currentAmount == -1) {
                    currentAmount = $(".amountToPay").html()
                    productSumPrice += parseInt(currentAmount);
                    productSumPrice += parseInt(price);
                    let productList = document.querySelectorAll(".product-box-list")
                    $(".ProductTotalQuantity").html(productList.length)
                    $(".ProductsTotalSumPrice").val(productSumPrice + parseInt($(".discountAmount").html()))
                    $(".amountToPay").html(productSumPrice)
                } else {
                    productSumPrice += parseInt(price);
                    let productList = document.querySelectorAll(".product-box-list")
                    $(".ProductTotalQuantity").html(productList.length)
                    $(".ProductsTotalSumPrice").val(productSumPrice + parseInt($(".discountAmount").html()))
                    $(".amountToPay").html(productSumPrice)
                }
            }
        }

        // ========== 메뉴 주문 함수 처리 ==========

        let productIndex = 1;
        let productList = document.querySelectorAll(".product-box-list")
        if (productList != null) {
            productIndex = productList.length + 1;
        }
        let product_list_lastChild = null
        let beforeDuplProduct = null

        function selectMenu(productId) {
            $.get("/usr/tables/getProduct", {
                id: productId,
                tabId: ${tabId},
                floor: ${floor}
            }, function (data) {
                let product = data.data1;
                let str = "";
                str += `
                        <li class="flex product-box-list product-box-list_\${productIndex}" id="product_\${product.id}" productId="\${product.id}" >
                            <input type="submit" id="id_\${productIndex}" value="\${productIndex}">
                            <input type="submit" id="product-name_\${productIndex}" value="\${product.name}" class="productList_\${product.id}">
                            <input type="submit" id="product-count_\${productIndex}" value="\${product.quantity + 1}" class="productCount_\${productIndex}">
                            <input type="submit" data-value="\${product.price}" id="product-price_\${productIndex}" value="\${product.price}" class="productPrice_\${productIndex}">
                            <input type="submit" id="product-discount_\${productIndex}" value="0">
                        </li>
                    `
                let duplProduct = document.querySelector("#product_" + product.id)
                if (duplProduct != null) {
                    if (beforeDuplProduct != null) {
                        beforeDuplProduct.style.backgroundColor = "inherit";
                        beforeDuplProduct.classList.remove("checked");
                    }
                    duplProduct.children[2].value++ // product 수 증가
                    duplProduct.children[3].value = duplProduct.children[3].dataset.value * duplProduct.children[2].value // product 갯수에 맞는 총가격
                    duplProduct.style.backgroundColor = "aqua"; // 배경색 주기
                    duplProduct.classList.add("checked"); // 클래스 입력
                    beforeDuplProduct = duplProduct;

                    product_list_lastChild = document.querySelector(".product-box-list:last-child")

                    if (product_list_lastChild != duplProduct) {
                        product_list_lastChild.style.backgroundColor = "inherit"
                        product_list_lastChild.classList.remove("checked");
                    }

                    let price = duplProduct.children[3].dataset.value
                    getProductTotalSumPriceAndTotalQuantity__2(price);
                } else {
                    let justBeforeChild = document.querySelector(".product-box-list_" + (productIndex - 1))
                    if (justBeforeChild != null) {
                        justBeforeChild.style.backgroundColor = "inherit";
                        justBeforeChild.classList.remove("checked");
                    }
                    productIndex++;

                    $(".tbody").append(str);
                    let productLastChild = document.querySelector("#selectedManuList-1 li:last-child")
                    productLastChild.style.backgroundColor = "aqua";
                    productLastChild.classList.add("checked")
                    let price = productLastChild.children[3].value
                    getProductTotalSumPriceAndTotalQuantity__2(price);

                    if (beforeDuplProduct != null) {
                        beforeDuplProduct.style.backgroundColor = "inherit";
                        beforeDuplProduct.classList.remove("checked");
                    }
                }

                if (product_list_lastChild != duplProduct) {
                    product_list_lastChild.style.backgroundColor = "inherit"
                    product_list_lastChild.classList.remove("checked");
                }

                product_list_lastChild = document.querySelector("#selectedManuList-1 li:last-child")
                document.querySelectorAll(".product-box-list").forEach((element) => {
                    element.addEventListener("click", (e) => {
                        product_list_lastChild.style.backgroundColor = "inherit";
                        product_list_lastChild.classList.remove("checked")
                        if (product != null) {
                            document.querySelector("#product_" + product.id).style.backgroundColor = "inherit";
                            document.querySelector("#product_" + product.id).classList.remove("checked")
                        }
                        product_list_lastChild = element
                        let id = e.target.id.substring(e.target.id.indexOf("_") + 1)
                        const el = document.querySelector(".product-box-list_" + id)
                        el.style.backgroundColor = "aqua"
                        el.classList.add("checked")
                    })
                })
            }, "json")
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

        function CancelProduct() {
            if ($(".tbody li").length != 0) {
                let checkedProduct = $(".checked")
                const checkedProductId = $('.checked').map((index, el) => el.id.substring(el.id.indexOf("_") + 1)).toArray();

                for (let i = 0; i < checkedProduct.length; i++) {
                    checkedProduct.remove();
                    let cancelPrice = checkedProduct[i].children[3].value
                    let discountPrice = checkedProduct[i].children[4].value

                    if (discountPrice != 0){
                        let discountAmount = $(".discountAmount").html()
                        $(".discountAmount").html(discountAmount-discountPrice)
                    }
                    getProductTotalSumPriceAndTotalQuantity__2(-cancelPrice);

                    let selectManuListLastChild = document.querySelector("#selectedManuList-1 li:last-child")
                    if (selectManuListLastChild != null) {
                        selectManuListLastChild.style.backgroundColor = "aqua"
                        document.querySelector("#selectedManuList-1 li:last-child").classList.add("checked")
                    }
                }

                $('input[name=delProductIds]').val(checkedProductId.join(","))

            }
        }

        getProductTotalSumPriceAndTotalQuantity__2(null);

        function addProduct() {
            let n = 1
            let checkedProduct = $(".checked")
            if (checkedProduct.length != 0) {
                let productQuantityInput = checkedProduct[0].childNodes[5];
                let productSumPriceInput = checkedProduct[0].childNodes[7];
                let beforeQuantity = productQuantityInput.value
                let productPrice = productSumPriceInput.dataset.value;

                if (beforeQuantity >= 1) {
                    let afterQuantity = parseInt(beforeQuantity) + n
                    productQuantityInput.value = afterQuantity;
                    productSumPriceInput.value = afterQuantity * productPrice;

                    getProductTotalSumPriceAndTotalQuantity__2(productPrice);
                }
            }
        }

        function removeProduct() {
            let n = 1
            let checkedProduct = $(".checked")
            if (checkedProduct.length != 0) {
                let productQuantityInput = checkedProduct[0].childNodes[5];
                let productSumPriceInput = checkedProduct[0].childNodes[7];
                let productPrice = productSumPriceInput.dataset.value;
                let beforeQuantity = productQuantityInput.value

                if (beforeQuantity > 1) {
                    let afterQuantity = parseInt(beforeQuantity) - n
                    productQuantityInput.value = afterQuantity;
                    productSumPriceInput.value = afterQuantity * productPrice;

                    getProductTotalSumPriceAndTotalQuantity__2(-productPrice);
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

        let eachSailPrice = 0;

        function calSailFunc() {
            let discountPercentage = document.querySelector(".numberFeed input").value

            if (discountPercentage.length != 0) {
                let checkedProduct = $(".tbody > .checked")
                let checkedProductSumPrice = 0;
                let eachSailPrice2 = 0;
                for (let i = 0; i < checkedProduct.length; i++) {
                    checkedProductSumPrice += parseInt(checkedProduct[i].children[3].value)
                    eachSailPrice += parseInt(checkedProduct[i].children[3].value) / 100 * discountPercentage
                    eachSailPrice2 = parseInt(checkedProduct[i].children[3].value) / 100 * discountPercentage
                    if (eachSailPrice != 0) {
                        checkedProduct[i].children[4].value = eachSailPrice
                    }
                }
                let allSailPrice = checkedProductSumPrice / 100 * discountPercentage
                let productsTotalSumPrice = document.querySelector(".amountToPay").innerHTML
                $(".amountToPay").html(productsTotalSumPrice - allSailPrice)
                let discountSumAMount = ${discountSumAMount};
                let disAmount = $(".discountAmount").html()
                if (discountSumAMount == 0) {
                    $(".discountAmount").html(parseInt(disAmount) + eachSailPrice2)
                } else {
                    $(".discountAmount").html(parseInt(disAmount) + eachSailPrice2)
                }
                clearInput();
            }
        }

        // =============== 메뉴 서비스 처리 ====================

        function freeProduct() {
            getProductTotalSumPriceAndTotalQuantity__2(null)
            let checkedProducts = document.querySelectorAll(".tbody > .checked");
            for (let i = 0; i < checkedProducts.length; i++) {
                let checkedProductName = checkedProducts[i].children[1].value;
                let checkedProductSumPrice = checkedProducts[i].children[3];
                let checkedProductSailPrice = checkedProducts[i].children[4];

                if (checkedProductSumPrice.value != 0) {
                    checkedProductSailPrice.value = checkedProductSumPrice.value;
                    checkedProductSumPrice.value = 0;
                    checkedProducts[i].children[1].value = "[S]" + checkedProductName;
                    let disCountAmount = $(".discountAmount").html()
                    $(".discountAmount").html(parseInt(disCountAmount) + parseInt(checkedProductSailPrice.value))
                    getProductTotalSumPriceAndTotalQuantity__2(null)
                } else {
                    checkedProducts[i].children[1].value = checkedProductName.substring(3);
                    checkedProductSumPrice.value = checkedProductSailPrice.value;
                    checkedProductSailPrice.value = 0;
                    let disCountAmount = $(".discountAmount").html()
                    $(".discountAmount").html(parseInt(disCountAmount) - parseInt(checkedProductSumPrice.value))
                    getProductTotalSumPriceAndTotalQuantity__2(null)
                }
            }
        }

    </script>
    <div class="manuPageRight">
        <ul class="productType-box">
            <c:forEach var="productType" items="${productTypes}">
                <li>
                    <button class="">${productType.name}</button>
                </li>
            </c:forEach>
        </ul>
        <ul class="product-box">
            <c:forEach var="product" items="${products}">
                <li id="productItems" onclick="selectMenu(${product.id})"
                    class="flex flex-col justify-center items-center w-full h-full cursor-pointer p-4">
                    <span class="h-3/5" name="productName">${product.name}</span>
                    <span class="text-red-400 pt-2 h-2/5" name="price">${product.price}원</span>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<%@include file="../common/foot.jsp" %>
