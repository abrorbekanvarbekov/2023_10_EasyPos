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
                <button class="btn btn-active btn-sm pl-2" >엑셀</button>
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
                <ul class="productType-list-container productType-list-con-left"></ul>
            </div>
            <div class="productType-main-right">
                <div class="productType-sort-buttons">
                    <button class="btn btn-active btn-xs">맨위로</button>
                    <button class="btn btn-active btn-xs">위로</button>
                    <button class="btn btn-active btn-xs">아래로</button>
                    <button class="btn btn-active btn-xs">맨아래로</button>
                    <button class="btn btn-active btn-xs">순번정렬</button>
                    <span class="material-symbols-outlined btn btn-active btn-xs ml-1 " onclick="openMsgBox12();">add</span>
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
                    <span>판매가</span>
                    <span>권한구분</span>
                    <span>터치키색</span>
                </div>
                <ul class="productType-list-container productType-list-con-right"></ul>
            </div>
        </div>
    </div>
</div>
<div class="product-search-box">
    <div class="pro-search-bg"></div>
    <div class="pro-search-main">
        <div class="">
            <span>상품조회</span>
        </div>
        <div class="productCl-box">
            <div>
                <span>상품분류</span>
                <select id="bigClassification-box" class="select select-bordered select-xs w-full max-w-xs">
                    <option value="allBigClassification">[ 대분류 전체 ]</option>
                </select>
                <select id="middleClassification-box" class="select select-bordered select-xs w-full max-w-xs">
                    <option value="allMiddleClassification">[ 중분류 전체 ]</option>
                </select>
                <select id="smallClassification-box" class="select select-bordered select-xs w-full max-w-xs">
                    <option value="allSmallClassification">[ 소분류 전체 ]</option>
                </select>
                <button class=" btn btn-active btn-sm ">
                    <span class="material-symbols-outlined">search</span>
                    <span>조회</span>
                </button>
            </div>
            <div>
                <span>조회구분</span>
                <select id="searchCategory-box" class="select select-bordered select-xs w-full max-w-xs">
                    <option value="allSmallClassification">상품명</option>
                    <option value="allSmallClassification">상품코드</option>
                </select>
                <input class="product-nameOrCode-input" type="text">
            </div>
        </div>
        <div class="pro-search-product-list-box">
            <div class="">
                <input type="checkbox" disabled>
                <span>소분류</span>
                <span>상품코드</span>
                <span>상품명</span>
                <span>판매가</span>
            </div>
            <ul class="search-pro-list-container">
                <li class="">
                    <span><input type="checkbox"></span>
                    <span></span>
                    <span></span>
                    <span></span>
                    <span></span>
                </li>
            </ul>
        </div>
        <button id="select-btn" value="true" class="btn btn-active btn-sm btn-info confirm-button">선택</button>
        <button id="close-btn" onclick="closeMsgBox();" value="false" class="btn btn-active btn-sm btn-ghost cancel-button">닫기</button>
    </div>
</div>
<script>


    function openMsgBox12() {
        $('.product-search-box').show();
        $('.pro-search-main').show();
        $('.pro-search-bg').show();
    }

    function closeMsgBox() {
        $('.product-search-box').hide();
        $('.pro-search-main').hide();
        $('.pro-search-bg').hide();
    }

    function getProductTypeList() {
        let searchKeyword = $(".touch-classification-name > div > input")[0].value
        $.get("/usr/basic-information/touchKeyManagement/addProductType", {
                searchKeyword: searchKeyword
            },
            function (data) {
                if (data.length != 0) {
                    let productTypeLi = "";
                    $.each(data, (idx, value) => {
                        productTypeLi += `
                            <li class="productType \${idx+1 == 1 ? 'checked' : ''}">
                                <span><input type="checkbox"></span>
                                <span>\${idx + 1}</span>
                                <span>\${value.code}</span>
                                <span>
                                    <input type="text" value="\${value.korName}">
                                </span>
                                <span>
                                    <input type="text" value="\${value.engName}">
                                </span>
                                <span>\${value.authDivision}</span>
                                <span style="background-color: \${value.color}">
                                    <select class="select select-bordered select-sm w-full max-w-xs" style="background-color: \${value.color}">
                                      <option selected>오랜지</option>
                                      <option>연파랑</option>
                                      <option>연녹</option>
                                      <option>핑크</option>
                                      <option>연빨강</option>
                                      <option>살구</option>
                                    </select>
                                </span>
                            </li>
                        `
                    })
                    $(".productType-list-con-left").html(productTypeLi);
                    clickEventForProType("productType-list-con-left");
                } else {
                    let msgBox = `
                        <div class="is-empty-msg">
                            <span>검색하신 정보가 존재하지 않습니다.</span>
                        </div>
                        `
                    $(".productType-list-con-left").html(msgBox);
                }
            }, "json")
    }

    function clickEventForProType(areaName) {
        let listItemLastItem = $(`.\${areaName} .productType.checked`)[0]
        listItemLastItem.style.backgroundColor = "rgb(243, 243, 243)"
        listItemLastItem.style.color = "red"
        listItemLastItem.classList.add("checked")

        $(`.\${areaName} .productType`).each((idx, element) => {
            element.addEventListener("click", function () {
                let lastCheckedEl = document.querySelector(`.\${areaName} .productType.checked`);
                lastCheckedEl.style.backgroundColor = "inherit";
                lastCheckedEl.style.color = "black";
                lastCheckedEl.classList.remove("checked");
                element.style.backgroundColor = "rgb(243, 243, 243)";
                element.style.color = "red";
                element.classList.add("checked");

                areaName == "productType-list-con-left" ? getProductList(element) : "";
            })
        })
    }

    function getProductList(productType) {
        let productTypeId = productType.children[2].textContent;
        $.get("/usr/basic-information/touchKeyManagement/getProducts", {
            productTypeId: productTypeId
        }, function (data) {
            if (data.length != 0) {
                let productLi = "";
                $.each(data, (idx, value) => {
                    let ordinalNum = (idx + 1).toString();
                    productLi += `
                    <li class="productType \${idx+1 == 1 ? 'checked' : ''}">
                        <span><input type="checkbox"></span>
                        <span>\${ordinalNum.padStart(3, "0")}</span>
                        <span>\${value.productCode}</span>
                        <span>\${value.productKorName}</span>
                        <span>\${value.price}</span>
                        <span>매장</span>
                        <span style="background-color: \${value.color}">
                            <select class="select select-bordered select-sm w-full max-w-xs" style="background-color: \${value.color}">
                              <option \${value.color == '오랜지' ? 'selected' : ''}>오랜지</option>
                              <option \${value.color == '연파랑' ? 'selected' : ''}>연파랑</option>
                              <option \${value.color == '연녹' ? 'selected' : ''}>연녹</option>
                              <option \${value.color == '핑크' ? 'selected' : ''}>핑크</option>
                              <option \${value.color == '연빨강' ? 'selected' : ''}>연빨강</option>
                              <option \${value.color == '살구' ? 'selected' : ''}>살구</option>
                            </select>
                        </span>
                    </li>
                    `
                })
                $(".productType-list-con-right").html(productLi);
                clickEventForProType("productType-list-con-right");
            } else {
                let msgBox = `
                        <div class="is-empty-msg">
                            <span>검색하신 정보가 존재하지 않습니다.</span>
                        </div>
                        `
                $(".productType-list-con-right").html(msgBox);
            }
        }, "json")
    }

    function searchProductList() {
        openMsgBox();
    }
</script>