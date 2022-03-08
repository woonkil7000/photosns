<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<!--인기 게시글-->
<main class="popular">
	<div class="exploreContainer">
		<div><span style="font-size: 18px; color: Dodgerblue; padding-right: 20px;"><i class="fas fa-heart"></i> 좋아요 랭킹20</span></div>
		<p></p>
		<div class="alert alert-warning" role="alert">
			<div  style="font-size: 12px;">유튜브의 경우 테두리 부분을 클릭해야 개별창을 열 수 있습니다.</div>
		</div>
		<!--인기게시글 갤러리(GRID배치)-->
		<div class="popular-gallery">
			<c:forEach var="image" items="${images}">
				<div class="p-img-box" style="padding-top: 30px;">
					<div>
						<!-- 이미지 링크 -->
						<!-- ####################### 이미지 모달 링크 ###################### -->




							<%-- ///////////////////// String contentTag: 삽입할 미디어 테그 결정 <img  or  <video  /////////////////////--%>
						<c:set var="contentType" value="${image.contentType.substring(0,5)}"/>
						<c:set var="pathUrl" value="/upload/${image.postImageUrl}"/>
						<c:set var="contentTag" value=""/>
							<%--
                            <c:out value=" #### init contentType=${contentType} ####"></c:out>
                            <c:out value=" #### init pathUrl=${pathUrl} ####"></c:out>
                            <c:out value=" #### init contentTag=${contentTag} ####"></c:out>
                            --%>
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
								<%--<img  src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지1' />--%>
								<%--<c:out value="${contentTag}"></c:out>--%>
							</c:when>
							<c:when test="${contentType=='video'}">
								<c:set var="contentTag" value="<video playsinline preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
								<c:set var="contentTag2" value="<video playsinline controls preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
								<!--<video controls muted autoplay src='${pathUrl}' style='max-height:100%;max-width:100%' alt='동영상2' />-->
								<%--<c:out value="${contentTag}"></c:out>--%>
							</c:when>
							<c:when test="${contentType=='youtu'}">
								<c:set var="contentTag" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='1' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
								<c:set var="contentTag2" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='1' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
							</c:when>
							<c:otherwise>
								<c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
								<c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
								<!--<img  src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지3' />-->
								<%--<c:out value="${contentTag}"></c:out>--%>
								<%-- //////////// contentTag:페이지용, contentTag2: 모달페이지용으로 video 속성 controls 추가됨/ img 는 테그 같음. ////////////// --%>
							</c:otherwise>
						</c:choose><%-- /////////////////////  String contentTag: 삽입할 미디어 테그 결정 <img or <video  -END-  /////////////////////--%>

						<!-- ####################### 이미지 링크 ###################### -->
						<a   class="btn btn-outline-primary btn-sm"
							 data-bs-toggle="modal"
							 data-bs-target="#image-modal"
							 data-bs-imageid="${image.id}"
							 data-bs-imageurl="${image.postImageUrl}"
							 data-bs-userid="${principal.user.id}"
							 data-bs-caption="${image.caption}"
							 data-bs-contentTag="${contentTag2}"
							 href="#"
							 role="button" style="outline: none;border: 0;">
								${contentTag}

							<!-- //////////// contentTag2 는 video 속성 controls 추가됨 ////////////// -->
						</a>

						<!-- ####################### 이미지 링크 ###################### -->



						<!-- ####################### 이미지 모달 링크 end ###################### -->
						<!-- 이미지 링크 end -->
					</div>
					<div><p style="font-size: 16px; color: Dodgerblue; padding-right: 16px;">${image.id}:${fn:substring(image.user.name,0,5)} <i class="fas fa-heart"></i> ${image.likeCount}</p>
					</div>
					<div><p style="font-size: 16px; color: Dodgerblue; padding-right: 16px;">${fn:substring(image.caption,0,7)}</p>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>
</main>


<!-- 이미지 Modal -->
<div class="modal fade" id="image-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel" style="color: Dodgerblue;">이미지 확대</h5>
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
					<label>사진 설명: </label> <span id="caption" style="font-size: 16px; color: Dodgerblue;"></span>
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
<%@ include file="../layout/footer.jsp"%>

