<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
                    <span onclick="getTables('floor-1')">조회</span>
                </button>
                <button onclick="" class="btn btn-active btn-sm pl-2">저장</button>
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
                    <div class="active" id="floor-1" onclick="getTables(this.id)">
                        <input type="text" value="1층">
                        <select>
                            <option value="사용">사용</option>
                            <option value="미사용">미사용</option>
                        </select>
                    </div>
                    <div id="floor-2" onclick="getTables(this.id)">
                        <input type="text" value="2층">
                        <select>
                            <option value="사용">사용</option>
                            <option value="미사용">미사용</option>
                        </select>
                    </div>
                    <div id="floor-3" onclick="getTables(this.id)">
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
            <ul class="other-management-tables"></ul>
        </div>
    </div>
</div>

<script>

    function getTables(floor) {
        $.ajax({
            url: "/usr/basic-information/otherManagement/tablesArrangement",
            method: "GET",
            data: {
                floor: floor.substring(floor.indexOf("-") + 1)
            },
            success: function (data) {
                drawingATable(data);
            },
            error: function (request, status, error) {
            },
            complete: function () {
            }

        })
    }

    getTables('floor-1');

    function drawingATable(data) {
        let tables = '';
        for (let i = 0; i < data.length; i++) {
            let table = data[i];
            tables += ` <li draggable="true" class="tables" id="table_\${table.tableName}" floor = "\${table.floor}"
                           style="position: absolute; width: \${table.width}; height: \${table.height}; top: \${table.top};
                            left: \${table.left}; border-radius: 5px; background-color: \${table.bgColor}">
                            \${table.tableName}
                        </li>`
        }

        $(".other-management-tables").html(tables);

        // ================================ //

        moveTheTable();
    }

    function moveTheTable() {
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
                // $.get('/usr/tables/update', {
                //     elPosX: tableEl.offsetLeft,
                //     elPosY: tableEl.offsetTop,
                //     number: tableId.substring(tableId.indexOf("_") + 1),
                //     floor: floor
                // }, function (data) {
                //     console.log("성공")
                // }, 'json')

            })
        }
    }

    let lastTableNum = 11;

    function createTable(tableType) {
        lastTableNum++;
        let activeFloor = $("#floors > div:not(:first-child).active")[0].id
        let floorNum = activeFloor.substring(activeFloor.indexOf("-") + 1);

        let newTable = "";
        if (tableType == "blueTable") {
            newTable = ` <li draggable="true" class="tables" id="table_\${lastTableNum}" floor = "\${floorNum}"
                           style="position:absolute; width: 135px; height: 85px; top: 15px;
                            left: 15px; border-radius: 5px; background-color: #BFE4FF">
                            \${lastTableNum}번
                        </li>`
        } else if (tableType == "orangeTable") {
            newTable = ` <li draggable="true" class="tables" id="table_\${lastTableNum}" floor = "\${floorNum}"
                           style="position:absolute; width: 135px; height: 85px; top: 15px;
                            left: 15px; border-radius: 5px; background-color: #FBD3B7">
                            \${lastTableNum}번
                        </li>`
        } else if (tableType == "circleTable") {
            newTable = ` <li draggable="true" class="tables" id="table_\${lastTableNum}" floor = "\${floorNum}"
                           style="position:absolute; width: 95px; height: 95px; top: 15px;
                            left: 15px; border-radius: 50px; background-color: #AFE4BB">
                            \${lastTableNum}번
                        </li>`
        }

        $(".other-management-tables").append(newTable);
        // moveTheTable();
    }


    document.querySelectorAll(".other-management-buttons > div:nth-child(2) > div:not(:first-child)").forEach((element) => {
        $(".other-management-buttons .active").css("backgroundColor", "orange");
        element.addEventListener("click", function (el) {
            $(".other-management-buttons .active").css("backgroundColor", "inherit");
            $(".other-management-buttons .active").removeClass("active");
            element.style.backgroundColor = "orange";
            element.classList.add("active");
        })
    })

</script>