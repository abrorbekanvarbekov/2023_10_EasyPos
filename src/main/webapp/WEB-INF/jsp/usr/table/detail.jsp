<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="List"/>

<%@include file="../common/head.jsp" %>

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
                    <li class="flex product-box-list product-box-list_${status.count}" id="product_${cartItem.id}">
                        <span id="id_${status.count}">${status.count}</span>
                        <span id="product-name_${status.count}"
                              class="productList_${status.count}">${cartItem.name}</span>
                        <span id="product-count_${status.count}"
                              class="productCount_${status.count}">${cartItem.quantity}</span>
                        <span id="product-price_${status.count}"
                              class="productPrice_${status.count}">${cartItem.quantity * cartItem.price}</span>
                        <span id="product-discount_${status.count}">0</span>
                    </li>
                </c:forEach>
            </ul>
        </ul>
        <div class="buttons">
            <button class="btn btn-sm">전체선택</button>
            <button onclick="CancelProduct();" class="btn btn-sm">취소</button>
            <button class="btn btn-sm text-blue-500 text-2l"><span class="material-symbols-outlined">add</span></button>
            <button class="btn btn-sm text-blue-500 text-2l"><span class="material-symbols-outlined">remove</span>
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
                    <span class="ProductTotalQuantity">${totalQuantity}</span>
                </div>
                <div>
                    <span>총매출액</span>
                    <span class="ProductsTotalSumPrice">${totalSumPrice}</span>
                </div>
                <div>
                    <span>할인총액</span>
                    <span>0</span>
                </div>
                <div>
                    <span>받을금액</span>
                    <span>0</span>
                </div>
                <div>
                    <span>받은금액</span>
                    <span>0</span>
                </div>
                <div>
                    <span>거스름돈</span>
                    <span>0</span>
                </div>
                <div>
                    asd
                </div>
            </div>
            <div class="calculator">
                <div class="numberFeed">
                    <input type="text">
                    <div>
                        <span class="btn w-full text-base">Clear</span>
                        <span class="material-symbols-outlined btn text-4xl">arrow_back</span>
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
                    <span class="btn">% 할인</span>
                    <span class="btn">금액변경</span>
                    <span class="btn">수량변경</span>
                    <span class="btn">Enter</span>
                </div>
            </div>
        </div>
    </div>
    <script>
        function getProductTotalSumPriceAndTotalQuantity() {
            $.get("getProductTotalSumPriceAndTotalQuantity", {
                tabId: ${tabId},
                floor: ${floor}
            }, function (data) {
                $(".ProductTotalQuantity").html(data.data1)
                $(".ProductsTotalSumPrice").html(data.data2)
            }, "json")
        }

        function CancelProduct() {
            let checkedProduct = $(".checked")
            let id = checkedProduct[0].id.substring(checkedProduct[0].id.indexOf("_") + 1, checkedProduct[0].id.lastIndex)
            $.get("/usr/tables/detail/cancelProduct", {
                productId: id,
                floor: ${floor},
                tabId: ${tabId}
            }, function (data) {
            }, "json")

            checkedProduct.remove();
            getProductTotalSumPriceAndTotalQuantity();
            document.querySelector("#selectedManuList-1 li:last-child").style.backgroundColor = "aqua"
            document.querySelector("#selectedManuList-1 li:last-child").classList.add("checked")
            getProductTotalSumPriceAndTotalQuantity();
        }

        getProductTotalSumPriceAndTotalQuantity();

        function selectMenu(productId) {

            $.get("/usr/tables/getProduct", {
                id: productId,
                tabId: ${tabId},
                floor: ${floor}
            }, function (data) {
                getProductTotalSumPriceAndTotalQuantity();
                if (data.resultCode == "F-1") {
                    alert(data.msg)
                    return history.back();
                }
                let str = "";
                let index;
                $.each(data.data1, function (idx, value) {
                    index = idx;
                    str += `
                        <li class="flex product-box-list product-box-list_\${idx + 1}" id="product_\${value.id}">
                            <span id="id_\${idx + 1}">\${idx + 1}</span>
                            <span id="product-name_\${idx + 1}" class="productList_\${value.id}">\${value.name}</span>
                            <span id="product-count_\${idx + 1}"
                                  class="productCount_\${idx + 1}">\${value.quantity}</span>
                            <span id="product-price_\${idx + 1}"
                                  class="productPrice_\${idx + 1}">\${value.quantity * value.price}</span>
                            <span id="product-discount_\${idx + 1}">0</span>
                        </li>
                    `
                })
                $(".tbody").empty().html("");
                $(".tbody").html(str);

                if (data.data2 != null) {
                    document.querySelector("#product_" + data.data2.id).style.backgroundColor = "aqua";
                    document.querySelector("#product_" + data.data2.id).classList.add("checked")
                } else {
                    document.querySelector("#selectedManuList-1 li:last-child").style.backgroundColor = "aqua";
                    document.querySelector("#selectedManuList-1 li:last-child").classList.add("checked")
                }
                let product_list_lastChild = document.querySelector("#selectedManuList-1 li:last-child")
                document.querySelectorAll(".product-box-list").forEach((element) => {
                    element.addEventListener("click", (e) => {
                        product_list_lastChild.style.backgroundColor = "inherit";
                        product_list_lastChild.classList.remove("checked")
                        if (data.data2 != null) {
                            document.querySelector("#product_" + data.data2.id).style.backgroundColor = "inherit";
                            document.querySelector("#product_" + data.data2.id).classList.remove("checked")
                        }
                        product_list_lastChild = element
                        let id = e.target.id.substring(e.target.id.indexOf("_") + 1, e.target.id.lastIndex)
                        const el = document.querySelector(".product-box-list_" + id)
                        el.style.backgroundColor = "aqua"
                        el.classList.add("checked")
                    })
                })
            }, "json")
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
