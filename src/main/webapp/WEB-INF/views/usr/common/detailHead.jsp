<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="head.jsp" %>
<script src="/resource/detail.js" defer="defer"></script>
<div class="header-detail">
    <a class="px-3 flex items-center cursor-default">
        <span class="text-red-500">Easy</span>
        <span>Pos</span>
    </a>
    <ul class="header-box-detail">
        <li class="btn-last-receipt">
            <a>
                <span class="material-symbols-outlined text-4xl">print</span>
                <div><span class="material-symbols-outlined ">undo</span></div>
                <span class="text-sm">직전 영수증</span>
            </a>
        </li>
        <li>
            <a href="btn-go-wallpapers">
                <span class="material-symbols-outlined text-3xl">desktop_windows</span>
                <span class="text-sm">바탕화면</span>
            </a>
        </li>
        <li>
            <a href="">
                <span class="material-symbols-outlined text-3xl">cached</span>
                <span class="text-sm">자료송수신</span>
            </a>
        </li>
        <li class="printer-control-box">
            <a>
                <span class="material-symbols-outlined text-4xl">print</span>
                <div class="printer-control-btn">
                    <span class="material-symbols-outlined">play_arrow</span>
                    <span class="material-symbols-outlined hidden">pause</span>
                </div>
                <span class="text-sm">프린터제어</span>
            </a>
        </li>
        <li>
            <a href="/usr/main/salesSummary">
                <span class="material-symbols-outlined text-3xl">currency_exchange</span>
                <span class="text-sm">총매출</span>
            </a>
        </li>
        <li class="btn-close">
            <a>
                <span class="material-symbols-outlined text-4xl">close</span>
            </a>
        </li>
    </ul>
</div>
<div class="messagePage-msg-box">
    <div class="layer-bg"></div>
    <div class="layer">
        <div class="confirm-message">등록된 상품을 취소하시겠습니까?</div>
        <button id="check-btn" value="true" class="btn btn-active btn-info  mt-2 confirm-button">확인</button>
        <button id="cancel-btn" value="false" class="btn btn-active btn-ghost mt-2 cancel-button">취소</button>
    </div>
</div>

<div class="messagePage-msg-box">
    <div class="change-layer-bg"></div>
    <div class="change-layer">
        <div class="change-confirm-message">등록된 상품을 취소하시겠습니까?</div>
        <button id="change-check-btn" value="true" class="btn btn-active btn-info  mt-2 confirm-button">확인</button>
    </div>
</div>
<script>

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
            const result = await showConfirmDialog("등록된 상품을 취소하시겠습니까?");
            return result;
        } catch (error) {
            return error;
        }
    }


    function openMsgBox() {
        $('.layer').show();
        $('.layer-bg').show();
    }

    function closeMsgBox(){
        $('.layer').hide();
        $('.layer-bg').hide();
    }


    <%--    ========= 프린터기 제어하기 ============== --%>
    let color = "";
    document.querySelector(".printer-control-box").addEventListener("click", function (el) {
        if (color == "") {
            color = document.querySelector(".printer-control-btn").style.backgroundColor = "red"
            document.querySelector(".printer-control-btn > span:first-child").classList.add("hidden")
            document.querySelector(".printer-control-btn > span:last-child").classList.remove("hidden")
            $('input[name=isPrintControl]').val("false");
        } else {
            document.querySelector(".printer-control-btn").style.backgroundColor = "dodgerblue"
            color = "";
            document.querySelector(".printer-control-btn > span:first-child").classList.remove("hidden")
            document.querySelector(".printer-control-btn > span:last-child").classList.add("hidden")
            $('input[name=isPrintControl]').val("true");
        }
    })

    //  ============ Detail smg box ============== //
    $(".btn-last-receipt").click(function () {
        $(".msg-tag").html("인쇄 내용이 존재하지 않습니다.")
        setTimeout(function () {
            $(".msg-tag").html("")
        }, 5000)
    })
</script>