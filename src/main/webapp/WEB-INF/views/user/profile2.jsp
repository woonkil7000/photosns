<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<input type="hidden" id="userId" value="${dto.user.id}" /> <%-- UserProfileDto returned --%>
<input type="hidden" id="principalId" value="${principal.user.id}" />
<input type="hidden" id="principalUsername" value="${principal.user.username}" />

<!-- 프로필 헤더 -->
<div class="container  overflow-hidden">
	<div class="pt-sm-5 pb-sm-0 pb-md-0 pt-md-5 align-text-bottom">
		<h4 class="cfs-2 pb-0 align-text-bottom px-2"><i class="fa fa-user"></i> 프로필 & My 미디어</h4>
	</div>

	<div class="row g-3 mb-1 text-center my-2 align-content-center" id="storyList">

		<div class="col-12 col-md-4">
			<p><h3><i class="fa fa-user"></i> ${dto.user.name}</h3>(${fn:substring(dto.user.username,0,15)})</p>
		</div>
		<div class="col-12 col-md-4">
			<div class="profile-img-wrap story-border" onclick="popup('.modal-image')">
			<form id="userProfileImageForm">
				<input type="file" name="profileImageFile" style="display: none;"
					   id="userProfileImageInput" />
			</form>
			<img style="max-width: 200px;max-height: 200px;" src="/upload/${dto.user.profileImageUrl}"
				 alt="" onerror="this.src='/images/noimage.png'"
				 id="userProfileImage" />
			<c:choose>
				<c:when test="${dto.pageOwnerState}">
					<p class="align-middle" style="font-size: 12px; color: Dodgerblue;"> 프로필 이미지 수정</p>
				</c:when>
			</c:choose>
		</div>
		</div>

		<div class="col-12 col-md-4">
			<c:choose>
			<c:when test="${dto.pageOwnerState}">
				<div><button class="btn btn-md btn-outline-dark" onclick="popup('.modal-info')"><span style="font-size: 16px; color: Dodgerblue;"><i class="fas fa-user-cog"></i>정보수정 / 로그아웃</span></button>
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

	</div>
	<!--전체 리스트 시작-->
</div>
<!---->

<%--프로필 섹션 ---%>
<section class="profile">
	<%--유저정보 컨테이너--%>
	<div class="profileContainer">
		<%--유저이미지--%>
		<div class="profile-left">

		</div>
		<%-- user name --%>
		<div   class="profile-right text-nowrap bd-highlight align-middle" style="color: Dodgerblue;">
			<p> </p><p> </p><p> </p>

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



		</div>
		<%-- <div class="profileContainer"> --%>
		<div class="profileContainer">
			<span><i class="far fa-images"></i> 등록 미디어: ${dto.imageCount}
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
<section id="tab-content"><%--게시물컨컨테이너--%>

	<div class="profileContainer"><%--그냥 감싸는 div (지우면이미지커짐)--%>
		<div id="tab-1-content" class="tab-content-item show">


<%-- 프로필 페이지 주인에게만 이미지 삭제 가능 알림 --%>
			<c:choose>
				<c:when test="${dto.pageOwnerState}">
					<%--<button class="cta" onclick="location.href='/image/upload'">포토앨범<i class="far fa-image"></i><i class="fas fa-cloud-upload-alt"></i></button>--%>
					<div class="alert alert-warning" role="alert">
						<div style="font-size: 12px;">미디어를 선택하면 설명(caption)을 수정하거나 파일을 삭제할 수 있습니다</div>
					</div>
				</c:when>
			</c:choose>
<%-- 이미지 삭제 가능 알림 end --%>

	<div class="alert alert-warning" role="alert">
		<div style="font-size: 12px;">유튜브는 영상의 바깥 하단부를 클릭해야 개별창을 열 수 있습니다</div>
	</div>

<%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  게시물 그리드  영역 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>

			<%--게시물 그리드배열--%>
			<div class="tab-1-content-inner">

			</div> <%-- class="tab-1-content-inner" --%>
	<%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  게시물 그리드  영역 END  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>
		</div> <%--그냥 감싸는 div (지우면이미지커짐)--%>
	</div> <%-- tab-1-content 게시물 컨테이너 --%>
</section>


				<%-- @@@@@@@@@@@@@@ 아이템들 @@@@@@@@@@@@@@ --%>

<!-- 페이지 주인일 때 -->
<%-- 앵커에 연결되는 모달 페이지 기능 [버튼] 노출 여부만 다름 !! --%>
<div class="container">
	<div class="row row-cols-3" id="storyList"></div>
</div>
<!-- 페이지 주인일때 end -->

				<%-- @@@@@@@@@@@@@ 아이템들 end @@@@@@@@@@@@@@ --%>



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
		<p>미디어를 삭제하시겠습니까?</p>
		<button onclick="deleteImage(${image.id},${principal.user.id})">선택한 미디어 삭제</button>
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
<div class="modal fade" id="image-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">상세 페이지</h5>
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
						<button type="button" class="btn btn-primary" id="update-btn">미디어 설명 수정</button>
					</div>
					<div>
						<button type="button" class="btn btn-danger d-grid gap-2 d-md-flex justify-content-md-end" id="delete-btn">미디어 삭제</button>
					</div>
						</c:when>
						<c:otherwise>
							<div style="display: none">
								<button type="button" class="btn btn-primary" id="update-btn" disabled>미디어 설명 수정</button>
							</div>
							<div style="display: none" >
								<button type="button" class="btn btn-danger d-grid gap-2 d-md-flex justify-content-md-end" id="delete-btn" disabled>미디어 삭제</button>
							</div>
						</c:otherwise>
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
	const delete_modal = document.querySelector('#image-modal'); // 모달 id
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

	<%-- 모달 닫힐때 영상 포즈 --%>
	// modal <div id='image-modal' ....> <iframe src='youtube address'> youtube player
	// modal <div id='image-modal' ....> <video src='......'> video player
	$('#image-modal').on('hidden.bs.modal', function () {
		$("#image-modal iframe").attr("src", $("#image-modal iframe").attr("src"));
		$("#image-modal video").attr("src", $("#image-modal video").attr("src"));
	});
	// when <video>
	/*$(function(){
		$('#image-modal').modal({
			show: false
		}).on('hidden.bs.modal', function(){
			$(this).find('video')[0].pause();
		});
	});*/


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