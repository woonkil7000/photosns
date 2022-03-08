<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kor">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link href="signin.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/main.css">
    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
    </style>

    <title>Photo SNS</title>
    <!-- Custom styles for this template -->
    <!--<link href="signin.css" rel="stylesheet">-->
</head>
<body class="text-center pt-lg-3">
            <form action="/login" method="post">
                       <img class="mb-3 mt-3" src="/images/logo2.png" width="150" height="50" alt="">
                <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
                           <c:set var="errorMsg" value="${param.error}"/>
                           <c:set var="logoutMsg" value="${param.logout}"/>
                           <c:choose>
                               <c:when test="${param.error}">
                                   <div class="alert alert-danger" role="alert">${test1}ID 또는 패스워드가 일치하지 않습니다</div>
                               </c:when>
                           </c:choose>
                           <c:choose>
                               <c:when test="${param.logout}">
                                   <div class="alert alert-danger" role="alert">${test2}로그 아웃되었습니다</div>
                               </c:when>
                           </c:choose>
                <div>
                            <input class="form-group col-lg-2" id="floatingInput"  type="text"  name="username" autocomplete="username" required="required" placeholder="아이디">
                </div>
                <div>
                            <input class="form-group col-lg-2" id="floatingPassword" type="password"  name="password" autocomplete="current-password" required="required" placeholder="패스워드">
                </div>
                <div>
                <label class="alert alert-warning col-md-2 mt-1 mb-3" role="alert">테스트용 ID="test" PW="111"</label>
                </div>
                <div>
                        <button class="btn btn-lg btn-primary">로그인</button>
                </div>
            </form>
                        <!--로그인 인풋end-->



                        <!-- 또는 -->
<%--                        <div class="login__horizon">--%>
<%--                            <div class="br"></div>--%>
<%--                            <div class="or">LOGIN WITH SNS</div>--%>
<%--                            <div class="br"></div>--%>
<%--                        </div>--%>
                        <!-- 또는end -->
                        
                        <!-- Oauth 소셜로그인 -->
            <div class="form-floating mt-3" style="border: 0px;">
                           <!-- <button onclick="javascript:location.href='/oauth2/authorization/google'"> -->
                           <button onclick="javascript:location.href='/oauth2/authorization/kakao'">
                               <!-- <i class="fab fa-google-plus-square"></i> -->
                               <image  height="30px" width="30" src="/images/kakao.png"/>
                               LOGIN WITH KAKAO
                           </button>
                       </div>
            <div class="form-floating mt-2">
                           <!-- <button onclick="javascript:location.href='/oauth2/authorization/google'"> -->
                           <button onclick="javascript:location.href='/oauth2/authorization/naver'">
                               <!-- <i class="fab fa-google-plus-square"></i> -->
                               <span><image  height="30px" width="30" src="/images/naver.png"/></span>
                               <span>LOGIN WITH NAVER</span>
                           </button>
                       </div>
                       <div class="form-floating mt-2">
                           <!-- <button onclick="javascript:location.href='/oauth2/authorization/google'"> -->
                           <button onclick="javascript:location.href='/oauth2/authorization/google'">
                               <!-- <i class="fab fa-google-plus-square"></i> -->
                               <span><img height="30px" width="30" src="/images/google.png"></img></span>
                               <span>LOGIN WITH GOOGLE</span>
                           </button>
                       </div>
            <div class="form-floating mt-2">
                            <!-- <button onclick="javascript:location.href='/oauth2/authorization/facebook'"> -->
                            <button onclick="javascript:location.href='/oauth2/authorization/facebook'">
                            <!-- <i class="fab fa-facebook-square"></i> -->
                                <image height="30px" width="30" src="/images/facebook.png"/>
                                <span>LOGIN WITH FACEBOOK</span>
                            </button>
                        </div>
                        <!-- Oauth 소셜로그인end -->

                    <!--계정이 없으신가요?-->
                    <div class="form-floating mt-3">
                        <span>계정이 없으신가요?</span>
                        <a href="/auth/signup">가입하기</a>
                    </div>
                    <!--계정이 없으신가요?end-->
            <p class="mt-3 text-muted">© 2017–2021</p>
        <!-- Option 1: Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>