<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="EasyPos"/>
<c:set var="pageName" value="기초정보"/>
<%@include file="../common/head.jsp" %>
<%@include file="../common/somePageHead.jsp" %>
<div class="side-bar">
    <div class="status-icons">
        <div>▶</div>
        <div>▼</div>
    </div>
    <div>
        <span class="material-symbols-outlined text-red-400">smart_display</span>
        <span class="pl-2">기초정보</span>
    </div>
    <nav class="menu-box">
        <ul>
            <li>
                <span class="material-symbols-outlined">article</span>
                <a href="#">상품관리</a>
                <ul>
                    <li onclick="classificationManagement();" id="classificationManagement">
                        <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                        <a>상품분류관리</a>
                    </li>
                    <li>
                        <span onclick="productLookUp();" id="productLookUp" class="material-symbols-outlined">subdirectory_arrow_right</span>
                        <a >상품조회</a>
                    </li>
                    <li>
                        <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                        <a href="#">상품등록</a>
                    </li>
                </ul>
            </li>
            <li>
                <span class="material-symbols-outlined">article</span>
                <a href="#">터치키관리</a>
                <ul>
                    <li>
                        <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                        <a href="#">터치키상품등록</a>
                    </li>
                    <li>
                        <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                        <a href="#">터치키상품등록(위치)</a>
                    </li>
                </ul>
            </li>
            <li>
                <span class="material-symbols-outlined">article</span>
                <a href="#">POS관리</a>
                <ul>
                    <li>
                        <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                        <a href="#">주방프리터 관리</a>
                    </li>
                </ul>
            </li>
            <li>
                <span class="material-symbols-outlined">article</span>
                <a href="#">사원관리</a>
                <ul>
                    <li>
                        <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                        <a href="#">사원관리</a>
                    </li>
                </ul>
            </li>
            <li>
                <span class="material-symbols-outlined">article</span>
                <a href="#">기타관리</a>
                <ul>
                    <li>
                        <span class="material-symbols-outlined">subdirectory_arrow_right</span>
                        <a href="#">테이블 베치</a>
                    </li>
                </ul>
            </li>
        </ul>
    </nav>
</div>

<%@include file="../basicInformation/salesInformationManagement.jsp"%>
<%--<%@include file=""%>--%>

<script>
    function classificationManagement() {
        $("#classificationManagement").css("color", "#FBD3AD");
        $(".basicInformation-left").css("display" , "flex")
    }

    function productLookUp() {
        $("#productLookUp").css("color", "#FBD3AD");
        $(".product-lookUp-page").css("display" , "flex")
    }

</script>
<%@include file="../common/footer.jsp" %>