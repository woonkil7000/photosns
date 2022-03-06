<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<input type="hidden" id="userId" value="${dto.user.id}" />
<input type="hidden" id="ip" value="" />
<input type="hidden" id="pageUrl" value="" />

	<section>
		<div class="pt-sm-4 pb-sm-0 pb-md-0 pt-md-4 align-text-bottom">
			<h4 class="cfs-2 pb-0 align-text-bottom"><i class="fas fa-images"></i> 전체 미디어</h4>
		</div>
		<div class="row g-3 mb-1 text-center my-2" id="storyList">
			<!-- item start -->
<%--			<div class="col-12 col-md-4">
				<div class="card">
					<div class="card-header"><!-- 카드헤더: 회원 프로필 이미지 | 이름 -->
					</div>
					<div class="card-body"><!-- 이미지 들어오는 부분 -->
					</div>
					<div class="card-title"><!-- item title -->
					</div>
					<div class="card-text"><!-- item like  -->
					</div>
					<div class="card-subtitle"><!-- item tags  -->
					</div>
					<div class="card-group"><!-- 댓글 list -->
						<div class="card-goup-item"></div> <!-- goup item list -->
					</div>
					<div class="card-footer"><!-- 댓글 입력부 -->
					</div>
				</div>
			</div>--%>
			<!-- item end -->

		</div>

		<!--전체 리스트 시작-->








			<!-- 이미지 Modal -->
			<div class="modal fade" id="image-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog  modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel" style="color: Dodgerblue;">이미지 확대</h5>
							<!-- ///////////// 모달 닫기 버튼  tag: data-bs-dismiss="modal"  /////////////-->
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>


						<div class="modal-body">
							<!--<img  data-bs-dismiss="modal" class="img-box" src="" alt="" onerror="this.src='/images/noimage.jpg'" id="lgimage" style="max-width: 380px;max-height: 520px;max-height: 100%; max-width: 100%;"  />-->
							<!--  ///////////// 이미지/영상 삽입되는 div  /////////////  -->
							<div class="img-box" data-bs-dismiss="modal" alt="" id="lgimage" style="max-width:380px;max-height:420px;max-height:100%;max-width:100%;"></div>
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

	</section>

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
			//console.log("imageid=",imageid);
			//console.log("imageurl=",imageurl);
			//console.log("userid=",userid);
			//console.log("caption=",caption);
			//console.log("contenttag=",contenttag);

			// 모달창에 데이타 반영
			document.querySelector("#image_id").value=imageid;
			document.querySelector("#caption").innerHTML=caption;
			document.querySelector("#user_id").value=userid;
			document.querySelector("#image_url").value="/upload/"+imageurl;
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

	<%-- 모달 닫힐때 영상 포즈 --%>
	// modal <div id='image-modal' ....> <iframe src='youtube address'> youtube player
	// modal <div id='image-modal' ....> <video src='......'> video player
	$('#image-modal').on('hidden.bs.modal', function () {
		$("#image-modal iframe").attr("src", $("#image-modal iframe").attr("src"));
		$("#image-modal video").attr("src", $("#image-modal video").attr("src"));
	});


	{
		const detectDeviceType = () =>
				/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
						navigator.userAgent
				)
						? "모바일"
						: "데스크톱";
		console.log("*********************************** ",detectDeviceType());
	}

	{
		$.getJSON('https://api.ipify.org?format=jsonp&callback=?', function (data) {
			//console.log("*********************************** ipify=",JSON.stringify(data, null, 2));
		});
	}
	{
		let apiKey = '25864308b6a77fd90f8bf04b3021a48c1f2fb302a676dd3809054bc1b07f5b42';
		$.getJSON('https://api.ipinfodb.com/v3/ip-city/?format=json&key=' + apiKey, function(data) {
			//console.log("*************************************** ipinfodb=",JSON.stringify(data, null, 2));
		});
	}
</script>
<script src="/js/storyall2.js"></script>
</body>
</html>
