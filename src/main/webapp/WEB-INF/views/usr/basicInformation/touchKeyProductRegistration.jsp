<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="touch-product-reg">
    <div class="touch-product-reg-container">
        <div class="touch-product-reg-top">
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
                <button onclick="saveChanges();" class="btn btn-active btn-sm pl-2">저장</button>
                <button onclick="delProductTypeAndProduct2();" class="btn btn-active btn-sm pl-2">삭제</button>
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
                    <button class="btn btn-active btn-xs" onclick="moveToTop('productType-list-con-left')">맨위로</button>
                    <button class="btn btn-active btn-xs" onclick="moveUp('productType-list-con-left');">위로</button>
                    <button class="btn btn-active btn-xs" onclick="moveDown('productType-list-con-left');">아래로</button>
                    <button class="btn btn-active btn-xs" onclick="moveToBottom('productType-list-con-left')">맨아래로
                    </button>
                    <button class="btn btn-active btn-xs" onclick="sortList('productType-list-con-left')">순번정렬</button>
                    <span onclick="addProductTypeLi();"
                          class="material-symbols-outlined btn btn-active btn-xs ml-1 ">add</span>
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
                <div class="product-type-container">
                    <ul class="proTypeNumAndCode"></ul>
                    <ul class="productType-list-container productType-list-con-left"></ul>
                </div>
            </div>
            <div class="productType-main-right">
                <div class="productType-sort-buttons">
                    <button class="btn btn-active btn-xs" onclick="moveToTop('productType-list-con-right')">맨위로</button>
                    <button class="btn btn-active btn-xs" onclick="moveUp('productType-list-con-right')">위로</button>
                    <button class="btn btn-active btn-xs" onclick="moveDown('productType-list-con-right')">아래로</button>
                    <button class="btn btn-active btn-xs" onclick="moveToBottom('productType-list-con-right')">맨아래로
                    </button>
                    <button class="btn btn-active btn-xs" onclick="sortList('productType-list-con-right')">순번정렬</button>
                    <span class="material-symbols-outlined btn btn-active btn-xs ml-1 "
                          onclick="openMsgBox();">add</span>
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
                <div class="product-container">
                    <ul class="productNumAndCode"></ul>
                    <ul class="productType-list-container productType-list-con-right"></ul>
                </div>
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
                <button onclick="getProductByProType();" class=" btn btn-active btn-sm ">
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
                <span>바코드</span>
            </div>
            <ul class="search-pro-list-container"></ul>
        </div>
        <button id="select-btn" onclick="selectProduct();" value="true"
                class="btn btn-active btn-sm btn-info confirm-button">선택
        </button>
        <button id="close-btn" onclick="closeMsgBox();" value="false"
                class="btn btn-active btn-sm btn-ghost cancel-button">닫기
        </button>
    </div>
</div>

<script>
    <%--  productMovement  --%>
    let isUpdate = false;

    function moveUp(areaName) {
        isUpdate = true;
        let list = document.querySelector(`.\${areaName}`);
        let selectedItem = list.querySelector('.checked');
        if (selectedItem && selectedItem.previousElementSibling) {
            let previousItem = selectedItem.previousElementSibling;
            list.insertBefore(selectedItem, previousItem);
        }
    }

    function moveDown(areaName) {
        isUpdate = true;
        let list = document.querySelector(`.\${areaName}`);
        let selectedItem = list.querySelector('.checked');
        if (selectedItem && selectedItem.nextElementSibling) {
            let nextItem = selectedItem.nextElementSibling.nextElementSibling;
            list.insertBefore(selectedItem, nextItem);
        }
    }

    function moveToTop(areaName) {
        isUpdate = true;
        let list = document.querySelector(`.\${areaName}`);
        let selectedItem = list.querySelector('.checked');
        if (selectedItem) {
            list.insertBefore(selectedItem, list.firstElementChild);
        }
    }

    function moveToBottom(areaName) {
        isUpdate = true;
        let list = document.querySelector(`.\${areaName}`);
        let selectedItem = list.querySelector('.checked');
        if (selectedItem) {
            list.appendChild(selectedItem);
        }
    }

    function sortList(areaName) {
        isUpdate = true;
        let list = document.querySelector(`.\${areaName}`);
        let items = list.getElementsByTagName("li");
        let sortedItems = Array.from(items).sort(function (a, b) {
            return a.textContent.localeCompare(b.textContent);
        });
        sortedItems.forEach(function (item) {
            list.appendChild(item);
        });
    }


    function getProductTypeList() {
        $(".productType-list-container").css("display", "flex");
        $(".proTypeNumAndCode").css("display", "flex");

        let searchKeyword = $(".touch-classification-name > div > input")[0].value
        $.get("/usr/basic-information/touchKeyManagement/getProductType", {
                searchKeyword: searchKeyword
            },
            function (data) {
                if (data.length != 0) {
                    let proTypeNumAndCode = "";
                    let proTypeList = "";
                    $.each(data, (idx, value) => {
                        proTypeNumAndCode += `
                            <li id="\${idx}">
                                <span><input type="checkbox" id="product-type-checkbox" value="\${value.id}"></span>
                                <span>\${idx + 1}</span>
                            </li>
                        `
                        proTypeList += `
                            <li class="productType \${idx+1 == 1 ? 'checked' : ''}" id="proTypeList_\${value.code}" sequenceNum="\${idx}">
                                <span>\${value.code}</span>
                                <span>
                                    <input id="proTypeKorName_\${value.code}" type="text" value="\${value.korName}"
                                            onclick="mine()" onchange="updateProductType(this.id)">
                                </span>
                                <span>
                                    <input id="proTypeEngName_\${value.code}" type="text" value="\${value.engName}"
                                            onclick="mine()" onchange="updateProductType(this.id)">
                                </span>
                                <span>\${value.authDivision}</span>
                                <span style="background-color: \${value.color}">
                                    <select id="proTypeColorBox_\${value.code}" onchange="updateProductType(this.id)"
                                        class="select select-bordered select-sm w-full max-w-xs" style="background-color: \${value.color}">
                                      <option value="darkorange" \${value.color == 'orange' ? 'selected' : ''}>오랜지</option>
                                      <option value="deepskyblue" \${value.color == 'lightblue' ? 'selected' : ''}>연파랑</option>
                                      <option value="lightgreen" \${value.color == 'lightgreen' ? 'selected' : ''}>연녹</option>
                                      <option value="lightpink" \${value.color == 'lightpink' ? 'selected' : ''}>핑크</option>
                                      <option value="orangered" \${value.color == 'orangered' ? 'selected' : ''}>연빨강</option>
                                      <option value="salmon" \${value.color == 'salmon' ? 'selected' : ''}>살구</option>
                                      <option value="yellow" \${value.color == 'yellow' ? 'selected' : ''}>연노랑</option>
                                    </select>
                                </span>
                            </li>
                        `
                    })

                    $(".proTypeNumAndCode").html(proTypeNumAndCode);
                    $(".productType-list-con-left").html(proTypeList);
                    clickEventForProType("productType-list-con-left", "productType");
                } else {
                    let msgBox = `
                        <div class="is-empty-msg">
                            <span>검색하신 정보가 존재하지 않습니다.</span>
                        </div>
                        `
                    $(".proTypeNumAndCode").empty();
                    $(".productType-list-con-left").html(msgBox);
                    $(".productType-list-con-right").html(msgBox);
                }
            }, "json")
    }

    function addProductTypeLi() {
        let display = $(".productType-main-left div:nth-child(3) > .productType-list-con-left").css("display");
        $(".productType-main-left div:nth-child(3) > .proTypeNumAndCode").css("display");
        let productTypeLen = $(".productType-list-con-left li").length

        if (display == "flex") {
            let proTypeNumAndCode = `
                <li >
                    <span><input type="checkbox"></span>
                    <span>\${productTypeLen + 1}</span>
                </li>
            `

            let proTypeList = `
                <li class="productType newProType" sequenceNum="\${productTypeLen}">
                    <span></span>
                    <span>
                        <input type="text">
                    </span>
                    <span>
                        <input type="text">
                    </span>
                    <span>매장</span>
                    <span style="background-color: orange">
                        <select id="new-productType-color-box" class="select select-bordered select-sm w-full max-w-xs" style="background-color: orange">
                          <option value="orange" selected>오랜지</option>
                          <option value="lightblue">연파랑</option>
                          <option value="lightgreen">연녹</option>
                          <option value="lightpink">핑크</option>
                          <option value="orangered">연빨강</option>
                          <option value="salmon">살구</option>
                        </select>
                    </span>
                </li>
             `
            if (productTypeLen != 0) {
                $(".proTypeNumAndCode").append(proTypeNumAndCode);
                $(".productType-list-con-left").append(proTypeList);
            } else {
                $(".proTypeNumAndCode").html(proTypeNumAndCode);
                $(".productType-list-con-left").html(proTypeList);
            }
        } else if (display == "block") {
            alert("조회 후 추가하세요.");
        }
    }

    function updateProductType(el) {
        if (el) {
            let listId = "#proTypeList_".concat(el.substring(el.indexOf("_") + 1));
            let listLi = document.querySelector(listId);
            listLi.classList.add("update-proType-item");
        }
    }

    function getProductList(productType) {
        $(".productNumAndCode").css("display", "flex");
        let productTypeCode = productType.id.substring(productType.id.indexOf("_") + 1);

        $.get("/usr/basic-information/touchKeyManagement/getProducts", {
            productTypeCode: productTypeCode
        }, function (data) {
            if (data.length != 0) {
                let productNumAndCode = "";
                let productList = "";
                $.each(data, (idx, value) => {
                    let ordinalNum = (idx + 1).toString();
                    productNumAndCode += `
                        <li id="\${idx}">
                            <span><input type="checkbox" id="product-checkbox"  value="\${value.productCode}"></span>
                            <span>\${ordinalNum.padStart(3, "0")}</span>
                        </li>
                        `
                    productList += `
                        <li class="product \${idx+1 == 1 ? 'checked' : ''}" id="product_\${value.productCode}" sequenceNum="\${ordinalNum.padStart(3, '0')}">
                            <span>\${value.productCode}</span>
                            <span>\${value.productKorName}</span>
                            <span>\${value.price}</span>
                            <span>매장</span>
                            <span style="background-color: \${value.color}">
                                <select id="productColorBox_\${value.productCode}" class="select select-bordered select-sm w-full max-w-xs"
                                    style="background-color: \${value.color}" onchange="updateProduct(this.id)">
                                  <option value="darkorange" \${value.color == 'orange' ? 'selected' : ''}>오랜지</option>
                                  <option value="deepskyblue" \${value.color == 'lightblue' ? 'selected' : ''}>연파랑</option>
                                  <option value="lightgreen" \${value.color == 'lightgreen' ? 'selected' : ''}>연녹</option>
                                  <option value="lightpink" \${value.color == 'lightpink' ? 'selected' : ''}>핑크</option>
                                  <option value="orangered" \${value.color == 'orangered' ? 'selected' : ''}>연빨강</option>
                                  <option value="salmon" \${value.color == 'salmon' ? 'selected' : ''}>살구</option>
                                  <option value="yellow" \${value.color == 'yellow' ? 'selected' : ''}>연노랑</option>
                                </select>
                            </span>
                        </li>
                    `
                })

                $(".productNumAndCode").html(productNumAndCode);
                $(".productType-list-con-right").html(productList);
                clickEventForProType("productType-list-con-right", "product");
            } else {
                let msgBox = `
                        <div class="is-empty-msg">
                            <div>검색하신 정보가 존재하지 않습니다.</div>
                        </div>
                        `
                $(".productNumAndCode").empty();
                $(".productNumAndCode").css("display", "flex");
                $(".productType-list-con-right").html(msgBox);
            }
        }, "json")
    }

    function updateProduct(el) {
        if (el) {
            let listId = "#product_".concat(el.substring(el.indexOf("_") + 1));
            let selectedLi = document.querySelector(listId);
            selectedLi.classList.add("update-pro-item");
        }
    }

    function clickEventForProType(areaName, elName) {
        let listItemLastItem = $(`.\${areaName} .\${elName}.checked`)[0]
        listItemLastItem.style.backgroundColor = "rgb(243, 243, 243)"
        listItemLastItem.style.color = "red"
        listItemLastItem.classList.add("checked")

        $(`.\${areaName} .\${elName}`).each((idx, element) => {
            element.addEventListener("click", function () {
                let lastCheckedEl = document.querySelector(`.\${areaName} .\${elName}.checked`);
                lastCheckedEl.style.backgroundColor = "inherit";
                lastCheckedEl.style.color = "black";
                lastCheckedEl.classList.remove("checked");
                lastCheckedEl.classList.remove("selected");

                element.style.backgroundColor = "rgb(243, 243, 243)";
                element.style.color = "red";
                element.classList.add("checked");
                element.classList.add("selected");
                areaName == "productType-list-con-left" ? getProductList(element) : "";
            })
        })
    }

    function clickEventForSearchProList(areaName, elName) {
        let listItemLastItem = $(`.\${areaName} .\${elName}.checked`)[0]
        listItemLastItem.style.backgroundColor = "rgb(243, 243, 243)"
        listItemLastItem.style.color = "red"
        listItemLastItem.classList.add("checked")

        $(`.\${areaName} .\${elName}`).each((idx, element) => {
            element.addEventListener("click", function () {
                let lastCheckedEl = document.querySelector(`.\${areaName} .\${elName}.checked`);
                lastCheckedEl.style.backgroundColor = "inherit";
                lastCheckedEl.style.color = "black";
                lastCheckedEl.classList.remove("checked");
                lastCheckedEl.classList.remove("selected");

                element.style.backgroundColor = "rgb(243, 243, 243)";
                element.style.color = "red";
                element.classList.add("checked");
                element.classList.add("selected");
                areaName == "productType-list-con-left" ? getProductList(element) : "";
            })
        })
    }

    function saveChanges() {
        let newProTypeLen = $(".productType-list-con-left > .newProType").length;
        let updateProTypeLen = $(".productType-list-con-left > li.update-proType-item").length;
        let updateProLen = $(".productType-list-con-right > .update-pro-item").length;

        if (newProTypeLen == 0 && updateProTypeLen == 0 && updateProLen == 0 && isUpdate == false) {
            alert("터치키은(는) 변경된 사항이 없습니다.");
            return;
        }

        // ============================================ //
        let proTypeNumAndCode = $(".proTypeNumAndCode");
        let proTypeNumAndCodeLiIdxList = [];
        let proTypeProCodeList = [];

        $(".productType-list-con-left li").each((idx, el) => {
            const proNumAndCodeLiIdx = proTypeNumAndCode[0].children[idx].id;
            const productProCode = el.id.substring(el.id.indexOf("_") + 1);
            proNumAndCodeLiIdx != "" ? proTypeNumAndCodeLiIdxList.push(proNumAndCodeLiIdx) : "";
            productProCode != "" ? proTypeProCodeList.push(productProCode) : "";
        })

        if (proTypeNumAndCodeLiIdxList.length != 0) {
            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/updateProTypeSequenceNum",
                method: "POST",
                data: {
                    proTypeCodeList: proTypeProCodeList.join(","),
                    proTypeSequenceNumLIst: proTypeNumAndCodeLiIdxList.join(",")
                },
                success: function (data) {
                    getProductTypeList();
                },
                error: function (request, status, error) {
                    getProductTypeList();
                },
                complete: function () {
                    getProductTypeList();
                }
            })
        }

        // ============================================ //
        let productNumAndCode = $(".productNumAndCode");
        let proNumAndCodeLiIdxList = [];
        let productProCodeList = [];

        $(".productType-list-con-right li").each((idx, el) => {
            const proNumAndCodeLiId = productNumAndCode[0].children[idx].id;
            const productProCode = el.id.substring(el.id.indexOf("_") + 1);
            proNumAndCodeLiIdxList.push(proNumAndCodeLiId);
            productProCodeList.push(productProCode);
        })

        if (proNumAndCodeLiIdxList.length != 0) {
            let selectProTypeItem = $(".productType-list-con-left li.checked ")[0];
            let selectProTypeCode = selectProTypeItem.id.substring(selectProTypeItem.id.indexOf("_") + 1);
            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/updateProductsSequenceNum",
                method: "POST",
                data: {
                    productProCodeList: productProCodeList.join(","),
                    proSequenceNumLIst: proNumAndCodeLiIdxList.join(","),
                    selectProTypeCode: selectProTypeCode
                },
                success: function (data) {
                    getProductList(selectProTypeItem);
                },
                error: function (request, status, error) {
                    getProductList(selectProTypeItem);
                },
                complete: function () {
                    getProductList(selectProTypeItem);
                }
            })
        }

        // ============================================ //
        if (newProTypeLen != 0) {
            let newProTypeSequenceNumList = [];
            let newProTypeKorNameList = [];
            let newProTypeEngNameList = [];
            let newProTypeColorList = [];

            $(".productType-list-con-left > .newProType").each((idx, el) => {
                const newProTypeSequenceNum = el.getAttribute("sequenceNum");
                newProTypeSequenceNumList.push(newProTypeSequenceNum);
                const newProTypeKorName = el.children[1].children[0].value;
                newProTypeKorNameList.push(newProTypeKorName);
                const newProTypeEngName = el.children[2].children[0].value;
                newProTypeEngNameList.push(newProTypeEngName);
                const newProTypeColorBox = el.children[4].children[0];
                const newProTypeColor = newProTypeColorBox.options[newProTypeColorBox.selectedIndex].value;
                newProTypeColorList.push(newProTypeColor);
            })

            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/addProductTypes",
                data: {
                    newProTypeSequenceNumList: newProTypeSequenceNumList.join(","),
                    productTypeKorNameList: newProTypeKorNameList.join(","),
                    productTypeEngNameList: newProTypeEngNameList.join(","),
                    productTypeColorList: newProTypeColorList.join(",")
                },
                method: "POST",
                success: function (data) {
                    alert("정상적으로 처리 되었습니다.");
                    getProductTypeList();
                },
                error: function (request, status, error,) {
                    alert("정상적으로 처리 되지 않았습니다.\n 다시 시도해보세요.");
                    getProductTypeList();
                },
                complete: function () {
                    getProductTypeList();
                }
            })
        }

        // ============================================ //
        if (updateProTypeLen != 0) {
            let updateProductTypeCodeList = [];
            let updateProTypeSequenceNumList = [];
            let updateProTypeKorNameList = [];
            let updateProTypeEngNameList = [];
            let updateProTypeColorList = [];

            $(".productType-list-con-left > li.update-proType-item").each((idx, el) => {
                const updateProTypeCode = el.id.substring(el.id.indexOf("_") + 1);
                updateProductTypeCodeList.push(updateProTypeCode);
                const updateProTypeSequenceNum = el.getAttribute("sequenceNum");
                updateProTypeSequenceNumList.push(updateProTypeSequenceNum);
                const updateProTypeKorName = el.children[1].children[0].value;
                updateProTypeKorNameList.push(updateProTypeKorName);
                const updateProTypeEngName = el.children[2].children[0].value;
                updateProTypeEngNameList.push(updateProTypeEngName);
                const updateProTypeColorBox = el.children[4].children[0];
                const updateProTypeColor = updateProTypeColorBox.options[updateProTypeColorBox.selectedIndex].value;
                updateProTypeColorList.push(updateProTypeColor);
            })

            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/updateProductTypes",
                data: {
                    updateProductTypeCodeList: updateProductTypeCodeList.join(","),
                    updateProTypeSequenceNumList: updateProTypeSequenceNumList.join(","),
                    updateProTypeKorNameList: updateProTypeKorNameList.join(","),
                    updateProTypeEngNameList: updateProTypeEngNameList.join(","),
                    updateProTypeColorList: updateProTypeColorList.join(",")
                },
                method: "POST",
                success: function (data) {
                    alert("정상적으로 처리 되었습니다.");
                    getProductTypeList();
                },
                error: function (request, status, error,) {
                    alert("정상적으로 처리 되지 않았습니다.\n 다시 시도해보세요.");
                    getProductTypeList();
                },
                complete: function () {
                    getProductTypeList();
                }
            })
        }

        // ============================================ //
        if (updateProLen != 0) {
            let selectProTypeItem = $(".productType-list-con-left li.checked ")[0];
            let selectProTypeCode = selectProTypeItem.id.substring(selectProTypeItem.id.indexOf("_") + 1);
            let updateProSequenceNumList = [];
            let updateProductCodeList = [];
            let updateProductColorList = [];

            $(".productType-list-con-right > li.update-pro-item").each((idx, el) => {
                const updateProductCode = el.id.substring(el.id.indexOf("_") + 1);
                updateProductCodeList.push(updateProductCode);
                const updateProSequenceNum = el.getAttribute("sequenceNum");
                updateProSequenceNumList.push(updateProSequenceNum);
                const updateProColorBox = el.children[4].children[0];
                const updateProColor = updateProColorBox.options[updateProColorBox.selectedIndex].value;
                updateProductColorList.push(updateProColor);
            })

            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/updateProducts",
                data: {
                    updateProductCodeList: updateProductCodeList.join(","),
                    updateProSequenceNumList: updateProSequenceNumList.join(","),
                    updateProductColorList: updateProductColorList.join(","),
                    selectProTypeCode: selectProTypeCode
                },
                method: "POST",
                success: function (data) {
                    alert("정상적으로 처리 되었습니다.");
                    getProductList(selectProTypeItem);
                },
                error: function (request, status, error,) {
                    alert("정상적으로 처리 되지 않았습니다.\n 다시 시도해보세요.");
                    getProductList(selectProTypeItem);
                },
                complete: function () {
                    getProductList(selectProTypeItem);
                }
            })
        }
    }

    function delProductTypeAndProduct2() {
        const delProTypeIdList = $('#product-type-checkbox:checked').map((index, el) => el.value).toArray();
        const delProductCodeList = $('#product-checkbox:checked').map((index, el) => el.value).toArray();
        if (delProTypeIdList != 0) {
            let result = confirm("정말 삭제하시겠습니까?")
            if (result == true) {
                $.ajax({
                    url: "/usr/basic-information/touchKeyManagement/delProductTypes",
                    data: {
                        delProTypeIdList: delProTypeIdList.join(",")
                    },
                    method: "POST",
                    success: function (data) {
                        alert("정상적으로 처리 되었습니다.");
                        getProductTypeList();
                    },
                    error: function (request, status, error) {
                        alert("정상적으로 처리 되지 않았습니다. \n 다시 시도해보세요.");
                        getProductTypeList();
                    },
                    complete: function () {
                        getProductTypeList();
                    }
                })
            }
        }

        if (delProductCodeList != 0) {
            let selectProTypeItem = $(".productType-list-con-left .productType.selected ")[0];
            let productTypeCode = selectProTypeItem.id.substring(selectProTypeItem.id.indexOf("_") + 1);

            let result = confirm("정말 삭제하시겠습니까?")
            if (result == true) {
                $.ajax({
                    url: "/usr/basic-information/touchKeyManagement/delTypeForProducts",
                    data: {
                        delProductCodeList: delProductCodeList.join(","),
                        productTypeCode: productTypeCode
                    },
                    method: "POST",
                    success: function (data) {
                        alert("정상적으로 처리 되었습니다.");
                        getProductList(selectProTypeItem);
                    },
                    error: function (request, status, error) {
                        alert("정상적으로 처리 되지 않았습니다. \n 다시 시도해보세요.");
                        getProductList(selectProTypeItem);
                    },
                    complete: function () {
                        getProductList(selectProTypeItem);
                    }
                })
            }
        }
    }

    function openMsgBox() {
        let selectedProTypeLen = $(".productType.selected").length
        if (selectedProTypeLen != 0) {
            $('.product-search-box').show();
            $('.pro-search-main').show();
            $('.pro-search-bg').show();

        } else if (selectedProTypeLen == 0) {
            alert("상품을 추가할 분류정보를 선택하세요. \n(신규 분류일 경우 저장 후 상품추가.)")
        }
    }

    function closeMsgBox() {
        $('.product-search-box').hide();
        $('.pro-search-main').hide();
        $('.pro-search-bg').hide();

        $('.search-pro-list-container').css("display", "none");
    }

    function getProductByProType() {
        let bigClassificationSelect = document.querySelector(`.productCl-box div > #bigClassification-box`);
        let middleClassificationSelect = document.querySelector(`.productCl-box div > #middleClassification-box`);
        let smallClassificationSelect = document.querySelector(`.productCl-box div > #smallClassification-box`);
        let searchCategorySelect = document.querySelector(`.productCl-box div > #searchCategory-box`);
        let bigClassificationCode = bigClassificationSelect.options[bigClassificationSelect.selectedIndex].value
        let middleClassificationCode = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].value;
        let smallClassificationCode = smallClassificationSelect.options[smallClassificationSelect.selectedIndex].value;
        let searchCategory = searchCategorySelect.options[searchCategorySelect.selectedIndex].textContent;
        let searchDivision = document.querySelector(`.productCl-box div > .product-nameOrCode-input`).value;
        $('.search-pro-list-container').css("display", "flex");

        $.get("/usr/basic-information/productSearch", {
            bigClassificationCode: bigClassificationCode,
            middleClassificationCode: middleClassificationCode,
            smallClassificationCode: smallClassificationCode,
            searchCategory: searchCategory,
            productName: searchDivision
        }, function (data) {
            if (data != null) {
                let productListItem = "";
                $.each(data, (idx, value) => {
                    productListItem += `
                    <li class="product \${idx+1 == 1 ? 'checked' : ''}">
                        <span><input type="checkbox" value="\${value.productCode}"></span>
                        <span>\${value.smallClassificationName}</span>
                        <span>\${value.productCode}</span>
                        <span>\${value.productKorName}</span>
                        <span data-value="\${value.price}">\${value.price.toLocaleString()}</span>
                        <span>0</span>
                    </li>
                    `
                })

                $(`.search-pro-list-container`).html(productListItem);

                clickEventForSearchProList("search-pro-list-container", "product");
                clickEventForProType("search-pro-list-container", "product");
                let listItemFirstItem = document.querySelector(`.search-pro-list-container li:nth-child(1)`)

                scrollToSelectedItem(listItemFirstItem)
            } else {
                let msgBox = `
                    <div class="is-empty-msg">
                        <div>검색하신 정보가 존재하지 않습니다.</div>
                    </div>
                `
                $(`.search-pro-list-container`).html(msgBox);
            }
        }, "json")
    }

    function selectProduct() {
        let productListLength = $(".search-pro-list-container li").length

        if (productListLength != 0) {
            let selectProductItem = $(".search-pro-list-container li span:nth-child(1) > input:checked").map((index, el) => el.value).toArray();
            let selectProTypeItem = $(".productType-list-con-left li.selected ")[0];
            let selectProTypeItemCode = selectProTypeItem.id.substring(selectProTypeItem.id.indexOf("_") + 1);
            let selectProTypeColorBox = selectProTypeItem.children[4].children[0];
            let selectProTypeColor = selectProTypeColorBox.options[selectProTypeColorBox.selectedIndex].value;

            if (selectProductItem.length != 0 && productListLength > 0) {
                $.post("/usr/basic-information/touchKeyManagement/addTypeForProducts", {
                    productCodeList: selectProductItem.join(","),
                    productTypeId: selectProTypeItemCode,
                    productTypeColor: selectProTypeColor
                }, function (data) {
                    if (data.success) {
                        getProductList(selectProTypeItem);
                        closeMsgBox();
                    } else if (data.success == false) {
                        closeMsgBox();
                    }
                }, "json");
            } else {
                alert("상품을 선택해주세요.");
            }
        }
    }
</script>