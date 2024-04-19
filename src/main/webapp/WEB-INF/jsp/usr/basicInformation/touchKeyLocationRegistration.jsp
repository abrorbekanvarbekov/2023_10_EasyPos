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
                <button onclick="saveChanges();" class="btn btn-active btn-sm pl-2">저장</button>
                <button onclick="delProductTypeAndProduct();" class="btn btn-active btn-sm pl-2">삭제</button>
            </div>
        </div>
        <div class="touch-location-classification">
            <div>
                <span>터치키분류</span>
                <select class="select select-bordered select-xs w-full max-w-xs">
                    <option value="1">1</option>
                    <option value="1">2</option>
                    <option value="1">3</option>
                    <option value="1">4</option>
                </select>
                <p>*</p>
                <select class="select select-bordered select-xs w-full max-w-xs">
                    <option value="1">1</option>
                    <option value="1">2</option>
                    <option value="1">3</option>
                    <option value="1">4</option>
                </select>
                <span class="ml-6">상품분류</span>
                <select class="select select-bordered select-xs w-full max-w-xs">
                    <option value="1">1</option>
                    <option value="1">2</option>
                    <option value="1">3</option>
                    <option value="1">4</option>
                </select>
                <p>*</p>
                <select class="select select-bordered select-xs w-full max-w-xs">
                    <option value="1">1</option>
                    <option value="1">2</option>
                    <option value="1">3</option>
                    <option value="1">4</option>
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
                <select class="select select-bordered select-sm w-full max-w-xs">
                    <option value="orange">오랜지</option>
                    <option value="lightblue">연파랑</option>
                    <option value="lightgreen">연녹</option>
                    <option value="lightpink">핑크</option>
                    <option value="orangered">연빨강</option>
                    <option value="salmon">살구</option>
                    <option value="yellow">연노랑</option>
                </select>
                <button class="btn btn-active btn-sm pl-2">적용</button>
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
                <input type="text" value="" class="product-name-input">
                <span class="material-symbols-outlined btn btn-active btn-xs">add</span>
                <span>터치색</span>
                <select class="select select-bordered select-sm w-full max-w-xs">
                    <option value="orange">오랜지</option>
                    <option value="lightblue">연파랑</option>
                    <option value="lightgreen">연녹</option>
                    <option value="lightpink">핑크</option>
                    <option value="orangered">연빨강</option>
                    <option value="salmon">살구</option>
                    <option value="yellow">연노랑</option>
                </select>
                <button class="btn btn-active btn-sm pl-2">적용</button>
            </div>
        </div>
        <div class="t-l-product-box">
            <ul class="t-l-product-list"></ul>
        </div>
    </div>
</div>

<script>
    function getProTypeList() {
        let searchKeyword = "";
        $.get("/usr/basic-information/touchKeyManagement/getProductType", {
                searchKeyword: searchKeyword
            },
            function (data) {
                if (data.length != 0) {
                    let proTypeList = "";
                    $.each(data, (idx, value) => {
                        proTypeList += `
                            <span draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                            <li  draggable="true"  style="background-color: \${value.color}" sequenceNum="\${value.sequenceNum}"  name="\${value.korName}"  id="\${value.code}" onclick="getProList(this)">
                                \${value.code} \${value.korName}
                            </li>
                        `
                    })
                    if (data.length <= 13) {
                        for (let i = data.length + 1; i <= 13; i++) {
                            proTypeList += `
                            <span draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                            <li ></li>
                            `
                        }
                    }
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
                        let dragstartEl = $(".t-l-classification-list .dragstart")[0];

                        if (dropEl.textContent == "") {
                            dropEl.style.backgroundColor = dragstartEl.style.backgroundColor;
                            dropEl.setAttribute("draggable", true)
                            dropEl.innerHTML = dragstartEl.innerHTML;

                            dragstartEl.innerHTML = "";
                            dragstartEl.style.backgroundColor = "inherit";
                            dragstartEl.classList.remove("dragstart");
                        } else {
                            let dropElBeforeText = dropEl.innerHTML.trim();
                            let dropElBeforeColor = dropEl.style.backgroundColor.trim();
                            dropEl.style.backgroundColor = dragstartEl.style.backgroundColor;
                            dropEl.setAttribute("draggable", true)
                            dropEl.innerHTML = dragstartEl.innerHTML;

                            dragstartEl.innerHTML = dropElBeforeText;
                            dragstartEl.style.backgroundColor = dropElBeforeColor;
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
        $(".pro-type-code").html(proTypeCode);
        $(".pro-type-name").html(proTypeCode + "ㅡ" + proTypeName);
        $(".pro-type-name-input").val(proTypeName);
        $(".pro-type-sequenceNum").html(proTypeSeqNum);


        $.get("/usr/basic-information/touchKeyManagement/getProducts", {
            productTypeCode: proTypeCode
        }, function (data) {
            let productList = "";
            if (data.length != 0) {
                $.each(data, (idx, value) => {
                    productList += `
                        <span draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                        <li draggable="true" style="background-color: \${value.color}" sequenceNum="\${value.sequenceNum}"  name="\${value.productKorName}"  id="\${value.productCode}">
                            \${value.productCode} \${value.productKorName}
                        </li>
                    `
                })

                if (data.length <= 27) {
                    for (let i = data.length + 1; i <= 27; i++) {
                        productList += `
                            <span draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                            <li></li>
                            `
                    }
                }
                $(".t-l-product-list").html(productList);
            } else {
                for (let i = 0; i <= 27; i++) {
                    productList += `
                            <span draggable="false"><input type="checkbox" class="checkbox checkbox-sm"/> </span>
                            <li></li>
                            `
                }
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
                    $(".product-code").html(productCode);
                    $(".product-name-input").val(productName);
                    $(".product-sequenceNum").html(productSeqNum);

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
                    let dragstartEl = $(".t-l-product-list .dragstart")[0];

                    if (dropEl.textContent == "") {
                        dropEl.style.backgroundColor = dragstartEl.style.backgroundColor;
                        dropEl.setAttribute("draggable", true)
                        dropEl.innerHTML = dragstartEl.innerHTML;

                        dragstartEl.innerHTML = "";
                        dragstartEl.style.backgroundColor = "inherit";
                        dragstartEl.classList.remove("dragstart");
                    } else {
                        let dropElBeforeText = dropEl.innerHTML.trim();
                        let dropElBeforeColor = dropEl.style.backgroundColor.trim();
                        dropEl.style.backgroundColor = dragstartEl.style.backgroundColor;
                        dropEl.setAttribute("draggable", true)
                        dropEl.innerHTML = dragstartEl.innerHTML;

                        dragstartEl.innerHTML = dropElBeforeText;
                        dragstartEl.style.backgroundColor = dropElBeforeColor;
                        dragstartEl.classList.remove("dragstart");
                    }
                });
            })
        }, "json")
    }

</script>