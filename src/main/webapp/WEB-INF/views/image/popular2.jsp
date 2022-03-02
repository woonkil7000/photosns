<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<input type="hidden" id="userId" value="${dto.user.id}" /> <%-- UserProfileDto returned --%>
<input type="hidden" id="principalId" value="${principal.user.id}" />
<input type="hidden" id="principalUsername" value="${principal.user.username}" />
<!--인기 게시글-->
<main class="popular">
	<div class="exploreContainer">
		<div><span style="font-size: 18px; color: Dodgerblue; padding-right: 20px;"><i class="fas fa-heart"></i> 좋아요 랭킹 </span></div>
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
	<div class="row row-cols-3" id="storyList"></div>
	<div class="col"></div>
</div>
<!-- 페이지 주인일때 end -->

<%-- @@@@@@@@@@@@@ 아이템들 end @@@@@@@@@@@@@@ --%>


<!-- 이미지 Modal -->
<div class="modal fade" id="image-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel" style="color: Dodgerblue;">미디어 확대</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>


			<div class="modal-body">
				<!--<img  data-bs-dismiss="modal" class="img-box" src=""
					  alt="" onerror="this.src='/images/noimage.jpg'"
					  id="lgimage" style="max-width: 380px;max-height: 520px;max-height: 100%; max-width: 100%;"  />-->
				<div class="img-box" alt="" id="lgimage" style="max-width:380px;max-height:420px;max-height:100%;max-width:100%;"></div>
				<form>
					<input type="hidden" id="image_id">
					<input type="hidden" id="image_url">
					<input type="hidden" id="user_id">
					<input type="hidden" id="contenttag">
					<hr>
					<label>미디어 설명: </label> <span id="caption" style="font-size: 16px; color: Dodgerblue;"></span>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 이미지 모달 end -->


<!-- 이미지 삭제 모달 이벤트 처리 -->
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
			//document.querySelector("#image_url").value="/upload/"+imageurl;
			//document.querySelector("#lgimage").src="/upload/"+imageurl;
			document.querySelector("#lgimage").innerHTML=contenttag; //이미지 삽입부분
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
	'playsinline': 0,
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

	<%-- 모달 닫힐때 영상 포즈 --%>
	// modal <div id='image-modal' ....> <iframe src='youtube address'> youtube player
	// modal <div id='image-modal' ....> <video src='......'> video player
	$('#image-modal').on('hidden.bs.modal', function () {
		$("#image-modal iframe").attr("src", $("#image-modal iframe").attr("src"));
		$("#image-modal video").attr("src", $("#image-modal video").attr("src"));
	});


	</script>
<script src="/js/popular2.js"></script>
<%@ include file="../layout/footer.jsp"%>

