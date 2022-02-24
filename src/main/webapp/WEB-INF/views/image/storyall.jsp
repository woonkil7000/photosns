<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
<input type="hidden" id="userId" value="${dto.user.id}" />
<main class="main">
	<section class="container">
		<!--전체 리스트 시작-->
		<article class="story-list" id="storyList">
			<div><span style="font-size: 18px; color: Dodgerblue; padding-right: 20px;"><i class="fas fa-images"></i> 전체 미디어</span></div>

			<!--전체 리스트 아이템-->

			<!--
			<div class="story-list__item">
				<div class="sl__item__header">
					<div>
						<img class="profile-image" src="#"
							onerror="this.src='/images/noimage.jpg'" />
					</div>
					<div>TherePrograming</div>
				</div>

				<div class="sl__item__img">
					<img src="/images/home.jpg" />
				</div>

				<div class="sl__item__contents">
					<div class="sl__item__contents__icon">

						<button>
							<i class="fas fa-heart active" id="storyLikeIcon-${image.id}" onclick="toggleLike()"></i>
						</button>
					</div>

					<span class="like"><b id="storyLikeCount-1">3 </b>likes</span>

					<div class="sl__item__contents__content">
						<p>등산하는 것이 너무 재밌네요</p>
					</div>

					<div id="storyCommentList-1">

						<div class="sl__item__contents__comment" id="storyCommentItem-1"">
							<p>
								<b>Lovely :</b> 부럽습니다.
							</p>

							<button>
								<i class="fas fa-times"></i>
							</button>

						</div>

					</div>

					<div class="sl__item__input">
						<input type="text" placeholder="댓글 달기..." id="storyCommentInput-1" />
						<button type="button" onClick="addComment()">게시</button>
					</div>

				</div>
			</div>
			-->

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

		</article>
	</section>
</main>
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
</script>
<script src="/js/storyall2.js"></script>
</body>
</html>
