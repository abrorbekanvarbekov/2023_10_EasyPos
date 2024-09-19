<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="touch-product-location">
    <div class="touch-product-location-con">
        <div class="touch-product-loc-top">
            <div>
                <span class="material-symbols-outlined pr-2 text-red-400">arrow_circle_right</span>
                <span>기초정보관리 > 터치키상품관리 > 터치키상품등록(위치)</span>
            </div>
            <div>
                <button class="btn btn-active btn-sm flex flex-row justify-between"
                        onclick="getProTypeList();">
                    <span class="material-symbols-outlined">search</span>
                    <span>조회</span>
                </button>
                <button onclick="saveUpdateInfo()" class="btn btn-active btn-sm pl-2">저장</button>
                <button onclick="delProductTypeAndProduct();" class="btn btn-active btn-sm pl-2">삭제</button>
            </div>
        </div>
        <div class="touch-location-classification">
            <div>
                <span>터치키분류</span>
                <select class="select select-bordered select-xs w-full max-w-xs" id="proTypeWidthNum">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option selected value="7">7</option>
                </select>
                <p>*</p>
                <select class="select select-bordered select-xs w-full max-w-xs" id="proTypeHeightNum">
                    <option value="1">1</option>
                    <option selected value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                </select>
                <span class="ml-6">상품분류</span>
                <select class="select select-bordered select-xs w-full max-w-xs" id="productWidthNum">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option selected value="7">7</option>
                </select>
                <p>*</p>
                <select class="select select-bordered select-xs w-full max-w-xs" id="productHeightNum">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option selected value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                </select>
            </div>
        </div>
        <div>
            <span class="material-symbols-outlined text-red-600 ">slideshow</span>
            <span>터치키분류정보</span>
        </div>
        <div class="t-l-classification-info">
            <div>
                <span>순번</span>
                <span class="pro-type-sequenceNum"></span>
                <span>분류코드</span>
                <span class="pro-type-code"></span>
                <span>분류명</span>
                <input type="text" value="" class="pro-type-name-input">
                <span>터치색</span>
                <select class="select select-bordered select-sm w-full max-w-xs" id="proType-color-selector">
                    <option value="orange">오랜지</option>
                    <option value="lightblue">연파랑</option>
                    <option value="lightgreen">연녹</option>
                    <option value="lightpink">핑크</option>
                    <option value="orangered">연빨강</option>
                    <option value="salmon">살구</option>
                    <option value="yellow">연노랑</option>
                </select>
                <button class="btn btn-active btn-sm pl-2" onclick="addAndUpdateProType()">적용</button>
            </div>
        </div>
        <div class="t-l-classification-box">
            <ul class="t-l-classification-list"></ul>
        </div>
        <%--        ========================--%>
        <div>
            <span class="material-symbols-outlined text-red-600 ">slideshow</span>
            <span>터치키상품정보</span>
            <span class="ml-4 pro-type-name"></span>
        </div>
        <div class="t-l-product-info">
            <div>
                <span>순번</span>
                <span class="product-sequenceNum"></span>
                <span>분류코드</span>
                <span class="product-code"></span>
                <span>분류명</span>
                <input type="submit" value="" class="product-name-input">
                <span class="material-symbols-outlined btn btn-active btn-xs">add</span>
                <span>터치색</span>
                <select class="select select-bordered select-sm w-full max-w-xs" id="product-color-selector">
                    <option value="orange">오랜지</option>
                    <option value="lightblue">연파랑</option>
                    <option value="lightgreen">연녹</option>
                    <option value="lightpink">핑크</option>
                    <option value="orangered">연빨강</option>
                    <option value="salmon">살구</option>
                    <option value="yellow">연노랑</option>
                </select>
                <button class="btn btn-active btn-sm pl-2" onclick="addAndUpdateProduct();">적용</button>
            </div>
        </div>
        <div class="t-l-product-box">
            <ul class="t-l-product-list"></ul>
        </div>
    </div>
</div>

<script>
    let selectElement1 = document.getElementById("proType-color-selector");
    let selectElement2 = document.getElementById("product-color-selector");
    selectElement1.selectedIndex = -1; // 선택된 옵션을 없앱니다.
    selectElement2.selectedIndex = -1; // 선택된 옵션을 없앱니다.
    function getProTypeList() {
        $(".t-l-product-list").empty();
        let searchKeyword = "";
        let widthLen = document.getElementById("proTypeWidthNum").options[document.getElementById("proTypeWidthNum").selectedIndex].value;
        let heightLen = document.getElementById("proTypeHeightNum").options[document.getElementById("proTypeHeightNum").selectedIndex].value;
        let spanWidth = ((100 / widthLen) / 100 * 15).toFixed(3);
        let liWidth = ((100 / widthLen) - spanWidth).toFixed(3);
        let itemLens = widthLen * heightLen - 1;
        let lastLiLen = 100 / widthLen;
        $.get("/usr/basic-information/touchKeyManagement/getProductType", {
                searchKeyword: searchKeyword
            },
            function (data) {
                if (data.length <= itemLens) {
                    let proTypeList = "";
                    for (let i = 0; i < data.length; i++) {
                        if (data[i].sequenceNum != i) {
                            data.splice(i, 0, "null")
                        }
                    }

                    $.each(data, (idx, value) => {
                        if (value != "null") {
                            proTypeList += `
                                <span style="width: \${spanWidth}%" draggable="false"><input type="checkbox" id="product-type-checkbox" value="\${value.id}"  class="checkbox checkbox-sm"/> </span>
                                <li class="proTypeItem" draggable="true"  style="background-color: \${value.color}; width: \${liWidth}%"
                                    sequenceNum="\${value.sequenceNum}"  name="\${value.korName}"
                                    id="\${value.code}" onclick="getProList(this)">
                                    \${value.code} \${value.korName}
                                </li>
                            `
                        } else {
                            proTypeList += `
                                <span style="width: \${spanWidth}%" draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                                <li style="width: \${liWidth}%" sequenceNum="\${idx}"></li>
                            `
                        }
                    })

                    if (data.length <= itemLens) {
                        for (let i = data.length + 1; i <= itemLens; i++) {
                            proTypeList += `
                            <span style="width: \${spanWidth}%" draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                            <li style="width: \${liWidth}%" sequenceNum="\${i-1}"></li>
                            `
                        }
                    }

                    proTypeList += `
                        <li style="width: \${lastLiLen}%; border-left: none" draggable="false">
                            <span draggable="false" class="material-symbols-outlined btn btn-xs">arrow_left</span>
                            <span draggable="false" class="material-symbols-outlined btn btn-xs">arrow_right</span>
                        </li>
                    `
                    $(".t-l-classification-list").html(proTypeList);
                }

                document.querySelectorAll(".t-l-classification-list li").forEach((element) => {
                    element.addEventListener("click", function (el) {
                        let beforeProType = $(".t-l-classification-list li.checked")
                        if (beforeProType.length != 0) {
                            beforeProType[0].style.borderRight = "1px solid darkgray";
                            beforeProType[0].style.borderBottom = "1px solid darkgray";
                            beforeProType[0].classList.remove("checked");
                        }

                        let proTypeName = element.getAttribute("name");
                        proTypeName == null ? $(".pro-type-name").empty() : '';
                        element.style.borderRight = "2px solid blue";
                        element.style.borderBottom = "2px solid blue";
                        element.classList.add("checked");
                    })
                })

                const items = document.querySelectorAll(".t-l-classification-list li");

                items.forEach((item) => {

                    item.addEventListener("dragstart", (e) => {
                        e.target.classList.add("dragstart");
                    });

                    item.addEventListener("dragover", (els) => {
                        els.preventDefault();
                    });

                    item.addEventListener("drop", (el) => {
                        el.preventDefault();
                        let dropEl = el.target;
                        let dragstartEl = document.querySelector(".t-l-classification-list .dragstart");
                        let parentEl = document.querySelector(".t-l-classification-list")
                        let newIndex = Array.prototype.indexOf.call(parentEl.children, dragstartEl);
                        let dropIndex = Array.prototype.indexOf.call(parentEl.children, dropEl);
                        let dropElSeqNum = dropEl.getAttribute("sequenceNum");
                        let dragstartElSeqNum = dragstartEl.getAttribute("sequenceNum");

                        if (newIndex < dropIndex) {
                            let sibling = parentEl.children[dropIndex];
                            sibling.setAttribute("sequenceNum", dragstartElSeqNum);
                            parentEl.insertBefore(dragstartEl, sibling);
                            let sibling2 = parentEl.children[newIndex];
                            dragstartEl.setAttribute("sequenceNum", dropElSeqNum);
                            parentEl.insertBefore(dropEl, sibling2)
                            dragstartEl.classList.remove("dragstart");
                        } else if (newIndex > dropIndex) {
                            let sibling2 = parentEl.children[newIndex];
                            dragstartEl.setAttribute("sequenceNum", dropElSeqNum);
                            parentEl.insertBefore(dropEl, sibling2)
                            let sibling = parentEl.children[dropIndex];
                            dropEl.setAttribute("sequenceNum", dragstartElSeqNum);
                            parentEl.insertBefore(dragstartEl, sibling);
                            dragstartEl.classList.remove("dragstart");
                        }
                    });
                })

            }, "json")
    }

    function getProList(productType) {
        let beforeProType = $(".t-l-classification-list li.checked");
        if (beforeProType.length != 0) {
            beforeProType[0].style.borderRight = "1px solid darkgray"
            beforeProType[0].style.borderBottom = "1px solid darkgray"
            beforeProType[0].classList.remove("checked");
        }
        productType.style.borderRight = "2px solid blue";
        productType.style.borderBottom = "2px solid blue";
        productType.classList.add("checked");
        let proTypeCode = productType.id;
        let proTypeName = productType.getAttribute("name");
        let proTypeSeqNum = productType.getAttribute("sequenceNum");
        let proTypeBackColor = productType.style.backgroundColor;

        $(".pro-type-code").html(proTypeCode);
        $(".pro-type-name").html(proTypeCode + "ㅡ" + proTypeName);
        $(".pro-type-name-input").val(proTypeName);
        $(".pro-type-sequenceNum").html(proTypeSeqNum);
        $('#proType-color-selector').val(proTypeBackColor).prop("selected", true);

        let widthLen = document.getElementById("productWidthNum").options[document.getElementById("productWidthNum").selectedIndex].value;
        let heightLen = document.getElementById("productHeightNum").options[document.getElementById("productHeightNum").selectedIndex].value;
        let spanWidth = ((100 / widthLen) / 100 * 15).toFixed(3);
        let liWidth = ((100 / widthLen) - spanWidth).toFixed(3);
        let itemLens = widthLen * heightLen - 1;
        let lastLiLen = 100 / widthLen;

        $.get("/usr/basic-information/touchKeyManagement/getProducts", {
            productTypeCode: proTypeCode
        }, function (data) {
            let productList = "";
            if (data.length != 0) {
                $.each(data, (idx, value) => {
                    productList += `
                        <span draggable="false" style="width: \${spanWidth}%"><input type="checkbox" id="product-checkbox" value="\${value.productCode}" class="checkbox checkbox-sm"/> </span>
                        <li class="productItem" draggable="true" style="background-color: \${value.color}; width: \${liWidth}%" sequenceNum="\${value.sequenceNum}"  name="\${value.productKorName}"  id="\${value.productCode}">
                            \${value.productCode} \${value.productKorName}
                        </li>
                    `
                })

                if (data.length <= itemLens) {
                    for (let i = data.length + 1; i <= itemLens; i++) {
                        productList += `
                            <span style="width: \${spanWidth}%" draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                            <li style="width: \${liWidth}%" sequenceNum="\${i-1}"></li>
                            `
                    }
                }

                productList += `
                        <li style="width: \${lastLiLen}%; border-left: none" draggable="false">
                            <span class="material-symbols-outlined btn btn-xs">arrow_left</span>
                            <span class="material-symbols-outlined btn btn-xs">arrow_right</span>
                        </li>
                    `

                $(".t-l-product-list").html(productList);
            } else {
                for (let i = 0; i <= itemLens; i++) {
                    productList += `
                            <span style="width: \${spanWidth}%" draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                            <li style="width: \${liWidth}%" ></li>
                            `
                }

                productList += `
                        <li style="width: \${lastLiLen}%; border-left: none" >
                            <span class="material-symbols-outlined btn btn-xs">arrow_left</span>
                            <span class="material-symbols-outlined btn btn-xs">arrow_right</span>
                        </li>
                    `

                $(".t-l-product-list").html(productList);
            }

            document.querySelectorAll(".t-l-product-list li").forEach((element) => {
                element.addEventListener("click", function (el) {
                    let beforeProduct = $(".t-l-product-list li.checked")
                    if (beforeProduct.length != 0) {
                        beforeProduct[0].style.borderRight = "1px solid darkgray";
                        beforeProduct[0].style.borderBottom = "1px solid darkgray";
                        beforeProduct[0].classList.remove("checked");
                    }
                    let productCode = element.id;
                    let productName = element.getAttribute("name");
                    let productSeqNum = element.getAttribute("sequenceNum");
                    let productBackColor = element.style.backgroundColor;

                    $(".product-code").html(productCode);
                    $(".product-name-input").val(productName);
                    $(".product-sequenceNum").html(productSeqNum);
                    $("#product-color-selector").val(productBackColor).prop("selected", true);
                    element.style.borderRight = "2px solid blue";
                    element.style.borderBottom = "2px solid blue";
                    element.classList.add("checked");
                })
            });

            const items = document.querySelectorAll(".t-l-product-list li");

            items.forEach((item) => {

                item.addEventListener("dragstart", (e) => {
                    e.target.classList.add("dragstart");
                });

                item.addEventListener("dragover", (els) => {
                    els.preventDefault();
                });

                item.addEventListener("drop", (el) => {
                    el.preventDefault();
                    let dropEl = el.target;
                    let dragstartEl = document.querySelector(".t-l-product-list .dragstart");
                    let parentEl = document.querySelector(".t-l-product-list")
                    let newIndex = Array.prototype.indexOf.call(parentEl.children, dragstartEl);
                    let dropIndex = Array.prototype.indexOf.call(parentEl.children, dropEl);
                    let dropElSeqNum = dropEl.getAttribute("sequenceNum");
                    let dragstartElSeqNum = dragstartEl.getAttribute("sequenceNum");

                    if (newIndex < dropIndex) {
                        let sibling = parentEl.children[dropIndex];
                        sibling.setAttribute("sequenceNum", dragstartElSeqNum);
                        parentEl.insertBefore(dragstartEl, sibling);
                        let sibling2 = parentEl.children[newIndex];
                        dragstartEl.setAttribute("sequenceNum", dropElSeqNum);
                        parentEl.insertBefore(dropEl, sibling2)
                        dragstartEl.classList.remove("dragstart");
                    } else if (newIndex > dropIndex) {
                        let sibling2 = parentEl.children[newIndex];
                        dragstartEl.setAttribute("sequenceNum", dropElSeqNum);
                        parentEl.insertBefore(dropEl, sibling2)
                        let sibling = parentEl.children[dropIndex];
                        dropEl.setAttribute("sequenceNum", dragstartElSeqNum);
                        parentEl.insertBefore(dragstartEl, sibling);
                        dragstartEl.classList.remove("dragstart");
                    }
                });
            })
        }, "json")
    }

    function addAndUpdateProType() {
        let proTypeLength = document.querySelectorAll(".t-l-classification-list li").length
        let selectedProType = document.querySelector(".t-l-classification-list li.checked")

        if (proTypeLength != 0 && selectedProType != null) {
            let nameToModify = document.querySelector(".t-l-classification-info > div:first-child > input").value
            let colorToModify = document.querySelector(".t-l-classification-info > div:first-child > select")
                .options[document.querySelector(".t-l-classification-info > div:first-child > select").selectedIndex].value;

            selectedProType.setAttribute("name", nameToModify);
            selectedProType.textContent = selectedProType.textContent.trim().substring(0, 4) + nameToModify;
            selectedProType.style.backgroundColor = colorToModify;
        }
    }

    function addAndUpdateProduct() {
        let productLength = document.querySelectorAll(".t-l-product-list li").length
        let selectedProduct = document.querySelector(".t-l-product-list li.checked")

        if (productLength != 0 && selectedProduct != null) {
            let nameToModify = document.querySelector(".t-l-product-info > div:first-child > input").value
            let colorToModify = document.querySelector(".t-l-product-info > div:first-child > select")
                .options[document.querySelector(".t-l-product-info > div:first-child > select").selectedIndex].value;

            selectedProduct.setAttribute("name", nameToModify);
            selectedProduct.textContent = selectedProduct.textContent.trim().substring(0, 7) + nameToModify;
            selectedProduct.style.backgroundColor = colorToModify;
        }
    }

    function saveUpdateInfo() {
        let proTypeListLength = document.querySelectorAll(".t-l-classification-list li").length

        if (proTypeListLength != 0) {
            let result = confirm("저장하시겠습니까?");
            if (result) {
                let proTypeSeqNumList = []
                let proTypeCodesList = []
                let proTypeNamesList = []
                let proTypeColorsList = []
                document.querySelectorAll(".t-l-classification-list li.proTypeItem").forEach((element) => {
                    proTypeSeqNumList.push(element.getAttribute("sequenceNum"));
                    proTypeCodesList.push(element.id);
                    proTypeNamesList.push(element.getAttribute("name"));
                    proTypeColorsList.push(element.style.backgroundColor);
                })
                $.ajax({
                    url: "/usr/basic-information/touchKeyLocation/updateProductTypes",
                    method: "POST",
                    data: {
                        proTypeSeqNumList: proTypeSeqNumList.join(","),
                        proTypeCodesList: proTypeCodesList.join(","),
                        proTypeNamesList: proTypeNamesList.join(","),
                        proTypeColorsList: proTypeColorsList.join(",")
                    },
                    success: function (data) {
                        getProTypeList();
                    },
                    error: function (request, status, error) {

                    },
                    complete: function () {

                    }
                })

                let productListLength = document.querySelectorAll(".t-l-product-list li").length

                if (productListLength != 0) {
                    let productSeqNumList = []
                    let productCodesList = []
                    let productColorsList = []
                    let selectedProTypeCode = document.querySelector(".t-l-classification-list li.checked").id
                    document.querySelectorAll(".t-l-product-list li.productItem").forEach((element) => {
                        productSeqNumList.push(element.getAttribute("sequenceNum"));
                        productCodesList.push(element.id);
                        productColorsList.push(element.style.backgroundColor);
                    })

                    $.ajax({
                        url: "/usr/basic-information/touchKeyManagement/updateProducts",
                        method: "POST",
                        data: {
                            updateProductCodeList: productCodesList.join(","),
                            updateProSequenceNumList: productSeqNumList.join(","),
                            updateProductColorList: productColorsList.join(","),
                            selectProTypeCode: selectedProTypeCode
                        },
                        success: function (data) {
                            getProTypeList();
                        },
                        error: function (request, status, error) {

                        },
                        complete: function () {

                        }
                    })
                }
            } else {
                getProTypeList();
            }
        }
    }

    function delProductTypeAndProduct() {
        const delProTypeIdList = $('#product-type-checkbox:checked').map((index, el) => el.value).toArray();
        const delProductCodeList = $('#product-checkbox:checked').map((index, el) => el.value).toArray();

        if (delProTypeIdList.length != 0) {
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
                        getProTypeList();
                    },
                    error: function (request, status, error) {
                        alert("정상적으로 처리 되지 않았습니다. \n 다시 시도해보세요.");
                        getProTypeList();
                    },
                    complete: function () {
                        getProTypeList();
                    }
                })
            }
        }

        if (delProductCodeList.length != 0) {
            let selectProTypeItem = $(".t-l-classification-list .proTypeItem.checked ")[0];
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
                        getProList(selectProTypeItem);
                    },
                    error: function (request, status, error) {
                        alert("정상적으로 처리 되지 않았습니다. \n 다시 시도해보세요.");
                        getProList(selectProTypeItem);
                    },
                    complete: function () {
                        getProList(selectProTypeItem);
                    }
                })
            }
        }
    }

</script>