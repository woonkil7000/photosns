<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo SNS</title>
    <link rel="stylesheet" href="/css/style.css">
    <!-- Fontawesome -->
    <link href="/fontawesome/css/all.css" rel="stylesheet"> <!--load all styles -->
    <link rel="stylesheet" charset="UTF-8" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.6.0/slick-theme.min.css"/>
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css"/>
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!--
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
        -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
</head>

<body>
    <div class="container">
        <main class="loginMain">
        <!--로그인섹션-->
            <section class="login">
               <!--로그인박스-->
                <article class="login__form__container">
                   <!--로그인 폼-->
                   <div class="login__form">
                       <div  class="login__facebook"><img src="/images/logo2.png" width="150" height="50" alt=""></div>
                       <div  class="alert alert-warning" role="alert">
                           <c:set var="errorMsg" value="${param.error}"/>
                           <c:set var="logoutMsg" value="${param.logout}"/>
                           <c:choose>
                               <c:when test="${param.error}">
                                   <div class="login__facebook"><span>${test1}ID 또는 패스워드가 일치하지 않습니다</span></div>
                               </c:when>
                           </c:choose>
                           <c:choose>
                               <c:when test="${param.logout}">
                                   <div class="alert alert-warning" role="alert"><span>${test2}로그 아웃되었습니다</span></div>
                               </c:when>
                           </c:choose>
                       </div>
                        <!--로그인 인풋-->
                        <form class="login__input" action="/login" method="post"><!-- security config login processing -->
                            <!--
                            <input type="text" name="username" placeholder="유저네임">
                            <input type="password" name="password" placeholder="비밀번호">
                            -->
                            <input type="text"  name="username" autocomplete="username" required="required" placeholder="아이디">
                            <input type="password"  name="password" autocomplete="current-password" required="required" placeholder="패스워드">

                            <div  class="login__facebook"><p>Test Id = "test"</p><p> PW = "111"</p></div>
                            <button>로그인</button>
                        </form>
                        <!--로그인 인풋end-->
                        
                        <!-- 또는 -->
                        <div class="login__horizon">
                            <div class="br"></div>
                            <div class="or">LOGIN WITH SNS</div>
                            <div class="br"></div>
                        </div>
                        <!-- 또는end -->
                        
                        <!-- Oauth 소셜로그인 -->
                       <div class="login__facebook">
                           <!-- <button onclick="javascript:location.href='/oauth2/authorization/google'"> -->
                           <button onclick="javascript:location.href='/oauth2/authorization/kakao'">
                               <!-- <i class="fab fa-google-plus-square"></i> -->
                               <span class="sc-kstrdz kBjdk"><image  height="30px" width="30" src="/images/kakao.png"/></span>
                               <span class="sc-hBEYos hXuLSV">LOGIN WITH KAKAO</span>
                           </button>
                       </div>
                       <div class="login__facebook">
                           <!-- <button onclick="javascript:location.href='/oauth2/authorization/google'"> -->
                           <button onclick="javascript:location.href='/oauth2/authorization/naver'">
                               <!-- <i class="fab fa-google-plus-square"></i> -->
                               <span class="sc-kstrdz kBjdk"><image  height="30px" width="30" src="/images/naver.png"/></span>
                               <span>LOGIN WITH NAVER</span>
                           </button>
                       </div>
                       <div class="login__facebook">
                           <!-- <button onclick="javascript:location.href='/oauth2/authorization/google'"> -->
                           <button onclick="javascript:location.href='/oauth2/authorization/google'">
                               <!-- <i class="fab fa-google-plus-square"></i> -->
                               <span class="sc-kstrdz kBjdk"><image height="30px" width="30" src="/images/google.png"/>
                               <span>LOGIN WITH GOOGLE</span>
                           </button>
                       </div>
                       <div class="login__facebook">
                            <!-- <button onclick="javascript:location.href='/oauth2/authorization/facebook'"> -->
                            <button onclick="javascript:location.href='/oauth2/authorization/facebook'">
                            <!-- <i class="fab fa-facebook-square"></i> -->
                                <image height="30px" width="30" src="/images/facebook.png"/>
                                <span>LOGIN WITH FACEBOOK</span>
                            </button>
                        </div>
                        <!-- Oauth 소셜로그인end -->
                    </div>
                    
                    <!--계정이 없으신가요?-->
                    <div class="login__register">
                        <span>계정이 없으신가요?</span>
                        <a href="/auth/signup">가입하기</a>
                    </div>
                    <!--계정이 없으신가요?end-->
                </article>
            </section>
        </main>
        
    </div>
</body>

</html>