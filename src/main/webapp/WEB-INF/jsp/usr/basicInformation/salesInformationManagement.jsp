<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="basicInformation-left">
    <div class="productClassificationPage">
        <div class="classification-top">
            <div>
                <span class="material-symbols-outlined pr-2 text-red-400">arrow_circle_right</span>
                <span>기초정보관리 > 상품관리 > 상품분류관리</span>
            </div>
            <div>
                <button class="btn btn-active btn-sm" id="save-btn">저장</button>
                <button class="btn btn-active btn-sm pl-2" id="remove-btn">삭제</button>
            </div>
        </div>
        <div class="classification-middle">
            <ul>
                <li>
                    <span>대분류명</span>
                    <input id="bigClassificationName" type="text" value="">
                    <button onclick="getBigClassificationList($('#bigClassificationName')[0].value);"
                            class="btn btn-sm btn-error" id="getBigClassification">조회
                    </button>
                </li>
                <li>
                    <span>중분류명</span>
                    <input type="text">
                    <button class="btn btn-sm btn-error">조회</button>
                </li>
                <li>
                    <span>소분류명</span>
                    <input type="text">
                    <button class="btn btn-sm btn-error">조회</button>
                </li>
            </ul>
        </div>
        <div class="classification-bottom">
            <div class="classification-boxes">
                <div class="remove-add-btn">
                    <span onclick="addClassification('productBigClassification');"
                          class="material-symbols-outlined btn btn-active btn-xs h-full " id="productBigClassification">add</span>
                    <span onclick="removeClassification('productBigClassification');"
                          class="material-symbols-outlined btn btn-active btn-xs h-full ml-1">remove</span>
                </div>
                <div>
                    <input type="checkbox" disabled>
                    <span>대분류코드</span>
                    <span>대분류명</span>
                    <span>중분류수</span>
                </div>
                <ul class="productBigClassification"></ul>
            </div>
            <div class="classification-boxes">
                <div class="remove-add-btn">
                    <span onclick="addClassification('productMiddleClassification');"
                          class="material-symbols-outlined btn btn-active btn-xs h-full "
                          id="productMiddleClassification">add</span>
                    <span onclick="removeClassification('productMiddleClassification');"
                          class="material-symbols-outlined btn btn-active btn-xs h-full ml-1">remove</span>
                </div>
                <div>
                    <input type="checkbox" disabled>
                    <span>중분류코드</span>
                    <span>중분류명</span>
                    <span>소분류수</span>
                </div>
                <ul class="productMiddleClassification"></ul>
            </div>
            <div class="classification-boxes">
                <div class="remove-add-btn">
                    <span onclick="addClassification('productSmallClassification');"
                          class="material-symbols-outlined btn btn-active btn-xs h-full "
                          id="productSmallClassification">add</span>
                    <span onclick="removeClassification('productSmallClassification');"
                          class="material-symbols-outlined btn btn-active btn-xs h-full ml-1">remove</span>
                </div>
                <div>
                    <input type="checkbox" disabled>
                    <span>소분류코드</span>
                    <span>소분류명</span>
                    <span>상품수</span>
                </div>
                <ul class="productSmallClassification"></ul>
            </div>
        </div>
    </div>
</div>

<script>
    let beforeEmptyListLength = 0;  // 나중에 무조건 해결 해야함
    let selectedClassName = "";     // 나중에 무조건 해결 해야함

    function selectedItem(className) {
        document.querySelectorAll(`.\${className} li`).forEach((element, idx) => {
            element.addEventListener("click", function () {
                let lastCheckedEl = document.querySelector(`.\${className} .checked`)
                lastCheckedEl.style.backgroundColor = "#FFFFFF"
                lastCheckedEl.classList.remove("checked")

                element.style.backgroundColor = "rgba(172, 172, 172, 0.3)"
                element.classList.add("checked")
                element.children[2].style.backgroundColor = "rgba(172, 172, 172, 0)";

                if (className == "productBigClassification") {
                    getMiddleClassificationList("", element.children[1].textContent);
                } else if (className == "productMiddleClassification") {
                    let bigClassificationCode = $(".productBigClassification .checked")[0].children[1].textContent
                    getSmallClassificationList("", element.children[1].textContent, bigClassificationCode);
                }

                selectedClassName = className;
            });
        });
    }

    function showEmptyMsg(className) {
        let msgBox = `<span class="alertMsg">해당되는 자료가 존재하지 않습니다.</span>`
        $(`.\${className}`).empty();
        $(`.\${className}`).append(msgBox);
    }

    function addClassification(className) {
        selectedClassName = className;
        let currEmptyListLength = document.querySelectorAll(`.\${className} .emptyList`).length;
        let listItemLength = document.querySelectorAll(`.\${className} li`).length;
        let classificationName = className.replace("product", "").replace("Classification", "").toLowerCase();
        let listId = classificationName + "_00" + (listItemLength + 1);

        if (beforeEmptyListLength == currEmptyListLength) {
            let classificationStr = `
                <li class="emptyList">
                    <input type="checkbox" id="\${listId}" >
                    <span>00\${listItemLength + 1}</span>
                    <input type="text" value="">
                    <span></span>
                </li>
                `

            let checkedItem = $(`.\${className} .checked`);
            if (checkedItem != null) {
                checkedItem.css("backgroundColor", "#FFFFFF");
                checkedItem.removeClass("checked");
            }

            $(`.\${className} .alertMsg`).remove();
            $(`.\${className}`).append(classificationStr);
            $(`.\${className} li:last-child`).addClass("checked");
            let childIdx = $(`.\${className} li`).length
            let lastChild = $(`.\${className} li:last-child`)[0];

            if (childIdx > 1) {
                $(`.\${className} li:nth-child(\${childIdx-1})`).css("backgroundColor", "#FFFFFF");
                $(`.\${className} li:nth-child(\${childIdx -1}) > input:nth-child(3)`).css("backgroundColor", "#FFFFFF");
                $(`.\${className} li:nth-child(\${childIdx - 1})`).removeClass("checked");
            }

            $(`.\${className} li:nth-child(\${childIdx})`).css("backgroundColor", "rgba(172, 172, 172, 0.3)");
            $(`.\${className} li:nth-child(\${childIdx}) > input:nth-child(3)`).css("backgroundColor", "rgba(172, 172, 172, 0)");

            selectedItem(className);

            if (className == "productBigClassification") {
                getMiddleClassificationList("", "");
            } else if (className == "productMiddleClassification") {
                getSmallClassificationList("", "", "");
            }

            beforeEmptyListLength = document.querySelectorAll(`.\${className} .emptyList`).length

        } else {
            switch (className) {
                case "productBigClassification" :
                    alert("변겅된 내역이 있습니다. 저장하세요.")
                    break
                case "productMiddleClassification" :
                    alert("대분류 정보은 변경된 사항이 있습니다. 변경을 저장후 소분류 정보 등록을 수행하세요.")
                    break
                case "productSmallClassification" :
                    alert("중분류 정보은 변경된 사항이 있습니다. 변경을 저장후 소분류 정보 등록을 수행하세요.")
                    break
            }
        }
    }

    function removeClassification(className) {
        let classificationListLength = $(`.\${className} .emptyList`).length

        if (classificationListLength != 0) {
            beforeEmptyListLength--;
            $(`.\${className} .checked`).remove('.checked');
            let childIdx = $(`.\${className} li`).length
            let lastChild = $(`.\${className} li:last-child`)[0];

            $(`.\${className} li:nth-child(\${childIdx})`).css("backgroundColor", "rgba(172, 172, 172, 0.3)");
            $(`.\${className} li:nth-child(\${childIdx}) > input:nth-child(3)`).css("backgroundColor", "rgba(172, 172, 172, 0)");
            $(`.\${className} li:last-child`).addClass("checked");
            let lastChildName = $(`.\${className} li:last-child`)

            if (className == "productBigClassification" && lastChildName.length != 0) {
                getMiddleClassificationList("", lastChildName[0].children[1].textContent);
            } else if (className == "productMiddleClassification" && lastChildName.length != 0) {
                let bigClassificationCode = $(".productBigClassification .checked")[0].children[1].textContent
                getSmallClassificationList("", lastChildName[0].children[1].textContent, bigClassificationCode);
            }

        } else {
            alert("삭제하시려면 선택하신 후 삭제 버튼을 눌러주세요.");
        }
    }

    function getBigClassificationList(searchClassificationName) {
        beforeEmptyListLength = 0;
        $.get("/usr/basic-information/getBigClassification", {
            searchClassificationName: searchClassificationName
        }, function (data) {
            let bigClassificationList = data.data1
            let bigClassificationNode = document.querySelector(".productBigClassification");

            // ============== bigClassification ========= //
            while (bigClassificationNode.firstChild) {
                bigClassificationNode.removeChild(bigClassificationNode.firstChild);
            }
            $.each(bigClassificationList, (idx, value) => {

                let bigListItem = document.createElement("li");
                let input1 = document.createElement('input')
                input1.type = "checkbox";
                input1.id = "big_" + value.bigClassificationCode;
                value.middleClassificationCnt != 0 ? input1.disabled = true : input1.disabled = false;
                bigListItem.appendChild(input1);

                let span1 = document.createElement('span');
                span1.textContent = value.bigClassificationCode;
                bigListItem.appendChild(span1);

                let input2 = document.createElement('input');
                input2.value = value.bigClassificationName
                bigListItem.appendChild(input2);

                let span2 = document.createElement('span');
                span2.textContent = value.middleClassificationCnt
                bigListItem.appendChild(span2);
                bigClassificationNode.appendChild(bigListItem);

                let bigLastChild = document.querySelector(".productBigClassification li:first-child");

                bigLastChild.classList.add("checked");
                bigLastChild.style.backgroundColor = "rgba(172, 172, 172, 0.3)";
                bigLastChild.children[2].style.backgroundColor = "rgba(172, 172, 172, 0)";

            });

            if (bigClassificationList == null) {
                showEmptyMsg("productBigClassification");
                getMiddleClassificationList("", "");
            } else {
                let bigLastChild = document.querySelector(".productBigClassification li:first-child");
                let bigLastChildCode = bigLastChild.children[1].textContent
                getMiddleClassificationList("", bigLastChildCode);
                selectedItem("productBigClassification");
            }
        }, "json")
    }

    function getMiddleClassificationList(searchClassificationName, bigClassificationCode) {
        $.get("/usr/basic-information/getMiddleClassification", {
            classificationCode: bigClassificationCode,
            searchClassificationName: searchClassificationName
        }, function (data) {
            let middleClassificationList = data.data1
            let middleClassificationNode = document.querySelector(".productMiddleClassification");

            // ========== middleClassification ============== //
            while (middleClassificationNode.firstChild) {
                middleClassificationNode.removeChild(middleClassificationNode.firstChild);
            }
            $.each(middleClassificationList, (idx, value) => {

                let middleListItem = document.createElement("li");

                let input1 = document.createElement('input')
                input1.type = "checkbox";
                input1.id = "middle_" + value.middleClassificationCode;
                value.smallClassificationCnt != 0 ? input1.disabled = true : input1.disabled = false;
                middleListItem.appendChild(input1);

                let span1 = document.createElement('span');
                span1.textContent = value.middleClassificationCode;
                middleListItem.appendChild(span1);

                let input2 = document.createElement('input');
                input2.value = value.middleClassificationName
                middleListItem.appendChild(input2);

                let span2 = document.createElement('span');
                span2.textContent = value.smallClassificationCnt
                middleListItem.appendChild(span2);

                middleClassificationNode.appendChild(middleListItem);
                let middleLastChild = document.querySelector(".productMiddleClassification li:first-child");

                middleLastChild.classList.add("checked");
                middleLastChild.style.backgroundColor = "rgba(172, 172, 172, 0.3)";
                middleLastChild.children[2].style.backgroundColor = "rgba(172, 172, 172, 0)";

            });

            if (middleClassificationList == null) {
                showEmptyMsg("productMiddleClassification");
                getSmallClassificationList("", "", "");
            } else {
                let middleLastChild = document.querySelector(".productMiddleClassification li:first-child");
                let middleLastChildCode = middleLastChild.children[1].textContent
                let bigClassificationCode = $(".productBigClassification .checked")[0].children[1].textContent
                getSmallClassificationList("", middleLastChildCode, bigClassificationCode);
                selectedItem("productMiddleClassification");
            }

        }, "json")
    }

    function getSmallClassificationList(searchClassificationName, middleClassificationCode, bigClassificationCode) {
        $.get("/usr/basic-information/getSmallClassification", {
            bigClassificationCode: bigClassificationCode,
            middleClassificationCode: middleClassificationCode,
            searchClassificationName: searchClassificationName
        }, function (data) {
            let smallClassificationList = data.data1
            let smallClassificationNode = document.querySelector(".productSmallClassification");

            // ========= smallClassification ============== //
            while (smallClassificationNode.firstChild) {
                smallClassificationNode.removeChild(smallClassificationNode.firstChild);
            }
            $.each(smallClassificationList, (idx, value) => {

                let smallListItem = document.createElement("li");
                let input1 = document.createElement('input')
                input1.type = "checkbox";
                input1.id = "small_" + value.smallClassificationCode;
                value.productCnt != 0 ? input1.disabled = true : input1.disabled = false;
                smallListItem.appendChild(input1);

                let span1 = document.createElement('span');
                span1.textContent = value.smallClassificationCode;
                smallListItem.appendChild(span1);

                let input2 = document.createElement('input');
                input2.value = value.smallClassificationName
                smallListItem.appendChild(input2);

                let span2 = document.createElement('span');
                span2.textContent = value.productCnt
                smallListItem.appendChild(span2);

                smallClassificationNode.appendChild(smallListItem);

                let smallLastChild = document.querySelector(".productSmallClassification li:first-child");
                smallLastChild.classList.add("checked");
                smallLastChild.style.backgroundColor = "rgba(172, 172, 172, 0.3)";
                smallLastChild.children[2].style.backgroundColor = "rgba(172, 172, 172, 0)";
            });

            selectedItem("productSmallClassification");
            if (smallClassificationList == null) {
                showEmptyMsg("productSmallClassification");
            }

        }, "json")
    }

    $("#save-btn").click(function () {
        const classificationList = $(`.\${selectedClassName} li`).map((idx, el) => el.children[2].value).toArray();
        const classificationCodeList = $(`.\${selectedClassName} li`).map((idx, el) => el.children[1].textContent).toArray();
        const bigClassificationCode = $(".productBigClassification li.checked")[0].children[1].textContent;
        let middleClassificationCode = "";
        let middleClassification = $(".productMiddleClassification li.checked");

        if (middleClassification.length != 0) {
            middleClassificationCode = middleClassification[0].children[1].textContent
        }

        if (classificationList.length != 0) {
            let result = confirm("저장 하시겠습니까?");
            if (result) {
                $.get("/usr/basic-information/createClassification", {
                    classificationNameList: classificationList.join(","),
                    classificationCodeList: classificationCodeList.join(","),
                    classificationName: selectedClassName,
                    bigClassificationCode: bigClassificationCode,
                    middleClassificationCode: middleClassificationCode
                }, function (data) {
                }, "json")

                alert("정산적로 저장되었습니다.");
                getBigClassificationList("");
                getMiddleClassificationList("", "");
                getSmallClassificationList("", "", "");
            }
        }
    })

    $("#remove-btn").click(function () {
        let removeClassifications = $(".classification-bottom div > ul li > input:first-child:checked").toArray();

        if (removeClassifications.length != 0) {
            for (let i = 0; i < removeClassifications.length; i++) {
                let removeClassificationId = removeClassifications[i].id.substring(removeClassifications[i].id.indexOf("_") + 1);
                let removeClassificationType = removeClassifications[i].id.substring(0, removeClassifications[i].id.indexOf("_"));
                let checkedBigClassificationCode = $(".productBigClassification li.checked")[0].children[1].textContent;
                let checkedMiddleClassificationCode = $(".productMiddleClassification li.checked")[0].children[1].textContent;
                let result = confirm("삭제 하시겠습니까?");

                if (result) {
                    $.get("/usr/basic-information/removeClassification", {
                        removeClassificationId: removeClassificationId,
                        removeClassificationType: removeClassificationType,
                        checkedBigClassificationCode: checkedBigClassificationCode,
                        checkedMiddleClassificationCode: checkedMiddleClassificationCode
                    }, function (data) {
                        console.log(data)
                    }, "json")

                    alert("정상적로 삭제 되었습니다.")
                    getBigClassificationList("");
                    getMiddleClassificationList("", "");
                    getSmallClassificationList("", "", "");
                }
            }
        }
    })

</script>