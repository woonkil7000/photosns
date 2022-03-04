<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../layout/header_.jsp"%>
<main class="popular">
    <div class="exploreContainer">
        <div><span style="font-size: 18px; color: Dodgerblue; padding-right: 20px;"><i class="fas fa-heart"></i> 접속자 조회 <i class="fas fa-heart"></i></span></div>
        <p></p>
        <!--
        <div class="alert alert-warning" role="alert">
            <div  style="font-size: 12px;">유튜브의 경우 영상 바깥 하단 부분을 클릭해야 개별창을 열 수 있습니다.</div>
        </div>
        -->
        <!--인기게시글 갤러리(GRID배치)-->
        <div class="popular-gallery">
        </div>
        <!--인기게시글 갤러리(GRID배치) end -->
    </div>
</main>

<%-- @@@@@@@@@@@@@@ 아이템들 @@@@@@@@@@@@@@ --%>

<%-- 앵커에 연결되는 모달 페이지 기능 [버튼] 노출 여부만 다름 !! --%>
<div class="container">
    <div class="row row-cols-1" id="storyList"></div>
    <div class="col"></div>
</div>
<!-- 페이지 주인일때 end -->

<%-- @@@@@@@@@@@@@ 아이템들 end @@@@@@@@@@@@@@ --%>

<script>

    let page=0;
    let orderNum=0;
    let isNoData=1; // init value: true. still no Data.
    let DataFailed=0; // 데이타 로딩 실패. init value: False
    let totalPage=0;
    let currentPage=0;
    let isLastPage=false;
    let appendLastFlag=0;// 더이상 데이타가 없습니다. 멘트 덧붙이기 했나? 안했나?
    let storyLoadUnlock=true; // storyLoad() 초기값 허용.
    let totalElements;

    function getVisitor() {
// ajax 로 Page<Visitor> 가져올 예정.20.
        $.ajax({
            type: "GET",
            url: `/api/visitor?page=${page}`,
            dataType: "json",
        }).done(res => {

            //console.log(" getVisitor ok: ",res);
            totalPage = res.data.totalPages; // 전체 페이지
            currentPage = res.data.pageable.pageNumber; // 현재 페이지 0부터 시작:
            totalElements=res.data.totalElements;
            isLastPage=res.data.last;

            res.data.content.forEach((u) => {
                let item = getImageItem(u,orderNum); // // @@@@@@@@@@@@@ <div> Get Row Data Function. return html tag applied list
                console.log("@ orderNum=",orderNum);
                console.log("@ item=",item);
                $("#storyList").append(item);
                orderNum++;
            });
            page=currentPage+1;
        }).fail(error=>{
            console.log("쓰기 오류:",error);
            console.log("오류 내용: ",error.responseJSON.data.content);
            console.log("isNoData=",isNoData);
            console.log("DataFailed=",DataFailed);
            // 이미지 데이타가 하나도 없을대 //데이터도 없고 데이타 로딩을 실패했을때
            if(isNoData==1&&DataFailed==1){
                let noImage = "<div><p> </p><p> </p><p> </p><span style=\"font-size: 16px; color: Dodgerblue;\">" +
                    " 데이터가 없습니다</p>";
                $("#storyList").append(noImage); // id=#storyList <div> 에 이어 붙이기
            }
        });
    }

    function getImageItem(visitor,order){ // @@@@@@@@@@@@@ <div> Get Row Data Function

        let result = `<div class="col"><p style='font-size: 16px; color: Dodgerblue; padding-right: 16px;'>`+
            order+` : ` +visitor.id+ ` : ` +visitor.createDate;
        result +=` : ` +visitor.ip+ ` : ` +visitor.pageUrl;
        result +=` : ` +visitor.userId+ `</p></div><hr>`; //visitor.user.id
        //console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ result= @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",result);
        return result;
    }

    getVisitor();

    // 스토리 스크롤 페이징하기
    $(window).scroll(() => {

        let checkNum = ($(document).height() - $(window).scrollTop() - $(window).height());

        //console.log("@@@@ before storyLoad() 혀용 storyLoadUnlock=",storyLoadUnlock);
        // 근사치 계산: checkNum=0일때 이벤트 발생함 // currentPage = 0부터 시작
        if ((checkNum < 300 && checkNum > -1) && storyLoadUnlock && (page <= (totalPage-1))) {

            // Set Timer 걸기. 동시이벤트 걸러내기.
            getVisitor();

            storyLoadUnlock=false;
            // console.time("X");
            // console.timeStamp("시작 시간");
            //console.log("========================= imageList() 함수 호출 실행됨 ==========================");
            //console.log("========================= after storyLoad() 불가 storyLoadUnlock=",storyLoadUnlock);
            setTimeout(function(){
                storyLoadUnlock=true; // 3초후 허용
                //console.log("================================== timer 2초후 허용함 storyLoadUnlock=",storyLoadUnlock);
                // console.timeEnd("X");
                // console.timeStamp("종료 시간");
            },1000)

            //window.scrollTo(0, $(window).scrollTop()+$(document).height()+300);
        }
        if (isLastPage==true&&appendLastFlag!=1){ // 데이타의 마지막 페이지
            appendLastFlag=1;
            // append. no more date message.
            let storyItem = "<div  class=\"alert alert-warning\" role=\"alert\">"+
                "<span style=\"font-size: 16px; color: Dodgerblue;\">" +
                " 더이상 데이터가 없습니다 (" +totalElements+ ")</span></div>";
            $("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
        }
        {passive: false}
    });

</script>

</body>
</html>
