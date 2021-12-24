/**
  1. 유저 프로파일 페이지
  (1) 유저 프로파일 페이지 구독하기, 구독취소
  (2) 구독자 정보 모달 보기
  (3) 구독자 정보 모달에서 구독하기, 구독취소
  (4) 유저 프로필 사진 변경
  (5) 사용자 정보 메뉴 열기 닫기
  (6) 사용자 정보(회원정보, 로그아웃, 닫기) 모달
  (7) 사용자 프로파일 이미지 메뉴(사진업로드, 취소) 모달 
  (8) 구독자 정보 모달 닫기
 */

// (1) 유저 프로파일 페이지 구독하기, 구독취소
function toggleSubscribe(userId, obj) {

	if ($(obj).text() === "구독취소") {
		$.ajax({
			type: "DELETE",
			url: "/api/subscribe/" + userId,
			dataType: "json",
		}).done((res) => {
			$(obj).text("구독하기");
			$(obj).toggleClass("blue");
		}).fail(error=>{
           console.log("구독취소 실패...error");
   		});
	} else {
		$.ajax({
			type: "POST",
			url: "/api/subscribe/" + userId,
			dataType: "json",
		}).done((res) => {
			$(obj).text("구독취소");
			$(obj).toggleClass("blue");
		}).fail(error=>{
   		    console.log("구독 실패...error");
   		});
	}
}

// (2) 구독자 정보  모달 보기
function subscribeInfoModalOpen(pageUserId) {
	// alert(pageUserId);
	// return;
	$(".modal-subscribe").css("display", "flex");

	//let userId = $("#userId").val(); // pageUserId 해당 페이지의 주인 id

	$.ajax({
		url: `/api/user/${pageUserId}/subscribe`,
		dataType:"json"
	}).done((res) => {

		console.log(res);
		return;

		$("#subscribeModalList").empty();

		res.data.forEach((u) => {
			let item = getSubscribeModalItem(u);
			$("#subscribeModalList").append(item);
		});
	}).fail((error) => {

		console.log("구독자 리스트 불러오기 오류 : ",error);
		return;
		});
}

function getSubscribeModalItem(u) {
	let item = `<div class="subscribe__item" id="subscribeModalItem-${u.userId}">`;
	item += `<div class="subscribe__img">`;
	item += `<img src="/upload/${u.profileImageUrl}" alt=""  onerror="this.src='/images/person.jpeg'"/>`;
	item += `</div>`;
	item += `<div class="subscribe__text">`;
	item += `<h2>${u.username}</h2>`;
	item += `</div>`;
	item += `<div class="subscribe__btn">`;
	if (!u.equalState) { // 동일 유저가 아닐때 버튼이 만들어져야함.
		if (u.subscribeState) { // 구독한 상태
			item += `<button class="cta blue" onclick="toggleSubscribeModal(${u.userId}, this)">구독취소</button>`;
		} else { // 구독안한 상태
			item += `<button class="cta" onclick="toggleSubscribeModal(${u.userId}, this)">구독하기</button>`;
		}
	}
	item += `</div>`;
	item += `</div>`;

	return item;
}


// (3) 구독자 정보 모달에서 구독하기, 구독취소
function toggleSubscribeModal(toUserId, obj) {

	if ($(obj).text() === "구독취소") {
		$.ajax({
			type: "DELETE",
			url: "/api/subscribe/" + toUserId,
			dataType: "json",
		}).done((res) => {
			$(obj).text("구독하기");
			$(obj).toggleClass("blue");
		}).fail(error=>{
		    console.log("구독취소 실패...error");
		});
	} else {
		$.ajax({
			type: "POST",
			url: "/api/subscribe/" + toUserId,
			dataType: "json",
		}).done((res) => {
			$(obj).text("구독취소");
			$(obj).toggleClass("blue");
		}).fail(error=>{
		    console.log("구독하기 실패...error");
		});
	}
}

// (4) 유저 프로파일 사진 변경 (완)
function profileImageUpload(pageUserId,principalId) {
	//let principalId = $("#principalId").val();
	//console.log("pageUserId="+pageUserId);
	//console.log("principalId="+principalId);

	// 로그인 사용자의  프로필 페이지 이외의 접근
	if(pageUserId!=principalId) {
		alert("현재 로그인한 사용자는 이 프로필 사진을 수정할수 없습니다");
		return;
	}

	$("#userProfileImageInput").click(); // 이미지 파일 선택 이벤트 실행.

	//이미지 선택하지 않으면 에러 메세지
	$("#userProfileImageInput").on("change",(e) => {
		let f = e.target.files[0];
		if (!f.type.match("image.*")){
			alert("이미지를 선택해야 합니다.");
			return;
		}
		// --------------------------------------------------------------------------

		// 서버에 이미지 전송
		let profileImageForm = $("#userProfileImageForm")[0];
		//console.log("폼 전송: "+profileImageForm);

		// form data객체를 이용하려면 폼케그의 필드와 그값을 나타내는 일련의 key/value쌍을 담을 수 있다.
		let formData = new FormData(profileImageForm);

		//$.ajax({}).done(res=>{}).fail(error=>{});
		$.ajax({
			type:"put",
			url:`/api/user/${principalId}/profileImageUrl`,
			data:formData,
			contentType:false, // 필수: x-www-form-urlencode로 파싱되는것 방지
			processData:false, // 필수: contentType을 false로 했을때 Query String으로 자동 생성되는것 방지. 해제!!
			enctype:"multipart/form-data",
			dataType:"json"
		}).done(res=>{

			//성공시 사진 전송시 이미지 변경됨.
			let reader=new FileReader();
			reader.onload=(e)=>{
				$("#userProfileImage").attr("src",e.target.result);
			}
			reader.readAsDataURL(f); // 이 코드 실행시 reader.conload 실행됨.

		}).fail(error=>{
			console.log("오류",error);
		});

		// --------------------------------------------------------------------------
	})

}


// (5) 사용자 정보 메뉴 열기 닫기
function popup(obj) {
	$(obj).css("display", "flex");
}

function closePopup(obj) {
	$(obj).css("display", "none");
}


// (6) 사용자 정보(회원정보, 로그아웃, 닫기) 모달
function modalInfo() {
	$(".modal-info").css("display", "none");
}

// (7) 사용자 프로파일 이미지 메뉴(사진업로드, 취소) 모달
function modalImage() {
	$(".modal-image").css("display", "none");
}

// (8) 구독자 정보 모달 닫기
function modalClose() {
	$(".modal-subscribe").css("display", "none");
	location.reload();
}