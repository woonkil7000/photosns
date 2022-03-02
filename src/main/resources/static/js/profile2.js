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
let uTubePathUrl;
//let pageUserId=`${principalId}`;
let isNoData=1; // init value: true. still no Data.
let DataFailed=0; // 데이타 로딩 실패. init value: False
let page=0;
let totalPage=0;
let currentPage=0;
let isLastPage=false;
let appendLastFlag=0;// 더이상 데이타가 없습니다. 멘트 덧붙이기 했나? 안했나?
let storyLoadUnlock=true; // storyLoad() 초기값 허용.
let totalElements;

let principalId = $("#principalId").val(); // input hidden value
console.log("principalId=",principalId);
let principalUsername = $("#principalUsername").val();
console.log("principalUsername=",principalUsername);
let userId = $("#userId").val(); // jquery grammar: querySelection? input hidden value
console.log("userId=",userId);

// (0) 페이지 유저 id로 페이지<이미지> 리스트 가져오기
function imageList() {

	// alert(pageUserId);
	$(".img").css("display", "flex");
	userId = $("#userId").val(); // pageUserId 해당 페이지의 주인 id

	$.ajax({
		url: `/api/image/${userId}?page=${page}`,
		dataType:"json"
	}).done((res) => {

		isNoData=0; // noData: 0:false. is Be Data.
		//console.log("url=",url);
		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ res=",res);
		console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ res.data=",res.data);
		totalPage = res.data.totalPages; // 전체 페이지
		currentPage = res.data.pageable.pageNumber; // 현재 페이지 0부터 시작:
		totalElements=res.data.totalElements;
		isLastPage=res.data.last;

		// res.data.forEach((u) // 오류!!! @@@@@@@@@@@@@@@@ forEach 돌리기전 res 출력해서 object 구조 먼저 확인 할 것!! @@@@@@@@@@@@

		res.data.content.forEach((u) => {
			let item = getImageItem(u); // // @@@@@@@@@@@@@ <div> Get Row Data Function. return html tag applied list
			//console.log("# item=",item);
			$("#storyList").append(item);
		});
		page=currentPage+1;

	}).fail((error) => {

		DataFailed=1; // 데이타 로딩 실패.
		console.log("리스트 불러오기 오류 : ",error);
		console.log("isNoData=",isNoData);
		console.log("DataFailed=",DataFailed);
		// 이미지 데이타가 하나도 없을대 //데이터도 없고 데이타 로딩을 실패했을때
		if(isNoData==1&&DataFailed==1){

			let	noImage ="<div class='col'></div><div class='col'><span style='font-size: 16px; color: Dodgerblue;'>";
			noImage +=" 등록된 미디어 데이터가 없습니다</span></div><div class='col'></div>";
			//console.log("no image=",noImage);
			$("#storyList").append(noImage); // id=#storyList <div> 에 이어 붙이기
		}
	});
}

function getImageItem(image){ // @@@@@@@@@@@@@ <div> Get Row Data Function

	console.log("======================== image.contentType ={} =================================",);

	<!-- Get Content Type -->
	let imageId=`${image.id}`;
	let contentType=`${image.contentType}`;
	contentType=contentType.substring(0,5);

	let pathUrl;
	console.log("/////////////////////////// contentType='" +contentType+ "'//////////////////////////////////////");
	if(contentType=='youtu'){ // when youtube
		pathUrl=`${image.postImageUrl}`;
	}else{
		pathUrl="/upload/"+`${image.postImageUrl}`;
	}
	console.log("/////////////////////////// pathUrl='" +pathUrl+ "'//////////////////////////////////////");

	// ############# fnContentType(contentType,pathUrl) ###############
	function fnContentType(contentType,pathUrl){
		// @@@@@@@@@@@ getImageItem 함수 [Row Data] 내부에서  content 유형에 따라 <div> 안에 들어갈 내용을 contentTag 로 반환하는 함수

		let contentTag;
		if (contentType=='image'){ // image
			////////////////////  이미지에만 팝업될 수 있게 <a> Tag 처리 ////////////////////////////
			//onclick="window.open('" +pathUrl+ "','window_name','width=430,height=500,location=no,status=no,scrollbars=yes');"
			//contentTag =`<a onclick="window.open('` +pathUrl+ `','window_name','width=380,height=500,location=no,status=no,scrollbars=yes');">`;
			contentTag ="<img  src='" +pathUrl+ "' style='max-height:100%;max-width:100%' alt='이미지' />";
			//contentTag +="</a>";
			console.log("=============== image ===================");
		}else if(contentType=='video'){ // video
			contentTag ="<video playsinline controls preload='auto' src='" +pathUrl+ "#t=0.01' style='max-height:100%;max-width:100%' alt='영상'>" +
				"이 브라우저는 비디오를 지원하지 않습니다</video>";
			console.log("=============== video ===================");
		}else if(contentType=='youtu'){ // youtube
			contentTag ="<iframe src='https://youtube.com/embed/"+pathUrl+"' volumn='3' controls='1' frameborder='1' allowfullscreen " +
				" style='max-height:100%;max-width:100%' alt='유튜브'></iframe>";
			console.log("=============== YouTube ===================");
		}else{ // 현재 DB 에 contentType 값이 없는 기존 image Data 가 있어서.
			////////////////////  이미지에만 팝업될 수 있게 <a> Tag 처리 ////////////////////////////
			//contentTag =`<a onclick="window.open('` +pathUrl+ `','window_name','width=380,height=500,location=no,status=no,scrollbars=yes');">`;
			contentTag ="<img src='" +pathUrl+ "' style='max-height:100%;max-width:100%' alt='이미지'/>";
			//contentTag +="</a>";
			console.log("=============== etc => image ===================");
		}
		//console.log("======================== contentTag ={} =================================",contentTag);
		return contentTag;
	}
	// ############# fnContentType(contentType,pathUrl) -END- ###############
	<!-- Get Content Type end  -->

	// @@@@ prefix
	function preTag(){
		let ptag;
			ptag =` <a   class='btn btn-outline-primary btn-sm' `;
			ptag +=` data-bs-toggle='modal' `;
			ptag +=` data-bs-target='#image-modal' `;
			ptag +=` data-bs-imageid='${image.id}' `;
			ptag +=` data-bs-imageurl='${image.postImageUrl}' `;
			ptag +=` data-bs-caption='${image.caption}' `;
			ptag +=` data-bs-userid='${image.user.id}' `;
			ptag +=` data-bs-contentTag="${fnContentType(contentType,pathUrl)}" `;
			ptag +=` href='#' `;
			ptag +=` role='button' style='outline: none;border: 0;'>`;
		return ptag;
	}//prefix end

	// @@@@ suffix
	function sufTag(){
		let stag;
		stag = "</a>";
		return stag;
	} // suffix end

	let contentTag = fnContentType(contentType,pathUrl);
	let result = `<div class="col" id="storyList-${image.id}">${contentTag}</div>`;
	result +=` `;
	console.log("------------- imageId=",imageId);
	console.log("============================== result=",result);

	// preTag(<a href=) + result + sufTag(/a>) // prefix, suffix 접두사 접미사
	result = preTag()+result;
	// 사진설명,좋아요카운트
	let likeCount=`${image.likeCount}`;
	//let caption = `${fn:substring(image.caption,0,7)}`; // 자바스크립트 substring 함수 사용.
	let caption = `${image.caption}`;
	caption = caption.substring(0,10);
	console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ likeCount=",likeCount);
	console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ caption=",caption);
	result +=`<div><p style='font-size: 16px; color: Dodgerblue; padding-right: 16px;'><i class='fas fa-heart'></i> ${likeCount}</p>`;
	result +=`<p style='font-size: 16px; color: Dodgerblue;'> ${caption}</p></div>`;
	result += sufTag();
	console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ result= @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",result);
	return result;
}

imageList();

//

// 스토리 스크롤 페이징하기
$(window).scroll(() => {

	//console.log(" =|=|=|= currentPage",currentPage);
	//console.log(" =|=|=|= totalPage",totalPage);
	//console.log(" =|=|=|= page++",page);
	//console.log("문서의 높이",$(document).height());
	//console.log("윈도우 스크롤 탑",$(window).scrollTop());
	//console.log("윈도우 높이",$(window).height());
	let checkNum = ($(document).height() - $(window).scrollTop() - $(window).height());
	//console.log("--------------------------------------------- checkNum="+checkNum);

	//console.log("@@@@ before storyLoad() 혀용 storyLoadUnlock=",storyLoadUnlock);
	// 근사치 계산: checkNum=0일때 이벤트 발생함 // currentPage = 0부터 시작
	if ((checkNum < 200 && checkNum > -1) && storyLoadUnlock && (page <= (totalPage-1))) {

		// Set Timer 걸기. 동시이벤트 걸러내기.
		imageList();
		storyLoadUnlock=false;
		// console.time("X");
		// console.timeStamp("시작 시간");
		//console.log("========================= imageList() 함수 호출 실행됨 ==========================");
		//console.log("========================= after storyLoad() 불가 storyLoadUnlock=",storyLoadUnlock);
		setTimeout(function(){
			storyLoadUnlock=true; // 3초후 허용
			//console.log("================================== timer 2초후 허용함 storyLoadUnlock=",storyLoadUnlock);
			// console.timeEnd("X");
			// console.timeStamp("종료 시간");
		},1000)

		//window.scrollTo(0, $(window).scrollTop()+$(document).height()+300);
	}
	if (isLastPage==true&&appendLastFlag!=1){ // 데이타의 마지막 페이지
		appendLastFlag=1;
		// append. no more date message.
		let storyItem = "<div  class=\"alert alert-warning\" role=\"alert\">"+
			"<span style=\"font-size: 16px; color: Dodgerblue;\">" +
			" 더이상 데이터가 없습니다 (" +totalElements+ ")</span></div>";
		$("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
	}
	{passive: false}
});


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
			let item = getSubscribeModalItem(u); // return html tag applied subscriber list and 구독하기 / 구독취소 버튼 표시 toggle button
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
	item += `<img src="/upload/${u.profileImageUrl}" alt=""  onerror="this.src='/images/noimage.jpg'"/>`;
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
		alert("현재 유저의 프로필이 아닙니다");
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
			//alert(" 선택한 이미지가 삭제되었습니다. \n\n deleted imageId= "+imageId+", principalId="+principalId);
			location.href = `/user/${principalId}`;
		}).fail(error=>{
			console.log("오류",error);
			//console.log("오류 내용: ",error.responseJSON.data.content);
			console.log("오류 내용: ",error.responseJSON.message);
			//alert("오류 발생"+error);
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
} //myCheck();
