<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="shortcut icon" href="/resource/images/favicon.ico">
    <!-- 테일윈드 불러오기 -->
    <!-- 노말라이즈, 라이브러리 -->
    <link href="https://cdn.jsdelivr.net/npm/daisyui@3.5.0/dist/full.css" rel="stylesheet" type="text/css"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <%--    alert 불러 오기--%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- 제이쿼리 불러오기 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- 폰트어썸 불러오기 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>
    <%-- google Icons   --%>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>
    <link rel="stylesheet" href="/resource/common.css" type="text/css">
    <script src="/resource/common.js" defer="defer"></script>
    <title>${pageTitle}</title>
</head>
<body>
<div class="header">
    <a class="px-3 flex items-center" href="/">
        <span class="text-red-500">Easy</span>
        <span>Pos</span>
    </a>
    <ul class="header-box">
        <li class="">
            <a class="" href="">
                <span class="material-symbols-outlined text-4xl">print</span>
                <span class="text-sm">직전 영수증</span>
            </a>
        </li>
        <li class="">
            <a class="" href="">
                <span class="material-symbols-outlined text-4xl">format_align_right</span>
                <span class="text-sm">메뉴 ON/OFF</span>
            </a>
        </li>
        <li >
            <a href="">
                <span class="material-symbols-outlined text-4xl">currency_exchange</span>
                <span class="text-sm">환전</span>
            </a>
        </li>
        <li >
            <a href="">
                <span class="material-symbols-outlined text-4xl">calendar_month</span>
                <span class="text-sm">예약현황</span>
            </a>
        </li>

        <li>
            <a href="">
                <span class="material-symbols-outlined text-4xl">desktop_windows</span>
                <span class="text-sm">바탕화면</span>
            </a>
        </li>
        <li >
            <a href="">
                <span class="material-symbols-outlined text-4xl">currency_exchange</span>
                <span class="text-sm">총매출</span>
            </a>
        </li>
        <li>
            <a href="">
                <span class="material-symbols-outlined text-4xl">close</span>
            </a>
        </li>
    </ul>
</div>
