<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Home"/>
<%@include file="../common/mainHead.jsp" %>

<div class="businessDate">
    <span>> 담당자: &nbsp;&nbsp; ${loginedEmployeeName}</span>
    <span>> 영업일자: &nbsp; &nbsp; ${rq.businessDate}</span>
    <span>> 포스번호 : &nbsp; &nbsp; 1</span>
</div>
<div class="floors">
    <%--    <a onclick="getTables(1)" id="floor_1" class="bg-blue-400">1층</a>--%>
    <%--    <a onclick="getTables(2)" id="floor_2" class="">2층</a>--%>
    <%--    <a onclick="getTables(3)" id="floor_3" class="">3층</a>--%>
    <a href="/?floor=1" class="${floor == 1? 'bg-blue-400' : ""}">1층</a>
    <a href="/?floor=2" class="${floor == 2? 'bg-blue-400' : ""}">2층</a>
    <a href="/?floor=3" class="${floor == 3? 'bg-blue-400' : ""}">3층</a>
</div>
<div class="container- homeRightFeed">
    <div class="tables-box">
        <c:forEach var="table" items="${tables}">
            <a href="usr/tables/detail?tabId=${table.number}&floor=${param.floor}"
               class="tables text-sm" id="table_${table.number}"
               draggable="true"
               floor="${floor}"
               style="width: ${table.width}; height: ${table.height}; top: ${table.top}; left: ${table.left}">
                <div class="tableGroupNum" id="groupNum_${table.number}"></div>
                <div class="flex flex-col h-full w-full items-center mt-2 overflow-hidden" id="${table.number}">
                    <span class="${cartItems != null ? "text-red-400" : ""}">${table.number}번</span>
                    <c:forEach var="priceSum" items="${priceSumList}">
                        <c:if test="${priceSum.table_id == table.number}">
                            <span class="text-blue-400 asd"
                                  id="table_${table.number}sumPrice">${priceSum.priceSum}</span>
                        </c:if>
                    </c:forEach>
                    <c:forEach var="cartItem" items="${cartItems}">
                        <c:if test="${cartItem.table_id==table.number}">
                            <div>
                                <span class="pr-2">${cartItem.productName}</span>
                                <span>${cartItem.quantity}</span>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </a>
        </c:forEach>
    </div>
</div>


<div class="homeLeftFeed" id="homeLeftFeed">
    <div class="miniWindow">
        <img src="/resource/images/a.png" alt="">
    </div>
    <div class="clock">
        <span id="hours" class="large_text"></span>
        <span class="colon">:</span>
        <span id="minute" class="large_text"></span>
    </div>
    <div class="tableFunctions">
        <div class="order" onclick="mainPageAllFunc('tableOrder');">
            <span>주문</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
        <div class="division">
            <span>분할</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
        <div class="movement" onclick="mainPageAllFunc('tableMovement');">
            <span>이동</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
        <div class="group" onclick="mainPageAllFunc('tableGroup');">
            <span>그룹</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
        <div class="summary" onclick="mainPageAllFunc('summary');">
            <span>요약</span>
            <span class="material-symbols-outlined">arrow_forward_ios</span>
        </div>
    </div>
    <div class="productInfo">
        <div>*주문정보</div>
        <div>
            <span>주문테이블수</span>
            <span class="orderTablesCnt">0</span>
        </div>
        <div>
            <span>전체고객수</span>
            <span>0</span>
        </div>
        <div>
            <span>담당자</span>
            <span>아브로르</span>
        </div>
        <div>
            <span>식사미제공</span>
            <span>0</span>
        </div>
    </div>
    <div class="tableMovementInfo hidden">
        <div class="flex items-center border-b-2 h-6 pl-4">
            <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
            <span>테이블 이동정보</span>
        </div>
        <div class="flex justify-center items-center border-b-2 h-6">현재테이블</div>
        <div class="flex justify-center flex-col pl-2 border-b-2">
            <div>
                <span>*그룹명</span>
                <input type="submit" value="${floor}층">
            </div>
            <div>
                <span>*테이블명</span>
                <input class="currTableNum" type="submit" value="">
            </div>
            <div>
                <span>*주문금액</span>
                <input class="currTableSumPrice" type="submit" value="">
            </div>
        </div>
        <div class="flex justify-center items-center border-b-2">
            <span class="material-symbols-outlined">keyboard_double_arrow_down</span>
        </div>
        <div class="flex justify-center items-center h-6 border-b">이동테이블</div>
        <div class="flex justify-center flex-col pl-2 border-b-2">
            <div>
                <span>*그룹명</span>
                <input type="submit" value="${floor}층">
            </div>
            <div>
                <span>*테이블명</span>
                <input class="afterTableNum" type="submit" value="">
            </div>
            <div>
                <span>*주문금액</span>
                <input class="afterTableSumPrice" type="submit" value="">
            </div>
        </div>
    </div>
    <div class="tableGroupInfo hidden">
        <div class="flex items-center border-b-2 h-8 pl-4">
            <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
            <span>테이블그룹</span>
        </div>
        <div class="table-Group-box">
            <div>
                <span>&nbsp;</span>
                <span>그룹번호</span>
                <span>테이블개수</span>
            </div>
            <div class="table-groups">
                <c:forEach var="tableGroup" items="${tableGroups}">
                    <div id="tableGroup_${tableGroup.id}">
                        <span style="background-color: ${tableGroup.color}">${tableGroup.id}</span>
                        <span>그룹${tableGroup.id}</span>
                        <span>${tableGroup.tableCnt}</span>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="group-add-remove-buttons">
            <button class="btn" id="tableGroupAddBtn">
                <span class="material-symbols-outlined text-blue-500 text-2xl">add</span>
            </button>
            <button class="btn " id="tableGroupRemoveBtn">
                <span class="material-symbols-outlined text-blue-500 text-2xl">remove</span>
            </button>
            <button class="btn text-blue-500 text-xm">그룹결제</button>
        </div>
    </div>
    <div class="tableSummary hidden">
        <span>
            <span class="material-symbols-outlined pr-2 text-4xl">swipe_right_alt</span>
            <h2>주문상세정보</h2>
        </span>
        <ul class="tableSummaryInfoBox"></ul>
        <div class="tableSummarySumPrice">
            <span>총액</span>
            <span></span>
        </div>
    </div>
</div>
<div class="home-msg-box">
    <span class="material-symbols-outlined">volume_up</span>
    <span class="msg-tag"></span>
</div>
<div class="messagePage-msg-box">
    <div class="layer-bg"></div>
    <div class="layer">
        <div class="confirm-message"></div>
        <button id="check-btn" class="btn btn-active btn-info  mt-2 confirm-button">확인</button>
        <button id="cancel-btn" class="btn btn-active btn-ghost mt-2 cancel-button">취소</button>
    </div>

    <div class="layer-bg-1"></div>
    <div class="layer-1">
        <div class="confirm-message-1"></div>
        <button id="check-btn-1" class="btn btn-active btn-info  mt-2 confirm-button-1">확인</button>
    </div>
</div>
<div class="summaryAlertFeed">
    <span class="material-symbols-outlined info">info</span>
    <div class="summaryAlertFeedTitle">
        <h1></h1>
        <h1></h1>
    </div>
    <ul>
        <li>
            <span>상품명</span>
            <span>수량</span>
            <span>금액</span>
            <span>주문시간</span>
        </li>
    </ul>
    <div class="summaryAlertFeedFooter">
        <span class="material-symbols-outlined">crop_square</span>
        <span></span>
        <span class="material-symbols-outlined">crop_square</span>
        <span></span>
    </div>
</div>
<script>

    function PutComma() {
        document.querySelectorAll(".asd").forEach((el) => {
            let num = el.innerHTML
            el.innerHTML = Number(num).toLocaleString();
        })
    }

    PutComma();

    function showConfirmDialog(message) {
        return new Promise((resolve, reject) => {
            let confirmMessage = document.querySelector(".confirm-message");
            let confirmButton = document.querySelector(".confirm-button");
            let cancelButton = document.querySelector(".cancel-button");

            confirmMessage.textContent = message;

            confirmButton.onclick = function () {
                closeMsgBox();
                resolve("true");
            };

            cancelButton.onclick = function () {
                closeMsgBox();
                reject("false");
            };

            openMsgBox();
        });
    }

    async function exampleFunction() {
        try {
            const result = await showConfirmDialog("주방으로 이동 주문서를 출력하시겠습니까?");
            return result;
        } catch (error) {
            return error;
        }
    }

    function openMsgBox() {
        $('.layer').show();
        $('.layer-bg').show();
    }

    function openMsgBox_1(message) {
        $('.layer-1').show();
        $('.layer-bg-1').show();
        let confirmMessage = document.querySelector(".confirm-message-1");
        let confirmButton = document.querySelector(".confirm-button-1");

        confirmMessage.textContent = message;

        confirmButton.onclick = function () {
            closeMsgBox_1();
            location.reload();
        };
    }

    function closeMsgBox() {
        $('.layer').hide();
        $('.layer-bg').hide();
    }

    function closeMsgBox_1() {
        $('.layer-1').hide();
        $('.layer-bg-1').hide();
    }


    document.querySelector(".orderTablesCnt").innerHTML = ${orderTablesCnt}

        function mainPageAllFunc(func) {
            switch (func) {
                case "tableOrder":
                    tableOrder();
                    break;
                case "tableMovement" :
                    tableMovement();
                    break;
                case "tableGroup" :
                    tableGroup();
                    break;
                case "summary" :
                    tableSummary();
                    break;
            }
        }

    //=============tableOrder==============//
    function tableOrder() {
        location.reload();
        let tabId = 0;
        document.querySelectorAll(".tables-box a").forEach((el) => {
            el.addEventListener("click", function (e) {
                tabId = el.id.substring(el.id.indexOf("_") + 1)
                $(".tables-box a").attr("href", `usr/tables/detail?tabId=\${tabId}&floor=${param.floor}`)
            })
        })
        $(".productInfo").removeClass("hidden")
        $(".tableMovementInfo").addClass("hidden")
        $(".tableGroupInfo").addClass("hidden")
        $(".tableSummary").addClass("hidden")
    }

    //=============tableMovement==============//
    function tableMovement() {
        $(".tableMovementInfo").removeClass("hidden")
        $(".productInfo").addClass("hidden")
        $(".tableGroupInfo").addClass("hidden")
        $(".tableSummary").addClass("hidden")
        $(".tables-box a").removeAttr("href")

        let clickCnt = 0;
        let currTableSumPrice = 0;
        let currTableNum = 0;
        let afterTableNum = 0;
        document.querySelectorAll(".tables-box a").forEach((element) => {
            element.addEventListener('click', async (e) => {
                clickCnt += 1;
                if (element.children[1].children.length == 1 && clickCnt != 2) {
                    openMsgBox_1("이동할 테이블 정보가 존재하지 않습니다");
                } else {
                    if (clickCnt == 2) {
                        afterTableNum = element.id.substring(element.id.indexOf("_") + 1);
                        $(".tableMovementInfo .afterTableNum").val(afterTableNum + "번")
                        $(".tableMovementInfo .afterTableSumPrice").val(currTableSumPrice)

                        await exampleFunction().then((result) => {
                            $.get("/usr/tables/movement", {
                                currTableNum: currTableNum,
                                afterTableNum: afterTableNum,
                                floor: ${floor},
                                msg: result
                            }, function (data) {
                                location.reload();
                            }, "json")
                        });
                    }

                    currTableNum = element.id.substring(element.id.indexOf("_") + 1);
                    let currTable = $("#table_" + currTableNum + "sumPrice")
                    if (currTable.length != 0) {
                        currTableSumPrice = currTable[0].innerText
                        $(".tableMovementInfo .currTableNum").val(currTableNum + "번")
                        $(".tableMovementInfo .currTableSumPrice").val(currTableSumPrice)
                    }
                }

            })
        })
    }

    //=============== makeRandomColor============//
    function makeRandomColor() {
        const r = Math.floor(Math.random() * 255);
        const g = Math.floor(Math.random() * 255);
        const b = Math.floor(Math.random() * 255);
        return `rgb(\${r},\${g},\${b})`;
    }

    //=============tableGroup==============//
    function selectTableGroupLastChild() {
        let checkedGroupNumId = 0;
        let tableGroupLastChild = document.querySelector(".table-groups div:last-child")
        if (tableGroupLastChild != null) {
            document.querySelectorAll(".table-groups div").forEach((element) => {
                element.addEventListener("click", function (e) {
                    tableGroupLastChild.classList.remove("checked")
                    tableGroupLastChild.style.backgroundColor = "inherit";
                    tableGroupLastChild.style.color = "black";
                    tableGroupLastChild = element
                    element.classList.add("checked");
                    element.style.backgroundColor = "blue";
                    element.style.color = "white";
                })
            });
            let checkedTableGroup = document.querySelector(".table-groups .checked");
            if (checkedTableGroup != null) {
                document.querySelectorAll(".tables-box a").forEach((ele) => {
                    let groupNumSpan = document.querySelector(".checked span:first-child")
                    checkedGroupNumId = checkedTableGroup.id.substring(checkedTableGroup.id.indexOf("_") + 1);
                    console.log(checkedGroupNumId)
                    let checkedGroupNumColor = groupNumSpan.style.backgroundColor;
                    ele.addEventListener("click", function (el) {
                        console.log(checkedGroupNumId)
                        let selectedTableId = ele.id.substring(ele.id.indexOf("_") + 1)
                        let groupNum = document.getElementById("groupNum_" + selectedTableId)
                        groupNum.style.display = "flex";
                        groupNum.innerText = checkedGroupNumId;
                        groupNum.style.backgroundColor = checkedGroupNumColor;

                        // $.get("/usr/tableGroup/update", {
                        //     groupId: 1
                        // }, function (data) {
                        //     let groupNumCntSpan = document.querySelector(".checked span:last-child")
                        //     groupNumCntSpan.innerText = data.data1.tableCnt;
                        // }, "json")
                    });
                });
            }
        }
    }

    function selectTableGroupLastChild2() {
        let tableGroupLastChild = document.querySelector(".table-groups div:last-child")
        if (tableGroupLastChild != null) {
            tableGroupLastChild.classList.add("checked")
            tableGroupLastChild.style.backgroundColor = "blue";
            tableGroupLastChild.style.color = "white";
            selectTableGroupLastChild();
        }
    }

    function updateTableGroupCnt() {
        document.querySelectorAll(".table-groups div").forEach((element) => {
            element.addEventListener("click", function (el) {
                document.querySelectorAll(".tables-box a").forEach((ele) => {
                    let groupNumSpan = document.querySelector(".checked span:first-child")
                    let checkedGroupNumId = element.id.substring(element.id.indexOf("_") + 1);
                    let checkedGroupNumColor = groupNumSpan.style.backgroundColor;
                    ele.addEventListener("click", function (el) {
                        let selectedTableId = ele.id.substring(ele.id.indexOf("_") + 1)
                        let groupNum = document.getElementById("groupNum_" + selectedTableId)
                        groupNum.style.display = "flex";
                        groupNum.innerText = checkedGroupNumId;
                        groupNum.style.backgroundColor = checkedGroupNumColor;

                        $.get("/usr/tableGroup/update", {
                            groupId: checkedGroupNumId
                        }, function (data) {
                            let groupNumCntSpan = document.querySelector(".checked span:last-child")
                            groupNumCntSpan.innerText = data.data1.tableCnt;
                        }, "json")
                    });
                });
            })
        });
    }

    function tableGroup() {
        $(".tableGroupInfo").removeClass("hidden")
        $(".productInfo").addClass("hidden")
        $(".tableMovementInfo").addClass("hidden")
        $(".tableSummary").addClass("hidden")
        $(".tables-box a").removeAttr("href")

        selectTableGroupLastChild();

        $("#tableGroupAddBtn").click(function () {
            $.get("/usr/tableGroup/addTableGroup", {
                color: makeRandomColor(),
            }, function (data) {
                let str = "";
                $.each(data.data1, function (idx, value) {
                    str += ` <div id="tableGroup_\${value.id}" >
                                <span style="background-color: \${value.color}">\${value.id}</span>
                                <span class="border-l-2">그룹\${value.id}</span>
                                <span>\${value.tableCnt}</span>
                             </div>
                        `
                });
                $(".table-groups").empty().html("");
                $(".table-groups").html(str);
                // click qilinigan group check qilish vazifasini bajaradi
                selectTableGroupLastChild();
                // tableGroup table sonini update qiladi
                // updateTableGroupCnt();
            }, "json")

        });

        $("#tableGroupRemoveBtn").click(function () {
            let checkedGroupNum = $(".checked")
            let checkedGroupNumId = checkedGroupNum[0].id.substring(checkedGroupNum[0].id.indexOf("_") + 1)
            $.get("/usr/tableGroup/removeTableGroup", {
                groupId: checkedGroupNumId
            }, function (data) {
                // tableGroup table sonini update qiladi
                // updateTableGroupCnt();
                checkedGroupNum.remove();
                selectTableGroupLastChild();
            }, "json")
        });

    }


    function tableSummary() {
        $(".tableSummary").removeClass("hidden")
        $(".tableMovementInfo").addClass("hidden")
        $(".productInfo").addClass("hidden")
        $(".tableGroupInfo").addClass("hidden")
        $(".tables-box a").removeAttr("href")

        function summaryPageLayout(cnt) {
            cnt = cnt < 6 ? 6 : cnt
            let str = `
             <li>
                <span></span>
                <span>상품명</span>
                <span>수량</span>
                <span>금액</span>
             </li>
               `;
            for (let i = 1; i <= cnt; i++) {
                str += `
            <li>
                <span>\${i}</span>
                <span></span>
                <span></span>
                <span></span>
            </li>
            `
            }
            $(".tableSummaryInfoBox").html(str)
        }

        function tableSummaryInfoBox(cnt) {
            summaryPageLayout(cnt);
            document.querySelectorAll(".tables-box > a").forEach((element) => {
                element.addEventListener("click", function (el) {
                    let tabId = element.id.substring(element.id.indexOf("_") + 1)
                    let floor = element.getAttribute("floor")
                    $.get("/usr/tables/getProductSummary", {
                        floor: floor,
                        tabId: tabId
                    }, function (data) {
                        let tableSummary = data.data1
                        let sumPrice = 0;
                        let str = `
                            <li>
                                <span></span>
                                <span>상품명</span>
                                <span>수량</span>
                                <span>금액</span>
                            </li>
                            `
                        let str2 = `
                                <li>
                                    <span>상품명</span>
                                    <span>수량</span>
                                    <span>금액</span>
                                    <span>주문시간</span>
                                </li>
                                `

                        if (tableSummary != null) {
                            for (let i = 0; i < tableSummary.length; i++) {
                                sumPrice += tableSummary[i].productSumPrice
                                str += `
                                         <li>
                                            <span>\${i + 1}</span>
                                            <span>\${tableSummary[i].productName}</span>
                                            <span>\${tableSummary[i].quantity}</span>
                                            <span>\${tableSummary[i].productSumPrice.toLocaleString()}</span>
                                         </li>
                                        `
                                str2 += `
                                        <li>
                                            <span>\${tableSummary[i].productName}</span>
                                            <span>\${tableSummary[i].quantity}개</span>
                                            <span>\${tableSummary[i].productSumPrice.toLocaleString()}</span>
                                            <span>\${tableSummary[i].regDate.substring(tableSummary[1].updateDate.indexOf(" "))}</span>
                                        </li>
                                        `
                            }

                            if (tableSummary.length < 6) {
                                str += `
                            <li>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                             </li>
                             <li>
                                <span></span>
                                <span></span>
                                <span></span>
                                <span></span>
                             </li>
                            `
                            }

                            let firstOrder = tableSummary[0].regDate.substring(tableSummary[1].updateDate.indexOf(" "))
                            let lastOrder = tableSummary[tableSummary.length - 1].regDate.substring(tableSummary[1].updateDate.indexOf(" "))
                            let sumPriceStr = sumPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",")
                            $(".summaryAlertFeedTitle > h1:nth-child(1)").html(`테이블 \${tabId} 주문내역`)
                            $(".summaryAlertFeedTitle > h1:nth-child(2)").html(`최초주문시간 \${firstOrder} 최초주문시간 \${lastOrder}`)
                            $(".tableSummaryInfoBox").html(str)
                            $(".summaryAlertFeed > ul").html(str2)
                            $(".summaryAlertFeedFooter span:nth-child(2)").html(`총수량 : &nbsp; &nbsp; \${tableSummary.length}개`)
                            $(".summaryAlertFeedFooter span:nth-child(4)").html(`총금액 : &nbsp; &nbsp; \${sumPriceStr}원`)

                            $(".tableSummarySumPrice > span:last-child").html(sumPriceStr);

                            $(".summaryAlertFeed").css("display", "flex")
                            let width = parseInt(element.getBoundingClientRect().width)
                            let height = parseInt(element.getBoundingClientRect().height)
                            let top = parseInt(element.getBoundingClientRect().top)
                            let left = parseInt(element.getBoundingClientRect().left)
                            $(".summaryAlertFeed").css("top", top + (height / 2 + 15))
                            $(".summaryAlertFeed").css("left", left - (width / 2 + 20))

                            addEventListener("mousemove", (event) => {
                                $(".summaryAlertFeed").css("display", "none")
                                summaryPageLayout(cnt);
                                $(".tableSummarySumPrice > span:last-child").html("");
                            })
                        } else if (tableSummary == null) {
                            summaryPageLayout(cnt);
                            $(".summaryAlertFeed").css("display", "none")
                            $(".tableSummarySumPrice > span:last-child").html("");
                        }
                    }, "json")
                })
            })
        }

        tableSummaryInfoBox(5);
    }

    // =========Clock========= //
    function watchClock() {
        const hours = $("#hours")
        const minutes = $("#minute")
        const present = new Date();
        let hour = present.getHours();
        let minute = present.getMinutes();
        if (hour < 10) {
            hour = "0" + hour
        }
        if (minute < 10) {
            minute = "0" + minute
        }
        hours.html(hour)
        minutes.html(minute)
    }

    watchClock();
    const clockInterval = setInterval(watchClock, 1000);


    function selectTableFunc() {
        let prevSelectedFunc = document.querySelector(".order");
        prevSelectedFunc.style.backgroundColor = "#50bcdf"
        document.querySelectorAll(".tableFunctions div").forEach((element) => {
            element.addEventListener("click", function () {
                prevSelectedFunc.style.backgroundColor = "inherit"
                prevSelectedFunc = element
                element.style.backgroundColor = "#50bcdf";
            })
        })
    }

    selectTableFunc();
</script>
<%@include file="../common/footer.jsp" %>