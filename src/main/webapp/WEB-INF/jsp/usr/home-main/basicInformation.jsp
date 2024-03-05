<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="EasyPos"/>
<c:set var="pageName" value="기초정보"/>
<%@include file="../common/head.jsp" %>
<%@include file="../common/somePageHead.jsp" %>

<div class="basic-information-container">
    <div class="side-bar">
        <div class="status-icons">
            <div>▶</div>
            <div>▼</div>
        </div>
        <div>
            <span class="material-symbols-outlined text-red-400">smart_display</span>
            <span class="pl-2">기초정보</span>
        </div>
        <nav class="menu-box">
            <ul>
                <li>
                    <span class="material-symbols-outlined">article</span>
                    <a href="#">상품관리</a>
                    <ul>
                        <li onclick="classificationManagement();" id="classificationManagement">
                            <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                            <a>상품분류관리</a>
                        </li>
                        <li onclick="productLookUp();" id="productLookUp">
                            <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                            <a>상품조회</a>
                        </li>
                        <li onclick="addProductPage();" id="addProductPage">
                            <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                            <a href="#">상품등록</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <span class="material-symbols-outlined">article</span>
                    <a href="#">터치키관리</a>
                    <ul>
                        <li>
                            <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                            <a href="#">터치키상품등록</a>
                        </li>
                        <li>
                            <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                            <a href="#">터치키상품등록(위치)</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <span class="material-symbols-outlined">article</span>
                    <a href="#">POS관리</a>
                    <ul>
                        <li>
                            <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                            <a href="#">주방프리터 관리</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <span class="material-symbols-outlined">article</span>
                    <a href="#">사원관리</a>
                    <ul>
                        <li>
                            <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                            <a href="#">사원관리</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <span class="material-symbols-outlined">article</span>
                    <a href="#">기타관리</a>
                    <ul>
                        <li>
                            <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                            <a href="#">테이블 베치</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>

    <%@include file="../basicInformation/salesInformationManagement.jsp" %>
    <%@include file="../basicInformation/productSearchPage.jsp" %>
    <%@include file="../basicInformation/productRegistrationPage.jsp" %>
</div>

<script>
    function classificationManagement() {
        $("#classificationManagement").css("color", "#FBD3AD");
        $(".basicInformation-left").css("display", "flex");

        $("#productLookUp").css("color", "#FFFFFF");
        $(".product-lookUp-page").css("display", "none")

        $("#addProductPage").css("color", "#FFFFFF");
        $(".add-product-page").css("display", "none")
    }

    function productLookUp() {
        $(".basicInformation-left").css("display", "none")
        $("#classificationManagement").css("color", "#FFFFFF");

        $("#addProductPage").css("color", "#FFFFFF");
        $(".add-product-page").css("display", "none")

        $("#productLookUp").css("color", "#FBD3AD");
        $(".product-lookUp-page").css("display", "flex")

        $(".product-list-search").css("display", "none")

        $(".product-add-container-curtain").css("display", "flex")

        getBigClassifications(".product-search-page");
        clickEvent(".product-list-search");

        $(".add-product-page").load(location.href + ' .add-product-page');
        $(".product-lookUp-page").unwrap();

    }

    function addProductPage() {
        $(".basicInformation-left").css("display", "none")
        $("#classificationManagement").css("color", "#FFFFFF");

        $("#productLookUp").css("color", "#FFFFFF")
        $(".product-lookUp-page").css("display", "none");

        $("#addProductPage").css("color", "#FBD3AD");
        $(".add-product-page").css("display", "flex")

        $(".product-list-reg").css("display", "none")

        $(".product-add-container-curtain").css("display", "flex")

        getBigClassifications(".product-reg-page");
        clickEvent(".product-list-reg");

        $(".product-lookUp-page").load(location.href + ' .product-lookUp-page');
        $(".add-product-page").unwrap();
    }

    //  ====================================== //
    function getBigClassifications(pageIdName) {
        $.get("/usr/basic-information/getBigClassification", {
            searchClassificationName: ""
        }, function (data) {
            if (data != null) {
                for (let i = 0; i < data.length; i++) {
                    let bigClassificationSelect = document.querySelector(`\${pageIdName} div:nth-child(1) #bigClassification-box`);
                    let bigSelectOption = document.createElement("option");
                    bigSelectOption.textContent = data[0].bigClassificationName;
                    bigSelectOption.value = data[0].bigClassificationCode;
                    bigSelectOption.id = data[0].bigClassificationCode;
                    bigClassificationSelect.appendChild(bigSelectOption);
                }
            }
            $(`\${pageIdName} div:nth-child(1) #bigClassification-box`).change((el) =>
                getMiddleClassifications(`\${pageIdName} #bigClassification-box`, `\${pageIdName} #middleClassification-box`, `\${pageIdName} #smallClassification-box`, 0));
            $(`\${pageIdName} #middleClassification-box`).change((el) =>
                getSmallClassifications(`\${pageIdName} #middleClassification-box`, `\${pageIdName} #smallClassification-box`));
        }, "json")
    }

    function getMiddleClassifications(bigIdName, middleIdName, smallIdName, middleCode) {
        let bigClassificationSelect = document.querySelector(`\${bigIdName}`);
        let classificationOptionId = bigClassificationSelect.options[bigClassificationSelect.selectedIndex].id;

        if (classificationOptionId != "") {
            $.get("/usr/basic-information/getMiddleClassification", {
                bigClassificationCode: classificationOptionId,
                searchClassificationName: ""
            }, function (data) {
                if (data != null) {
                    for (let i = 0; i < data.length; i++) {
                        let middleClassificationSelect = document.querySelector(`\${middleIdName}`);
                        let middleSelectOption = document.createElement("option");
                        middleSelectOption.textContent = data[i].middleClassificationName;
                        middleSelectOption.value = data[i].middleClassificationCode;
                        middleSelectOption.id = data[i].middleClassificationCode;
                        middleSelectOption.setAttribute("data-value", data[0].bigClassificationCode);
                        middleClassificationSelect.appendChild(middleSelectOption);

                        if (middleSelectOption.value == middleCode) {
                            middleSelectOption.selected = true;
                        }
                    }
                }
            }, "json")
        } else {
            $(`\${middleIdName}`).empty();
            let str = `<option value="allMiddleClassification">[ 중분류 전체 ]</option>`;
            $(`\${middleIdName}`).html(str);

            $(`\${smallIdName}`).empty();
            let str2 = `<option value="allSmallClassification">[ 소분류 전체 ]</option>`;
            $(`\${smallIdName}`).html(str2);
        }
    }

    function getSmallClassifications(middleIdName, smallIdName) {
        let middleClassificationSelect = document.querySelector(`\${middleIdName}`);
        let classificationOptionBigId = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].dataset.value;
        let classificationOptionMidId = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].id;

        if (classificationOptionMidId != "") {
            $.get("/usr/basic-information/getSmallClassification", {
                bigClassificationCode: classificationOptionBigId,
                middleClassificationCode: classificationOptionMidId,
                searchClassificationName: ""
            }, function (data) {
                if (data != null) {
                    for (let i = 0; i < data.length; i++) {
                        let smallClassificationSelect = document.querySelector(`\${smallIdName}`);
                        let smallSelectOption = document.createElement("option");
                        smallSelectOption.textContent = data[i].smallClassificationName;
                        smallSelectOption.value = data[i].smallClassificationCode;
                        smallSelectOption.id = data[i].smallClassificationCode;
                        smallClassificationSelect.appendChild(smallSelectOption);
                    }
                }
            }, "json")
        } else {
            $(`\${smallIdName}`).empty();
            let str = `<option value="allSmallClassification">[소분류 전체]</option>`;
            $(`\${smallIdName}`).html(str);
        }
    }

    function productSearchBtn(pageName, productListName) {
        pageName == "product-reg-page" ? $(".product-add-container-curtain").css("display", "none") : "";
        pageName == "product-reg-page" ? $(".product-list-reg").css("display", "flex") : $(".product-list-search").css("display", "flex");
        // pageName != "addProductPage" ? $(".product-add-container-curtain").css("display", "none") : "";
        let bigClassificationSelect = document.querySelector(`.\${pageName} div > #bigClassification-box`);
        let middleClassificationSelect = document.querySelector(`.\${pageName} div > #middleClassification-box`);
        let smallClassificationSelect = document.querySelector(`.\${pageName} div > #smallClassification-box`);
        let searchCategorySelect = document.querySelector(`.\${pageName} div > #searchCategory-box`);
        let bigClassificationCode = bigClassificationSelect.options[bigClassificationSelect.selectedIndex].value
        let middleClassificationCode = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].value;
        let smallClassificationCode = smallClassificationSelect.options[smallClassificationSelect.selectedIndex].value;
        let searchCategory = searchCategorySelect.options[searchCategorySelect.selectedIndex].textContent;
        let productName = document.querySelector(`.\${pageName} div > .product-nameOrCode-input`).value;

        $.get("/usr/basic-information/productSearch", {
            bigClassificationCode: bigClassificationCode,
            middleClassificationCode: middleClassificationCode,
            smallClassificationCode: smallClassificationCode,
            searchCategory: searchCategory,
            productName: productName
        }, function (data) {
            let productListItem = "";
            let dataLength = data == null ? 1 : data.length;

            $.each(data, (idx, value) => {
                productListItem += `
                    <li class="productList" id="listItem_\${idx+1}">
                        <span><input type="checkbox"></span>
                        <span>\${idx + 1}</span>
                        <span>\${value.productCode}</span>
                        <span data-value="\${value.bigClassificationCode}">\${value.bigClassificationName}</span>
                        <span data-value="\${value.middleClassificationCode}">\${value.middleClassificationName}</span>
                        <span data-value="\${value.smallClassificationCode}">\${value.smallClassificationName}</span>
                        <span>\${value.productKorName}</span>
                        <span>\${value.productEngName}</span>
                        <span>\${value.price.toLocaleString()}</span>
                        <span>\${value.costPrice.toLocaleString()}</span>
                        <span>0</span>
                    </li>
                    `
            })

            if (dataLength < 16) {
                for (let i = dataLength + 1; i < 16; i++) {
                    productListItem += `
                        <li class="productList " id="listItem_\${i}">
                            <span><input type="checkbox"></span>
                            <span>\${i}</span>
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
                        `
                }
            }
            $(`.\${productListName}`).html(productListItem);

            pageName == "product-reg-page" ? clickEvent(".product-list-reg") : clickEvent(".product-list-search");

            let listItemFirstItem = document.querySelector(`.\${productListName} li:nth-child(1)`)
            pageName == "product-reg-page" ? getBasicInformation(listItemFirstItem, ".product-reg-page") : getBasicInformation(listItemFirstItem, ".product-search-page");
        }, "json")
    }

    function clickEvent(pageClassName) {
        document.querySelectorAll(`\${pageClassName} .productList`).forEach((element, idx) => {
            let listItemLastItem = document.querySelector(`\${pageClassName} li:nth-child(1)`)
            listItemLastItem.style.backgroundColor = "rgb(232,232,232)"
            listItemLastItem.style.color = "red"
            listItemLastItem.classList.add("checked")
            element.addEventListener("click", function () {
                let lastCheckedEl = document.querySelector(".checked")
                lastCheckedEl.style.backgroundColor = "inherit"
                lastCheckedEl.style.color = "black"
                lastCheckedEl.classList.remove("checked")

                element.style.backgroundColor = "rgb(232,232,232)"
                element.style.color = "red"
                element.classList.add("checked")
                pageClassName == ".product-list-reg" ? getBasicInformation(element, ".product-reg-page") :
                    getBasicInformation(element, ".product-search-page");
            })
        })
    }

    function getBasicInformation(element, pageClassName) {
        setBasicIBigC(element, pageClassName);
        let productKorName = element.children[6].textContent;
        $(`\${pageClassName} div > #basic-i-productKorName`).val(productKorName);

        let productEngName = element.children[7].textContent;
        $(`\${pageClassName} div > #basic-i-productEngName`).val(productEngName);

        let productPrice = element.children[8].textContent;
        $(`\${pageClassName} div > #basic-i-productPrice`).val(productPrice);

        let productCostPrice = element.children[9].textContent;
        $(`\${pageClassName} div > #basic-i-productCostPrice `).val(productCostPrice);
    }

    function setBasicIBigC(element, pageClassName) {
        let bigClassificationCode = element.children[3].dataset.value;
        let bigClassificationNode = document.querySelector(`\${pageClassName} div > #basic-i-bigC`);

        while (bigClassificationNode.firstChild) {
            bigClassificationNode.removeChild(bigClassificationNode.firstChild);
        }
        $.get("/usr/basic-information/getBigClassification", {}, function (data) {
            if (data != null) {
                for (let i = 0; i < data.length; i++) {
                    let bigClassificationSelect = document.querySelector(`\${pageClassName} div > #basic-i-bigC`);
                    let bigSelectOption = document.createElement("option");
                    bigSelectOption.textContent = data[0].bigClassificationName;
                    bigSelectOption.value = data[0].bigClassificationCode;
                    bigSelectOption.id = data[0].bigClassificationCode;
                    bigClassificationSelect.appendChild(bigSelectOption);

                    if (bigSelectOption.value == bigClassificationCode) {
                        bigSelectOption.selected = true
                    }
                }

                setBasicIMiddleC(element, pageClassName);
                // $(`\${pageClassName} div > #basic-i-bigC`).change((el) => setBasicIMiddleC(element, pageClassName));
            }
        }, "json")
    }

    function setBasicIMiddleC(element, pageClassName) {
        let middleClassificationCode = element.children[4].dataset.value;
        let bigClassificationSelect = document.querySelector(`\${pageClassName} div > #basic-i-bigC`);
        let classificationOptionId = bigClassificationSelect.options[bigClassificationSelect.selectedIndex].id;

        let middleClassificationNode = document.querySelector(`\${pageClassName} div > #basic-i-middleC`);
        while (middleClassificationNode.firstChild) {
            middleClassificationNode.removeChild(middleClassificationNode.firstChild);
        }

        $.get("/usr/basic-information/getMiddleClassification", {
            bigClassificationCode: classificationOptionId,
            searchClassificationName: ""
        }, function (data) {
            if (data != null) {
                for (let i = 0; i < data.length; i++) {
                    let middleClassificationSelect = document.querySelector(`\${pageClassName} div > #basic-i-middleC`);
                    let middleSelectOption = document.createElement("option");
                    middleSelectOption.textContent = data[i].middleClassificationName;
                    middleSelectOption.value = data[i].middleClassificationCode;
                    middleSelectOption.id = data[i].middleClassificationCode;
                    middleSelectOption.setAttribute("data-value", data[0].bigClassificationCode);
                    middleClassificationSelect.appendChild(middleSelectOption);

                    if (middleSelectOption.value == middleClassificationCode) {
                        middleSelectOption.selected = true;
                    }
                }

                setBasicISmallC(element, pageClassName);
                // $(`\${pageClassName} div > #basic-i-middleC`).change((el) => setBasicISmallC(element, pageClassName));
            }
        }, "json")
    }

    function setBasicISmallC(element, pageClassName) {
        let smallClassificationCode = element.children[5].dataset.value;
        let middleClassificationSelect = document.querySelector(`\${pageClassName} div > #basic-i-middleC`);
        let classificationOptionBigId = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].dataset.value;
        let classificationOptionId = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].id;

        let smallClassificationNode = document.querySelector(`\${pageClassName} div > #basic-i-smallC`);
        while (smallClassificationNode.firstChild) {
            smallClassificationNode.removeChild(smallClassificationNode.firstChild);
        }

        $.get("/usr/basic-information/getSmallClassification", {
            bigClassificationCode: classificationOptionBigId,
            middleClassificationCode: classificationOptionId,
            searchClassificationName: ""
        }, function (data) {
            if (data != null) {
                for (let i = 0; i < data.length; i++) {
                    let smallClassificationSelect = document.querySelector(`\${pageClassName} div > #basic-i-smallC`);
                    let smallSelectOption = document.createElement("option");
                    smallSelectOption.textContent = data[i].smallClassificationName;
                    smallSelectOption.value = data[i].smallClassificationCode;
                    smallSelectOption.id = data[i].smallClassificationCode;
                    smallClassificationSelect.appendChild(smallSelectOption);

                    if (smallSelectOption.value == smallClassificationCode) {
                        smallSelectOption.selected = true
                    }
                }
            }
        }, "json")
    }


    $(".product-reg-page div > #basic-i-bigC").change((el) => updateBasicIBigC(el.target))
    $(".product-reg-page div > #basic-i-middleC").change((el) => updateBasicIMiddleC(el.target))
    $(".product-reg-page div > #basic-i-smallC").change((el) => updateBasicISmallC(el.target))

    function updateBasicIBigC(selectedOption) {
        let selectedEl = document.querySelector(".product-list-reg li.checked")
        let bigCName = selectedOption.options[selectedOption.selectedIndex].textContent;
        let bigCId = selectedOption.options[selectedOption.selectedIndex].id;
        selectedEl.children[3].textContent = bigCName;
        selectedEl.children[3].setAttribute("data-value", bigCId);
        setBasicIMiddleC(selectedEl, ".product-reg-page");
    }

    function updateBasicIMiddleC(selectedOption) {
        let selectedEl = document.querySelector(".product-list-reg li.checked")
        let middleCName = selectedOption.options[selectedOption.selectedIndex].textContent;
        let middleCId = selectedOption.options[selectedOption.selectedIndex].id;
        selectedEl.children[4].textContent = middleCName;
        selectedEl.children[4].setAttribute("data-value", middleCId);
        setBasicISmallC(selectedEl, ".product-reg-page");
        updateBasicISmallC($(".product-reg-page div > #basic-i-smallC")[0]);
    }

    function updateBasicISmallC(selectedOption) {
        console.log($(".product-reg-page div > #basic-i-smallC")[0].options.selected)
        let selectedEl = document.querySelector(".product-list-reg li.checked")
        let smallCName = selectedOption.options[selectedOption.selectedIndex].textContent;
        let smallCId = selectedOption.options[selectedOption.selectedIndex].id;

        selectedEl.children[5].textContent = smallCName;
        selectedEl.children[5].setAttribute("data-value", smallCId);
    }
</script>
<%@include file="../common/footer.jsp" %>