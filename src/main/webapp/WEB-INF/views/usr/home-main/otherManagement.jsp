<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="../common/head.jsp" %>
<%@include file="../common/somePageHead.jsp" %>

<div class="other-management-page">
    <div class="other-management-con">
        <div class="other-management-top">
            <div>
                <span class="material-symbols-outlined pr-2 text-red-400">arrow_circle_right</span>
                <span>기초정보관리 > 기타 관리 > 테이블 배치</span>
            </div>
            <div>
                <button class="btn btn-active btn-sm flex flex-row justify-between"
                        onclick="">
                    <span class="material-symbols-outlined">search</span>
                    <span>조회</span>
                </button>
                <button onclick="saveUpdateTableData();" class="btn btn-active btn-sm pl-2">저장</button>
            </div>
        </div>
        <div class="other-management-main">
            <div class="other-management-buttons">
                <div>
                    <span class="material-symbols-outlined btn btn-active btn-xs">add</span>
                    <span class="material-symbols-outlined btn btn-active btn-xs">remove</span>
                </div>
                <div class="" id="floors">
                    <div>
                        <span>그룹명</span>
                        <span>사용여부</span>
                    </div>
                    <div class="${param.floor == 1 ? 'bg-orange-400' : ''}"
                         onclick="location.replace('/usr/home-main/tableLayout?floor=1')">
                        <input type="text" value="1층">
                        <select>
                            <option value="사용">사용</option>
                            <option value="미사용">미사용</option>
                        </select>
                    </div>
                    <div class="${param.floor == 2 ? 'bg-orange-400' : ''}"
                         onclick="location.replace('/usr/home-main/tableLayout?floor=2')">
                        <input type="text" value="2층">
                        <select>
                            <option value="사용">사용</option>
                            <option value="미사용">미사용</option>
                        </select>
                    </div>
                    <div class="${param.floor == 3 ? 'bg-orange-400' : ''}"
                         onclick="location.replace('/usr/home-main/tableLayout?floor=3')">
                        <input type="text" value="3층">
                        <select>
                            <option value="사용">사용</option>
                            <option value="미사용">미사용</option>
                        </select>
                    </div>
                </div>
                <div>
                    <div>
                        <button class="btn btn-outline btn-error btn-sm">테이블정보</button>
                        <button class="btn btn-outline btn-error btn-sm">복수등록</button>
                        <button class="btn btn-outline btn-error btn-sm">선택삭제</button>
                        <button class="btn btn-outline btn-error btn-sm">테이블복사</button>
                    </div>
                    <div>
                        <div>
                            <span class="material-symbols-outlined pr-2 text-lg text-red-400">arrow_circle_right</span>
                            <span>테이블</span>
                        </div>
                        <span style="background-color: #BFE4FF" class="mt-1" onclick="createTable('blueTable')"></span>
                        <span style="background-color: #FBD3B7" class="mt-1"
                              onclick="createTable('orangeTable')"></span>
                        <span style="background-color: #AFE4BB" class="mt-1"
                              onclick="createTable('circleTable')"></span>
                        <div>
                            <span class="material-symbols-outlined pr-2 text-lg text-red-400">arrow_circle_right</span>
                            <span>구조물</span>
                        </div>
                        <span style="background-color: #A6A6A9" class="mt-1"></span>
                        <span style="background-color: #BFE4FF" class="mt-1"></span>
                        <span style="background-color: #FFD3D3" class="mt-1"></span>
                    </div>
                </div>
            </div>
            <ul class="other-management-tables">
                <%--                <li class="target"></li>--%>
                <%--                <li class="target"></li>--%>
                <%--                <li class="target"></li>--%>
                <%--                <li class="target"></li>--%>
                <c:forEach var="table" items="${tableList}" varStatus="idx">
                    <li draggable="true" class="tables right ${idx.count == 1 ? 'resizable-content' : ''}"
                        id="table_${idx.count}" floor="${table.floor}"
                        style="position: absolute; width: ${table.width}; height: ${table.height}; top: ${table.top};
                                left: ${table.left}; border-radius: ${table.border_radius}px; background-color: ${table.bgColor}">
                            ${table.tableName}
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('.tables').forEach((element) => {
        element.addEventListener('click', function () {
            // 기존에 추가된 테두리가 있으면 제거
            removeBorders(this);
            // 상, 하, 좌, 우 테두리 요소 생성
            const borders = ['top', 'bottom', 'left', 'right'].map(direction => {
                const border = document.createElement('div');
                border.className = `border-line border-\${direction}`;
                return border;
            });

            // 생성된 테두리 요소들을 타겟에 추가
            borders.forEach(border => this.appendChild(border));

            document.querySelectorAll(".border-top").forEach((ele) => {
                ele.addEventListener("mouseenter", function (el) {
                    element.style.cursor = "n-resize";
                })
                ele.addEventListener("mouseout", function () {
                    element.style.cursor = "all-scroll";
                })
            })

            document.querySelectorAll(".border-bottom").forEach((ele) => {
                ele.addEventListener("mouseenter", function (el) {
                    element.style.cursor = "n-resize";
                })
                ele.addEventListener("mouseout", function () {
                    element.style.cursor = "all-scroll";
                })
            })

            document.querySelectorAll(".border-left").forEach((ele) => {
                ele.addEventListener("mouseenter", function (el) {
                    element.style.cursor = "w-resize";
                })
                ele.addEventListener("mouseout", function () {
                    element.style.cursor = "all-scroll";
                })
            })

            document.querySelectorAll(".border-right").forEach((ele) => {
                ele.addEventListener("mouseenter", function (el) {
                    element.style.cursor = "w-resize";
                })
                ele.addEventListener("mouseout", function () {
                    element.style.cursor = "all-scroll";
                })
            })
        });
    })

    // 기존에 있는 테두리 제거 함수
    function removeBorders(element) {
        const borders = element.querySelectorAll('.border-line');
        borders.forEach(border => border.remove());
    }

    // ======================================= //
    document.querySelectorAll(".other-management-tables li").forEach((element) => {
        element.addEventListener("click", function () {
            element.style.border = "2px solid red"
        })
    })

    const HomeContainer = document.querySelector(".other-management-tables")
    if (HomeContainer != null) {
        const {width: containerWidth, height: containerHeight} = HomeContainer.getBoundingClientRect();
        let posX = null;
        let posY = null;
        let tableId = null;
        let originLeft = null;
        let originTop = null;
        let originX = null;
        let originY = null;
        let boxWidth = null;
        let boxHeight = null;
        let floor = null;

        document.querySelectorAll(".other-management-tables .tables").forEach((element) => {
            element.addEventListener("dragstart", (e) => {
                tableId = e.target.id
                floor = e.target.attributes.floor.value
                posX = e.offsetX;
                posY = e.offsetY;
                originX = e.clientX;
                originY = e.clientY;
                originLeft = element.offsetLeft;
                originTop = element.offsetTop;
                boxWidth = element.clientWidth;
                boxHeight = element.clientHeight;
            })
        })

        document.querySelector(".other-management-tables").addEventListener("dragover", (e) => {
            e.preventDefault();
            e.stopPropagation();
        })

        document.querySelector(".other-management-tables").addEventListener("drop", (e) => {
            e.preventDefault();
            e.stopPropagation();
            const tableEl = document.getElementById(tableId);
            const diffX = e.clientX - originX;
            const diffY = e.clientY - originY;
            const endOfXPoint = containerWidth - boxWidth;
            const endOfYPoint = containerHeight - boxHeight;

            let left = Math.min(Math.max(0, originLeft + diffX), endOfXPoint);
            let right = Math.min(Math.max(0, originTop + diffY), endOfYPoint);
            if (tableEl != null) {
                tableEl.style.left = left + "px";
                tableEl.style.top = right + "px";
            }
        })
    }

    let lastTableNum = ${tableList.get(tableList.size()-1).lastTableNum};

    function createTable(tableType) {
        lastTableNum++;
        let floorNum = ${param.floor};

        const ul = document.querySelector(".other-management-tables")

        if (tableType == "blueTable") {
            const li = document.createElement("li")
            li.textContent = lastTableNum + "번";
            li.id = "table_" + lastTableNum;
            li.style.cssText = "position:absolute; width: 135px; height: 85px; top: 15px;" +
                " left: 15px; border-radius: 5px; background-color: #BFE4FF"
            li.setAttribute("floor", floorNum);
            li.draggable = true;
            li.classList.add("tables");
            ul.appendChild(li);

            $.ajax({
                url: "/usr/home-main/createTable",
                method: "POST",
                data: {
                    tableNum: parseInt(li.textContent.substring(0, li.textContent.indexOf("번"))),
                    tableColor: "#BFE4FF",
                    floor: floorNum,
                    width: 135,
                    height: 85,
                    top: 15,
                    left: 15,
                    border_radius: 5
                },
                success: function (data) {
                    location.replace('/usr/home-main/tableLayout?floor=' + floorNum)
                },
                error: function (request, status, error) {
                },
                complete: function () {
                }
            })

        } else if (tableType == "orangeTable") {
            const li = document.createElement("li")
            li.textContent = lastTableNum + "번";
            li.id = "table_" + lastTableNum;
            li.style.cssText = "position:absolute; width: 135px; height: 85px; top: 15px;" +
                " left: 15px; border-radius: 5px; background-color: #FBD3B7"
            li.setAttribute("floor", floorNum);
            li.draggable = true;
            li.classList.add("tables");
            ul.appendChild(li);

            $.ajax({
                url: "/usr/home-main/createTable",
                method: "POST",
                data: {
                    tableNum: parseInt(li.textContent.substring(0, li.textContent.indexOf("번"))),
                    tableColor: "#FBD3B7",
                    floor: floorNum,
                    width: 135,
                    height: 85,
                    top: 15,
                    left: 15,
                    border_radius: 5
                },
                success: function (data) {
                    location.replace('/usr/home-main/tableLayout?floor=' + floorNum);
                },
                error: function (request, status, error) {
                },
                complete: function () {
                }
            })
        } else if (tableType == "circleTable") {
            const li = document.createElement("li")
            li.textContent = lastTableNum + "번";
            li.id = "table_" + lastTableNum;
            li.style.cssText = "position:absolute; width: 95px; height: 95px; top: 15px;" +
                " left: 15px; border-radius: 50px; background-color: #AFE4BB"
            li.setAttribute("floor", floorNum);
            li.draggable = true;
            li.classList.add("tables");
            ul.appendChild(li);

            $.ajax({
                url: "/usr/home-main/createTable",
                method: "POST",
                data: {
                    tableNum: parseInt(li.textContent.substring(0, li.textContent.indexOf("번"))),
                    tableColor: "#AFE4BB",
                    floor: floorNum,
                    width: 95,
                    height: 95,
                    top: 15,
                    left: 15,
                    border_radius: 50
                },
                success: function (data) {
                    location.replace('/usr/home-main/tableLayout?floor=' + floorNum);
                },
                error: function (request, status, error) {
                },
                complete: function () {
                }
            })
        }
    }

    function saveUpdateTableData() {
        document.querySelectorAll(".other-management-tables li").forEach((element) => {
            updateTableLocation(element);
        })
    }

    function updateTableLocation(tableEl) {
        $.ajax({
            url: "/usr/home-main/updateTable",
            method: "POST",
            data: {
                width: parseInt(tableEl.style.width),
                height: parseInt(tableEl.style.height),
                elPosX: parseInt(tableEl.offsetLeft),
                elPosY: parseInt(tableEl.offsetTop),
                number: parseInt(tableEl.textContent),
                floor: parseInt(${param.floor})
            },
            success: function (data) {
            },
            error: function (request, status, error) {
            },
            complete: function () {
            }
        })


        // $.ajax('/usr/tables/update', {}, function (data) {
        //     console.log("성공")
        // }, 'json')
        // console.log(tableEl)
    }

    // ===================================== //

    // function getTables(floor) {
    //     $.ajax({
    //         url: "/usr/basic-information/otherManagement/tablesArrangement",
    //         method: "GET",
    //         data: {
    //             floor: floor.substring(floor.indexOf("-") + 1)
    //         },
    //         success: function (data) {
    //             drawingATable(data);
    //         },
    //         error: function (request, status, error) {
    //         },
    //         complete: function () {
    //         }
    //
    //     })
    // }
    //
    // getTables('floor-1');

    // function drawingATable(data) {
    //     let tables = '';
    //     for (let i = 0; i < data.length; i++) {
    //         let table = data[i];
    //         tables += ` <li draggable="true" class="tables" id="table_\${table.tableName}" floor = "\${table.floor}"
    //                        style="position: absolute; width: \${table.width}; height: \${table.height}; top: \${table.top};
    //                         left: \${table.left}; border-radius: 5px; background-color: \${table.bgColor}">
    //                         \${table.tableName}
    //                     </li>`
    //     }
    //
    //     $(".other-management-tables").html(tables);
    //     moveTheTable();
    //
    // }

    // function moveTheTable() {
    //     const HomeContainer = document.querySelector(".other-management-tables")
    //     if (HomeContainer != null) {
    //         const {width: containerWidth, height: containerHeight} = HomeContainer.getBoundingClientRect();
    //         let posX = null;
    //         let posY = null;
    //         let tableId = null;
    //         let originLeft = null;
    //         let originTop = null;
    //         let originX = null;
    //         let originY = null;
    //         let boxWidth = null;
    //         let boxHeight = null;
    //         let floor = null;
    //
    //         document.querySelectorAll(".other-management-tables .tables").forEach((element) => {
    //             element.addEventListener("dragstart", (e) => {
    //                 console.log(e)
    //                 tableId = e.target.id
    //                 floor = e.target.attributes.floor.value
    //                 posX = e.offsetX;
    //                 posY = e.offsetY;
    //                 originX = e.clientX;
    //                 originY = e.clientY;
    //                 originLeft = element.offsetLeft;
    //                 originTop = element.offsetTop;
    //                 boxWidth = element.clientWidth;
    //                 boxHeight = element.clientHeight;
    //             })
    //         })
    //
    //         document.querySelector(".other-management-tables").addEventListener("dragover", (e) => {
    //             e.preventDefault();
    //             e.stopPropagation();
    //         })
    //
    //         document.querySelector(".other-management-tables").addEventListener("drop", (e) => {
    //             e.preventDefault();
    //             e.stopPropagation();
    //             const tableEl = document.getElementById(tableId);
    //             const diffX = e.clientX - originX;
    //             const diffY = e.clientY - originY;
    //             const endOfXPoint = containerWidth - boxWidth;
    //             const endOfYPoint = containerHeight - boxHeight;
    //
    //             let left = Math.min(Math.max(0, originLeft + diffX), endOfXPoint);
    //             let right = Math.min(Math.max(0, originTop + diffY), endOfYPoint);
    //             if (tableEl != null) {
    //                 tableEl.style.left = left + "px";
    //                 tableEl.style.top = right + "px";
    //             }
    //             // $.get('/usr/tables/update', {
    //             //     elPosX: tableEl.offsetLeft,
    //             //     elPosY: tableEl.offsetTop,
    //             //     number: tableId.substring(tableId.indexOf("_") + 1),
    //             //     floor: floor
    //             // }, function (data) {
    //             //     console.log("성공")
    //             // }, 'json')
    //
    //         })
    //     }
    // }

    // document.querySelectorAll(".other-management-buttons > div:nth-child(2) > div:not(:first-child)").forEach((element) => {
    //     $(".other-management-buttons .active").css("backgroundColor", "orange");
    //     element.addEventListener("click", function (el) {
    //         $(".other-management-buttons .active").css("backgroundColor", "inherit");
    //         $(".other-management-buttons .active").removeClass("active");
    //         element.style.backgroundColor = "orange";
    //         element.classList.add("active");
    //     })
    // })

</script>