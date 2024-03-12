<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="add-product-page touch-product-reg">
    <div class="product-lookUp-container">
        <div class="product-lookUp-top">
            <div>
                <span class="material-symbols-outlined pr-2 text-red-400">arrow_circle_right</span>
                <span>기초정보관리 > 터치키상품관리 > 터치키상품등록</span>
            </div>
            <div>
                <button class="btn btn-active btn-sm flex flex-row justify-between"
                        onclick="getProductTypeList();">
                    <span class="material-symbols-outlined">search</span>
                    <span>조회</span>
                </button>
                <button class="btn btn-active btn-sm pl-2">저장</button>
                <button class="btn btn-active btn-sm pl-2">삭제</button>
                <button class="btn btn-active btn-sm pl-2">엑셀</button>
            </div>
        </div>
        <div class="touch-classification-name">
            <div>
                <span>터치 분류명</span>
                <input class="touch-ClName-input" type="text">
            </div>
        </div>
        <div class="productType-center-box">
            <div class="productType-main-left">
                <div class="productType-sort-buttons">
                    <button class="btn btn-active btn-xs">맨위로</button>
                    <button class="btn btn-active btn-xs">위로</button>
                    <button class="btn btn-active btn-xs">아래로</button>
                    <button class="btn btn-active btn-xs">맨아래로</button>
                    <button class="btn btn-active btn-xs">순번정렬</button>
                    <button class="btn btn-active btn-xs">소분류+</button>
                    <span class="material-symbols-outlined btn btn-active btn-xs ml-1 ">add</span>
                </div>
                <div class="productType-lookUp-titles">
                    <input type="checkbox" disabled>
                    <span>순번</span>
                    <span>분류코드</span>
                    <span>분류명</span>
                    <span>영문분류명</span>
                    <span>권한구분</span>
                    <span>터치키색</span>
                </div>
                <ul class="productType-list-container">
                    <li class="">
                        <span><input type="checkbox"></span>
                        <span>1</span>
                        <span>001</span>
                        <span>
                            <input type="text">
                        </span>
                        <span>
                            <input type="text">
                        </span>
                        <span>매장</span>
                        <span>
                            <select class="select select-bordered select-sm w-full max-w-xs">
                              <option selected>Small</option>
                              <option>Small Apple</option>
                              <option>Small Orange</option>
                              <option>Small Tomato</option>
                            </select>
                        </span>
                    </li>
                </ul>
            </div>
            <div class="productType-main-right">
                <div class="productType-sort-buttons">
                    <button class="btn btn-active btn-xs">맨위로</button>
                    <button class="btn btn-active btn-xs">위로</button>
                    <button class="btn btn-active btn-xs">아래로</button>
                    <button class="btn btn-active btn-xs">맨아래로</button>
                    <button class="btn btn-active btn-xs">순번정렬</button>
                    <span class="material-symbols-outlined btn btn-active btn-xs ml-1 ">add</span>
                </div>
                <div>
                    <span>순번</span>
                    <span>분류코드</span>
                    <span>분류명</span>
                </div>
                <div class="productType-lookUp-titles">
                    <input type="checkbox" disabled>
                    <span>순번</span>
                    <span>분류코드</span>
                    <span>분류명</span>
                    <span>영문분류명</span>
                    <span>권한구분</span>
                    <span>터치키색</span>
                </div>
                <ul class="productType-list-container">

                </ul>
            </div>
        </div>
    </div>
</div>

<script>

    function getProductTypeList() {
        $.get("/usr/basic-information/touchKeyManagement/addProductType", {},
            function (data) {
                if (data != null) {
                    let productTypeLi = "";
                    $.each(data, (idx, value) => {
                        productTypeLi += `
                            <li class="productType">
                                <span><input type="checkbox"></span>
                                <span>1</span>
                                <span>001</span>
                                <span>
                                    <input type="text">
                                </span>
                                <span>
                                    <input type="text">
                                </span>
                                <span>매장</span>
                                <span>
                                    <select class="select select-bordered select-sm w-full max-w-xs">
                                      <option selected>Small</option>
                                      <option>Small Apple</option>
                                      <option>Small Orange</option>
                                      <option>Small Tomato</option>
                                    </select>
                                </span>
                            </li>
                    `
                    })
                }
            }, "json")
    }
</script>