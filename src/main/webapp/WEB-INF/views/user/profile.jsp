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
			<div class="profile-img-wrap story-border"
				 onclick="popup('.modal-image')">
				<form id="userProfileImageForm">
					<input type="file" name="profileImageFile" style="display: none;"
						   id="userProfileImageInput" />
				</form>
				<img class="profile-image" src="/upload/${dto.user.profileImageUrl}"
					 alt="" onerror="this.src='/images/person.jpeg'"
					 id="userProfileImage" />
				<label>[edit]</label>
			</div>
		</div>
		<!--유저이미지end-->



	</div>
</section>


<section  class="profile">
	<div class="profileContainer">
	<!--유저정보 및 사진등록 구독하기-->
	<div class="profile-right">
		<div class="name-group">
			<h2>${user.name}</h2>

			<c:choose>
				<c:when test="${dto.pageOwnerState}">
					<!--<button class="cta" onclick="location.href='/image/upload'">포토앨범<i class="far fa-image"></i><i class="fas fa-cloud-upload-alt"></i></button>-->
					<button class="modi" onclick="location.href='/image/upload'"><i class="fas fa-cloud-upload-alt"></i>사진/게시 등록</button>
					<button class="modi" onclick="popup('.modal-info')">
						<i class="fas fa-user-cog"></i><i class="fas fa-power-off"></i>정보수정/로그아웃
					</button>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${dto.subscribeState}">
							<button class="cta blue"
									onclick="toggleSubscribe(${dto.user.id},this)">구독취소</button>
						</c:when>
						<c:otherwise>
							<button class="cta" onclick="toggleSubscribe(${dto.user.id},this)">구독하기</button>
						</c:otherwise>
					</c:choose>

				</c:otherwise>
			</c:choose>

		</div>
		<div class="profileContainer">
			<ul>
				<li><a href=""><i class="far fa-images"></i><span>등록사진:${dto.imageCount}</span>
				</a></li>
				<li><a href="javascript:subscribeInfoModalOpen(${dto.user.id});" ><i class="fas fa-users"></i><span>구독자:${dto.subscribeCount}</span>
				</a></li>
			</ul>
		</div>
		<div class="state" style="display: none">
			<ul>
				<li><i class="fas fa-info-circle"></i><span>info${dto.user.bio}</span></li>
				<li><i class="fas fa-home"></i><span>home${dto.user.website}</span></li>
			</ul>
		</div>
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
			<!--게시물컨 그리드배열-->
			<div class="tab-1-content-inner">

				<!--아이템들-->
                <!--  JSTL 문법  -->
				<c:forEach var="image" items="${dto.user.images}"><!-- EL 표현식에서 변수명을 적으면 get함수가 자동으로 호출됨. -->

					<div class="img-box">
						<a href=""> <img src="/upload/${image.postImageUrl}" alt="">
						</a>
						<div class="comment">
							<a href="#a" class=""> <i class="fas fa-heart"></i><span>${image.likeCount}</span>
							</a>
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

<script src="/js/profile.js"></script>

<%@ include file="../layout/footer.jsp"%>