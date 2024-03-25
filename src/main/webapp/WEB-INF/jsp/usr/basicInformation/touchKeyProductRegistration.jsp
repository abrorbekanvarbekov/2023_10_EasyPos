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
                <button onclick="saveProductType();" class="btn btn-active btn-sm pl-2">저장</button>
                <button onclick="delProductType();" class="btn btn-active btn-sm pl-2">삭제</button>
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
                <ul class="productType-list-container productType-list-con-left"></ul>
            </div>
            <div class="productType-main-right">
                <div class="productType-sort-buttons">
                    <button class="btn btn-active btn-xs">맨위로</button>
                    <button class="btn btn-active btn-xs">위로</button>
                    <button class="btn btn-active btn-xs">아래로</button>
                    <button class="btn btn-active btn-xs">맨아래로</button>
                    <button class="btn btn-active btn-xs">순번정렬</button>
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


    function getProductTypeList() {
        $(".productType-list-container").css("display", "flex");

        let searchKeyword = $(".touch-classification-name > div > input")[0].value
        $.get("/usr/basic-information/touchKeyManagement/getProductType", {
                searchKeyword: searchKeyword
            },
            function (data) {
                if (data.length != 0) {
                    let productTypeLi = "";
                    $.each(data, (idx, value) => {
                        productTypeLi += `
                            <li class="productType \${idx+1 == 1 ? 'checked' : ''}" id="productType_\${value.id}">
                                <span><input type="checkbox" id="product-type-checkbox" value="\${value.id}"></span>
                                <span>\${value.id}</span>
                                <span>\${value.code}</span>
                                <span>
                                    <input id="proTypeKorName_\${value.id}" type="text" value="\${value.korName}"
                                            onclick="mine()" onchange="updateProductType(this.id)">
                                </span>
                                <span>
                                    <input id="proTypeEngName_\${value.id}" type="text" value="\${value.engName}"
                                            onclick="mine()" onchange="updateProductType(this.id)">
                                </span>
                                <span>\${value.authDivision}</span>
                                <span style="background-color: \${value.color}">
                                    <select id="proTypeColorBox_\${value.id}" onchange="updateProductType(this.id)"
                                        class="select select-bordered select-sm w-full max-w-xs" style="background-color: \${value.color}">
                                      <option value="orange" \${value.color == 'orange' ? 'selected' : ''}>오랜지</option>
                                      <option value="lightblue" \${value.color == 'lightblue' ? 'selected' : ''}>연파랑</option>
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
                    $(".productType-list-con-left").html(productTypeLi);
                    clickEventForProType("productType-list-con-left", "productType");
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

    function addProductTypeLi() {
        let display = $(".productType-main-left .productType-list-container").css("display");
        let productTypeLen = $(".productType-list-con-left li").length

        if (display == "flex") {
            let productTypeLi = `
                <li class="productType newProType">
                    <span><input type="checkbox"></span>
                    <span>\${productTypeLen + 1}</span>
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
                $(".productType-list-con-left").append(productTypeLi);
            } else {
                $(".productType-list-con-left").html(productTypeLi);
            }
        } else if (display == "none") {
            alert("조회 후 추가하세요.");
        }
    }

    function updateProductType(el) {
        if (el) {
            let listId = "#productType_".concat(el.substring(el.indexOf("_") + 1));
            let selectedLi = document.querySelector(listId);
            selectedLi.classList.add("update-proType-item");
        }
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
                    <li class="product \${idx+1 == 1 ? 'checked' : ''}" id="product_\${value.id}">
                        <span><input type="checkbox" id="product-checkbox" value="\${value.id}"></span>
                        <span>\${ordinalNum.padStart(3, "0")}</span>
                        <span>\${value.productCode}</span>
                        <span>\${value.productKorName}</span>
                        <span>\${value.price}</span>
                        <span>매장</span>
                        <span style="background-color: \${value.color}">
                            <select id="productColorBox_\${value.id}" class="select select-bordered select-sm w-full max-w-xs"
                                style="background-color: \${value.color}" onchange="updateProduct(this.id)">
                              <option value="orange" \${value.color == 'orange' ? 'selected' : ''}>오랜지</option>
                              <option value="lightblue" \${value.color == 'lightblue' ? 'selected' : ''}>연파랑</option>
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
                $(".productType-list-con-right").html(productLi);
                clickEventForProType("productType-list-con-right", "product");
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

    function saveProductType() {
        let newProTypeLen = $(".productType-list-con-left > .newProType").length;
        let updateProTypeLen = $(".productType-list-con-left > .update-proType-item").length;
        let updateProLen = $(".productType-list-con-right > .update-pro-item").length;

        if (newProTypeLen == 0 && updateProTypeLen == 0 && updateProLen == 0) {
            alert("터치키은(는) 변경된 사항이 없습니다.");
        }

        if (newProTypeLen != 0) {
            let newProTypeKorNameList = [];
            let newProTypeEngNameList = [];
            let newProTypeColorList = [];

            $(".productType-list-con-left > .newProType").each((idx, el) => {
                const newProTypeKorName = el.children[3].children[0].value;
                newProTypeKorNameList.push(newProTypeKorName);
                const newProTypeEngName = el.children[4].children[0].value;
                newProTypeEngNameList.push(newProTypeEngName);
                const newProTypeColorBox = el.children[6].children[0];
                const newProTypeColor = newProTypeColorBox.options[newProTypeColorBox.selectedIndex].value;
                newProTypeColorList.push(newProTypeColor);
            })

            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/addProductTypes",
                data: {
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

        if (updateProTypeLen != 0) {
            let updateProductTypeIdList = [];
            let updateProTypeKorNameList = [];
            let updateProTypeEngNameList = [];
            let updateProTypeColorList = [];
            $(".productType-list-con-left > .update-proType-item").each((idx, el) => {
                const updateProTypeId = el.id.substring(el.id.indexOf("_") + 1);
                updateProductTypeIdList.push(updateProTypeId);
                const updateProTypeKorName = el.children[3].children[0].value;
                updateProTypeKorNameList.push(updateProTypeKorName);
                const updateProTypeEngName = el.children[4].children[0].value;
                updateProTypeEngNameList.push(updateProTypeEngName);
                const updateProTypeColorBox = el.children[6].children[0];
                const updateProTypeColor = updateProTypeColorBox.options[updateProTypeColorBox.selectedIndex].value;
                updateProTypeColorList.push(updateProTypeColor);
            })

            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/updateProductTypes",
                data: {
                    updateProTypeIdList: updateProductTypeIdList.join(","),
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

        if (updateProLen != 0) {
            let selectProTypeItem = $(".productType-list-con-left .productType.selected ")[0];
            let updateProductIdList = [];
            let updateProductColorList = [];

            $(".productType-list-con-right > .update-pro-item").each((idx, el) => {
                const updateProductId = el.id.substring(el.id.indexOf("_") + 1);
                updateProductIdList.push(updateProductId);
                const updateProColorBox = el.children[6].children[0];
                const updateProColor = updateProColorBox.options[updateProColorBox.selectedIndex].value;
                updateProductColorList.push(updateProColor);
            })

            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/updateProducts",
                data: {
                    updateProductIdList: updateProductIdList.join(","),
                    updateProductColorList: updateProductColorList.join(",")
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

    function delProductType() {
        const delProTypeIdList = $('#product-type-checkbox:checked').map((index, el) => el.value).toArray();
        const delProductIdList = $('#product-checkbox:checked').map((index, el) => el.value).toArray();
        if (delProTypeIdList != 0) {
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

        if (delProductIdList != 0) {
            let selectProTypeItem = $(".productType-list-con-left .productType.selected ")[0];
            $.ajax({
                url: "/usr/basic-information/touchKeyManagement/delTypeForProducts",
                data: {
                    delProductIdList: delProductIdList.join(",")
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
                        <span><input type="checkbox" value="\${value.id}"></span>
                        <span>\${value.smallClassificationName}</span>
                        <span>\${value.productCode}</span>
                        <span>\${value.productKorName}</span>
                        <span data-value="\${value.price}">\${value.price.toLocaleString()}</span>
                        <span></span>
                    </li>
                    `
                })

                $(`.search-pro-list-container`).html(productListItem);

                clickEventForProType("search-pro-list-container", "product");z``
                let listItemFirstItem = document.querySelector(`.search-pro-list-container li:nth-child(1)`)

                scrollToSelectedItem(listItemFirstItem)
            } else {
                let msgBox = `
                    <div class="is-empty-msg">
                        <span>검색하신 정보가 존재하지 않습니다.</span>
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
            let selectProTypeItem = $(".productType-list-con-left .productType.selected ")[0];
            let selectProTypeItemCode = selectProTypeItem.children[2].textContent;
            let selectProTypeColorBox = selectProTypeItem.children[6].children[0];
            let selectProTypeColor = selectProTypeColorBox.options[selectProTypeColorBox.selectedIndex].value;

            if (selectProductItem.length != 0 && productListLength > 0) {
                $.post("/usr/basic-information/touchKeyManagement/addTypeForProducts", {
                    productIdList: selectProductItem.join(","),
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