<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<!--사진 업로드페이지 중앙배치-->
<main class="uploadContainer mt-0">
    <!--사진업로드 박스-->
    <section class="upload">
        <!--사진업로드 로고-->
        <!--<div class="upload-top">
                <img src="/images/logo2.png"  width="50" height="50" alt="">
        </div>
        -->
        <!-- 업로드 선택 탭 -->
        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">사진영상 파일</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">유튜브 공유</button>
            </li>
            <!--
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">...</button>
            </li>
            -->
        </ul>
        <div class="tab-content" id="pills-tabContent">

            <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                <!-- 파일 업로드 -->
                <div class="upload-top">
                    <span style="font-size: 18px; color: Dodgerblue;"> 사진/영상 파일 올리기</span>
                </div>
                <!--사진업로드 Form-->
                <form class="upload-form" method="POST" enctype="multipart/form-data" action="/image">
                    <input class="form-control" type="file" name="file"  onchange="imageChoose(this)"/>
                    <div class="upload-img mt-0 mb-0 pt-0 pb-0">
                        <img style="max-height: 200px;max-width: 300px;" src="/images/noimage.jpg" alt="uplaod file" id="imageUploadPreview" />
                    </div>
                    <!--사진설명 + 업로드버튼-->
                    <div class="alert alert-primary btn-sm mt-0 mb-0" role="alert"><b>전송 완료시 [화면이 전환]됩니다.</b> 용량이 큰 파일은 [화면이 전환]될 때 까지 잠시 기다려주세요</div>
                    <div class="upload-form-detail form-floating">
                        <!--<input type="text" placeholder="사진설명" name="caption">-->
                        <!--<div class="form-floating">-->
                        <label for="floatingTextarea">사진 제목 입력(선택사항)</label>
                        <textarea class="form-control"  placeholder="사진/영상 설명" name="caption" id="floatingTextarea"></textarea>
                        <input class="form-control" type="text" placeholder="#해시 태그 입력(선택사항)" name="tags">
                        <button class="btn btn-primary btn-lg">파일 전송 시작</button>
                    </div>
                    <!--사진설명end-->
                </form>
                <!--사진업로드 Form-->

                <!-- 파일 업로드 end -->
            </div>
            <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                <!-- 유튜브 주소 붙여넣기 -->
                <div class="upload-top mb-0 mt-0">
                    <span style="font-size: 18px; color: Dodgerblue;"> YouTube [공유] 링크 올리기</span>
                </div>
                <!-- 유튜브 업로드 Form-->
                <form class="upload-form" method="POST" action="/youtube" onsubmit="jbSubmit();">
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon3">공유 링크:</span>
                        <input type="hidden" name="uAddress" id="uAddress" value="">
                        <input type="text" name="iAddress" class="form-control" id="basic-url" aria-describedby="basic-addon3" placeholder="...여기에 붙여넣기">
                    </div>
                    <!--유튜브 설명 + 업로드버튼-->
                    <div class="alert alert-primary" role="alert">
                        <span style="font-size: 16px; color: Dodgerblue;">YouTube [공유] 링크를 복사한 후 붙여넣기 하세요</span>
                    </div>
                    <div class="upload-form-detail form-floating">
                        <!--<input type="text" placeholder="사진설명" name="caption">-->
                        <!--<div class="form-floating">-->
                        <label for="floatingTextarea">YouTube 제목 입력(선택사항)</label>
                        <textarea class="form-control"  placeholder="사진/영상 설명" name="caption" id="floatingTextarea2"></textarea>
                        <input class="form-control" type="text" placeholder="#해시 태그 입력(선택사항)" name="tags">
                        <button class="btn btn-primary btn-lg">YouTube [공유] 전송</button>
                    </div>
                    <!--유튜브 설명end-->
                </form>
                <!--유튜브 업로드 Form-->

                <!-- 유튜브 주소 붙여넣기 end -->
            </div>
            <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
                ...
            </div>
        </div>
        <!-- 업로드 선택 텝 end -->


        <!--사진업로드 로고 end-->
        <!--
        <div class="mb-3">
            <label for="formFileMultiple" class="form-label">Multiple files input example</label>
            <input class="form-control" type="file" id="formFileMultiple" multiple>
        </div>
        -->
    </section>
    <!--사진업로드 박스 end-->
</main>
<br/><br/>

<script>
    function jbSubmit(){
        let address=document.querySelector("#basic-url").value;
        let uid=youtubeId(address);
        document.querySelector("#uAddress").value=uid;
        //alert(document.querySelector("#uAddress").value);
        //return false;
    }
    // 유튜브 아이디 추출
    function youtubeId(url) {
        var tag = "";
        if(url)  {
            var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
            var matchs = url.match(regExp);
            if (matchs) {
                //tag += "유튜브 아이디 : "+matchs[7];
                tag += matchs[7];
            }
            return tag;
        }
    }
    /*
        var s1 = "https://www.youtube.com/watch?v=Vrwyo1A8XNg";
        var s2 = "http://youtu.be/Vrwyo1A8XNg";
        document.write(youtubeId(s1));
        document.write("<br />");
        document.write(youtubeId(s2));
    */
    // utube Id extract
    function extractVideoID(url) {
        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
        var match = url.match(regExp);
        if (match && match[7].length == 11) {
            return match[7];
        } else {
            alert("Could not extract video ID.");
        }
    }
</script>
<script src="/js/upload.js" ></script>
<%@ include file="../layout/footer.jsp" %>