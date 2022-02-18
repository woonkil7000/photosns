/**
	2. 스토리 페이지
	(1) 스토리 로드하기
	(2) 스토리 스크롤 페이징하기
	(3) 좋아요, 안좋아요
	(4) 댓글쓰기, 댓글삭제
 */

//const mime = require("mime");
let isNoData=1; // init value: true. still no Data.
let DataFailed=0; // 데이타 로딩 실패. init value: False
let page = 0;
let totalPage=0;
let currentPage=0;
let appendFlag=0;

let principalId = $("#principalId").val(); // input hidden value
let principalUsername = $("#principalUsername").val();

function storyLoad() {
  // ajax로 Page<Image> 가져올 예정 (3개)
  $.ajax({
    type: "get",
    url: `/api/image2?page=${page}`,
    dataType: "json",
  }).done((res) => {
	  isNoData=0; // noData: 0:false. is Be Data.
	  console.log("## res=",res); // ##### 사용하지 말것! 이렇게 ==> console.log("## res="+res);
	//console.log("############### /api/image?page return responseEntity pages => "+JSON.stringify(res));
	//console.log("-------------------------- res -end- -------------------------------");

	  totalPage = res.data.totalPages; // 전체 페이지
	  currentPage = res.data.pageable.pageNumber; // 현재 페이지 0부터 시작:
    //res.data.forEach((image)=>{ // List로 받을때
	  console.log("======================= res.data.totalPages =",res.data.totalPages);
	  console.log("======================= currentpage : res.data.pageable.pageNumber =",res.data.pageable.pageNumber);
	  //console.log("#### file = ",res.data.content)

	  res.data.content.forEach((image)=>{ // Page로 받을때
        let storyItem = getStoryItem(image);
		console.log("#### storyItem ####  = \"getStoryItem(image)\" ==> ",storyItem);
		//console.log("#### res.data.content.forEach((image) storyItem = \"getStoryItem(image)\" storyItem => "+JSON.stringify(storyItem));
		console.log("------------------------- forEach -end- --------------------------------");
        $("#storyList").append(storyItem);
    });
//    let images = res.data.content;
//    images.forEach((image) => {
//      let storyItem = getStoryItem(image);
//      $("#storyList").append(storyItem);
//    });
  }).fail(error=>{
	  DataFailed=1;
	  console.log("오류",error);
	console.log("오류 내용: ",error.responseJSON.message);

	  // 비동기 방식이라서  ajax 안으로 구문 이동시켜야함.
	  console.log("isNoData=",isNoData);
	  console.log("DataFailed=",DataFailed);
	  if(isNoData==1 && DataFailed==1){ // 데이터도 없고 데이타 로딩을 실패했을때
		  let storyItem = "<div><p> </p><p> </p><p> </p><span style=\"font-size: 13px; color: Dodgerblue;\">" +
			  ": : : : : 이미지가 없습니다 : : : : :</p>";
		  //$("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
		  //document.write(storyItem);
		  //history.back();
		  // window.location.replace("/");
		  // location.href=`/user/${userId}`;
		  $("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
	  }
  });

} // storyLoad()

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
  if (checkNum < 1 && checkNum > -1 && (page <= totalPage-1)) {
    storyLoad();
	  page++;
  }
  if ((currentPage==totalPage-1) && appendFlag==0 && isNoData==0){
	  appendFlag=1;
	  // append. no more date message.
	  let storyItem = "<div><span style=\"font-size: 13px; color: Dodgerblue;\">" +
		  ": : : : : 더이상 이미지가 없습니다 : : : : :</p>";
	  $("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
	}

});





/** 이미지 비율 유지하면 크기 정하기
 * Conserve aspect ratio of the original region. Useful when shrinking/enlarging
 * images to fit into a certain area.
 *
 * @param {Number} srcWidth width of source image
 * @param {Number} srcHeight height of source image
 * @param {Number} maxWidth maximum available width
 * @param {Number} maxHeight maximum available height
 * @return {Object} { width, height }
 */
function calculateAspectRatioFit(srcWidth, srcHeight, maxWidth, maxHeight) {

	let ratio = Math.min(maxWidth / srcWidth, maxHeight / srcHeight);

	return { width: srcWidth*ratio, height: srcHeight*ratio };
}


function getStoryItem(image) {

	//let file=`/upload/${image.user.profileImageUrl}`;

	//let file=`${image.user.profileImageUrl}`;
	//let mediaTag2 = matchMedia(file);
	//let mediaTag  = file.contentType();
	//console.log("============================================== mediaType =",mediaTag);
	//console.log("============================================== mediaType2 =",mediaTag2);

	console.log("======================== image.contentType ={} =================================",);

	<!-- Get Content Type -->
	let contentType=`${image.contentType}`;
	contentType=contentType.substring(0,5)
	let pathUrl=`/upload/${image.postImageUrl}`;

	function fnContentType(contentType,pathUrl){
		let contentTag;

		if (contentType=='image'){ // image
			contentTag="<img  src='" +pathUrl+ "' style='max-height:100%;max-width:100%' alt='이미지' />";
			console.log("=============== image ===================");
		}else if(contentType=='video'){ // video
			contentTag="<video controls muted autoplay src='" +pathUrl+ "' style='max-height:100%;max-width:100%' alt='이미지' />";
			console.log("=============== video ===================");
		}else{ // 현재 DB 에 contentType 값이 없는 기존 image Data 가 있어서.
			contentTag="<img src='" +pathUrl+ "' style='max-height:100%;max-width:100%' alt='이미지'/>";
			console.log("=============== etc => image ===================");
		}
		console.log("======================== contentTag ={} =================================",contentTag);
		return contentTag;
	}
	<!-- Get Content Type end  -->

  let result = `
<!--전체 리스트 아이템-->
<div class="story-list__item">
	<!--리스트 아이템 헤더영역-->
	<div class="sl__item__header">
		<div>`;

  	//result += mediaTag + ` class="profile-image" src="/upload/${image.user.profileImageUrl}" alt=""  onerror="this.src='/images/noimage.jpg'"/>`;

	// 사용자 프로필 이미지
	result += `<img class="profile-image" src="/upload/${image.user.profileImageUrl}" alt=""  onerror="this.src='/images/noimage.jpg'"/>`;

result +=`		</div>
		<div><span style="font-size: 18px; color: Dodgerblue;">${image.user.name} <a href="/user/${image.user.id}"><i class="far fa-user"></i></a></span></div>
	</div>
	<!--헤더영역 end-->

	<!--게시물이미지 영역-->
	<!-- <div class="sl__item__img"> -->
	<!-- <div class="col-md-5 px-0"> -->
	<div >
		<!-- <img src="/upload/${image.postImageUrl}" class="rounded mx-auto d-block"  class="img-fluid" alt="" /> -->
		`;



  result +=`
<!-- ####################### 이미지 모달 링크 ###################### -->
<a   class="btn btn-outline-primary btn-sm"
 data-bs-toggle="modal"
 data-bs-target="#image-modal"
 data-bs-imageid="${image.id}"
 data-bs-imageurl="${image.postImageUrl}"
 data-bs-caption="${image.caption}" 
 data-bs-userid="${image.user.id}" 
 data-bs-contentTag="${fnContentType(contentType,pathUrl)}"    
 href="#" 
 role="button" style="outline: none;border: 0;">
`;

  		//fnContentType(contentType,pathUrl);
		// #### || 게시물 이미지 테크 위치  ||  #### <img src=''> #### contentTag ####
  result += fnContentType(contentType,pathUrl)
  			//<img src="/upload/${image.postImageUrl}" style="max-height: 100%; max-width: 100%" alt="이미지"/>

	result +=`</a>
<!-- ####################### 이미지 모달 링크 end ###################### -->

`;



  result +=`
    </div>
	<!-- 게시물 이미지 영역 end -->

	<!--게시물 내용 + 댓글 영역-->
	<div class="sl__item__contents">
		<!-- 하트모양 버튼 박스 -->
		<div class="sl__item__contents__icon"> `;

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
		<!--좋아요-->
		<span class="like">좋아요 <b id="storyLikeCount-${image.id}">${image.likeCount}</b></span>
		<!--좋아요end-->
		</div>
		<!-- 하트모양 버튼 박스 end -->

		<!--태그박스-->
		<div class="sl__item__contents__tags">
			`;

  image.tags.forEach((tag) => {
    result += `#${tag.name} `;
  });

  result += `			
		</div>
		<!--태그박스end-->

		<!--게시글내용-->
		<div class="sl__item__contents__content">
			<span style="font-size: 18px; color: Dodgerblue;">${image.caption}</span>
		</div>
		<!--게시글내용end-->

		<!-- 댓글 박스 시작 -->
		<div id="storyCommentList-${image.id}">
		`;
		<!--  ####################### 댓글 목록 반복문  시작 ############################# -->
  image.comments.forEach((comment) => {
    result += `	<div class="sl__item__contents__comment" id="storyCommentItem-${comment.id}">
			     ${comment.user.name}: ${comment.content}
  				`;

    if (principalId == comment.user.id) {
      result += `
  				    <button onClick="deleteComment(${comment.id})"><i class="fas fa-times"></i></button>
  				`;
    }

    result += `
			  </div>`;
  });

  result += `
		</div>
		<!-- 댓글 박스 끝 -->
		<!--  ########################  댓글 목록 반복문 끝   ################################# -->
		<!--댓글입력박스-->
		<!-- <div class="sl__item__input"> -->
		<div class="sl__item__input">
			<input type="text" placeholder="댓글 달기..." id="storyCommentInput-${image.id}" />
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
			  <div class="sl__item__contents__comment" id="storyCommentItem-${comment.id}"> 
			      ${comment.user.name}: ${comment.content}
			    <button onClick="deleteComment(${comment.id})"><i class="fas fa-times"></i></button>
			  </div>
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





