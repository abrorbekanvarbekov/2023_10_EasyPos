<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="List"/>

<%@include file="../common/head.jsp" %>

<div class="manuPage">
    <div>
        <div class="table-box-type-1">
            <table border="1">
                <thead>
                <tr>
                    <th></th>
                    <th>상품명</th>
                    <th>수량</th>
                    <th>금액</th>
                    <th>할인금액</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="i" begin="1" end="8">
                    <tr class="product-box-list product-box-list_${i}">
                        <td id="${i}">${i}</td>
                        <td class="productList_${i}" id="${i}"></td>
                        <td id="${i}"></td>
                        <td id="${i}"></td>
                        <td id="${i}"></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="buttons">
                <button class="btn">전체선택</button>
                <button class="btn">취소</button>
                <button class="btn text-blue-500 text-2l"><span class="material-symbols-outlined">add</span></button>
                <button class="btn text-blue-500 text-2l"><span class="material-symbols-outlined">remove</span></button>
                <button class="btn text-blue-500 text-2l"><span class="material-symbols-outlined">expand_less</span>
                </button>
                <button class="btn text-blue-500 text-2l"><span class="material-symbols-outlined">expand_more</span>
                </button>
            </div>
        </div>
    </div>
    <script>

        let onclickCount = 0

        function selectMenu(li) {
            onclickCount++
            $.get("/usr/tables/getProduct", {
                id: li
            }, function (data) {
                $(".productList_" + onclickCount).html(data.data1.name)
                console.log(data.data1.name)
            }, "json")
        }

        $(".product-box-list").click( (e) => {

        })
    </script>
    <div>
        <ul class="productType-box">
            <c:forEach var="productType" items="${productTypes}">
                <li onclick="selectMenu(${productType.id });">
                    <button class="">${productType.name}</button>
                </li>
            </c:forEach>
        </ul>
        <ul class="product-box">
            <li>1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
            <li>5</li>
            <li>6</li>
            <li>7</li>
            <li>8</li>
            <li>9</li>
            <li>10</li>
        </ul>
    </div>
</div>
<%@include file="../common/foot.jsp" %>
