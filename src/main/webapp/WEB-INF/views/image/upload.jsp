<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
    <!--사진 업로드페이지 중앙배치-->
        <main class="uploadContainer">
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
                    <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">파일 전송</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">유튜브 영상 공유</button>
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
                        <div class="upload-top"><button type="button" class="btn btn-outline-primary" disabled data-bs-toggle="button" autocomplete="off">
                            <span style="font-size: 18px; color: Dodgerblue;"><i class="fas fa-file-upload"></i></span>
                            <span style="font-size: 14px; color: Dodgerblue;"> 사진/영상 파일 업로드</span></button>
                        </div>
                        <!--사진업로드 Form-->
                        <form class="upload-form" method="POST" enctype="multipart/form-data" action="/image">
                            <input type="file" name="file"  onchange="imageChoose(this)"/>
                            <div class="upload-img">
                                <img src="/images/noimage.jpg" alt="" id="imageUploadPreview" />
                            </div>
                            <!--사진설명 + 업로드버튼-->
                            <div class="alert alert-primary" role="alert"><b>전송 완료시 [화면이 전환]됩니다.</b> 용량이 큰 파일은 [화면이 전환]될 때 까지 잠시 기다려주세요</div>
                            <div class="upload-form-detail form-floating">
                                <!--<input type="text" placeholder="사진설명" name="caption">-->
                                <!--<div class="form-floating">-->
                                <textarea class="form-control"  placeholder="사진/영상 설명" name="caption" id="floatingTextarea"></textarea>
                                <label for="floatingTextarea">사진 제목 입력(선택사항)</label>
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

                        <div class="upload-top mb-3"><button type="button" class="btn btn-outline-primary" disabled data-bs-toggle="button" autocomplete="off">
                            <span style="font-size: 18px; color: Dodgerblue;"><i class="fas fa-file-upload"></i></span>
                            <span style="font-size: 14px; color: Dodgerblue;"> 유튜브 주소 붙여넣기</span></button>
                        </div>
                        <!-- 유튜브 업로드 Form-->
                        <form class="upload-form" method="POST" action="/youtube">
                            <div class="input-group mb-3">
                                <span class="input-group-text" id="basic-addon3">주소:</span>
                                <input type="text" name="uAddress" class="form-control" id="basic-url" aria-describedby="basic-addon3" placeholder="youtube 주소를 여기에...">
                            </div>
                            <!--유튜브 설명 + 업로드버튼-->
                            <div class="alert alert-primary" role="alert">
                                <span style="font-size: 18px; color: Dodgerblue;">https://youtu.be/abcdefg 이렇게 생긴 공유용 주소를 붙여넣으시면 안됩니다.</span>
                                <span style="font-size: 18px; color: Dodgerblue;">유튜브 퍼가기에 들어가면 나오는 코드에 있는 https://www.youtube.com/embed/abcdefg 이런식의 주소를 붙여넣어야해요.</span></div>
                            <div class="upload-form-detail form-floating">
                                <!--<input type="text" placeholder="사진설명" name="caption">-->
                                <!--<div class="form-floating">-->
                                <textarea class="form-control"  placeholder="사진/영상 설명" name="caption" id="floatingTextarea2"></textarea>
                                <label for="floatingTextarea">유튜브 제목 입력(선택사항)</label>
                                <input class="form-control" type="text" placeholder="#해시 태그 입력(선택사항)" name="tags">
                                <button class="btn btn-primary btn-lg">유튜브 주소 전송</button>
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
	
	<script src="/js/upload.js" ></script>
    <%@ include file="../layout/footer.jsp" %>