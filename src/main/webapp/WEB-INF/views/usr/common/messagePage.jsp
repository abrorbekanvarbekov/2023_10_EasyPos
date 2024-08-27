<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="head.jsp"%>
<div class="messagePage-msg-box">
    <div class="mt-6 flex justify-between">
        <span class="btn btn-accent btn-sm modal-exam">모달 예시</span>
        <span class="btn btn-accent btn-sm popUp-exam">팝업 예시</span>
    </div>

    <div class="layer-bg"></div>
    <div class="layer">
        <div>등록된 상품취소하시겠습니까?</div>
        <button id="check-btn" class="btn btn-active btn-info  mt-2">확인</button>
        <button id="cancel-btn" class="btn btn-active btn-ghost mt-2">취소</button>
    </div>
</div>


<script>
    $('.modal-exam').click(function () {
        $('.layer').show();
        $('.layer-bg').show();
    })

    $('#close-btn').click(function () {
        $('.layer').hide();
        $('.layer-bg').hide();
    })

</script>