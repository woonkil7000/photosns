/**
	2. 스토리 페이지
	(1) 스토리 로드하기
	(2) 스토리 스크롤 페이징하기
	(3) 좋아요, 안좋아요
	(4) 댓글쓰기, 댓글삭제
 */

let page = 0;

let principalId = $("#principalId").val(); // input hidden value
let principalUsername = $("#principalUsername").val();

function storyLoad() {
  // ajax로 Page<Image> 가져올 예정 (3개)
  $.ajax({
    type: "get",
    url: `/api/image2?page=${page}`,
    dataType: "json",
  }).done((res) => {
	console.log("############### /api/image?page return responseEntity pages => "+JSON.stringify(res));
	console.log("-------------------------- res -end- -------------------------------");
    //res.data.forEach((image)=>{ // List로 받을때
    res.data.content.forEach((image)=>{ // Page로 받을때
        let storyItem = getStoryItem(image);
		console.log("#### storyItem ####  = getStoryItem(image) => ",storyItem);
		console.log("------------------------- forEach -end- --------------------------------");
        $("#storyList").append(storyItem);
    });
//    let images = res.data.content;
//    images.forEach((image) => {
//      let storyItem = getStoryItem(image);
//      $("#storyList").append(storyItem);
//    });
  }).fail(error=>{
    console.log("오류",error);
  });
}

storyLoad();

// 스토리 스크롤 페이징하기
$(window).scroll(() => {

    //console.log("문서의 높이",$(document).height());
    //console.log("윈도우 스크롤 탑",$(window).scrollTop());
    //console.log("윈도우 높이",$(window).height());

    let checkNum = ($(document).height() - $(window).scrollTop() - $(window).height());
    //console.log("checkNum="+checkNum);

  // 근사치 계산
  if (checkNum < 10 && checkNum > -1) {
    page++;
    storyLoad();
  }
});

function isFileImage(file) {
	const acceptedImageTypes = ['image/gif', 'image/jpeg', 'image/png','image/jpg','image/JPG'];

	return file && acceptedImageTypes.includes(file['type'])
};


function getStoryItem(image) {
  let result = `
<!--전체 리스트 아이템-->
<div class="story-list__item">
	<!--리스트 아이템 헤더영역-->
	<div class="sl__item__header">
		<div><img class="profile-image" src="/upload/${image.user.profileImageUrl}" alt=""  onerror="this.src='/images/person.jpeg'"/></div>
		<div><span style="font-size: 18px; color: Dodgerblue;">${image.user.name} <a href="/user/${image.user.id}"><i class="far fa-user"></i></a></span></div>
	</div>
	<!--헤더영역 end-->

	<!--게시물이미지 영역-->
	<!-- <div class="sl__item__img"> -->
	<!-- <div class="col-md-5 px-0"> -->
	<div class="sl__item__img">
		<!-- <img src="/upload/${image.postImageUrl}" class="rounded mx-auto d-block"  class="img-fluid" alt="" /> -->
		`;


  result +=`<img src="/upload/${image.postImageUrl}" alt=""/>`;

  result +=`
    </div>

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
		</div>
		<!-- 하트모양 버튼 박스 end -->

		<!--좋아요-->
		<span class="like">좋아요 <b id="storyLikeCount-${image.id}">${image.likeCount}</b></span>
		<!--좋아요end-->

		<!--태그박스-->
		<div class="sl__item__contents__tags">
			<p> `;

  image.tags.forEach((tag) => {
    result += `#${tag.name} `;
  });

  result += `			
			</p>
		</div>
		<!--태그박스end-->

		<!--게시글내용-->
		<div class="sl__item__contents__content">
			<p>${image.caption}</p>
		</div>
		<!--게시글내용end-->


		<!-- 댓글 박스 시작 -->
		<div id="storyCommentList-${image.id}">
		`;

		<!--  ####################### 댓글 목록 반복문  시작 ############################# -->

  image.comments.forEach((comment) => {
    result += `	<div class="sl__item__contents__comment" id="storyCommentItem-${comment.id}">
			    <p>
			      <b>${comment.user.name} :</b>
			      ${comment.content}
			    </p>
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
			    <p>
			      <b>${comment.user.name} :</b> ${comment.content}
			    </p>
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






