<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../common/head.jsp" %>
<c:set var="pageTitle" value="LoginPage"/>

<div class="login-page-box">
    <section>
        <div class="loginPage-top-part">
            <img src="/resource/images/advertisement1.jpg" alt="">
            <div class="login-box">
                <button class="loginPage-close-btn">
                    <span class="material-symbols-outlined">close</span>
                </button>
                <h1 class="loginPage-logo">EasyPOS</h1>
                <div>
                    <div class="loginId">
                        <span class="material-symbols-outlined">person</span>
                        <input type="text" id="loginId" value="">
                    </div>
                    <div class="loginPw">
                        <span class="material-symbols-outlined">password</span>
                        <input type="password" id="loginPw" value="">
                    </div>
                    <div class="loginSave-check-box">
                        <input type="checkbox" id="check-btn">
                        <span>아이디 저장</span>
                        <span class="material-symbols-outlined">keyboard_alt</span>
                    </div>
                    <button class="login-btn">로그인</button>
                </div>
            </div>
        </div>
        <div class="loginPage-bottom-part">
            <img src="/resource/images/advertisement2.jpg" alt="">
            <img src="/resource/images/advertisement3.jpg" alt="">
        </div>
        <div class="loginPage-msg-box">
            <span class="material-symbols-outlined">volume_up</span>
            <span class="loginPage-msg-tag text-red-600"></span>
        </div>
    </section>
</div>

<script>
    $(".login-btn").click(function () {
        let loginId = $("#loginId")[0].value;
        let loginPw = $("#loginPw")[0].value;
        let isIdSave = $("#check-btn")[0].checked

        $.get("/usr/member/doLogin", {
            loginId: loginId,
            loginPw: loginPw,
            isIdSave: isIdSave
        }, function (data) {

            if (data.resultCode === "S-1") {
                location.replace(data.msg)
            } else {
                $(".loginPage-msg-box > span:nth-child(2)").html(data.msg)
            }

        }, "json")
    })

    document.querySelector('#loginId').addEventListener('keydown', (e) => {
        if (e.key == "Enter" || e.keyCode == "13") {
            $(".login-btn").click();
        }
    });

    document.querySelector('#loginPw').addEventListener('keydown', (e) => {
        if (e.key == "Enter" || e.keyCode == "13") {
            $(".loginPw").focus();
            $(".login-btn").click();
        }
    });


</script>

<%@include file="../common/footer.jsp" %>