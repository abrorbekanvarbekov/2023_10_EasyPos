<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageName" value="매출요약"/>
<c:set var="pageTitle" value="매출요약"/>
<c:set var="pageTitle" value="매출요약"/>

<%@include file="../common/PayCashTotalSalesHead.jsp" %>

<div class="totalSales-container">
    <div>
        <span>영업일자</span>
        <div>
            <span>${todayDate}</span>
            <form action="" method="get" name="selected-floor-form">
                <select data-value="${floor}" id="floor-select-box" name="floor"
                        class="select select-bordered select-sm ">
                    <option value="전체">전체</option>
                    <option value="1층">1층</option>
                    <option value="2층">2층</option>
                    <option value="3층">3층</option>
                </select>
            </form>
        </div>
    </div>
    <div>
        <div>
            <span>총매출액</span>
            <span>${payedTotalAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
            <span>영수건수</span>
            <span>${payedCartCnt + payedCashCnt}</span>
        </div>
        <div>
            <span>현금매출</span>
            <span>${payedCashSumAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")} [${payedCashCnt}건]</span>
            <span>반품금액</span>
            <span>0</span>
        </div>
        <div>
            <span>반품건수</span>
            <span>${numberOfReturns}</span>
            <span>카드매출</span>
            <span>${payedCartSumAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")} [${payedCartCnt}건]</span>
        </div>
        <div>
            <span>할인금액</span>
            <span>${payedTotalDiscountAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
            <span>봉사료액</span>
            <span>0</span>
        </div>
        <div>
            <span>상품권매출</span>
            <span>0</span>
            <span>부가세액</span>
            <span>${VAT_Amount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
        </div>
        <div>
            <span>현금시재</span>
            <span>${payedCashSumAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
            <span>기타매출</span>
            <span>0</span>
        </div>
        <div>
            <span>순매출액</span>
            <span>${payedTotalAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
            <span>고객수</span>
            <span>${payedCartCnt + payedCashCnt}</span>
        </div>
    </div>
    <div>
        <div>
            <span>전체주문금액</span>
            <span>${outstandingAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
            <span>미결제테이블금액</span>
            <span>${outstandingAmount.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
        </div>
        <div>
            <span>미결제배달금액</span>
            <span>0</span>
            <span>예상매출</span>
            <span>${expectedSales.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ",")}</span>
        </div>
        <div>
            <span>주문고개수</span>
            <span>0</span>
        </div>
        <div class="flex justify-end pt-6 pr-8">
            <button class="btn btn-info w-24">인쇄</button>
        </div>
    </div>
</div>

<script>

    $("#floor-select-box").change(function (el) {
        let valueSelect = document.querySelector("#floor-select-box");
        let floor = valueSelect.options[valueSelect.selectedIndex].value;
        $('form[name=selected-floor-form]').submit();
    })

    $('select[data-value]').each(function (index, item) {
        const items = $(item)
        const defaultValue = items.attr('data-value').trim();
        if (defaultValue.length > 0) {
            items.val(defaultValue);
        }
    })
</script>

<%@include file="../common/footer.jsp"%>