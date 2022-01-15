<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 시큐리티 테그 라이브러리 security tag library dependency -->
<!-- 세션 principalDetails에 접근하는 방법 : 공식 property="principal" 상용구문 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Photo Story</title>

	<!-- 제이쿼리 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

	<!-- Style -->
	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="/css/story.css">
	<link rel="stylesheet" href="/css/popular.css">
	<link rel="stylesheet" href="/css/profile.css">
	<link rel="stylesheet" href="/css/upload.css">
	<link rel="stylesheet" href="/css/update.css">
	<link rel="shortcut icon" href="/images/insta.svg">
	<!--
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	-->

	<!-- Fontawesome -->
    <link href="/fontawesome/css/all.css" rel="stylesheet"> <!--load all styles -->
	<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" /> -->
	<!-- <link rel="stylesheet" href="/fontawesome/css/all.min.css"> -->
	<!-- Fonts -->
	<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">
</head>

<body>
	<input type="hidden" id="principalId" value="${principal.user.id}"/>
	<input type="hidden" id="principalUsername" value="${principal.user.username}"/>

	<header class="header">
		<div class="container">
			<a href="/image/storyall" class="logo">
				<img src="/images/logo.jpg" alt="">
			</a>
			<nav class="navi">
				<ul class="navi-list">
					<li class="navi-item"><a href="/image/storyall" alt="storyall">
							<!-- <i class="fas fa-home"></i> -->
						<!-- <i class="fas fa-newspaper"></i> -->
						<i class="fas fa-images"></i>
						</a></li>
					<li class="navi-item"><a href="/image/story" alt="subscribe">
						<!-- <i class="fas fa-home"></i> -->
						<i class="fas fa-newspaper"></i>
					</a></li>
					<li class="navi-item"><a href="/image/popular" alt="popular">
							<!-- <i class="fas fa-compass"></i>-->
							<i class="fas fa-heart"></i>
							<!--<i class="fas fa-thumbs-up"></i>-->
						</a></li>
					<li class="navi-item"><a href="/user/${principal.user.id}" alt="profile">
							<i class="fas fa-user"></i>
						</a></li>
                      <!-- <li class="navi-item"><i class="fas fa-user"></i></li> --> <!-- uses solid style -->
                      <!-- <li class="navi-item"><i class="far fa-user"></i></li> --> <!-- uses regular style -->
                      <!-- <li class="navi-item"><i class="fal fa-user"></i></li> --> <!-- uses light style -->

                      <!-- <li class="navi-item"><i class="fab fa-github-square"></i></li> --> <!-- uses brands style -->

				</ul>
			</nav>
		</div>
	</header>