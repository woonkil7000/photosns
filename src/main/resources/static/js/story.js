/**
	2. 스토리 페이지
	(1) 스토리 로드하기
	(2) 스토리 스크롤 페이징하기
	(3) 좋아요, 안좋아요
	(4) 댓글쓰기, 댓글삭제
 */

let isNoData=1; // init value: true. still no Data.
let DataFailed=0; // 데이타 로딩 실패. init value: False
let page=0;
let totalPage=0;
let currentPage=0;
let isLastPage=false;
let appendFlag=0;
let storyLoadUnlock=true; // storyLoad() 초기값 허용.
let totalElements;

let principalId = $("#principalId").val(); // jquery grammar: querySelection? input hidden value
let principalUsername = $("#principalUsername").val();
let userId = $("#userId").val(); // jquery grammar: querySelection? input hidden value

function storyLoad() {
  // ajax로 Page<Image> 가져올 예정 (3개)
  $.ajax({
    type: "get",
	  contentType: "charset=utf-8",
	  url: `/api/image?page=${page}`,
    dataType: "json",
  }).done((res) => {

	  console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ if OK @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ok page=",page);
	  isNoData=0; // noData: 0:false. is Be Data.
	  console.log("## res=",res); // ##### 사용하지 말것! 이렇게 ==> console.log("## res="+res);
	  totalPage = res.data.totalPages; // 전체 페이지
	  currentPage = res.data.pageable.pageNumber; // 현재 페이지 0부터 시작:
	  isLastPage=res.data.last;
	  totalElements=res.data.totalElements;
	  console.log("########################################## PAGE ########################################################");
	  //console.log("///////////////////// page++ ############ page++ [from 0]=",page);
	  //console.log("///////////////////// totalPages ############ res.data.totalPages =",res.data.totalPages);
	  //console.log("///////////////////// current page ############ currentpage = res.data.pageable.pageNumber [from 0]=",res.data.pageable.pageNumber);
	  //console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ isLastPage? @@@@@@@@@@@@@@@@@@@@@@@@@@@@ ",isLastPage);
	 	//res.data.forEach((image)=>{ // List로 받을때
		res.data.content.forEach((image)=>{ // Page로 받을때
			let storyItem = getStoryItem(image);
			//console.log("#### storyItem ####  = \"getStoryItem(image)\" ==> ",storyItem);
			//console.log("#### res.data.content.forEach((image) storyItem = \"getStoryItem(image)\" storyItem => "+JSON.stringify(storyItem));
			console.log("----------------------- forEach -end- ----------------------------------");
			$("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
    	});
	page=currentPage+1;

  }).fail(error=>{

	  DataFailed=1; // 데이타 로딩 실패.
	  console.log("오류",error);
	  console.log("오류 내용: ",error.responseJSON.message);
	  // 비동기 방식이라서  ajax 안으로 구문 이동시켜야함.
	  //console.log("isNoData=",isNoData);
	  //console.log("DataFailed=",DataFailed);
	  if(isNoData==1 && DataFailed==1){ // 데이터도 없고 데이타 로딩을 실패했을때
		  let noImage = "<div  class=\"alert alert-warning\" role=\"alert\"><p> </p><p> </p><p> </p><span style=\"font-size: 16px; color: Dodgerblue;\">" +
			  "아직 구독을 신청한 회원이 없습니다</span>"+
			  "<p> </p>"+
			  "<p>초기 화면의 미디어 목록에서</p>"+
			  "<p>다른 회원 프로필을 선택하여</p>"+
			  "<span style=\"font-size: 16px; color: Dodgerblue;\">"+
			  "<p>\"구독하기\"를 신청하면</p>"+
			  "<p>구독중인 회원들의 게시물을 </p>"+
			  "<p>여기에서 볼 수 있습니다 </p></span></div>";
		  //$("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
		  //document.write(storyItem);
		  $("#storyList").append(noImage); // id=#storyList <div> 에 이어 붙이기
	  }
  });
} // storyLoad() -END-

// 첫 로딩 실행
storyLoad();

// 스토리 스크롤 페이징하기
$(window).scroll(() => {

	//console.log(" =|=|=|= currentPage",currentPage);
	//console.log(" =|=|=|= totalPage",totalPage);
	//console.log(" =|=|=|= page++",page);
    //console.log("문서의 높이",$(document).height());
    //console.log("윈도우 스크롤 탑",$(window).scrollTop());
    //console.log("윈도우 높이",$(window).height());

    let checkNum = ($(document).height() - $(window).scrollTop() - $(window).height());
    //console.log("checkNum="+checkNum);

  // 근사치 계산 // currentPage = 0부터 시작
  if ((checkNum < 500 && checkNum > -1)  && storyLoadUnlock && (page <= totalPage-1)) {

	  storyLoad();
	  storyLoadUnlock=false;
	  //console.time("X");
	  //console.timeStamp("시작 시간");
	  setTimeout(function(){
		  storyLoadUnlock=true; // 2초후 허용
		  // console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ timer 2초후 허용함 storyLoadUnlock=",storyLoadUnlock);
		  // console.timeEnd("X");
		  // console.timeStamp("종료 시간");
	  },3000)

  }
	if (isLastPage==true&&appendFlag!=1){
		appendFlag=1;
		// append. no more date message.
		let noImage = "<div class=\"alert alert-warning\" role=\"alert\"><span style=\"font-size: 16px; color: Dodgerblue;\">" +
			" 더이상 미디어 데이터가 없습니다(" +totalElements+ ")</span></div>";
		$("#storyList").append(noImage); // id=#storyList <div> 에 이어 붙이기
	}
	{passive: false}
});

function getStoryItem(image) {

	console.log("======================== image.contentType ={} =================================",);

	let commentCount=`${image.commentCount}`;
	<!-- Get Content Type -->
	let caption = `${image.caption}`;
	caption = replaceBrTag(caption);
	//console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ caption <br>",caption);
	let imageId=`${image.id}`;
	let contentType=`${image.contentType}`;
	contentType=contentType.substring(0,5)
	let pathUrl;
	console.log("/////////////////////////// contentType='" +contentType+ "'//////////////////////////////////////");
	if(contentType=='youtu'){ // when youtube
		pathUrl=`${image.postImageUrl}`;
	}else{
		pathUrl="/upload/"+`${image.postImageUrl}`;
	}
	console.log("/////////////////////////// pathUrl='" +pathUrl+ "'//////////////////////////////////////");

	function fnContentType(widthType,contentType,pathUrl){
		// @@@@@@@@@@@ getStoryItem [Row Data] 내부에서  content 유형에 따라 <div> 안에 들어갈 내용을 contentTag 로 반환하는 함수
		// widthType 0: default, 1: wideFull

		let contentTag;
		let contentTag2;

		if (contentType=='image'){ // image
			contentTag="<img src='" +pathUrl+ "' style='max-height:300px;max-width:100%' alt='이미지' />";
			contentTag2 ="<img src='" +pathUrl+ "' style='max-height:100%;max-width:100%;' alt='이미지' />";
			console.log("=============== image ===================");
		}else if(contentType=='video'){ // video
			contentTag="<video class='noloop' id='content" +imageId+ "'  playsinline controls preload='auto' src='" +pathUrl+ "#t=0.1' style='max-height:300px;max-width:100%' alt='영상'>" +
				"이 브라우저는 비디오를 지원하지 않습니다</video>"+
				"<p onclick='toggleLoop(" +imageId+ ")'><button type='button' class='btn btn-outline-primary btn-sm'>반복 설정</button><button type='button' id='btnLoop" +imageId+"' onclick='toggleLoop(" +imageId+ ")' class='btn btn-outline-primary btn-sm'>once</button>"+
				"</p>";
			contentTag2 ="<video class='noloop' id='content" +imageId+ "'  playsinline controls preload='auto' src='" +pathUrl+ "#t=0.01' style='max-height:100%;max-width:100%;' alt='영상'>" +
				"이 브라우저는 비디오를 지원하지 않습니다</video>"+
				"<p  style='display: none' onclick='toggleLoop(" +imageId+ ")'><button type='button' class='btn btn-outline-primary btn-sm'>반복 설정</button><button type='button' id='btnLoop" +imageId+"' onclick='toggleLoop(" +imageId+ ")' class='btn btn-outline-primary btn-sm'>once</button>"+
				"</p>";
			console.log("=============== video ===================");
		}else if(contentType=='youtu'){ // youtube
			contentTag ="<iframe src='https://youtube.com/embed/"+pathUrl+"' frameborder='0' allowfullscreen " +
				" style='max-height:100%;max-width:100%' alt='유튜브'></iframe>";
			contentTag2 ="<iframe src='https://youtube.com/embed/"+pathUrl+"' frameborder='0' allowfullscreen " +
				" style='max-height:100%;max-width:100%' alt='유튜브'></iframe>";
			console.log("=============== YouTube ===================");
		}else{ // 현재 DB 에 contentType 값이 없는 기존 image Data 가 있어서.
			contentTag="<img src='" +pathUrl+ "' style='max-height:300px;max-width:100%' alt='이미지'/>";
			contentTag2 ="<img src='" +pathUrl+ "' style='max-height:100%;max-width:100%' alt='이미지'/>";
			console.log("=============== etc => image ===================");
		}
		console.log("======================== contentTag or contentTag2  ={} =================================",contentTag);
		console.log("======================== contentTag or contentTag2  ={} =================================",contentTag2);
		if (widthType == 0){
			return contentTag;
		}else if(widthType==1) {
			return contentTag2;
		}else{
			return contentTag2
		}
	}
	<!-- Get Content Type end  -->


  let result = `
<!--전체 리스트 아이템-->
<div class="col-12 col-md-4"> <!-- column 3-->
	<!--리스트 아이템 헤더영역-->
<div class="card">
<div class="card-header">`;

		<!-- 사용자 프로필 이미지 -->
	result += `<div class="card-cover"><a  href="/user/${image.user.id}"><img width="23" height="23" class="profile-image" src="/upload/${image.user.profileImageUrl}" alt=""  onerror="imgError(this);"/>`;

	result +=`
		<span style="font-size: 18px; color: Dodgerblue;"><a class="profile-image" href="/user/${image.user.id}"><b>${image.user.name}</b></a></span></div>
	</div>
	<!--헤더영역 end-->

	<!--게시물이미지 영역-->
	<!-- <div class="sl__item__img"> -->
	<!-- <div class="col-md-5 px-0"> -->
	<div class="col align-self-end mx-1 my-0">`;
	result += before_atag();
	result +=`<i class="bi bi-fullscreen"></i>`;
	result += after_atag();
	result +=`</div>
	<div class="card-body">
		`;

	result +=`
	<!-- ####################### 이미지 모달 링크 ###################### -->
	`;

	/////////////// contentType이 이미지인 경우만 <a tag for modal 시작부 삽입 ////////////////////
	function before_atag(){
		let atag;
		if(contentType=='image' || contentType=='video' || contentType=='youtu'||contentType=='null' || contentType==''){

			atag =` <a   class='btn btn-outline-primary btn-sm' `;
			atag +=` data-bs-toggle='modal' `;
			atag +=` data-bs-target='#image-modal' `;
			atag +=` data-bs-imageid='${image.id}' `;
			atag +=` data-bs-imageurl='${image.postImageUrl}' `;
			atag +=` data-bs-caption="${image.caption}" `;
			/*atag +=` data-bs-caption="`;
			atag += replaceBrTag(caption);
			atag += `"`;*/
			atag +=` data-bs-userid='${image.user.id}' `;
			atag +=` data-bs-contentTag="${fnContentType(1,contentType,pathUrl)}" `;
			atag +=` data-bs-principalid="${principalId}" `;
			atag +=` href='#' `;
			atag +=` role='button' style='outline: none;border: 0px;'>`;
		}else{
			atag = "";
		}
		return atag;
	}
	//////////////// contentType이 이미지인 경우만 <a  tag for modal 시작부 삽입 -END- ///////////////////

	/////////////// contentType이 이미지인 경우만 </a tag 종료부 삽입 ////////////////////
	function after_atag(){
		let atag;
		if(contentType=='image' || contentType=='video' || contentType=='youtu' || contentType=='null'||contentType=='') {
			atag = "</a>";
		}else{
			atag = "";
		}
		return atag;
	}
	/////////////// contentType이 이미지인 경우만 </a tag 삽입종료부 -END- ////////////////////

	// fnContentType(widthType,contentType,pathUrl);
	// #### || 게시물 컨텐츠 목록부분: 이미지/동영상 테크 위치  ||  #### <img src=''> or <video> #### contentTag ####
	// widthType 0: default size, 1: wideFull

	/*result += before_atag();*/

	if (contentType==='image'){ // 이미지 일때 이미지에 a tag 걸기
		result += before_atag();
		result += fnContentType(0,contentType,pathUrl);
		result += after_atag();
	}else{
		result += fnContentType(0,contentType,pathUrl);
	}
	//<img src="/upload/${image.postImageUrl}" style="max-height: 100%; max-width: 100%" alt="이미지"/>
	/*result += after_atag();*/

	result +=`<!-- </a> -->
		<!-- /////////////// contentType이 이미지인 경우만 <a> tag 삽입 //////////////////// -->`;

	result +=` 
<!-- ####################### 이미지 모달 링크 end ###################### -->

`;

	result +=`	
			</div>
    <div class="card-title pb-3 px-2 align-items-lg-start">
			<span style="font-size: 17px; color: Dodgerblue;padding-left: 5px;"><b id="id_caption">${caption}</b></span>
    <!-- 게시물 이미지 영역 end -->

	<!--게시물 내용 + 댓글 영역-->
		<!-- 하트모양 버튼 박스 -->
		<div class="likes-icon px-2"> `;

  if (image.likeState) {
    result += `<button onclick="toggleLike(${image.id})">
							<i class="fas fa-heart active" id="storyLikeIcon-${image.id}"></i>
						</button>`;
  } else {
    result += `<button onclick="toggleLike(${image.id})">
							<i class="far fa-heart" id="storyLikeIcon-${image.id}"></i>
						</button>`;
  }

  result += `	
		<!--좋아요 카운트-->
		좋아요<span class="like" id="storyLikeCount-${image.id}">${image.likeCount}</span>
		<!--좋아요 카운트 end-->
		</div>
		<!-- 하트모양 버튼 박스 end -->
	</div> <!-- class card-title -->
	
		<!--태그박스-->
		<div class="card-subtitle">
			`;

  image.tags.forEach((tag) => {
    result += `#${tag.name} `;
  });

  result += `			
		</div>
		<!--태그박스end-->

		<!--게시글내용-->
		<!--
		<div class="sl__item__contents__content">
			<span style="font-size: 18px; color: Dodgerblue;">{image.caption}</span>
		</div>
		-->
		<!--게시글내용end-->
		`;

		<!-- 댓글 박스 시작 -->
	if (commentCount>3){ // 댓글 수 4이상 부터 댓글 아이콘 + 카운터 + 펼치기 버튼 노출
		result +=`<div class="commentCount"><i class="bi bi-list"></i>${image.commentCount}
					<button onclick="commentShowAll('image'+${image.id})"><i class="bi bi-arrows-expand"></i></button>
					</div>`;
	}

	result +=`
		<!-- 댓글 박스 시작 -->
		<div class="comment-card"><!-- comment card start -->
		<div class="comment-card-body" id="storyCommentList-${image.id}"><!-- card body -->
		`;

	<!--  ####################### 댓글 목록 반복문  시작 ############################# -->

	let i=0;
	image.comments.forEach((comment) => {

		if(i<3) { // 3ea show! , else display: none;
			result += `	
				<div class="list-group-item" id="storyCommentItem-${comment.id}"> <!-- item list -->
					<a class="profile-image" href="/user/${comment.user.id}">
					<img class="profile-icon" src="/upload/${comment.user.profileImageUrl}" alt=""  onerror="imgError(this);"/>
						</a>${comment.content}				
  				`;
			if (principalId == comment.user.id) { // 유저의 댓글이면 삭제버튼 표시
				result += `<button class="del-btn" onClick="deleteComment(${comment.id})"><i class="bi bi-trash"></i>							
					`; // 유저의 댓글이면 삭제버튼 표시 end
			}
			result += `</div>`; // item list

		}else { // 댓글 4개 부터 class 이름 image+{image.id} 이름으로 묶어서 펼치기 / 접기 적용.

			result += `	
				<span  class="image${image.id}" style="display: none">
				<div class="list-group-item" id="storyCommentItem-${comment.id}"> <!-- item list -->
					<a class="profile-image" href="/user/${comment.user.id}">
						<img class="profile-icon" src="/upload/${comment.user.profileImageUrl}" alt=""  onerror="imgError(this);"/>
						</a>${comment.content}
  				`;
			if (principalId == comment.user.id) { // 유저의 댓글이면 삭제버튼 표시
				result += `<button class="del-btn" onClick="deleteComment(${comment.id})"><i class="bi bi-trash"></i></button>
								`; // list-group-item -end-//   유저의 댓글이면 삭제버튼 표시 end
			}
			result +=`</div>
				</span>	`;
		} // if() -end-
		i++;
	});// forEach end


  result += `
		</div><!-- comment card body #end -->
		</div><!-- comment card #end -->
		<!-- 댓글 박스 끝 -->
		<!--  ########################  댓글 목록 반복문 끝   ################################# -->
		
		<!--댓글입력박스-->
		<!-- <div class="sl__item__input"> -->
		<div class="card-footer">
			<input type="text" placeholder="댓글 달기" size="15" maxlength="20" id="storyCommentInput-${image.id}" />
			<button type="button" onClick="addComment(${image.id})">쓰기</button>
		</div>
		<!--댓글달기박스end-->		
	</div>
</div>
<!--전체 리스트 아이템end-->
`;
	return result;
}

function toggleLike(imageId) {
	let likeIcon = $("#storyLikeIcon-" + imageId);
	if (likeIcon.hasClass("far")) {
		$.ajax({
			type: "POST",
			url: `/api/image/${imageId}/likes`,
			dataType: "json"
		}).done(res => {
			let likeCountStr = $(`#storyLikeCount-${imageId}`).text();
			let likeCount = Number(likeCountStr) + 1;
			console.log("좋아요 카운트=",likeCount)
			$(`#storyLikeCount-${imageId}`).text(likeCount);

			likeIcon.addClass("fas");
			likeIcon.addClass("active");
			likeIcon.removeClass("far");
		});



	} else {
		$.ajax({
			type: "DELETE",
			url: `/api/image/${imageId}/likes`,
			dataType: "json"
		}).done(res => {
			let likeCountStr = $(`#storyLikeCount-${imageId}`).text();
			let likeCount = Number(likeCountStr) - 1;
			console.log("좋아요취소 카운트=",likeCount)
			$(`#storyLikeCount-${imageId}`).text(likeCount);

			likeIcon.removeClass("fas");
			likeIcon.removeClass("active");
			likeIcon.addClass("far");
		});

	}
}

// 댓글쓰기

function addComment(imageId) {

	let commentInput = $(`#storyCommentInput-${imageId}`);
	let commentList = $(`#storyCommentList-${imageId}`);
	
	let data = {
		imageId: imageId,
		content: commentInput.val()
	}
	// 이미지번호와 코멘트 입력내용.

	// alert(data.content);
	// return;


	if (data.content === "") {
		alert("댓글을 작성해주세요!");
		return;
	}

	// console.log(data);
	// console.log(JSON.stringify(data));
	// return;

	// 통신 성공하면 아래 prepend 되야 되고 ID값 필요함
	$.ajax({
		type: "POST",
		//url: "/image/${imageId}/comment",
		url: "/api/comment",
		data: JSON.stringify(data),
		//contentType: "plain/text; charset=utf-8",
		contentType: "application/json;charset=utf-8",
		dataType: "json" //응답 받을때
	}).done(res => {
		console.log("댓글 쓰기 성공: ",res);

		let comment = res.data;
		let content = `
			  <li>
			  <div class="list-group-item" id="storyCommentItem-${comment.id}"> 
			      <a class="profile-image" href="/user/${comment.user.id}">
				<img width="23" height="23" style="border-radius: 50%;" height="23" width="23" src="/upload/${comment.user.profileImageUrl}" alt=""  onerror="imgError(this);"/>
				</a>${comment.content}
			     <i class="bi bi-plus-square"></i> <button onClick="deleteComment(${comment.id})"> <i class="bi bi-trash"></i></button>
			  </div>
			  </li>
			  `;
		// 코멘트 삭제를 위해 ${comment.id} 삽입
		commentList.prepend(content); // 앞에 붙이기
		commentInput.val("");
	}).fail(error=>{
	    console.log("댓글 쓰기 오류:",error);
		console.log("오류 내용: ",error.responseJSON.data.content);
	    alert(error.responseJSON.message+" : "+error.responseJSON.data.content);
	});

}

// 댓글 삭제
function deleteComment(commentId) {
	$.ajax({
		type: "DELETE",
		url: "/api/comment/" + commentId,
		dataType: "json"
	}).done(res => {
	    console.log("댓글 삭제: delete commentId => ",commentId);
	    console.log("#storyCommentItem-${commentId}.remove() : #storyCommentItem-? => ",$(`#storyCommentItem-${commentId}`));
		$(`#storyCommentItem-${commentId}`).remove();
	}).fail(error=>{
	    console.log("댓글 삭제 오류",error);
	});
}


function commentShowAll(imageId){
	let imageid="."+imageId;
	console.log("@@ imageid=",imageid);
	//document.querySelector(".image147").style.display = "none";
	const comments=document.querySelectorAll(imageid);
	//document.querySelectorAll(imageid).style.display = "block";
	console.log("@@ comments=",comments);

	for(let i=0;i<comments.length;i++){
		const item=comments.item(i);
		const style=comments.item(i).style.display;
		console.log("@@ style = comments.item(i).style.display=",style);

		if(style=='none'){
			item.style.display="block";
		}else if(style=='block'){
			item.style.display="none";
		}else{
			console.log("error: check style.display value~~");
		}
		console.log("@@ item.style.display=",item.style.display);
		//item.style.border="1px solid #ff0000";
	}
}

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

// for YouTube
{
	<!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
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
				'controls': 1,
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
function replaceBrTag1(str) {
	if (str == undefined || str == null)
	{
		return "";
	}
	str = str.replace(/\r\n/ig, '<br>');
	str = str.replace(/\\n/ig, '<br>');
	str = str.replace(/\n/ig, '<br>');
	return str;
}
function replaceBrTag(str) {
	if (str == undefined || str == null)
	{
		return "";
	}
	str = str.replace(/\r\n/ig, '<br>');
	str = str.replace(/\\n/ig, '<br>');
	str = str.replace(/\n/ig, '<br>');
	str = str.replace(/'/g, "&apos;");
	str = str.replace(/"/g, "&quot;");
	str = str.replace(/ /g, '&nbsp;');
	return str;
}
function commentShowAll(imageId){
	let imageid="."+imageId;
	console.log("@@ imageid=",imageid);
	//document.querySelector(".image147").style.display = "none";
	const comments=document.querySelectorAll(imageid);
	//document.querySelectorAll(imageid).style.display = "block";
	console.log("@@ comments=",comments);

	for(let i=0;i<comments.length;i++){
		const item=comments.item(i);
		const style=comments.item(i).style.display;
		console.log("@@ style = comments.item(i).style.display=",style);

		if(style=='none'){
			item.style.display="block";
		}else if(style=='block'){
			item.style.display="none";
		}else{
			console.log("error: check style.display value~~");
		}
		console.log("@@ item.style.display=",item.style.display);
		//item.style.border="1px solid #ff0000";
	}
}

function toggleLoop(imageid) {
	//alert(imageid);
	let contentId = "content"+imageid;
	let btnLoopId="#btnLoop"+imageid;
	let txtBtn=$(btnLoopId).text();
	//alert("contentId="+contentId+",txtBtn="+txtBtn);
	if (txtBtn==='once'){
		document.getElementById(contentId).setAttribute('loop',''); // loop 속성 추가
		$(btnLoopId).text("loop"); // loop 면 unloop
		//$(contentId).attr("loop","");
		//$(contentId).removeAttr("loop");
	}else if(txtBtn==='loop'){
		document.getElementById(contentId).removeAttribute('loop',''); // loop 속성 제거
		$(btnLoopId).text("once"); // unloop 면 loop
	}
}
function toggleControls(imageid) {
	//alert(imageid);
	let contentId = "content"+imageid;
	let btnControlsId="#btnControls"+imageid;
	let txtBtn=$(btnControlsId).text();
	//alert("contentId="+contentId+",txtBtn="+txtBtn);
	if (txtBtn==='controls'){
		document.getElementById(contentId).setAttribute('controls',''); // 속성 추가
		$(btnControlsId).text("controls view"); // loop 면 unloop
	}else if(txtBtn==='controls view'){
		document.getElementById(contentId).removeAttribute('controls',''); //  속성 제거
		$(btnControlsId).text("controls"); // unloop 면 loop
	}
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