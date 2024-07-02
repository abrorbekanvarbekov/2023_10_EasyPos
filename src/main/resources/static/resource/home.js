const HomeContainer = document.querySelector(".container-")

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


    document.querySelectorAll(".container- .tables").forEach((element) => {
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

    document.querySelector(".container-").addEventListener("dragover", (e) => {
        e.preventDefault();
        e.stopPropagation();
    })

    document.querySelector(".container-").addEventListener("drop", (e) => {
        e.preventDefault();
        e.stopPropagation();
        const tableEl = document.getElementById(tableId);
        const diffX = e.clientX - originX;
        const diffY = e.clientY - originY;
        const endOfXPoint = containerWidth - boxWidth;
        const endOfYPoint = containerHeight - boxHeight;
        tableEl.style.left = `${Math.min(Math.max(0, originLeft + diffX), endOfXPoint)}px`;
        tableEl.style.top = `${Math.min(Math.max(0, originTop + diffY), endOfYPoint)}px`;

        $.get('/usr/tables/update', {
            elPosX: tableEl.offsetLeft,
            elPosY: tableEl.offsetTop,
            tableName: tableId,
            floor: floor
        }, function (data) {
            console.log("성공")
        }, 'json')

    })
}




