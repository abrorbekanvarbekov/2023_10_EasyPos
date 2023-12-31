<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<div class="footerFeed">
    <ul>
        <li class="payByCreditCartBtn">
            <form action="/usr/tables/orderPage/payByCreditCart" method="post" name="do-pay-creditCart-form">
                <input type="hidden" name="AmountToBeReceivedCart" value=""/>
                <input type="hidden" name="CartTotalSailAmount" value=""/>
                <input type="hidden" name="CartTotalAmount" value=""/>
                <input type="hidden" name="CartSplitAmount" value=""/>
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
                <input type="hidden" name="productPrices" value=""/>
                <input type="hidden" name="productNames" value=""/>
                <input type="hidden" name="productSailPrices" value=""/>
                <input type="hidden" name="productIds" value=""/>
                <input type="hidden" name="productCnts" value=""/>
                <input type="hidden" name="delProductIds" value=""/>
                <input type="hidden" name="isPrintControl" value="true"/>
                <input type="hidden" name="floor" value="${param.floor}"/>
                <input type="hidden" name="tabId" value="${param.tabId}"/>
            </form>
            <a class="order-btn">주문</a>
        </li>
    </ul>
</div>

<script>


    $(".payByCreditCartBtn").click(function () {
        let cartItemsList = $(".product-box-list")
        if (cartItemsList.length == 0) {
            $(".payByCreditCartBtn > a").removeAttr("href")
            $(".payByCashBtn > a").removeAttr("href")
        } else {
            let amountToPay = document.querySelector(".amountToPay").innerHTML
            let totalAmount = document.querySelector(".ProductsTotalSumPrice").value
            let splitAmount = document.querySelector(".numberFeed > input").value
            let cartTotalSailAmount = document.querySelector(".discountAmount").innerHTML

            if (parseInt(splitAmount) > parseInt(amountToPay)) {
                $(".order-msg-box > .msg-tag").html("결제할 금액을 확인해주세요!");
            } else {
                $('input[name=AmountToBeReceivedCart]').val(amountToPay)
                $('input[name=CartTotalAmount]').val(totalAmount)
                $('input[name=CartSplitAmount]').val(splitAmount)
                $('input[name=CartTotalSailAmount]').val(cartTotalSailAmount)
                $('form[name=do-pay-creditCart-form]').submit();
            }

        }
    })

    $(".payByCashBtn").click(function () {
        let cartItemsList = $(".product-box-list")
        if (cartItemsList.length == 0) {
            $(".payByCreditCartBtn > a").removeAttr("href")
            $(".payByCashBtn > a").removeAttr("href")
        } else {
            let amountToPay = document.querySelector(".amountToPay").innerHTML
            let totalAmount = document.querySelector(".ProductsTotalSumPrice").value
            let splitAmount = document.querySelector(".numberFeed > input").value.trim()
            let cashTotalSailAmount = document.querySelector(".discountAmount").innerHTML

            if (parseInt(splitAmount) > parseInt(amountToPay)) {
                $(".order-msg-box > .msg-tag").html("결제할 금액을 확인해주세요!");
            }else{
                $('input[name=AmountToBeReceivedCash]').val(amountToPay)
                $('input[name=CashTotalAmount]').val(totalAmount)
                $('input[name=CashSplitAmount]').val(splitAmount)
                $('input[name=CashTotalSailAmount]').val(cashTotalSailAmount)
                $('form[name=do-pay-cash-form]').submit();
            }
        }
    })


    $(".order-btn").click(function () {
        const productIds = $('.product-box-list').map((index, el) => el.id.substring(el.id.indexOf("_") + 1)).toArray();
        const productCnts = $('.product-box-list').map((index, el) => el.children[2].value).toArray();
        const productSailPrices = $('.product-box-list').map((index, el) => el.children[4].value).toArray();
        const productPrices = $('.product-box-list').map((index, el) => el.children[3].value).toArray();
        const productNames = $('.product-box-list').map((index, el) => el.children[1].value).toArray();

        $('input[name=productNames]').val(productNames.join(","))
        $('input[name=productPrices]').val(productPrices.join(","))
        $('input[name=productSailPrices]').val(productSailPrices.join(","))
        $('input[name=productIds]').val(productIds.join(","))
        $('input[name=productCnts]').val(productCnts.join(","))

        $('form[name=do-insert-product-form]').submit();
    })

</script>
</body>
</html>
