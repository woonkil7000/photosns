<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<input type="hidden" id="userId" value="${dto.user.id}" /> <%-- UserProfileDto returned --%>
<input type="hidden" id="principalId" value="${principal.user.id}" />
<input type="hidden" id="principalUsername" value="${principal.user.username}" />

<input type="hidden" id="ip" value="" />
<input type="hidden" id="pageUrl" value="" />
<input type="hidden" id="pageOwnerState" value="${dto.pageOwnerState}" />

<!--	<section> -->
<div class="container  overflow-hidden">
		<div class="pt-sm-5 pb-sm-0 pb-md-0 pt-md-5 align-text-bottom">
			<h4 class="cfs-2 pb-0 align-text-bottom px-2"><i class="fas fa-images"></i> 전체 미디어</h4>
		</div>
		<div class="row g-3 mb-1 text-center my-2 align-content-center" id="storyList">
			<!-- item start -->
			<!-- item end -->
		</div>

		<!--전체 리스트 시작-->
</div>

<%-- 이미지 수정 삭제 Modal start --%>
<div class="modal fade" id="image-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">상세 페이지</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body m-0 p-0">
				<%--<img  class="img-box" src="" alt="" onerror="this.src='/images/noimage.jpg'" id="delimage" style="max-width:250px;height:300px;max-height: 100%; max-width: 100%;"/>--%>
				<div class="img-box text-center" alt="컨텐츠" id="lgimage" style="max-height:100%;max-width:100%;"></div>
			</div>
			<div class="modal-second">
				<form>
					<input type="hidden" id="image_id">
					<input type="hidden" id="image_url">
					<input type="hidden" id="user_id">
					<input type="hidden" id="contenttag">
					<input type="hidden" id="principalid">
					<%--<hr>--%>
					<%--<label>사진 설명</label><input type="text" id="caption" size="45">--%>
					<label class="form-control" for="id_textcaption">제목</label>
					<textarea class="form-control" name="caption" id="id_textcaption"></textarea>
				</form>
			</div>
			<%-- 컨텐츠의 주인에게만 이미지 삭제 버튼 보임 --%>
			<div class="modal-footer text-center" id="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫 기</button>
				<button type="button" class="btn btn-primary" id="update-btn" style="display: none">제목 수정</button>
				<button type="button" class="btn btn-danger" id="delete-btn" style="display: none">미디어 삭제</button>
			</div><!-- modal footer -end-  -->
		</div>
	</div>
</div>
<%-- 이미지 수정 삭제 Modal END --%>

<%-- 이미지 수정, 삭제 모달 이벤트 처리 --%>
<script>
	{	// 모달 요소 선택
		//let delete_modal = document.getElementById('#delete-modal'); // 모달 id
		const delete_modal = document.querySelector('#image-modal'); // 모달 id
		// 모달 이벤트 감지
		delete_modal.addEventListener('show.bs.modal', function (event) {
			// 트리거 버트 선택
			const button = event.relatedTarget;
			// 전달할 데이타 가져오기
			const imageid = button.getAttribute("data-bs-imageid");
			const imageurl = button.getAttribute("data-bs-imageurl");
			const userid = button.getAttribute("data-bs-userid");
			const caption = button.getAttribute(`data-bs-caption`);
			const contenttag = button.getAttribute("data-bs-contenttag");
			const principalid = button.getAttribute("data-bs-principalid");
			//const btntag = button.getAttribute("data-bs-btntag");
			console.log("imageid=",imageid);
			console.log("imageurl=",imageurl);
			console.log("userid=",userid);
			console.log("caption=",caption);
			console.log("contenttag=",contenttag);
			//console.log("btntag=",btntag);
			console.log("principalid=",principalid);

			// 모달창에 데이타 반영
			//console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ caption='"+replaceBrTag(caption)+"'");
			document.querySelector("#image_id").value=imageid;
			//document.querySelector("#caption").innerHTML=replaceBrTag(caption); // innerHTML
			//document.querySelector("#caption").innerHTML=caption; // innerHTML
			document.querySelector("#id_textcaption").innerHTML=caption; // innerHTML
			document.querySelector("#user_id").value=userid;
			document.querySelector("#image_url").value="/upload/"+imageurl;
			//document.querySelector("#delimage").src="/upload/"+imageurl;
			document.querySelector("#lgimage").innerHTML=contenttag; // 이미지 삽입부분  innerHTML
			document.querySelector("#contenttag").value=contenttag;
			//document.querySelector("#modal-footer").innerHTML=btntag; // 모달 풋터 수정, 삭제 버튼 innerHTML
			document.querySelector("#principalid").value=principalid;

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

			// 삭제할 이미지 객채 생성
			const image = {
				id: document.querySelector("#image_id").value,
				caption: document.querySelector("#id_textcaption").value,
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

			// 수정할 이미지 객채 생성
			const image = {
				id: document.querySelector("#image_id").value,
				caption: document.querySelector("#id_textcaption").value,
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


	function myCheck(test) {
		let result;
		let text = "\n\n 정말 \""+test+"\" 를 실행하시겠습니까?\n\n 확인 또는 취소를 눌러주세요!\n\n";
		if (confirm(text) == true) {
			//text = "You pressed OK!";
			result = true;
		} else {
			//text = "You canceled!";
			result=false;
		}
		//document.getElementById("demo").innerHTML = text;
		return result;
	}

	//myCheck();
	<%-- 모달 닫힐때 영상 포즈 --%>
	// modal <div id='image-modal' ....> <iframe src='youtube address'> youtube player
	// modal <div id='image-modal' ....> <video src='......'> video player
	$('#image-modal').on('hidden.bs.modal', function () {
		$("#image-modal iframe").attr("src", $("#image-modal iframe").attr("src"));
		$("#image-modal video").attr("src", $("#image-modal video").attr("src"));
	});

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

	{ // Device Type
		const detectDeviceType = () =>
				/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
						navigator.userAgent
				)
						? "모바일"
						: "데스크톱";
		console.log("*********************************** ",detectDeviceType());
	}

	{ // IP
		$.getJSON('https://api.ipify.org?format=jsonp&callback=?', function (data) {
			//console.log("*********************************** ipify=",JSON.stringify(data, null, 2));
		});
	}
	{ // IP
		let apiKey = '25864308b6a77fd90f8bf04b3021a48c1f2fb302a676dd3809054bc1b07f5b42';
		$.getJSON('https://api.ipinfodb.com/v3/ip-city/?format=json&key=' + apiKey, function(data) {
			//console.log("*************************************** ipinfodb=",JSON.stringify(data, null, 2));
		});
	}


	{
	/* 모달 창 열릴 때 이벤트 function hideEditButton(){*/
		var myModal = document.getElementById('image-modal')
		myModal.addEventListener('show.bs.modal', function (event) {
			console.log("@@@@@@@@@@@@@@@@@@@@@@@ myModal @@@@@@@@@@@@@@@@@@@@@@@");
			//document.querySelector(".btn").style.display="none";
			let user_id = document.querySelector("#user_id").value;
			let principalid = document.querySelector("#principalid").value;
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ user_id="+user_id+",principalid ="+principalid);

			if (user_id == principalid){ // 컨텐츠 주인이 아니면 수정,삭제 버튼 숨김
				document.querySelector("#update-btn").style.display="block";
				document.querySelector("#delete-btn").style.display="block";
			}else{
				document.querySelector("#update-btn").style.display="none";
				document.querySelector("#delete-btn").style.display="none";
			}
		})
	/*}*/
	}

{
	// 모달 창 show 될 때 이벤트 실행
	//let delete_modal = document.getElementById('#delete-modal'); // 모달 id
	const delete_modal = document.querySelector('#image-modal'); // 모달 id
	// 모달 이벤트 감지
	delete_modal.addEventListener('show.bs.modal', function (event) {
		const str=$("#id_textcaption").html();
		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ $('#id_textcaption').html() str="+str);
		const str2 = str.toString().replace("&lt;br;&gt;","\n",);
		const str3 = str2.toString().replace("<br>","\n",);
		//const str2 = br2nl(str,true);
		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@ str2.toString().replace str3="+str3);
		//document.querySelector("#id_textcaption").innerHTML="test!!";
		document.querySelector("#id_textcaption").innerHTML=str3;
	});
}

	// nl2br
	/**
	 * This function is same as PHP's nl2br() with default parameters.
	 *
	 * @param {string} str Input text
	 * @param {boolean} replaceMode Use replace instead of insert
	 * @param {boolean} isXhtml Use XHTML
	 * @return {string} Filtered text
	 */
	function nl2br (str, replaceMode, isXhtml) {
		var breakTag = (isXhtml) ? '<br />' : '<br>';
		var replaceStr = (replaceMode) ? '$1'+ breakTag : '$1'+ breakTag +'$2';
		return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, replaceStr);
	}
	// br2nl
	/**
	 * This function inverses text from PHP's nl2br() with default parameters.
	 *
	 * @param {string} str Input text
	 * @param {boolean} replaceMode Use replace instead of insert
	 * @return {string} Filtered text
	 */
	function br2nl (str, replaceMode) {
		var replaceStr = (replaceMode) ? "\n" : '';
		// Includes <br>, <BR>, <br />, </br>
		return str.toString().replace(/<\s*\/?br\s*[\/]?>/gi, replaceStr);
	}

</script>
<script src="/js/storyall2.js"></script>
</body>
</html>
