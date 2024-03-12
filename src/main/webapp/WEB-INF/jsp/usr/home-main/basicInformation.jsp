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

    <%-- ====================== 상품관리  ======================== --%>
<%--    <%@include file="../basicInformation/salesInformationManagement.jsp" %>--%>
<%--    <%@include file="../basicInformation/productSearchPage.jsp" %>--%>
<%--    <%@include file="../basicInformation/productRegistrationPage.jsp" %>--%>

    <%-- ====================== 터치키상품 관리  ======================== --%>
    <%@include file="../basicInformation/touchKeyProductRegistration.jsp" %>
</div>

<script>
    function classificationManagement() {
        $("#classificationManagement").css("color", "#FBD3AD");
        $(".basicInformation-left").css("display", "flex");

        $("#productLookUp").css("color", "#FFFFFF");
        $(".product-lookUp-page").css("display", "none")

        $("#addProductPage").css("color", "#FFFFFF");
        $(".add-product-page").css("display", "none");

        $(".basicInformation-left").unwrap();
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
        $(".basicInformation-left").load(location.href + ' .basicInformation-left');

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
        $(".basicInformation-left").load(location.href + ' .basicInformation-left');

        $(".add-product-page").unwrap();
    }

    //  ====================================== //
    function mine() {
        $(event.target).select();
    }

    function getBigClassifications(pageIdName) {
        $.get("/usr/basic-information/getBigClassification", {
            searchClassificationName: ""
        }, function (data) {
            if (data != null) {
                for (let i = 0; i < data.length; i++) {
                    let bigClassificationSelect = document.querySelector(`\${pageIdName} div:nth-child(1) #bigClassification-box`);
                    let bigSelectOption = document.createElement("option");
                    bigSelectOption.textContent = data[i].bigClassificationName;
                    bigSelectOption.value = data[i].bigClassificationCode;
                    bigSelectOption.id = data[i].bigClassificationCode;
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
        let middleClassificationNode = document.querySelector(`\${middleIdName}`);

        while (middleClassificationNode.firstChild) {
            middleClassificationNode.removeChild(middleClassificationNode.firstChild);
        }

        if (classificationOptionId != "") {
            $.get("/usr/basic-information/getMiddleClassification", {
                bigClassificationCode: classificationOptionId,
                searchClassificationName: ""
            }, function (data) {
                if (data != null) {
                    let valuesToKeep = ['allMiddleClassification'];
                    let middleClassificationSelect = document.querySelector(`\${middleIdName}`);
                    let options = middleClassificationSelect.getElementsByTagName('option');
                    for (let i = 0; i < options.length; i++) {
                        let option = options[i];
                        if (!valuesToKeep.includes(option.value)) {
                            option.remove();
                        }
                    }
                    for (let i = 0; i < data.length; i++) {
                        let middleSelectOption = document.createElement("option");
                        middleSelectOption.textContent = data[i].middleClassificationName;
                        middleSelectOption.value = data[i].middleClassificationCode;
                        middleSelectOption.id = data[i].middleClassificationCode;
                        middleSelectOption.setAttribute("data-value", data[i].bigClassificationCode);
                        middleClassificationSelect.appendChild(middleSelectOption);

                        if (middleSelectOption.value == middleCode) {
                            middleSelectOption.selected = true;
                        }
                    }
                    getSmallClassifications(middleIdName, smallIdName)
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
        let smallClassificationNode = document.querySelector(`\${smallIdName}`);

        while (smallClassificationNode.firstChild) {
            smallClassificationNode.removeChild(smallClassificationNode.firstChild);
        }
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
            if (data != null) {
                let productListItem = "";
                $.each(data, (idx, value) => {
                    pageName == "product-reg-page" ?
                        productListItem += `
                    <li class="productList \${idx+1 == 1 ? 'checked' : ''}" id="listId_\${value.id}" data-value="listItem_\${idx+1}">
                        <span><input type="checkbox" id="checkbox-product-id" value="\${value.id}"></span>
                        <span>\${idx + 1}</span>
                        <span>\${value.productCode}</span>
                        <span data-value="\${value.bigClassificationCode}">\${value.bigClassificationName}</span>
                        <span data-value="\${value.middleClassificationCode}">\${value.middleClassificationName}</span>
                        <span data-value="\${value.smallClassificationCode}">\${value.smallClassificationName}</span>
                        <span>
                            <input type="text" id="korNameInput_\${value.id}" value="\${value.productKorName}"
                                    onfocus="mine()" onchange="updateProductId(this.id)">
                        </span>
                        <span>
                            <input type="text" id="engNameInput_\${value.id}" value="\${value.productEngName}"
                                    onfocus="mine()" onchange="updateProductId(this.id)">
                        </span>
                        <span>
                            <input type="text" id="priceInput_\${value.id}" value="\${value.price.toLocaleString()}"
                                    onKeyup="this.value=this.value.replace(/[^0-9]/g,'')" onfocus="mine()" onchange="updateProductId(this.id)">
                        </span>
                        <span>
                            <input type="text" id="costPriceInput_\${value.id}" value="\${value.costPrice.toLocaleString()}"
                                    onKeyup="this.value=this.value.replace(/[^0-9]/g,'')" onfocus="mine()" onchange="updateProductId(this.id)">
                        </span>
                        <span>0</span>
                    </li>
                    `
                        : productListItem += `
                    <li class="productList \${idx+1 == 1 ? 'checked' : ''}"" id="listItem_\${idx+1}">
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

                $(`.\${productListName}`).html(productListItem);

                pageName == "product-reg-page" ? clickEvent(".product-list-reg") : clickEvent(".product-list-search");

                let listItemFirstItem = document.querySelector(`.\${productListName} li:nth-child(1)`)

                scrollToSelectedItem(listItemFirstItem)

                pageName == "product-reg-page" ? setBasicInformation(listItemFirstItem, ".product-reg-page", ".product-list-reg") :
                    setBasicInformation(listItemFirstItem, ".product-search-page", ".product-list-search");
            } else {
                let msgBox = `
                        <div class="is-empty-msg">
                            <span>검색하신 정보가 존재하지 않습니다.</span>
                        </div>
                `
                $(`.\${productListName}`).html(msgBox);
            }
        }, "json")
    }

    function clickEvent(pageClassName) {
        document.querySelectorAll(`\${pageClassName} .productList`).forEach((element, idx) => {
            let listItemLastItem = document.querySelector(`\${pageClassName} li.checked`)
            listItemLastItem.style.backgroundColor = "rgb(232,232,232)"
            listItemLastItem.style.color = "red"
            listItemLastItem.classList.add("checked")

            element.addEventListener("click", function () {
                let lastCheckedEl = document.querySelector(`\${pageClassName} li.checked`)
                lastCheckedEl.style.backgroundColor = "inherit"
                lastCheckedEl.style.color = "black"
                lastCheckedEl.classList.remove("checked")
                element.style.backgroundColor = "rgb(232,232,232)"
                element.style.color = "red"
                element.classList.add("checked")
                pageClassName == ".product-list-reg" ? setBasicInformation(element, ".product-reg-page", ".product-list-reg") :
                    setBasicInformation(element, ".product-search-page", ".product-list-search");
            })
        })
    }

    function setBasicInformation(element, pageClassName, pageClassName2) {
        setBasicIBigC(element, pageClassName, pageClassName2);
        if (pageClassName == ".product-reg-page" && element != null) {
            let productKorName = element.children[6].children[0].value;
            $(`\${pageClassName} div > #basic-i-productKorName`).val(productKorName);

            let productEngName = element.children[7].children[0].value;
            $(`\${pageClassName} div > #basic-i-productEngName`).val(productEngName);

            let productPrice = element.children[8].children[0].value;
            $(`\${pageClassName} div > #basic-i-productPrice`).val(productPrice.replace(",", ""));

            let productCostPrice = element.children[9].children[0].value;
            $(`\${pageClassName} div > #basic-i-productCostPrice `).val(productCostPrice.replace(",", ""));

        } else if (pageClassName == ".product-search-page" && element != null) {
            let productKorName = element.children[6].textContent;
            $(`\${pageClassName} div > #basic-i-productKorName`).val(productKorName);

            let productEngName = element.children[7].textContent;
            $(`\${pageClassName} div > #basic-i-productEngName`).val(productEngName);

            let productPrice = element.children[8].textContent;
            $(`\${pageClassName} div > #basic-i-productPrice`).val(productPrice);

            let productCostPrice = element.children[9].textContent;
            $(`\${pageClassName} div > #basic-i-productCostPrice `).val(productCostPrice);
        }
    }

    function setBasicIBigC(element, pageClassName, pageClassName2) {
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
                    bigSelectOption.textContent = data[i].bigClassificationName;
                    bigSelectOption.value = data[i].bigClassificationCode;
                    bigSelectOption.id = data[i].bigClassificationCode;
                    bigClassificationSelect.appendChild(bigSelectOption);

                    if (bigSelectOption.value == bigClassificationCode) {
                        bigSelectOption.selected = true
                        updateBasicIBigC(bigClassificationSelect, pageClassName, pageClassName2);
                    }
                }
            }
        }, "json")
    }

    function setBasicIMiddleC(element, pageClassName, pageClassName2) {
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
                    middleSelectOption.setAttribute("data-value", data[i].bigClassificationCode);
                    middleClassificationSelect.appendChild(middleSelectOption);

                    if (middleSelectOption.value == middleClassificationCode) {
                        middleSelectOption.selected = true;
                        updateBasicIMiddleC(middleClassificationSelect, pageClassName, pageClassName2);
                    }
                }
            }
        }, "json")
    }

    function setBasicISmallC(element, pageClassName, pageClassName2) {
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
                        updateBasicISmallC(smallClassificationSelect, pageClassName, pageClassName2);
                    }
                }
            }
        }, "json")
    }

    function updateBasicIBigC(selectedOption, pageClassName, pageClassName2) {
        let selectedEl = document.querySelector(`\${pageClassName2} li.checked`)
        if (selectedEl != null) {
            let bigCName = selectedOption.options[selectedOption.selectedIndex].textContent;
            let bigCId = selectedOption.options[selectedOption.selectedIndex].id;
            selectedEl.children[3].textContent = bigCName;
            selectedEl.children[3].setAttribute("data-value", bigCId);
        }
        setBasicIMiddleC(selectedEl, pageClassName, pageClassName2);
    }

    function updateBasicIMiddleC(selectedOption, pageClassName, pageClassName2) {
        let selectedEl = document.querySelector(`\${pageClassName2} li.checked`)
        if (selectedEl != null) {
            let middleCName = selectedOption.options[selectedOption.selectedIndex].textContent;
            let middleCId = selectedOption.options[selectedOption.selectedIndex].id;
            selectedEl.children[4].textContent = middleCName;
            selectedEl.children[4].setAttribute("data-value", middleCId);
        }
        setBasicISmallC(selectedEl, pageClassName, pageClassName2);
    }

    function updateBasicISmallC(selectedOption, pageClassName, pageClassName2) {
        let selectedEl = document.querySelector(`\${pageClassName2} li.checked`)
        if (selectedEl != null) {
            let smallCName = selectedOption.options[selectedOption.selectedIndex].textContent;
            let smallCId = selectedOption.options[selectedOption.selectedIndex].id;

            selectedEl.children[5].textContent = smallCName;
            selectedEl.children[5].setAttribute("data-value", smallCId);
        }
    }

    function addProductLine() {
        $(".product-list-reg").css("display", "flex");
        $(".product-add-container-curtain").css("display", "none")
        let productListLength = $(".product-list-reg li").length

        let bigClassificationNode = document.querySelector(`.product-reg-page div > #basic-i-bigC`);
        while (bigClassificationNode.firstChild) {
            bigClassificationNode.removeChild(bigClassificationNode.firstChild);
        }
        $.get("/usr/basic-information/getBigClassification", {}, function (data) {
            if (data != null) {
                for (let i = 0; i < data.length; i++) {
                    let bigClassificationSelect = document.querySelector(`.product-reg-page div > #basic-i-bigC`);
                    let bigSelectOption = document.createElement("option");
                    bigSelectOption.textContent = data[i].bigClassificationName;
                    bigSelectOption.value = data[i].bigClassificationCode;
                    bigSelectOption.id = data[i].bigClassificationCode;
                    bigClassificationSelect.appendChild(bigSelectOption);
                }

                let bigClassificationSelect = document.querySelector(`.product-reg-page div > #basic-i-bigC`);
                let classificationOptionId = bigClassificationSelect.options[bigClassificationSelect.selectedIndex].id;

                let middleClassificationNode = document.querySelector(`.product-reg-page div > #basic-i-middleC`);
                while (middleClassificationNode.firstChild) {
                    middleClassificationNode.removeChild(middleClassificationNode.firstChild);
                }
                $.get("/usr/basic-information/getMiddleClassification", {
                    bigClassificationCode: classificationOptionId,
                    searchClassificationName: ""
                }, function (data) {
                    if (data != null) {
                        for (let i = 0; i < data.length; i++) {
                            let middleClassificationSelect = document.querySelector(`.product-reg-page div > #basic-i-middleC`);
                            let middleSelectOption = document.createElement("option");
                            middleSelectOption.textContent = data[i].middleClassificationName;
                            middleSelectOption.value = data[i].middleClassificationCode;
                            middleSelectOption.id = data[i].middleClassificationCode;
                            middleSelectOption.setAttribute("data-value", data[i].bigClassificationCode);
                            middleClassificationSelect.appendChild(middleSelectOption);
                        }

                        let middleClassificationSelect = document.querySelector(`.product-reg-page div > #basic-i-middleC`);
                        let classificationOptionBigId = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].dataset.value;
                        let classificationOptionId = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].id;

                        let smallClassificationNode = document.querySelector(`.product-reg-page div > #basic-i-smallC`);
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
                                    let smallClassificationSelect = document.querySelector(`.product-reg-page div > #basic-i-smallC`);
                                    let smallSelectOption = document.createElement("option");
                                    smallSelectOption.textContent = data[i].smallClassificationName;
                                    smallSelectOption.value = data[i].smallClassificationCode;
                                    smallSelectOption.id = data[i].smallClassificationCode;
                                    smallClassificationSelect.appendChild(smallSelectOption);
                                }

                                let bigClassificationSelect = document.querySelector(`.product-reg-page div > #basic-i-bigC`);
                                let middleClassificationSelect = document.querySelector(`.product-reg-page div > #basic-i-middleC`);
                                let smallClassificationSelect = document.querySelector(`.product-reg-page div > #basic-i-smallC`);
                                let bigCName = bigClassificationSelect.options[bigClassificationSelect.selectedIndex].textContent;
                                let bigCCode = bigClassificationSelect.options[bigClassificationSelect.selectedIndex].value;
                                let middleCName = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].textContent;
                                let middleCCode = middleClassificationSelect.options[middleClassificationSelect.selectedIndex].value;
                                let smallCName = smallClassificationSelect.options[smallClassificationSelect.selectedIndex].textContent;
                                let smallCCode = smallClassificationSelect.options[smallClassificationSelect.selectedIndex].value;
                                let productCode = productListLength.toString();
                                let productListItem = `
                                <li class="productList new-pro-item" id="listItem_\${productListLength+1}">
                                    <span><input type="checkbox"></span>
                                    <span>\${productListLength+1}</span>
                                    <span></span>
                                    <span data-value="\${bigCCode}">\${bigCName}</span>
                                    <span data-value="\${middleCCode}">\${middleCName}</span>
                                    <span data-value="\${smallCCode}">\${smallCName}</span>
                                    <span><input type="text"></span>
                                    <span><input type="text"></span>
                                    <span><input type="text"></span>
                                    <span><input type="text"></span>
                                    <span></span>
                                </li>
                                `
                                $(".product-list-reg").append(productListItem);

                                if (productListLength == 0) {
                                    let productListFirChild1 = document.querySelector(".product-list-reg li:first-child")
                                    productListFirChild1.style.backgroundColor = "rgb(232,232,232)";
                                    productListFirChild1.style.color = "red";
                                    productListFirChild1.classList.add("checked");
                                }

                                let productListFirChild = document.querySelector(".product-list-reg li.checked")
                                let productListLastChild = document.querySelector(".product-list-reg li:last-child")
                                productListFirChild.style.backgroundColor = "inherit";
                                productListFirChild.style.color = "black";
                                productListFirChild.classList.remove("checked");

                                productListLastChild.style.backgroundColor = "rgb(232,232,232)";
                                productListLastChild.style.color = "red";
                                productListLastChild.classList.add("checked");
                                scrollToSelectedItem(productListLastChild);

                                document.querySelectorAll(`.product-list-reg li`).forEach((element, idx) => {
                                    let listItemLastItem = document.querySelector(`.product-list-reg li.checked`)
                                    listItemLastItem.style.backgroundColor = "rgb(232,232,232)"
                                    listItemLastItem.style.color = "red"
                                    listItemLastItem.classList.add("checked")

                                    element.addEventListener("click", function () {
                                        let lastCheckedEl = document.querySelector(`.product-list-reg li.checked`)
                                        lastCheckedEl.style.backgroundColor = "inherit"
                                        lastCheckedEl.style.color = "black"
                                        lastCheckedEl.classList.remove("checked")
                                        element.style.backgroundColor = "rgb(232,232,232)"
                                        element.style.color = "red"
                                        element.classList.add("checked")
                                    })
                                })
                            }
                        }, "json")
                    }
                }, "json")
            }
        }, "json")
    }

    function removeProductLine() {
        let productListLength = $(".product-list-reg li").length

        if (productListLength != 0) {
            let productListLastChild = document.querySelector(".product-list-reg li.new-pro-item:last-child")
            if (productListLastChild != null && productListLength > 0) {
                productListLastChild.remove();
                if (productListLength > 1) {
                    let productListLastChild2 = document.querySelector(".product-list-reg li:last-child")
                    productListLastChild2.classList.add("checked")
                    productListLastChild2.style.backgroundColor = "rgb(232,232,232)";
                    productListLastChild2.style.color = "red";
                }
            } else {
                alert("삭제하시려면 선택하신 후 삭제 버튼을 눌러주세요.");
            }
        }
    }

    function scrollToSelectedItem(selectedItem) {
        selectedItem.scrollIntoView({
            behavior: 'smooth',
            block: 'end',
            inline: "nearest"
        });
    }

    function addProduct() {
        let newProductLength = document.querySelectorAll(".product-list-reg li.new-pro-item").length
        let updateProductIds = document.querySelectorAll(".product-list-reg li.update-pro-item")
        if (newProductLength != 0) {
            let bigClassificationCodeList = [];
            let middleClassificationCodeList = [];
            let smallClassificationCodeList = [];
            let productKorNameList = [];
            let productEngNameList = [];
            let priceList = [];
            let costPriceList = [];
            document.querySelectorAll(".product-list-reg li.new-pro-item").forEach((el) => {
                bigClassificationCodeList.push(el.children[3].dataset.value);
                middleClassificationCodeList.push(el.children[4].dataset.value);
                smallClassificationCodeList.push(el.children[5].dataset.value);
                productKorNameList.push(el.children[6].children[0].value);
                productEngNameList.push(el.children[7].children[0].value);
                priceList.push(el.children[8].children[0].value != '' ? el.children[8].children[0].value : 0);
                costPriceList.push(el.children[9].children[0].value != '' ? el.children[9].children[0].value : 0);
            });

            $.post("/usr/basic-information/addProduct", {
                bigClassificationCodeList: bigClassificationCodeList.join(","),
                middleClassificationCodeList: middleClassificationCodeList.join(","),
                smallClassificationCodeList: smallClassificationCodeList.join(","),
                productKorNameList: productKorNameList.join(","),
                productEngNameList: productEngNameList.join(","),
                priceList: priceList.join(","),
                costPriceList: costPriceList.join(",")
            }, function (data) {
                if (data == '성공') {
                    let productListFirstChild = document.querySelector(".product-list-reg li:first-child");
                    productSearchBtn('product-reg-page', 'product-list-reg');
                    scrollToSelectedItem(productListFirstChild);
                }
            })
        }

        if (updateProductIds.length != 0) {
            let updateProductIdList = [];
            let bigClassificationCodeList = [];
            let middleClassificationCodeList = [];
            let smallClassificationCodeList = [];
            let productKorNameList = [];
            let productEngNameList = [];
            let priceList = [];
            let costPriceList = [];

            updateProductIds.forEach((el) => {
                updateProductIdList.push(el.id.substring(el.id.indexOf("_") + 1));
                bigClassificationCodeList.push(el.children[3].dataset.value);
                middleClassificationCodeList.push(el.children[4].dataset.value);
                smallClassificationCodeList.push(el.children[5].dataset.value);
                productKorNameList.push(el.children[6].children[0].value);
                productEngNameList.push(el.children[7].children[0].value);
                priceList.push(el.children[8].children[0].value != '' ? el.children[8].children[0].value.replace(",", "") : 0);
                costPriceList.push(el.children[9].children[0].value != '' ? el.children[9].children[0].value.replace(",", "") : 0);
            });

            console.log(updateProductIdList)
            $.post("/usr/basic-information/modifyProduct", {
                updateProductIdList: updateProductIdList.join(","),
                bigClassificationCodeList: bigClassificationCodeList.join(","),
                middleClassificationCodeList: middleClassificationCodeList.join(","),
                smallClassificationCodeList: smallClassificationCodeList.join(","),
                productKorNameList: productKorNameList.join(","),
                productEngNameList: productEngNameList.join(","),
                priceList: priceList.join(","),
                costPriceList: costPriceList.join(",")
            }, function (data) {
                if (data.success) {
                    let productListFirstChild = document.querySelector(".product-list-reg li:first-child");
                    productSearchBtn('product-reg-page', 'product-list-reg');
                    scrollToSelectedItem(productListFirstChild);
                }
            }, "json")
        }
    }

    function updateProductId(el) {
        let selectedEl = document.querySelector(".product-list-reg li.checked");
        selectedEl.classList.add("update-pro-item");

        if (el) {
            let listId = "#listId_".concat(el.substring(el.indexOf("_") + 1));
            let selectedLi = document.querySelector(listId);
            selectedLi.classList.add("update-pro-item");
        }
    }

    function delProduct() {
        const values = $('#checkbox-product-id:checked').map((index, el) => el.value).toArray();
        if (values != 0) {
            $.post("/usr/basic-information/delProduct", {
                delProductIds: values.join(","),
            }, function (data) {
                if (data.success) {
                    let productListFirstChild = document.querySelector(".product-list-reg li:first-child");
                    productSearchBtn('product-reg-page', 'product-list-reg');
                    scrollToSelectedItem(productListFirstChild);
                }
            }, "json")
        }
    }

</script>
<%@include file="../common/footer.jsp" %>