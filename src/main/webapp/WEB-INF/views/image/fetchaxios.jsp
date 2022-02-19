<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<!-- 시큐리티 테그 라이브러리 security tag library dependency -->
<!-- 세션 principalDetails에 접근하는 방법 : 공식 property="principal" 상용구문 -->
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="principal" />
</sec:authorize>

<html lang="kor">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js" integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <title>Ajax Fetch Axios</title>
</head>
<body>
<script>
    let today = new Date();
    let date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
    let time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    let dateTime = date+' '+time;

    async function 데이타가져오는함수(){
        let response = await fetch('/api/image2')
            .then((response)=>{
                if(!response.ok){ // 에러 처리
                    throw new Error('400 아니면 500 에러남')
                }
                return response.json() // error message
            })
            .then((결과) => { // get data
                console.log("##### fetch 결과=",결과)
                console.log("# fetch 결과.data=",결과.data)
                console.log("# fetch dateTime=",dateTime)
            })
            .catch(() => { // 에러 처리
                console.log('# fetch 에러남')
            })
    }

    데이타가져오는함수().catch(()=>{
        console.log('# fetch 에러남')
    });


    //     axios 사용         코드 간단하게
    axios.get('/image')
        .then((result)=>{
            console.log(" ##### axios result => ",result)
            console.log(" ##### axios result.data => ",result.data)
            console.log(" # axios result.data.data.totalPages => ",result.data.data.totalPages)
            console.log(" # axios result.data.data.totalElements => ",result.data.data.totalElements)
        }).catch(()=>{ // 에러 처리
        console.log('# axios 에러남')
    })

 /*   setTimeout(function(){
        데이타가져오는함수();
        console.log("# dateTime=",dateTime)
    },5000)

    function first(){
        console.log("# first()=",1);
    }

    function second(파라미터) {
        console.log("# second()=",2);
        파라미터()
    }
    second(first);*/

    function 알림창열기(구멍1,구멍2){
        document.getElementById(구멍1).style.display=구멍2;
    }
</script>
<div class="alert-box" id="alert" style="display: block;">
    <p>Alert Box 1</p>
    <button onclick="알림창열기('alert','none')">closebutton</button>
</div>
<div class="alert-box" id="alert2" style="display: block;">
    <p>Alert Box 2</p>
    <button onclick="알림창열기('alert2','none')">closebutton</button>
</div>
</body>
</html>