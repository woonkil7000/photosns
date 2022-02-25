<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<input type="hidden" id="userId" value="${dto.user.id}" /> <%-- UserProfileDto returned --%>

<%--프로필 섹션 ---%>
<section class="profile">
	<%--유저정보 컨테이너--%>
	<div class="profileContainer">
		<%--유저이미지--%>
		<div class="profile-left">
			<div class="profile-img-wrap story-border" onclick="popup('.modal-image')">
				<form id="userProfileImageForm">
					<input type="file" name="profileImageFile" style="display: none;"
						   id="userProfileImageInput" />
				</form>
				<img class="profile-image" src="/upload/${dto.user.profileImageUrl}"
					 alt="" onerror="this.src='/images/noimage.png'"
					 id="userProfileImage" />
				<c:choose>
					<c:when test="${dto.pageOwnerState}">
						<p class="align-middle" style="font-size: 12px; color: Dodgerblue;"> 프로필 이미지 수정</p>
					</c:when>
				</c:choose>
			</div>
		</div>
		<%-- user name --%>
		<div   class="profile-right text-nowrap bd-highlight align-middle" style="color: Dodgerblue;">
			<p> </p><p> </p><p> </p>
			<p><h2><i class="fa fa-user"></i> ${dto.user.name}</h2>(${fn:substring(dto.user.username,0,15)})</p>
		</div>
		<%--유저이미지end--%>
	</div>
</section>

<%--프로필 섹션 end--%>
<section  class="profile">
	<div class="profileContainer">
	<%--유저정보 및 사진등록 구독하기--%>
	<div class="profile-right">
		<div class="name-group">

			<c:choose>
				<c:when test="${dto.pageOwnerState}">
					<div><button class="modi" onclick="popup('.modal-info')"><span style="font-size: 16px; color: Dodgerblue;"><i class="fas fa-user-cog"></i>정보수정 / 로그아웃</span></button>
					</div>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${dto.subscribeState}">
								<button class="cta blue" onclick="toggleSubscribe(${dto.user.id},this)">구독취소</button>
						</c:when>
						<c:otherwise>
							<button class="cta" onclick="toggleSubscribe(${dto.user.id},this)">구독하기</button>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>

		</div>
		<%-- <div class="profileContainer"> --%>
		<div class="profileContainer">
			<span><i class="far fa-images"></i> 등록 사진수: ${dto.imageCount}
			<a href="javascript:subscribeInfoModalOpen(${dto.user.id});" ><i class="fas fa-users"></i> 구독 정보: ${dto.subscribeCount} </span></a>
		</div>
		<%--
		<div class="state">
			<ul>
				<li><i class="fas fa-info-circle"></i><span>info${dto.user.bio}</span></li>
				<li><i class="fas fa-home"></i><span>home${dto.user.website}</span></li>
			</ul>
		</div>
		--%>
	</div>
	<%--유저정보 및 사진등록 구독하기--%>
	</div>
</section>

<%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 이하 게시물 리스트 섹션 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>

<%--게시물컨섹션--%>
<section id="tab-content">
	<%--게시물컨컨테이너--%>
	<div class="profileContainer">
		<%--그냥 감싸는 div (지우면이미지커짐)--%>
		<div id="tab-1-content" class="tab-content-item show">

<%-- 프로필 페이지 주인에게만 이미지 삭제 가능 알림 --%>
			<c:choose>
				<c:when test="${dto.pageOwnerState}">
					<%--<button class="cta" onclick="location.href='/image/upload'">포토앨범<i class="far fa-image"></i><i class="fas fa-cloud-upload-alt"></i></button>--%>
					<div class="alert alert-warning" role="alert">
						<div style="font-size: 12px;">이미지를 선택하면 설명(caption)을 수정하거나 파일을 삭제할 수 있습니다</div>
						<div style="font-size: 12px;">(*유튜브는 테두리 부분 클릭)</div>
					</div>
				</c:when>
			</c:choose>
<%-- 이미지 삭제 가능 알림 end --%>



<%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  게시물 그리드  영역 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>

			<%--게시물 그리드배열--%>
			<div class="tab-1-content-inner">

				<%--아이템들--%>
                <%--  JSTL 문법  --%>
										<%--------------------------- 이미지 리스트 루프 ------------------------------------------%>
				<c:forEach var="image" items="${dto.user.images}">  <%-- EL 표현식에서 변수명을 적으면 get함수가 자동으로 호출됨. --%>

					<%-- profileImageUpload(${dto.user.id},${principal.user.id}) --%>
					<%--<div class="img-box" onclick="deleteImage(${image.id},${principal.user.id})">--%>
					<div class="img-box" id="${image.id}">
						<div  class="img">
							<c:choose>
								<%-- 프로필 페이지의 주인일 때 --%>
								<c:when test="${dto.pageOwnerState}">

										<%-- ///////////////////// String contentTag: 삽입할 미디어 테그 결정 <img  or  <video  /////////////////////--%>
										<c:set var="contentType" value="${image.contentType.substring(0,5)}"/>
										<c:set var="pathUrl" value="/upload/${image.postImageUrl}"/>
									<c:choose>
										<c:when test="${contentType eq 'youtu'}">
											<c:set var="pathUrl" value="${image.postImageUrl}"/>
										</c:when>
									</c:choose>
										<c:set var="contentTag" value=""/>
										<c:set var="contentTag2" value=""/>
									<c:choose>
										<c:when test="${contentType=='image'}">
												<c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
												<c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
										</c:when>
										<c:when test="${contentType=='video'}">
												<c:set var="contentTag" value="<video preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
												<c:set var="contentTag2" value="<video playinline controls loop preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
										</c:when>
										<c:when test="${contentType=='youtu'}">
												<c:set var="contentTag" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='0' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
												<c:set var="contentTag2" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='0' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
										</c:when>
										<c:otherwise>
												<c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
												<c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
										</c:otherwise>
									</c:choose>

									<%-- /////////////////////  String contentTag: 삽입할 미디어 테그 결정 img or video  -END-  /////////////////////--%>

											<%-- ####################### 이미지 링크 ###################### --%>

											<a   class="btn btn-outline-primary btn-sm"
											data-bs-toggle="modal"
											data-bs-target="#delete-modal"
											data-bs-imageid="${image.id}"
											data-bs-imageurl="${image.postImageUrl}"
											data-bs-userid="${principal.user.id}"
											data-bs-caption="${image.caption}"
											data-bs-contentTag="${contentTag2}"
											href="#"
											role="button" style="outline: none;border: 0;">
												${contentTag}

										<%--//////////// contentTag2 는 video 속성 controls 추가됨 //////////////--%>
									</a>

									<%-- ####################### 이미지 링크 ###################### --%>

								</c:when>

								<%-- 프로필 페이지 주인일 때 pageOwnerState -END- --%>

<%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  페이지 주인일때 아닐때 구분  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>

<%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  페이지 주인일때 아닐때 구분  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>

								<%-- 페이지 주인이 아닐때 start --%>
								<c:otherwise>
									<%-- ####################### 페이지 주인이 아닐때 링크 테그 start ###################### --%>
									<%-- ///////////////////// String contentTag: 삽입할 미디어 테그 결정 <img  or  <video  ///////////////////// --%>
									<c:set var="contentType" value="${image.contentType.substring(0,5)}"/>
									<c:set var="pathUrl" value="/upload/${image.postImageUrl}"/>
									<c:choose>
										<c:when test="${contentType eq 'youtu'}"> <%-- substring => youtu --%>
										<c:set var="pathUrl" value="${image.postImageUrl}"/>
										</c:when>
									</c:choose>
									<c:set var="contentTag" value=""/>
									<c:set var="contentTag2" value=""/>
									<c:choose>
										<c:when test="${contentType=='image'}">
											<c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
											<c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
										</c:when>
										<c:when test="${contentType=='video'}">
											<c:set var="contentTag" value="<video preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
											<c:set var="contentTag2" value="<video playinline controls preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
										</c:when>
										<c:when test="${contentType=='youtu'}">
											<c:set var="contentTag" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='0' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
											<c:set var="contentTag2" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='0' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
										</c:when>
										<c:otherwise>
											<c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
											<c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
										</c:otherwise>
									</c:choose>

									<%-- /////////////////////  String contentTag: 삽입할 미디어 테그 결정 <img or <video  -END-  /////////////////////--%>

									<%-- ####################### 이미지 <a href=""> 모달창 링크 ###################### --%>

									  <a class="btn btn-outline-primary btn-sm"
										 data-bs-toggle="modal"
										 data-bs-target="#delete-modal"
										 data-bs-imageid="${image.id}"
										 data-bs-imageurl="${image.postImageUrl}"
										 data-bs-userid="${principal.user.id}"
										 data-bs-caption="${image.caption}"
										 data-bs-contentTag="${contentTag2}"
										 href="#"
										 role="button" style="outline: none;border: 0;">
											${contentTag}

										<%-- //////////// contentTag:페이지용, contentTag2: 모달페이지용으로 video 속성 controls 추가됨/ img 는 테그 같음. /////////////--%>
									</a>

									<%-- ####################### 이미지 <a href=""> 모달창 링크 ###################### --%>



									<%-- ####################### 페이지 주인이 아닐때 링크 테그 END ###################### --%>

								</c:otherwise><%-- 페이지 주인이 아닐때 END --%>
							</c:choose>
							<%--  --%>
						</div>
						<div><span style="font-size: 16px; color: Dodgerblue;">${fn:substring(image.caption,0,7)}</span></div>
						<div>
							<span style="font-size: 16px; color: Dodgerblue; padding-right: 16px;"><i class="fas fa-heart"></i> ${image.likeCount}</span>
						</div>
					</div><%-- for each 바로 안쪽 테그. class="img-box"  --%>
				</c:forEach>
				<%--아이템들 end--%>

				<%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  게시물 그리드  영역 END  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>

			</div> <%-- class="tab-1-content-inner" --%>
		</div> <%--그냥 감싸는 div (지우면이미지커짐)--%>
	</div>
	<%-- 게시물 컨테이너 --%>
</section>



<%--로그아웃, 회원정보변경 모달--%>
<div class="modal-info" onclick="modalInfo()">
	<div class="modal1">
		<button onclick="location.href='/user/${principal.user.id}/update'">회원정보 수정</button>
		<button onclick="location.href='/logout'">로그아웃</button>
		<button onclick="closePopup('.modal-info')">취소</button>
	</div>
</div>
<%--로그아웃, 회원정보변경 모달 end--%>

<%--프로필사진 바꾸기 모달--%>
<div  class="modal-image" onclick="modalImage()">
	<div class="modal">
		<p>프로필 사진 바꾸기</p>
		<button onclick="profileImageUpload(${dto.user.id},${principal.user.id})">프로필 사진 등록/수정 업로드</button>
		<button onclick="closePopup('.modal-image')">취소</button>
	</div>
</div>
<%--프로필사진 바꾸기 모달end--%>

<%-- 프로필 페이지: 업로드 이미지 삭제 모달--%>
<div class="modal-imgdelete" style="display: none" onclick="modalDelete()">
	<div class="modal2">
		<p>이미지를 삭제하시겠습니까?</p>
		<button onclick="deleteImage(${image.id},${principal.user.id})">선택한 이미지 삭제</button>
		<button onclick="closePopup('.modal-imgdelete')">취소</button>
	</div>
</div>
<%-- 프로필 페이지: 업로드 이미지 삭제 모달 end--%>

<div class="modal-subscribe">
	<div class="subscribe">
		<div class="subscribe-header">
			<span>구독정보</span>
			<button onclick="modalClose()">
				<i class="fas fa-times"></i>
			</button>
		</div>
		<div class="subscribe-list" id="subscribeModalList"></div>
	</div>
</div>


<%-- Button trigger modal --%>
<%--
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
	Launch demo modal
</button>
<a  class="btn btn-outline-primary btn-sm" data-bs-toggle="delete-modal" data-bs-target="delete-modal" href="#" role="button">삭제</a>
--%>


<%-- 이미지 수정 삭제 Modal start --%>
<div class="modal fade" id="delete-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">이미지 상세 페이지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<%--<img  class="img-box" src="" alt="" onerror="this.src='/images/noimage.jpg'" id="delimage" style="max-width:250px;height:300px;max-height: 100%; max-width: 100%;"/>--%>
				<div class="img-box" alt="" id="lgimage" style="max-width:380px;max-height:420px;max-height:100%;max-width:100%;"></div>
				<form>
					<input type="hidden" id="image_id">
					<input type="hidden" id="image_url">
					<input type="hidden" id="user_id">
					<input type="hidden" id="contenttag">

					<hr>
					<%--<label>사진 설명</label><input type="text" id="caption" size="45">--%>
					<textarea class="form-control"  placeholder="사진/영상 제목" name="caption" id="caption"></textarea>
				</form>
			</div>
			<div class="modal-footer">
					<div>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫 기</button>
					</div>
					<%-- 프로필 페이지 주인에게만 이미지 삭제 버튼 보임 --%>
					<c:choose>
						<c:when test="${dto.pageOwnerState}">
					<div>
						<button type="button" class="btn btn-primary" id="update-btn">이미지 설명 수정</button>
					</div>
					<div>
						<button type="button" class="btn btn-danger d-grid gap-2 d-md-flex justify-content-md-end" id="delete-btn">이미지 삭제</button>
					</div>
						</c:when>
					</c:choose>
			</div>
		</div>
	</div>
</div>
<%-- 이미지 수정 삭제 Modal END --%>

<%-- 이미지 삭제 모달 이벤트 처리 --%>
<script>
	{	// 모달 요소 선택
	//const delete_modal = document.getElementById('#delete-modal'); // 모달 id
	const delete_modal = document.querySelector('#delete-modal'); // 모달 id
	// 모달 이벤트 감지
	delete_modal.addEventListener('show.bs.modal', function (event) {
		// 트리거 버트 선택
		const button = event.relatedTarget;
		// 전달할 데이타 가져오기
		const imageid = button.getAttribute("data-bs-imageid");
		const imageurl = button.getAttribute("data-bs-imageurl");
		const userid = button.getAttribute("data-bs-userid");
		const caption = button.getAttribute("data-bs-caption");
		const contenttag = button.getAttribute("data-bs-contenttag");
		console.log("imageid=",imageid);
		console.log("imageurl=",imageurl);
		console.log("userid=",userid);
		console.log("caption=",caption);
		console.log("contenttag=",contenttag);

		// 모달창에 데이타 반영
		document.querySelector("#image_id").value=imageid;
		document.querySelector("#caption").innerHTML=caption;
		document.querySelector("#user_id").value=userid;
		document.querySelector("#image_url").value="/upload/"+imageurl;
		//document.querySelector("#delimage").src="/upload/"+imageurl;
		document.querySelector("#lgimage").innerHTML=contenttag; // 이미지 삽입부분
		document.querySelector("#contenttag").value=contenttag;
		// If necessary, you could initiate an AJAX request here
		// and then do the updating in a callback.
		// Update the modal's content.
		//const modalTitle = delete_modal.querySelector('.modal-title')
		//const modalBodyInput = delete_modal.querySelector('.modal-body input')
		//modalTitle.textContent = 'New message to ' + recipient
		//modalBodyInput.value = recipient
	})
	}


	{
	// 삭제 완료 버튼
		const delete_button=document.querySelector("#delete-btn");
	// 클릭 이벤트 감지
		delete_button.addEventListener('click',function (event) {


				if(!myCheck("이미지 삭제")) {return;} // 취소 선택시 삭제 중단.

				// 삭제 이미지 객채 생성
				const image = {
					id: document.querySelector("#image_id").value,
					caption: document.querySelector("#caption").value,
					userid: document.querySelector("#user_id").value,
					url: document.querySelector("#image_url").value
				};
				console.log("image object =", image);

				// 삭제 REST API 호출 - fetch()
				const url = "/api/image/" + image.id + "/delete";
				console.log("fetch url=", url);

				// fetch(url,{})
				fetch(url, {
					method: "DELETE", // method = 삭제요청
					body: JSON.stringify(image), // 객체를 JSON 으로 전달
					headers: {
						"Content-Type": "application/json"
					}

					// }).then(function (response) {}) --%>> response => {}
				}).then(response => {
					// http 응답 코드에 따른 메시지 출력
					const msg = (response.ok) ? "이미지 삭제 완료~" : "이미지 삭제 실패!!";
					console.log(msg);
					//alert(msg);
					// 현재 페이지를 새로 고침
					window.location.reload();
				})
		});

	}

	{
		// Caption 수정 완료 버튼
		const update_button=document.querySelector("#update-btn");
		// 클릭 이벤트 감지
		update_button.addEventListener('click',function (event) {

			// 수정 이미지 객채 생성
			const image = {
				id: document.querySelector("#image_id").value,
				caption: document.querySelector("#caption").value,
				userid: document.querySelector("#user_id").value,
				url: document.querySelector("#image_url").value
			};
			console.log("image object =", image);

			// 삭제 REST API 호출 - fetch()
			const url="/api/image/"+image.id+"/update";
			console.log("fetch url=",url);

			// fetch(url,{})
			fetch(url,{
				method: "PATCH", // method = 수정 요청
				body: JSON.stringify(image), // 객체를 JSON 으로 전달
				headers: {
					"Content-Type": "application/json"
				}

				// }).then(function (response) {}) --%>> response => {}
			}).then(response => {
				// http 응답 코드에 따른 메시지 출력
				const msg = (response.ok) ? "이미지 update 완료~" : "이미지 update 실패!!";
				console.log(msg);
				//alert(msg);
				// 현재 페이지를 새로 고침
				window.location.reload();
			})

		});

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

	// for YouTube
	{
		<%-- 1. The <iframe> (and video player) will replace this <div> tag. --%>
		//<div id="player"></div>

		// 2. This code loads the IFrame Player API code asynchronously.
		var tag = document.createElement('script');
		tag.src = "https://www.youtube.com/iframe_api";
		var firstScriptTag = document.getElementsByTagName('script')[0];
		firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
		// 3. This function creates an <iframe> (and YouTube player)
		//    after the API code downloads.
		var player;
		function onYouTubeIframeAPIReady() {
			player = new YT.Player('player', {
				height: '280',
				width: '325',
				videoId: 'tgbNymZ7vqY',//tgbNymZ7vqY M7lc1UVf-VE
				playerVars: {
					'playsinline': 1,
					'volumn': 40,
					'controls': 1
				},
				events: {
					'onReady': onPlayerReady,
					'onStateChange': onPlayerStateChange
				}
			});
		}

		// 4. The API will call this function when the video player is ready.
		function onPlayerReady(event) {
			//event.target.playVideo();
		}

		// 5. The API calls this function when the player's state changes.
		//    The function indicates that when playing a video (state=1),
		//    the player should play for six seconds and then stop.
		var done = false;
		function onPlayerStateChange(event) {
			if (event.data == YT.PlayerState.PLAYING && !done) {
				//setTimeout(stopVideo, 10000);
				done = true;
			}
		}
		function stopVideo() {
			player.stopVideo();
		}
	}
</script>
<%-- --%>
<script src="/js/profile2.js"></script>
<%@ include file="../layout/footer.jsp"%>