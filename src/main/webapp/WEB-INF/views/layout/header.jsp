<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 시큐리티 테그 라이브러리 security tag library dependency -->
<!-- 세션 principalDetails에 접근하는 방법 : 공식 property="principal" 상용구문 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

	<!-- 제이쿼리 -->
	<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>


	<!-- Style -->
	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="/css/story.css">
	<link rel="stylesheet" href="/css/popular.css">
	<link rel="stylesheet" href="/css/profile.css">
	<link rel="stylesheet" href="/css/upload.css">
	<link rel="stylesheet" href="/css/update.css">
	<link rel="shortcut icon" href="/images/insta.svg">

	<!-- Fontawesome -->
    <link href="/fontawesome/css/all.css" rel="stylesheet"> <!--load all styles -->
	<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" /> -->
	<!-- Fonts -->
	<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/fontawesome/css/all.min.css">
	<title>Photo SNS</title>
</head>

<body>
<!-- Optional JavaScript; choose one of the two! -->

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- Option 2: Separate Popper and Bootstrap JS -->
<!--
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
-->
	<input type="hidden" id="principalId" value="${principal.user.id}"/>
	<input type="hidden" id="principalUsername" value="${principal.user.username}"/>

	<header class="header">
		<div class="container">
			<a href="/image/storyall" class="logo">
				<img src="/images/logo2.png" alt="">
			</a>
			<nav class="navi">
				<ul class="navi-list">
					<li class="navi-item"><a href="/image/storyall" >
						<i class="fas fa-images"></i>
						</a></li>
					<li class="navi-item"><a href="/image/story" alt="subscribe">
						<i class="fas fa-newspaper"></i>
					</a></li>
					<li class="navi-item"><a href="/image/popular" alt="popular">
						<i class="fas fa-heart"></i>
						</a></li>
					<li class="navi-item"><a href="/image/upload" alt="upload">
						<i class="fas fa-file-upload"></i>
					</a></li>
					<li class="navi-item"><a href="/user/${principal.user.id}" alt="profile">
						<!--<span style="font-size: 40px; color: Dodgerblue; padding-right: 20px;">-->
						<i class="fa fa-user"></i>
						</a></li>
                      <!-- <li class="navi-item"><i class="fas fa-user"></i></li> --> <!-- uses solid style -->
                      <!-- <li class="navi-item"><i class="far fa-user"></i></li> --> <!-- uses regular style -->
                      <!-- <li class="navi-item"><i class="fal fa-user"></i></li> --> <!-- uses light style -->

                      <!-- <li class="navi-item"><i class="fab fa-github-square"></i></li> --> <!-- uses brands style -->

				</ul>
			</nav>
		</div>
	</header>