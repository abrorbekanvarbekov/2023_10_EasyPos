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
                        <button onclick="deleteTable();" class="btn btn-outline btn-error btn-sm">선택삭제</button>
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
                              A onclick="createTable('circleTable')"></span>
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
                <c:forEach var="table" items="${tableList}" varStatus="idx">
                    <li draggable="true"
                        class="tables right ${idx.count == 1 ? 'resizable-content' : ''}"
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
    // li 태그들을 가져옵니다
    function tableResizeable(element) {
        // 크기 조절 핸들을 추가
        const leftTop = document.createElement('div');
        const top = document.createElement('div');
        const rightTop = document.createElement('div');
        const right = document.createElement('div');
        const rightBottom = document.createElement('div');
        const bottom = document.createElement('div');
        const leftBottom = document.createElement('div');
        const left = document.createElement('div');

        leftTop.className = 'resize-leftTop resizeable';
        top.className = 'resize-top resizeable';
        rightTop.className = 'resize-rightTop resizeable';
        right.className = 'resize-right resizeable';
        rightBottom.className = 'resize-rightBottom resizeable';
        bottom.className = 'resize-bottom resizeable';
        leftBottom.className = 'resize-leftBottom resizeable';
        left.className = 'resize-left resizeable';

        element.appendChild(leftTop);
        element.appendChild(top);
        element.appendChild(rightTop);
        element.appendChild(right);
        element.appendChild(rightBottom);
        element.appendChild(bottom);
        element.appendChild(leftBottom);
        element.appendChild(left);

        let isResizing = false;  // 크기 조절 중인지 여부
        let lastX, lastY;        // 마지막 마우스 위치
        let resizingSide = null;
        let resizingUpDown = null;
        let resizingLT_RB = null;
        let resizingRT_LB = null;

        leftTop.addEventListener('mousedown', function (e) {
            element.classList.add("updatedLi");

            let parentLi = leftTop.parentNode;
            parentLi.draggable = false;
            isResizing = true;
            resizingLT_RB = "leftTop";
            lastX = e.clientX;
            lastY = e.clientY;
            document.addEventListener('mousemove', resizeAngleLT_RB);
            document.addEventListener('mouseup', stopResizeAngleLT_RB);
        });

        leftTop.addEventListener('mouseup', stopResizeAngleLT_RB)

        top.addEventListener('mousedown', function (e) {
            element.classList.add("updatedLi");

            let parentLi = top.parentNode;
            parentLi.draggable = false;
            isResizing = true;
            resizingUpDown = "top";
            lastY = e.clientY;
            document.addEventListener('mousemove', resizeX);
            document.addEventListener('mouseup', stopResizeX);
        });

        top.addEventListener('mouseup', stopResizeX)

        rightTop.addEventListener('mousedown', function (e) {
            element.classList.add("updatedLi");

            let parentLi = rightTop.parentNode;
            parentLi.draggable = false;
            isResizing = true;
            resizingRT_LB = "rightTop";
            lastX = e.clientX;
            lastY = e.clientY;
            document.addEventListener('mousemove', resizeAngleRT_LB);
            document.addEventListener('mouseup', stopResizeAngleRT_LB);
        });

        rightTop.addEventListener('mouseup', stopResizeAngleRT_LB)

        right.addEventListener('mousedown', function (e) {
            element.classList.add("updatedLi");

            let parentLi = right.parentNode;
            parentLi.draggable = false;
            isResizing = true;
            resizingSide = "right";
            lastX = e.clientX;
            document.addEventListener('mousemove', resizeY);
            document.addEventListener('mouseup', stopResizeY);
        });

        right.addEventListener('mouseup', stopResizeX)

        rightBottom.addEventListener('mousedown', function (e) {
            element.classList.add("updatedLi");

            let parentLi = rightBottom.parentNode;
            parentLi.draggable = false;
            isResizing = true;
            resizingLT_RB = "rightBottom";
            lastX = e.clientX;
            lastY = e.clientY;
            document.addEventListener('mousemove', resizeAngleLT_RB);
            document.addEventListener('mouseup', stopResizeAngleLT_RB);
        });

        rightBottom.addEventListener('mouseup', stopResizeAngleLT_RB);

        bottom.addEventListener('mousedown', function (e) {
            element.classList.add("updatedLi");

            let parentLi = bottom.parentNode;
            parentLi.draggable = false;
            isResizing = true;
            resizingUpDown = "bottom";
            lastY = e.clientY;
            document.addEventListener('mousemove', resizeX);
            document.addEventListener('mouseup', stopResizeX);
        });

        bottom.addEventListener('mouseup', stopResizeY);

        leftBottom.addEventListener('mousedown', function (e) {
            element.classList.add("updatedLi");

            let parentLi = leftBottom.parentNode;
            parentLi.draggable = false;
            isResizing = true;
            resizingRT_LB = "leftBottom";
            lastX = e.clientX;
            lastY = e.clientY;
            document.addEventListener('mousemove', resizeAngleRT_LB);
            document.addEventListener('mouseup', stopResizeAngleRT_LB);
        });

        leftBottom.addEventListener('mouseup', stopResizeAngleRT_LB);

        left.addEventListener('mousedown', function (e) {
            element.classList.add("updatedLi");

            let parentLi = left.parentNode;
            parentLi.draggable = false;
            isResizing = true;
            resizingSide = "left";
            lastX = e.clientX;
            document.addEventListener('mousemove', resizeY);
            document.addEventListener('mouseup', stopResizeY);
        });

        left.addEventListener('mouseup', stopResizeY);

        function resizeX(e) {
            if (!isResizing) return;
            // 마우스의 현재 위치
            const dy = e.clientY - lastY;
            if (resizingUpDown === 'bottom') {
                // 가로로 크기 조절
                element.style.height = element.offsetHeight + dy + 'px';
            } else if (resizingUpDown === 'top') {
                // 왼쪽으로 크기 조절
                element.style.height = element.offsetHeight - dy + 'px';
                element.style.top = element.offsetTop + dy + 'px';  // 요소의 왼쪽 위치 변경
            }
            // 위치 업데이트
            lastY = e.clientY;
        }

        function resizeY(e) {
            if (!isResizing) return;
            // 마우스의 현재 위치
            const dx = e.clientX - lastX;

            if (resizingSide === 'right') {
                // 가로로 크기 조절
                element.style.width = element.offsetWidth + dx + 'px';
            } else if (resizingSide === 'left') {
                // 왼쪽으로 크기 조절
                element.style.width = element.offsetWidth - dx + 'px';
                element.style.left = element.offsetLeft + dx + 'px';  // 요소의 왼쪽 위치 변경
            }
            // 위치 업데이트
            lastX = e.clientX;
        }

        function resizeAngleLT_RB(e) {
            if (!isResizing) return;
            // 마우스의 현재 위치
            const dx = e.clientX - lastX;
            const dy = e.clientY - lastY;

            if (resizingLT_RB === "leftTop") {
                // 가로로 크기 조절
                if (Math.abs(dx) > Math.abs(dy)) {
                    element.style.width = element.offsetWidth - dx + 'px';
                    element.style.left = element.offsetLeft + dx + 'px';  // 요소의 왼쪽 위치 변경
                }
                // 세로로 크기 조절
                else {
                    element.style.height = element.offsetHeight - dy + 'px';
                    element.style.top = element.offsetTop + dy + 'px';  // 요소의 왼쪽 위치 변경
                }
            } else if (resizingLT_RB === "rightBottom") {
                // 가로로 크기 조절
                if (Math.abs(dx) > Math.abs(dy)) {
                    element.style.width = element.offsetWidth + dx + 'px';
                }
                // 세로로 크기 조절
                else {
                    element.style.height = element.offsetHeight + dy + 'px';
                }
            }
            // 위치 업데이트
            lastX = e.clientX;
            lastY = e.clientY;
        }

        function stopResizeAngleLT_RB() {
            let parentLi = top.parentNode;
            parentLi.draggable = true;
            isResizing = false;
            resizingLT_RB = null;
            document.removeEventListener('mousemove', resizeAngleLT_RB);
            document.removeEventListener('mouseup', stopResizeAngleLT_RB);
        }

        function resizeAngleRT_LB(e) {
            if (!isResizing) return;
            // 마우스의 현재 위치
            const dx = e.clientX - lastX;
            const dy = e.clientY - lastY;

            if (resizingRT_LB === "rightTop") {
                // 가로로 크기 조절
                if (Math.abs(dx) > Math.abs(dy)) {
                    element.style.width = element.offsetWidth + dx + 'px';
                }
                // 세로로 크기 조절
                else {
                    element.style.height = element.offsetHeight - dy + 'px';
                    element.style.top = element.offsetTop + dy + 'px';  // 요소의 왼쪽 위치 변경
                }
            } else if (resizingRT_LB === "leftBottom") {
                // 가로로 크기 조절
                if (Math.abs(dx) > Math.abs(dy)) {
                    element.style.width = element.offsetWidth - dx + 'px';
                    element.style.left = element.offsetLeft + dx + 'px';  // 요소의 왼쪽 위치 변경
                }
                // 세로로 크기 조절
                else {
                    element.style.height = element.offsetHeight + dy + 'px';
                }
            }
            // 위치 업데이트
            lastX = e.clientX;
            lastY = e.clientY;
        }

        function stopResizeAngleRT_LB() {
            let parentLi = top.parentNode;
            parentLi.draggable = true;
            isResizing = false;
            resizingRT_LB = null;
            document.removeEventListener('mousemove', resizeAngleLT_RB);
            document.removeEventListener('mouseup', stopResizeAngleRT_LB);
        }

        function stopResizeX() {
            let parentLi = top.parentNode;
            parentLi.draggable = true;
            isResizing = false;
            resizingUpDown = null;
            document.removeEventListener('mousemove', resizeX);
            document.removeEventListener('mouseup', stopResizeX);
        }

        function stopResizeY() {
            let parentLi = top.parentNode;
            parentLi.draggable = true;
            isResizing = false;
            resizingSide = null;
            document.removeEventListener('mousemove', resizeY);
            document.removeEventListener('mouseup', stopResizeY);
        }
    }

    // ======================================= //
    document.querySelectorAll(".other-management-tables li").forEach((element) => {
        element.addEventListener("click", function () {
            let clickedLi = document.querySelector(".other-management-tables > .clicked");
            if (clickedLi != null) {
                clickedLi.classList.remove("clicked");
                clickedLi.style.border = "none";
                for (let i = 0; i < clickedLi.children.length; i++) {
                    clickedLi.children[i].style.display = "none";
                }
            }
            element.classList.add("clicked");
            element.style.border = "1px solid #00bfff";

            tableResizeable(element);
        })
    })


    function tableMovement() {
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
                    element.classList.add("updatedLi");

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
    }

    tableMovement();
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
        document.querySelectorAll(".other-management-tables li.updatedLi").forEach((element) => {
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

    function deleteTable() {
        document.querySelectorAll(".other-management-tables li.clicked").forEach((element) => {
            let tableId = element.textContent.trim().substring(element.textContent.trim().indexOf("_") + 1);
            let floor = parseInt(${param.floor});
            $.ajax({
                url: "/usr/home-main/deleteTable",
                method: "POST",
                data: {
                    tableId: tableId,
                    floor: floor
                },
                success: function (data) {
                    location.replace('/usr/home-main/tableLayout?floor=' + floor);
                },
                error: function (request, status, error) {
                },
                complete: function () {
                }
            })
        })
    }

</script>