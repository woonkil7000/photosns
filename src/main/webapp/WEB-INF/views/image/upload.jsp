<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
    <!--사진 업로드페이지 중앙배치-->
        <main class="uploadContainer">
           <!--사진업로드 박스-->
            <section class="upload">
               <!--사진업로드 로고-->
                <div class="upload-top">
                    <a href="home.html" class="">
                        <img src="/images/logo2.png"  width="50" height="50" alt="">
                    </a>
                    <p>사진 업로드</p>
                </div>
                <!--사진업로드 로고 end-->
                <!--사진업로드 Form-->
                <form class="upload-form" method="POST" enctype="multipart/form-data" action="/image">
                    <input type="file" name="file"  onchange="imageChoose(this)"/>
                    <div class="upload-img">
                        <img src="/images/noimage.jpg" alt="" id="imageUploadPreview" />
                    </div>
                    <!--사진설명 + 업로드버튼-->
                    <div class="alert alert-danger" role="alert">파일 업로드가 완료되면 화면이 자동전환됩니다.용량이 큰 파일은 잠시 기다려주세요.</div>
                    <div class="upload-form-detail form-floating">
                   		 <!--<input type="text" placeholder="사진설명" name="caption">-->
                        <!--<div class="form-floating">-->
                        <textarea class="form-control"  placeholder="사진/영상 제목" name="caption" id="floatingTextarea"></textarea>
                        <label for="floatingTextarea">사진/영상 제목</label>
                        <input class="form-control" type="text" placeholder="#태그" name="tags">
                        <button class="cta blue btn btn-primary btn-lg">파일 업로드</button>
                    </div>
                    <!--사진설명end-->
                </form>
                <!--사진업로드 Form-->
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
	
	<script src="/js/upload.js" ></script>
    <%@ include file="../layout/footer.jsp" %>