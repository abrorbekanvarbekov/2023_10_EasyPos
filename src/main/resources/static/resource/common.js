const container = document.querySelector(".container-")
document.querySelectorAll(".product-box-list").forEach((element) => {
    element.addEventListener("click", (e) => {
        console.log(e.target.id)
        const el = document.querySelector(".product-box-list_" + e.target.id)
        el.style.backgroundColor = "blue"
    })
})

const {width: containerWidth, height: containerHeight} = container.getBoundingClientRect();

let posX = null;
let posY = null;
let tableId = null;
let originLeft = null;
let originTop = null;
let originX = null;
let originY = null;
let boxWidth = null;
let boxHeight = null;

document.querySelectorAll(".container- .tables").forEach((element) => {
    element.addEventListener("dragstart", (e) => {
        tableId = e.target.id
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
        id: tableId
    }, function (data) {
        console.log("성공")
    }, 'json')

})


// const container = document.querySelector(".area")
// const box = document.querySelector(".area__box")
//
// const {width:containerWidth, height:containerHeight} = container.getBoundingClientRect();
// const {width:boxWidth, height:boxHeight} = box.getBoundingClientRect();
//
// let stickerId = null;
// let isDragging = null;
// let originLeft = null;
// let originTop = null;
// let originX= null;
// let originY = null;
//
//
// box.addEventListener("mousedown", (e) => {
//     isDragging = true;
//     originX = e.clientX;
//     originY = e.clientY;
//     originLeft = box.offsetLeft;
//     originTop = box.offsetTop;
//     console.log(originTop, originLeft)
// })
//
// box.addEventListener("mouseup", (e) => {
//     isDragging = false;
// })
//
// document.addEventListener("mousemove", (e) => {
//     if(isDragging){
//         const diffX = e.clientX - originX;
//         const diffY = e.clientY - originY;
//         const endOfXPoint = containerWidth - boxWidth;
//         const endOfYPoint = containerHeight - boxHeight;
//         box.style.left = `${Math.min(Math.max(0, originLeft + diffX), endOfXPoint)}px`;
//         box.style.top = `${Math.min(Math.max(0, originTop + diffY), endOfYPoint)}px`;
//
//         console.log(boxCurrentTop, boxCurrentLeft)
//         boxCurrentLeft = box.offsetLeft;
//         boxCurrentTop = box.offsetTop;
//     }
// });
