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
		//return;

		$("#subscribeModalList").empty();

		res.data.forEach((u) => {
			let item = getSubscribeModalItem(u); // return html tag applied subscriber list and toggle button
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
	item += `<h2>${u.name.substring(0,10)}(${u.username.substring(0,10)}...)</h2>`;
	item += `</div>`;
	item += `<div class="subscribe__btn">`;
	if (!u.equalUserState) { // 동일 유저가 아닐때 버튼이 만들어져야함. 자기자신 제외.
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
	 console.log("pageUserId => ",pageUserId);
	 console.log("principalId => ",principalId);

	if(pageUserId != principalId){
		alert("현재 사용자의 프로필이 아닙니다");
		return;
	}

	$("#userProfileImageInput").click();

	$("#userProfileImageInput").on("change", (e) => {
		let f = e.target.files[0];

		if (!f.type.match("image.*")) {
			alert("이미지를 등록해야 합니다.");
			return;
		}

		// 서버에 이미지 전송. 통신 시작
		let profileImageForm = $("#userProfileImageForm")[0];
		//let profileImageForm = $('form')[0];
		console.log("profileImageForm => ",profileImageForm);
		//return;

		//let formData = new FormData(profileImageForm); // form data 전송시 FormData(): key:value 쌍으로 formData 에 담을 수 있다.
		//let formData = new FormData(profileImageForm);
		let formData = new FormData(profileImageForm);
		//formData.append('tax_file', $('input[type=file]')[0].files[0]);
		console.log("formData => ",formData);
		//return;
		// FormData객체로 보내야함. key/value formData에 값들만 담김.
		// Form태그 데이터 전송 타입을 multipart/form-data 로 만들어줌.

		$.ajax({
			type: "POST", // ######################## PUT 안됨 ################################
			url: `/api/user/${principalId}/profileImageUrl`,
			data: formData,
			//data: JSON.stringify(formData),
			//contentType: false, //필수  x-www-form-urlencoded로 파싱됨.
			//contentType: 'application/json; charset=utf-8',
			contentType: false,
			processData: false, //필수 : contentType을 false로 줬을 때 쿼리 스트링으로 자동 설정됨. 그거 해제 하는 법
			enctype: "multipart/form-data", // 필수 아님 x-www-form-urlencoded로 파싱되는것 방지.
			dataType: 'json'
			//async: true
		}).done(res=>{
			console.log("#### .done res=> 진행 ####");
			console.log("res =>",res);
			//let f = document.querySelector('input[type=file]').files[0];
			let reader = new FileReader();
			reader.onload=(e)=>{
				$("#userProfileImage").attr("scr",e.target.result);
			}
			reader.readAsDataURL(f); // 이코드 실행시 reader.onload 실행됨.
			location.href = `/user/${principalId}`;
		}).fail(error=>{
			console.log("폼 ajax 전송 오류",error);
		});


		/*
		$.ajax({
			type: 'PUT',
			url:  prefix + '/MyData',
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify(JSONObject),
			dataType: 'json',
			async: true,
			success: function(result) {
				alert('At ' + result.time
					+ ': ' + result.message);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert(jqXHR.status + ' ' + jqXHR.responseText);
			}
		});
*/


		/*
                }).done(res=>{

                    console.log("########## principalId => "+principalId);
                    console.log("########## 파일전송 ajax.done(res=>)");
                    // 사진 전송 성공시 이미지 변경
                    let reader = new FileReader();
                    reader.onload = (e) => {
                        $("#userProfileImage").attr("src", e.target.result);
                    }
                    reader.readAsDataURL(f); // 이 코드 실행시 reader.onload 실행됨.
                }).fail(error=>{

                    console.log("########## principalId => "+principalId);
                    console.log("########## 파일전송 실퍠!",error.responseText);
                });

        */
	});
}
// 이미지 삭제

function deleteImage(imageId,principalId) {

		//let pid = ${u.userId}
		$.ajax({
			type: "DELETE",
			url: `/api/image/${imageId}/delete`,
			dataType: "json"
		}).done(res => {
			console.log("delete imageId=", imageId);
			console.log("principalId=",principalId);
			alert(" 선택한 이미지가 삭제되었습니다. \n\n deleted imageId= "+imageId+", principalId="+principalId);
			location.href = `/user/${principalId}`;
		}).fail(error=>{
			console.log("오류",error);
			//console.log("오류 내용: ",error.responseJSON.data.content);
			console.log("오류 내용: ",error.responseJSON.message);
			alert("오류 발생"+error);
		});
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

// 본인의 이미지 삭제(사진 삭제, 취소) 모달
function modalDelete() {
	$(".modal-imgdelete").css("display", "none");
}