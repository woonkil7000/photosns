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


	<!-- Style -->

	<link rel="stylesheet" href="/css/style.css">
	<link rel="stylesheet" href="/css/story.css">
	<link rel="stylesheet" href="/css/popular.css">
	<link rel="stylesheet" href="/css/profile.css">
	<link rel="stylesheet" href="/css/upload.css">
	<link rel="stylesheet" href="/css/update.css">
	<!--
	<link rel="shortcut icon" href="/images/insta.svg">
	-->

	<!-- Fontawesome -->
    <link href="/fontawesome/css/all.css" rel="stylesheet"> <!--load all styles -->

	<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" /> -->
	<!-- Fonts -->

	<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="/fontawesome/css/all.min.css">

	<link rel="stylesheet" href="/node_modules/bootstrap-icons/font/bootstrap-icons.css">

	<link rel="stylesheet" href="/css/main.css">

	<title>Photo SNS</title>
</head>

<body>

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<!-- ip address -->
<script src="/js/recIp.js"></script>

	<input type="hidden" id="principalId" value="${principal.user.id}"/>
	<input type="hidden" id="principalUsername" value="${principal.user.username}"/>
	<!--
	<header class="navbar navbar-expand-md fixed-top navbar-primary d-flex flex-column align-items-center flex-md-column px-5 pt-1 pb-1 bg-light">
	-->
	<header class="navbar navbar-expand-md fixed-top navbar-primary d-flex text-center flex-md-column px-5 pt-0 pb-0 mb-0 mt-0 bg-light">
			<!--
			<nav class="my-2 me-md-5 h1">
			-->
			<nav class="navbar navbar-expand-lg navbar-primary text-center">
				<div class="container-fluid">
				<a class="navbar-brand"  href="/image/storyall" alt="storyall">
						<i class="fas fa-images"></i>
						</a>
				<a class="navbar-brand"  href="/image/story" alt="subscribe">
						<i class="fas fa-newspaper"></i>
					</a>
				<a class="navbar-brand"  href="/image/popular2" alt="popular">
						<i class="fas fa-heart"></i>
						</a>
				<a class="navbar-brand"  href="/image/upload" alt="upload">
						<i class="fas fa-file-upload"></i>
					</a>
				<a class="navbar-brand"  href="/user/${principal.user.id}" alt="profile">
						<i class="fa fa-user"></i>
						</a>
				</div>
			</nav>
	</header>