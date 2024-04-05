<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="footerFeed">
    <ul>
        <li class="payByCreditCardBtn">
            <form action="/usr/tables/orderPage/payByCreditCard" method="post" name="do-pay-creditCard-form">
                <input type="hidden" name="AmountToBeReceivedCard" value=""/>
                <input type="hidden" name="CardTotalSailAmount" value=""/>
                <input type="hidden" name="CardTotalAmount" value=""/>
                <input type="hidden" name="CardSplitAmount" value=""/>
                <input type="hidden" name="floor" value="${rq.floor}"/>
                <input type="hidden" name="tabId" value="${param.tabId}"/>
            </form>
            <a>카드</a>
        </li>
        <li class="payByCashBtn">
            <form action="/usr/tables/orderPage/payByCash" method="post" name="do-pay-cash-form">
                <input type="hidden" name="AmountToBeReceivedCash" value=""/>
                <input type="hidden" name="CashTotalSailAmount" value=""/>
                <input type="hidden" name="CashTotalAmount" value=""/>
                <input type="hidden" name="CashSplitAmount" value=""/>
                <input type="hidden" name="CashChangeAmount" value=""/>
                <input type="hidden" name="floor" value="${rq.floor}"/>
                <input type="hidden" name="tabId" value="${param.tabId}"/>
            </form>
            <a>현금</a>
        </li>
        <li>
            <a href="">기타 결제</a>
        </li>
        <li>
            <a href="">분할 결제</a>
        </li>
        <li onclick="freeProduct();">
            <a>서비스</a>
        </li>
        <li>
            <a href="">제휴 카드</a>
        </li>
        <li>
            <a href="">주문 안함</a>
        </li>
        <li>
            <a href="">의상</a>
        </li>
        <li>
            <a href="">수표</a>
        </li>
        <li>
            <a href="">쿠폰</a>
        </li>
        <li>
            <a href="">중간 계산서</a>
        </li>
        <li>
            <a href="">포장</a>
        </li>
        <li>
            <form action="/usr/tables/insertProduct" method="post" name="do-insert-product-form">
                <input type="hidden" name="productPricesList" value=""/>
                <input type="hidden" name="productNamesList" value=""/>
                <input type="hidden" name="productSailPriceList" value=""/>
                <input type="hidden" name="productIdList" value=""/>
                <input type="hidden" name="productCntList" value=""/>
                <input type="hidden" name="updateProIdList" value=""/>
                <input type="hidden" name="updateProNameList" value=""/>
                <input type="hidden" name="updateProCntList" value=""/>
                <input type="hidden" name="updateProPriceList" value=""/>
                <input type="hidden" name="updateProSailPriceList" value=""/>
                <input type="hidden" name="delProductList" value=""/>
                <input type="hidden" name="delProductNameList" value=""/>
                <input type="hidden" name="isPrintControl" value="true"/>
                <input type="hidden" name="floor" value="${param.floor}"/>
                <input type="hidden" name="tabId" value="${param.tabId}"/>
            </form>
            <a class="order-btn">주문</a>
        </li>
    </ul>
</div>

<script>


    $(".payByCreditCardBtn").click(function () {
        let cartItemsList = $(".tbody li")
        if (cartItemsList.length == 0) {
            $(".payByCreditCardBtn > a").removeAttr("href")
            $(".payByCashBtn > a").removeAttr("href")
        } else {
            let amountToPay = parseInt(document.querySelector(".amountToPay").innerHTML)
            let totalAmount = parseInt(document.querySelector(".ProductsTotalSumPrice").value)
            let splitAmount = document.querySelector(".numberFeed > input").value
            let cardTotalSailAmount = parseInt(document.querySelector(".discountAmount").innerHTML)


            if (parseInt(splitAmount) == 0) {
                $(".order-msg-box > .msg-tag").html("결제할 금액을 확인해주세요!");
            } else {
                $('input[name=AmountToBeReceivedCard]').val(amountToPay)
                $('input[name=CardTotalAmount]').val(totalAmount)
                $('input[name=CardSplitAmount]').val(splitAmount == "" ? 0 : parseInt(splitAmount))
                $('input[name=CardTotalSailAmount]').val(cardTotalSailAmount)
                // ==========================================================//
                doInsertProduct();
                $('form[name=do-pay-creditCard-form]').submit();
            }

        }
    })
    //  ==================================================================================== //
    $(".payByCashBtn").click(function () {
        let cartItemsList = $(".tbody li")
        if (cartItemsList.length == 0) {
            $(".payByCreditCardBtn > a").removeAttr("href")
            $(".payByCashBtn > a").removeAttr("href")
        } else {
            let amountToPay = parseInt(document.querySelector(".amountToPay").innerHTML);
            let totalAmount = parseInt(document.querySelector(".ProductsTotalSumPrice").value);
            let splitAmount = document.querySelector(".numberFeed > input").value.trim();
            let cashTotalSailAmount = parseInt(document.querySelector(".discountAmount").innerHTML);

            if (parseInt(splitAmount) > amountToPay) {
                // =========== 현금 결제 거름돈이 있을시 ======== //
                $('input[name=AmountToBeReceivedCash]').val(amountToPay);
                $('input[name=CashTotalAmount]').val(totalAmount);
                $('input[name=CashSplitAmount]').val(parseInt(splitAmount));
                $('input[name=CashChangeAmount]').val(parseInt(splitAmount) - amountToPay);
                $('input[name=CashTotalSailAmount]').val(cashTotalSailAmount);
                // ==========================================================//
                doInsertProduct();
                $('form[name=do-pay-cash-form]').submit();
            } else if (parseInt(splitAmount) == 0) {
                $(".order-msg-box > .msg-tag").html("결제할 금액을 확인해주세요!");
            } else {
                // ======== 현금 분할 결제나 현금 전체 결제시 ========//
                $('input[name=AmountToBeReceivedCash]').val(amountToPay);
                $('input[name=CashTotalAmount]').val(totalAmount);
                $('input[name=CashSplitAmount]').val(splitAmount == "" ? 0 : parseInt(splitAmount));
                $('input[name=CashChangeAmount]').val(0);
                $('input[name=CashTotalSailAmount]').val(cashTotalSailAmount);
                // ==========================================================//
                doInsertProduct();
                $('form[name=do-pay-cash-form]').submit();
            }
        }
    })


    $(".order-btn").click(function () {
        const productIds = $('.tbody li.newProduct').map((index, el) => el.id.substring(el.id.indexOf("_") + 1)).toArray();
        const productCnts = $('.tbody li.newProduct').map((index, el) => el.children[2].value).toArray();
        const productSailPrices = $('.tbody li.newProduct').map((index, el) => el.children[4].value).toArray();
        const productPrices = $('.tbody li.newProduct').map((index, el) => el.children[3].value).toArray();
        const productNames = $('.tbody li.newProduct').map((index, el) => el.children[1].value).toArray();

        const updateProductIds = $('.tbody li.updateProduct').map((index, el) => el.id.substring(el.id.indexOf("_") + 1)).toArray();
        const updateProductNames = $('.tbody li.updateProduct').map((index, el) => el.children[1].value).toArray();
        const updateProductCnts = $('.tbody li.updateProduct').map((index, el) => el.children[2].value).toArray();
        const updateProductPrices = $('.tbody li.updateProduct').map((index, el) => el.children[3].value).toArray();
        const updateProductSailPrices = $('.tbody li.updateProduct').map((index, el) => el.children[4].value).toArray();

        $('input[name=productIdList]').val(productIds.join(","))
        $('input[name=productCntList]').val(productCnts.join(","))
        $('input[name=productSailPriceList]').val(productSailPrices.join(","))
        $('input[name=productPricesList]').val(productPrices.join(","))
        $('input[name=productNamesList]').val(productNames.join(","))

        $('input[name=updateProIdList]').val(updateProductIds.join(","))
        $('input[name=updateProNameList]').val(updateProductNames.join(","))
        $('input[name=updateProCntList]').val(updateProductCnts.join(","))
        $('input[name=updateProPriceList]').val(updateProductPrices.join(","))
        $('input[name=updateProSailPriceList]').val(updateProductSailPrices.join(","))

        $('form[name=do-insert-product-form]').submit();
    })

    function doInsertProduct() {
        let result = false;
        $.get("/usr/tables/orderPage/isExistCartItem", {
            floor:${rq.floor},
            tabId:${param.tabId}
        }, function (data) {
            let isExistCartItem = data.dataName

            if (isExistCartItem !== "true") {
                const productIds = $('.tbody li.newProduct').map((index, el) => el.id.substring(el.id.indexOf("_") + 1)).toArray();
                const productCnts = $('.tbody li.newProduct').map((index, el) => el.children[2].value).toArray();
                const productSailPrices = $('.tbody li.newProduct').map((index, el) => el.children[4].value).toArray();
                const productPrices = $('.tbody li.newProduct').map((index, el) => el.children[3].value).toArray();
                const productNames = $('.tbody li.newProduct').map((index, el) => el.children[1].value).toArray();

                $.ajax({
                    url: "/usr/tables/insertProduct",
                    data: {
                        productIdList: productIds.join(","),
                        productCntList: productCnts.join(","),
                        productSailPriceList: productSailPrices.join(","),
                        productPricesList: productPrices.join(","),
                        productNamesList: productNames.join(","),
                        floor: ${rq.floor},
                        tabId: ${param.tabId},
                        isPrintControl: "true"
                    },
                    method: "POST",
                    success: function (data) {
                    },
                    error: function (request, status, error) {

                    },
                    complete: function () {

                    }
                })
            }

        }, "json")

        return result;
    }

</script>
</body>
</html>
