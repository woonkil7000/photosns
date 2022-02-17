<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<script>

    // Function to check Whether both passwords
    // is same or not.
    function checkPassword(form) {
        password1 = form.password.value;
        password2 = form.password2.value;

        // If password not entered
        if (password1 == '')
            alert ("첫번째 패스워드를 입력해주세요");

        // If confirm password not entered
        else if (password2 == '')
            alert ("확인용 패스워드를 입력해주세요");

        // If Not same return False.
        else if (password1 != password2) {
            alert ("\n패스워드가 서로 다릅니다: 패스워드를 다시 입력해주세요")
            return false;
        }

        // If same return True.
        else{
            //alert("Password Match: Welcome to GeeksforGeeks!")
            return true;
        }
    }
</script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photogram</title>
    <link rel="stylesheet" href="/css/style.css">
    <!--
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
        -->
</head>

<body>
    <div class="container">
        <main class="loginMain">
           <!--회원가입섹션-->
            <section class="login">
                <article class="login__form__container">
                  
                   <!--회원가입 폼-->
                    <div class="login__form">
                        <!--로고-->
                        <h1><img src="/images/logo2.png"  width="150" height="50" alt=""></h1>
                         <!--로고end-->
                         
                         <!--회원가입 인풋-->
                        <form onSubmit = "return checkPassword(this)" class="login__input" action="/auth/signup" method="post">
                            영문ID<input type="text" name="username" placeholder="영문 ID" maxlength="20" required="required">
                            패스워드<input type="password" name="password" placeholder="패스워드" required="required">
                            패스워드<input type="password" name="password2" placeholder="패스워드" required="required">
                            이름<input type="text" name="name" placeholder="이름" required="required">
                            EMAIL<input type="email" name="email" placeholder="이메일" required="required">
                            <!-- <input type="text" name="name" placeholder="이름" required="required"> -->
                            <button>가입</button>
                        </form>
                        <!--회원가입 인풋end-->
                    </div>
                    <!--회원가입 폼end-->
                    
                    <!--계정이 있으신가요?-->
                    <div class="login__register">
                        <span>계정이 있으신가요?</span>
                        <a href="/auth/signin">로그인</a>
                    </div>
                    <!--계정이 있으신가요?end-->
                    
                </article>
            </section>
        </main>
    </div>
</body>

</html>