<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>

<input type="hidden" id="userId" value="${dto.user.id}" />

<!--프로필 섹션-->
<section class="profile">
	<!--유저정보 컨테이너-->
	<div class="profileContainer">
		<!--유저이미지-->
		<div class="profile-left">
			<div class="profile-img-wrap story-border" onclick="popup('.modal-image')">
				<form id="userProfileImageForm">
					<input type="file" name="profileImageFile" style="display: none;"
						   id="userProfileImageInput" />
				</form>
				<img class="profile-image" src="/upload/${dto.user.profileImageUrl}"
					 alt="" onerror="this.src='/images/person.jpeg'"
					 id="userProfileImage" />
			</div>
		</div>
		<!-- user name -->
		<div   class="profile-right text-nowrap bd-highlight">
			<p> </p><p> </p><p> </p>
			<span  class="align-middle" style="color: Dodgerblue;"><h2>${dto.user.name}</h2>${fn:substring(dto.user.username,0,15)}</span>
		</div>
		<!--유저이미지end-->

	</div>

</section>
<!--프로필 섹션 end-->

<section  class="profile">
	<div class="profileContainer">
	<!--유저정보 및 사진등록 구독하기-->
	<div class="profile-right">
		<div class="name-group">

			<c:choose>
				<c:when test="${dto.pageOwnerState}">
					<!--<button class="cta" onclick="location.href='/image/upload'">포토앨범<i class="far fa-image"></i><i class="fas fa-cloud-upload-alt"></i></button>-->
					<div>
					<div><button class="modi" onclick="location.href='/image/upload'"><span style="font-size: 16px; color: Dodgerblue;"><i class="fas fa-cloud-upload-alt"></i>새로운 사진 등록</span></button>
					</div>
					<div><button class="modi" onclick="popup('.modal-info')"><span style="font-size: 16px; color: Dodgerblue;"><i class="fas fa-user-cog"></i><i class="fas fa-power-off"></i>정보수정/로그아웃</span></button>
					</div>
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
		<!-- <div class="profileContainer"> -->
		<div class="profileContainer">
			<a href=""><i class="far fa-images"></i><span>등록사진:${dto.imageCount}</span></a>
			<a href="javascript:subscribeInfoModalOpen(${dto.user.id});" ><span><i class="fas fa-users"></i>구독자:${dto.subscribeCount}</span></a>
		</div>
		<!--
		<div class="state">
			<ul>
				<li><i class="fas fa-info-circle"></i><span>info${dto.user.bio}</span></li>
				<li><i class="fas fa-home"></i><span>home${dto.user.website}</span></li>
			</ul>
		</div>
		-->
	</div>
	<!--유저정보 및 사진등록 구독하기-->
	</div>
</section>

<!--게시물컨섹션-->
<section id="tab-content">
	<!--게시물컨컨테이너-->
	<div class="profileContainer">
		<!--그냥 감싸는 div (지우면이미지커짐)-->
		<div id="tab-1-content" class="tab-content-item show">

<!-- 프로필 페이지 주인에게만 이미지 삭제 가능 알림 -->
			<c:choose>
				<c:when test="${dto.pageOwnerState}">
					<!--<button class="cta" onclick="location.href='/image/upload'">포토앨범<i class="far fa-image"></i><i class="fas fa-cloud-upload-alt"></i></button>-->
					<div class="alert btn-primary d-flex align-items-center" role="alert">
						<div>아래에서 이미지를 선택하면 설명(caption)을 수정하거나 사진을 삭제할 수 있습니다
						</div>
					</div>
				</c:when>
			</c:choose>
<!-- 이미지 삭제 가능 알림 end -->

			<!--게시물컨 그리드배열-->
			<div class="tab-1-content-inner">

				<!--아이템들-->
                <!--  JSTL 문법  -->
				<c:forEach var="image" items="${dto.user.images}"><!-- EL 표현식에서 변수명을 적으면 get함수가 자동으로 호출됨. -->
					<!-- profileImageUpload(${dto.user.id},${principal.user.id}) -->
					<!-- <div class="img-box" onclick="deleteImage(${image.id},${principal.user.id})"> -->
					<div class="img-box" id="${image.id}">
						<div  class="col">
							<c:choose>
								<c:when test="${dto.pageOwnerState}"> <!-- 페이지 주인일때  -->
									<!-- ####################### 이미지 링크 ###################### -->
									<a   class="btn btn-outline-primary btn-sm"
										 data-bs-toggle="modal"
										 data-bs-target="#delete-modal"
										 data-bs-imageid="${image.id}"
										 data-bs-imageurl="${image.postImageUrl}"
										 data-bs-userid="${principal.user.id}"
										 data-bs-caption="${image.caption}"
										 href="#"
										 role="button" style="outline: none;border: 0;"><img src="/upload/${image.postImageUrl}"></a>
									<!-- ####################### 이미지 링크 ###################### -->
								</c:when>
								<c:otherwise> <!-- 페이지 주인 아닐때 -->
									<!-- ####################### 이미지 링크 ###################### -->
									<img src="/upload/${image.postImageUrl}">
									<!-- ####################### 이미지 링크 ###################### -->
								</c:otherwise>
							</c:choose>
						</div>
						<!--
						fn:substring(string객체, 시작index, 종료index)
						-->
						<div><span style="font-size: 16px; color: Dodgerblue;">${fn:substring(image.caption,0,7)}</span></div>

						<!-- 프로필 페이지 주인에게만 이미지 삭제 버튼 보임 -->
						<c:choose>
							<c:when test="${dto.pageOwnerState}">

						<!-- 이미지 삭제 모달 트리거 버튼 -->

						<!--
						<div  class="col-sm-10">
						<a  class="btn btn-outline-primary btn-sm"
							data-bs-toggle="modal"
							data-bs-target="#delete-modal"
							data-bs-imageid="${image.id}"
							data-bs-imageurl="${image.postImageUrl}"
							data-bs-userid="${principal.user.id}"
							data-bs-caption="${image.caption}"
							href="#"
							role="button">수정|삭제</a>
						</div>
						-->

						<!-- 이미지 삭제 모달 크리거 버튼 end -->

						</c:when>
					</c:choose>
						<!-- 이미지 삭제 버튼 보임 end -->


						<div>
							<span style="font-size: 16px; color: Dodgerblue; padding-right: 16px;"><i class="fas fa-heart"></i> ${image.likeCount}</span>
						</div>
					</div>
				</c:forEach>

				<!--아이템들end-->
			</div>
		</div>
	</div>
</section>

<!--로그아웃, 회원정보변경 모달-->
<div class="modal-info" onclick="modalInfo()">
	<div class="modal1">
		<button onclick="location.href='/user/${principal.user.id}/update'">회원정보 수정</button>
		<button onclick="location.href='/logout'">로그아웃</button>
		<button onclick="closePopup('.modal-info')">취소</button>
	</div>
</div>
<!--로그아웃, 회원정보변경 모달 end-->

<!--프로필사진 바꾸기 모달-->
<div class="modal-image" onclick="modalImage()">
	<div class="modal">
		<p>프로필 사진 바꾸기</p>
		<button onclick="profileImageUpload(${dto.user.id},${principal.user.id})">프로필 사진 등록/수정 업로드</button>
		<button onclick="closePopup('.modal-image')">취소</button>
	</div>
</div>
<!--프로필사진 바꾸기 모달end-->

<!-- 프로필 페이지: 업로드 이미지 삭제 모달-->
<div class="modal-imgdelete" style="display: none" onclick="modalDelete()">
	<div class="modal2">
		<p>이미지를 삭제하시겠습니까?</p>
		<button onclick="deleteImage(${image.id},${principal.user.id})">선택한 이미지 삭제</button>
		<button onclick="closePopup('.modal-imgdelete')">취소</button>
	</div>
</div>
<!-- 프로필 페이지: 업로드 이미지 삭제 모달 end-->

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


<!-- Button trigger modal -->
<!--
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
	Launch demo modal
</button>
<a  class="btn btn-outline-primary btn-sm" data-bs-toggle="delete-modal" data-bs-target="delete-modal" href="#" role="button">삭제</a>
-->


<!-- Modal -->
<div class="modal fade" id="delete-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">이미지 설명 수정 / 삭제</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>


			<div class="modal-body">
					<img  class="img-box" src=""
						  alt="" onerror="this.src='/images/person.jpeg'"
						  id="delimage" style="max-width:250px;height:300px;max-height: 100%; max-width: 100%;"  />
				<form>
					<input type="hidden" id="image_id">
					<input type="hidden" id="image_url">
					<input type="hidden" id="user_id">
					<hr>
					<label>사진 설명 </label> <input type="text" id="caption" size="45">
				</form>
			</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="update-btn">설명 수정</button>
				<button type="button" class="btn btn-primary" id="delete-btn">이미지 삭제</button>
			</div>
		</div>
	</div>
</div>

<!-- 이미지 삭제 모달 이벤트 처리 -->
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
		console.log("imageid=",imageid);
		console.log("imageurl=",imageurl);
		console.log("userid=",userid);
		console.log("caption=",caption);

		// 모달창에 데이타 반영
		document.querySelector("#image_id").value=imageid;
		document.querySelector("#caption").value=caption;
		document.querySelector("#user_id").value=userid;
		document.querySelector("#image_url").value="/upload/"+imageurl;
		document.querySelector("#delimage").src="/upload/"+imageurl;
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

			// 삭제 이미지 객채 생성
			const image = {
				id: document.querySelector("#image_id").value,
				caption: document.querySelector("#caption").value,
				userid: document.querySelector("#user_id").value,
				url: document.querySelector("#image_url").value
			};
			console.log("image object =", image);

			// 삭제 REST API 호출 - fetch()
			const url="/api/image/"+image.id+"/delete";
			console.log("fetch url=",url);

			// fetch(url,{})
			fetch(url,{
				method: "DELETE", // method = 삭제요청
				body: JSON.stringify(image), // 객체를 JSON 으로 전달
				headers: {
					"Content-Type": "application/json"
				}

			// }).then(function (response) {}) -->> response => {}
			}).then(response => {
				// http 응답 코드에 따른 메시지 출력
				const msg = (response.ok) ? "이미지 삭제 완료~" : "이미지 삭제 실패!!";
				console.log(msg);
				alert(msg);
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

			// 삭제 이미지 객채 생성
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

				// }).then(function (response) {}) -->> response => {}
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
</script>
<!-- -->
<script src="/js/profile.js"></script>
<%@ include file="../layout/footer.jsp"%>