<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="add-product-page">
    <div class="product-lookUp-container">
        <div class="product-lookUp-top">
            <div>
                <span class="material-symbols-outlined pr-2 text-red-400">arrow_circle_right</span>
                <span>기초정보관리 > 상품관리 > 상품등록</span>
            </div>
            <div>
                <button class=" btn btn-active btn-sm flex flex-row justify-between" onclick="productSearchBtn('product-reg-page', 'product-list-reg');">
                    <span class="material-symbols-outlined">search</span>
                    <span>조회</span>
                </button>
                <button class="btn btn-active btn-sm pl-2">저장</button>
                <button class="btn btn-active btn-sm pl-2">삭제</button>
                <button class="btn btn-active btn-sm pl-2">엑셀</button>
            </div>
        </div>
        <div class="product-lookUp-middle product-reg-page" >
            <div>
                <span>상품분류</span>
                <select id="bigClassification-box" class="select select-bordered select-sm w-full max-w-xs">
                    <option value="allBigClassification">[ 대분류 전체 ]</option>
                </select>
                <select id="middleClassification-box" class="select select-bordered select-sm w-full max-w-xs">
                    <option value="allMiddleClassification">[ 중분류 전체 ]</option>
                </select>
                <select id="smallClassification-box" class="select select-bordered select-sm w-full max-w-xs">
                    <option value="allSmallClassification">[ 소분류 전체 ]</option>
                </select>
            </div>
            <div>
                <span>조회구분</span>
                <select id="searchCategory-box" class="select select-bordered select-sm w-full max-w-xs">
                    <option value="allSmallClassification">상품명</option>
                    <option value="allSmallClassification">상품코드</option>
                </select>
                <input class="product-nameOrCode-input" type="text">
                <span>사용구분</span>
                <select class="select select-bordered select-sm w-full max-w-xs">
                    <option value="allSmallClassification">[ 전체 ]</option>
                </select>
            </div>
        </div>
        <div class="remove-add-btn">
            <span class="material-symbols-outlined btn btn-active btn-xs h-full ">add</span>
            <span class="material-symbols-outlined btn btn-active btn-xs h-full ml-1">remove</span>
        </div>
        <div class="product-lookUp-bottom">
            <div class="product-lookUp-titles">
                <input type="checkbox" disabled>
                <span>No</span>
                <span>상품코드</span>
                <span>대분류명</span>
                <span>중분류명</span>
                <span>소분류명</span>
                <span>상품명</span>
                <span>영문상품명</span>
                <span>판매가</span>
                <span>원가</span>
                <span>만지율</span>
            </div>
            <ul class="product-list-container product-list-reg">
                <c:forEach begin="1" end="16" varStatus="listIdx">
                    <li class="productList" id="listItem_${listIdx.index}">
                        <span><input type="checkbox"></span>
                        <span>${listIdx.index}</span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="product-add-container">
            <div class="product-reg-page">
                <div>
                    <span>대분류명</span>
                    <select id="basic-i-bigC" class="select select-bordered select-sm w-full max-w-xs">
                    </select>
                    <select id="basic-i-middleC" class="select select-bordered select-sm w-full max-w-xs">
                    </select>
                    <select id="basic-i-smallC" class="select select-bordered select-sm w-full max-w-xs">
                    </select>
                    <span>상품구분</span>
                    <select class="select select-bordered select-sm w-full max-w-xs"></select>
                </div>
                <div>
                    <span>상품명</span>
                    <input type="text" id="basic-i-productKorName">
                    <span>상품영문명</span>
                    <input type="text" id="basic-i-productEngName">
                </div>
                <div>
                    <span>판매가</span>
                    <input type="text" id="basic-i-productPrice">
                    <span>원가</span>
                    <input type="text" id="basic-i-productCostPrice">
                </div>
            </div>
        </div>
        <div class="product-add-container-curtain"></div>
    </div>
</div>

<script>

</script>