<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<!--인기 게시글-->
<main class="popular">
	<div class="exploreContainer">
		<div><span style="font-size: 18px; color: Dodgerblue; padding-right: 20px;">나만의 좋아요 랭킹 10</span></div>
		<!--인기게시글 갤러리(GRID배치)-->
		<div class="popular-gallery">
			<c:forEach var="image" items="${images}">
				<div class="p-img-box" style="padding-top: 30px;">
					<!-- <a href="/user/${image.user.id}"> -->
					<div>




						<!-- 이미지 링크 -->
						<!-- ####################### 이미지 모달 링크 ###################### -->
						<a   class="btn btn-outline-primary btn-sm"
							 data-bs-toggle="modal"
							 data-bs-target="#image-modal"
							 data-bs-imageid="${image.id}"
							 data-bs-imageurl="${image.postImageUrl}"
							 data-bs-caption="${image.caption}"
							 href="#"
							 role="button" style="outline: none;border: 0;">

							<img src="/upload/${image.postImageUrl}"
								  style="max-height: 100%; max-width: 100%" alt="이미지"/>
						</a>
						<!-- ####################### 이미지 모달 링크 end ###################### -->
						<!-- 이미지 링크 end -->




					</div>
					<div><p style="font-size: 16px; color: Dodgerblue; padding-right: 16px;">${fn:substring(image.user.name,0,5)} <i class="fas fa-heart"></i> ${image.likeCount}</p>
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
				<img  data-bs-dismiss="modal" class="img-box" src=""
					  alt="" onerror="this.src='/images/noimage.jpg'"
					  id="lgimage" style="max-width: 380px;max-height: 520px;max-height: 100%; max-width: 100%;"  />
				<form>
					<input type="hidden" id="image_id">
					<input type="hidden" id="image_url">
					<input type="hidden" id="user_id">
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
			console.log("imageid=",imageid);
			console.log("imageurl=",imageurl);
			console.log("userid=",userid);
			console.log("caption=",caption);

			// 모달창에 데이타 반영
			document.querySelector("#image_id").value=imageid;
			document.querySelector("#caption").innerHTML=caption;
			document.querySelector("#user_id").value=userid;
			document.querySelector("#image_url").value="/upload/"+imageurl;
			document.querySelector("#lgimage").src="/upload/"+imageurl;
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
<%@ include file="../layout/footer.jsp"%>

