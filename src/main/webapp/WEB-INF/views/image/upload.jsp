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
        <ul class="nav nav-pills" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">사진/영상 파일</button>
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
                <%--<div class="upload-top mb-0 mt-0">
                    <span style="font-size: 22px; color: Dodgerblue;">사진/영상 파일 올리기</span>
                </div>--%>
                <button  type="button" class="btn btn-outline-primary btn-md py-1 my-1">사진/영상 파일 올리기</button>
                <!--사진업로드 Form-->
                <form  accept-charset="utf-8" class="upload-form py-1 my-1" method="POST" enctype="multipart/form-data" action="/image">
                    <div class="input-group">
                        <input class="form-control py-1 my-1" type="file" name="file" id="fileId" onchange="imageChoose(this)"/>
                    </div>
                    <div class="input-group py-0 my-0">
                        <img style="max-height: 100px;max-width: 150px;padding: 0px;border: 0px;" src="/images/noimage.jpg" alt="uplaod file" id="imageUploadPreview" />
                        <div class="col-lg-1 px-1"><span id="file_num"></span><br><span id="file_type"></span><br><span id="file_size"></span></div>
                    </div>
                    <!--사진설명 + 업로드버튼-->
                    <div class="mb-4">
                        <label class="form-label my-0 py-0" for="txtTitle">제목 입력(선택사항)</label>
                        <textarea class="form-control"  id="txtTitle" name="caption" rows="2"></textarea>
                        <label class="form-label my-0 py-0" for="inputTags">#태그(선택사항)</label>
                        <input class="form-control" type="text" id="inputTags" name="tags">
                    </div>
                    <%--<div class="alert alert-primary btn-sm my-1 py-0" role="alert">
                        <p><b>아래 [전송 시작] 버튼을 눌러주세요</b></p>
                        <b>전송이 완료되면 [화면 자동 전환]됩니다</b>
                        <p>용량이 큰 파일은 잠시 기다려주세요</p>
                    </div>--%>
                    <div class="output" id="idOutput" style="display: none"></div><!-- file path and extensions -->
                    <div class="btn btn-warning btn-sm" id="idCaution" style="display: none"></div><!-- warning only images comment -->
                    <div class="btn btn-warning btn-sm" id="idCaution2" style="display: none"></div><!-- warning oersize file comment -->
                    <div class="badge text-primary fs-6 fw-light text-wrap pb-1 mb-1" style="width: 18rem;" id="idComment">
                        <p>아래 [전송 시작] 버튼을 눌러주세요</p>
                        <p>전송이 완료되면 [화면 자동 전환]됩니다</p>
                        <p>용량이 큰 파일은 잠시 기다려주세요</p>
                    </div>
                        <button class="btn btn-primary btn-lg" id="btnSubmit">파일 전송 시작</button>

                    <!--사진설명end-->
                </form>
                <!--사진업로드 Form-->

                <!-- 파일 업로드 end -->
            </div>
            <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                <!-- 유튜브 주소 붙여넣기 -->
<%--
                <div class="upload-top mb-2 pb-2">
                    <span style="font-size: 22px; color: Dodgerblue;"> YouTube 공유 링크 올리기</span>
                </div>
--%>
                <button  type="button" class="btn btn-outline-primary btn-md py-1 my-1">YouTube 공유 링크 올리기</button>
                <!-- 유튜브 업로드 Form-->
                <form accept-charset="utf-8" class="upload-form py-1 my-1" method="POST" action="/youtube" onsubmit="jbSubmit();">
                    <div class="input-group">
                        <span class="input-group-text" id="basic-addon3">공유 링크:</span>
                        <input type="hidden" name="uAddress" id="uAddress" value="">
                        <input type="text" name="iAddress" class="form-control" id="basic-url" aria-describedby="basic-addon3" placeholder="...여기에 붙여넣기">
                    </div>
                    <!--유튜브 설명 + 업로드버튼-->
                    <div class="alert alert-primary mt-2 pt-2" role="alert">
                        <span style="font-size: 16px; color: Dodgerblue;">YouTube [공유] 링크를 복사한 후 붙여넣기 하세요</span>
                    </div>
                    <div class="mb-4">
                        <label for="txtTitle2">제목 입력(선택사항)</label>
                        <textarea class="form-control py-0 my-0" name="caption" id="txtTitle2" rows="3"></textarea>
                        <label for="inputText2">#태그(선택사항)</label>
                        <input class="form-control" type="text" name="tags" id="inputText2">
                    </div>
                        <button class="btn btn-primary btn-lg" id="btnSubmit2">YouTube 공유 링크 전송</button>
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

<script language="JavaScript" src="/js/upload.js" charset='UTF-8'></script>
<%@ include file="../layout/footer.jsp" %>