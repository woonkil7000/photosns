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

/*async function storyLoad() {
	console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ page="+page)
	let response = await fetch(`/api/image?page=${page}`)
		.then((response) => {
			if (!response.ok) { //////////////////// 에러 처리
				throw new Error('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 400 아니면 500 에러남')
				console.log('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 400 아니면 500 에러남')
			}
			return response.json()
		})
		.then((res) => {
			console.log(res.data)
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ if OK @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ok page=",page);
			isNoData=0; // noData: 0:false. is Be Data.
			console.log("## res=",res); // ##### 사용하지 말것! 이렇게 ==> console.log("## res="+res);
			//console.log("############### /api/image?page return responseEntity pages => "+JSON.stringify(res));
			//console.log("-------------------------- res -end- -------------------------------");
			totalPage = res.data.totalPages; // 전체 페이지
			currentPage = res.data.pageable.pageNumber; // 현재 페이지 0부터 시작:
			isLastPage=res.data.last;
			console.log("######################################## PAGE ##########################################################");
			console.log("######################################## PAGE ##########################################################");
			console.log("/////////////////// page  ############ page++ [from 0]=",page);
			console.log("/////////////////// totalPages ############ res.data.totalPages =",res.data.totalPages);
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ currentpage [from 0]=  pageNumber=",res.data.pageable.pageNumber);
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ isLastPage? @@@@@@@@@@@@@@@@@@@@@@@@@@@@ ",isLastPage);
			//console.log("#### file = ",res.data.content)

			//res.data.forEach((image)=>{ // List로 받을때
			res.data.content.forEach((image)=>{ // Page로 받을때

				let storyItem = getStoryItem(image);
				////////// [프로필이미지] [작성자 이름] [이미지] [좋아요 카운트] [댓글]
				/////////////// getStoryItem() 함수 호출

				console.log("#### storyItem ####  = \"getStoryItem(image)\" ==> ",storyItem);
				//console.log("#### res.data.content.forEach((image) storyItem = \"getStoryItem(image)\" storyItem => "+JSON.stringify(storyItem));
				console.log("------------------------- forEach -end- --------------------------------");
				$("#storyList").append(storyItem);
			});
			page++;

			/////////////////////////////////////// if OK -END-  /////////////////////////////////////////////
		})
		.catch(() => { /////////////////////// 에러 처리

			DataFailed=1;
			console.log('에러 남')
			console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  if failed  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
			console.log("오류",error);
			console.log("오류 내용: ",error.responseJSON.message);
		});
	//////////////////////////////////////// if failed -END- //////////////////////////////////////////////

	// 비동기 방식이라서  구문 안으로 이동시켜야함.
	console.log("isNoData=",isNoData);
	console.log("DataFailed=",DataFailed);
	if(isNoData==1 && DataFailed==1){ // 이미지 데이타가 하나도 없을대 //데이터도 없고 데이타 로딩을 실패했을때
		let storyItem = "<div><p> </p><p> </p><p> </p><span style=\"font-size: 13px; color: Dodgerblue;\">" +
			": : : : : 이미지가 없습니다 : : : : :</p>";
		//$("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
		//document.write(storyItem);
		//history.back();
		// window.location.replace("/");
		// location.href=`/user/${userId}`;
		$("#storyList").append(storyItem); // id=#storyList <div> 에 이어 붙이기
	}


} // new storyLoad() -END-*/


function storyLoad() {
  // ajax로 Page<Image> 가져올 예정 (3개)
  $.ajax({
    type: "get",
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
  if ((checkNum < 1000 && checkNum > -1)  && storyLoadUnlock && (page <= totalPage-1)) {

	  storyLoad();
	  storyLoadUnlock=false;
	  //console.time("X");
	  //console.timeStamp("시작 시간");
	  setTimeout(function(){
		  storyLoadUnlock=true; // 2초후 허용
		  // console.log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ timer 2초후 허용함 storyLoadUnlock=",storyLoadUnlock);
		  // console.timeEnd("X");
		  // console.timeStamp("종료 시간");
	  },1000)

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

	function fnContentType(contentType,pathUrl){
		let contentTag;

		if (contentType=='image'){ // image
			contentTag="<img width='340' src='" +pathUrl+ "' style='max-height:100%;max-width:100%' alt='이미지' />";
			console.log("=============== image ===================");
		}else if(contentType=='video'){ // video
			contentTag="<video width='340' playsinline controls loop preload='auto' src='" +pathUrl+ "#t=0.1' style='max-height:100%;max-width:100%' alt='이미지' />";
			console.log("=============== video ===================");
		}else if(contentType=='youtu'){ // youtube
			contentTag ="<iframe width='325' height='250' src='https://youtube.com/embed/"+pathUrl+"' frameborder='0' allowfullscreen " +
				" style='max-height:100%;max-width:100%' alt='유튜브'></iframe>";
			console.log("=============== YouTube ===================");
		}else{ // 현재 DB 에 contentType 값이 없는 기존 image Data 가 있어서.
			contentTag="<img width='340' src='" +pathUrl+ "' style='max-height:100%;max-width:100%' alt='이미지'/>";
			console.log("=============== etc => image ===================");
		}
		console.log("======================== contentTag ={} =================================",contentTag);
		return contentTag;
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
	<div class="card-body">
		`;

	result +=`
	<!-- ####################### 이미지 모달 링크 ###################### -->
	`;

	/////////////// contentType이 이미지인 경우만 <a tag 시작부 삽입 ////////////////////
	function before_atag(){
		let atag;
		if(contentType=='image'||contentType=='null' || contentType==''){

			atag =` <a   class='btn btn-outline-primary btn-sm' `;
			atag +=` data-bs-toggle='modal' `;
			atag +=` data-bs-target='#image-modal' `;
			atag +=` data-bs-imageid='${image.id}' `;
			atag +=` data-bs-imageurl='${image.postImageUrl}' `;
			atag +=` data-bs-caption='${image.caption}' `;
			atag +=` data-bs-userid='${image.user.id}' `;
			atag +=` data-bs-contentTag="${fnContentType(contentType,pathUrl)}" `;
			atag +=` href='#' `;
			atag +=` role='button' style='outline: none;border: 0;'>`;
		}else{
			atag = "";
		}
		return atag;
	}
	//////////////// contentType이 이미지인 경우만 <a  tag 시작부 삽입 -END- ///////////////////

	/////////////// contentType이 이미지인 경우만 </a tag 종료부 삽입 ////////////////////
	function after_atag(){
		let atag;
		if(contentType=='image' || contentType=='null'||contentType=='') {
			atag = "</a>";
		}else{
			atag = "";
		}
		return atag;
	}
	/////////////// contentType이 이미지인 경우만 </a tag 삽입종료부 -END- ////////////////////

	// fnContentType(contentType,pathUrl);
	// #### || 게시물 이미지/동영상 테크 위치  ||  #### <img src=''> or <video> #### contentTag ####

	result += before_atag();

	result += fnContentType(contentType,pathUrl);
	//<img src="/upload/${image.postImageUrl}" style="max-height: 100%; max-width: 100%" alt="이미지"/>
	result += after_atag();

	result +=`<!-- </a> -->
		<!-- /////////////// contentType이 이미지인 경우만 <a> tag 삽입 //////////////////// -->`;

	result +=` 
<!-- ####################### 이미지 모달 링크 end ###################### -->

`;

	result +=`	
			</div>
    <div class="card-title pb-3 px-2 align-items-lg-start">
			<span style="font-size: 17px; color: Dodgerblue;padding-left: 5px;"><b>${caption}</b></span>
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
		<span class="like" id="storyLikeCount-${image.id}">좋아요${image.likeCount}</span>
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
			  <div class="sl__item__contents__comment" id="storyCommentItem-${comment.id}"> 
			      <div style="text-align: left;"><a href="/user/${comment.user.id}">
				<img  style="border-radius: 50%;" height="22" width="22" src="/upload/${comment.user.profileImageUrl}" alt=""  onerror="this.src='/images/noimage.png'"/>
				</a>${comment.content}
				</div>
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

function replaceBrTag(str) {
	if (str == undefined || str == null)
	{
		return "";
	}
	str = str.replace(/\r\n/ig, '<br>');
	str = str.replace(/\\n/ig, '<br>');
	str = str.replace(/\n/ig, '<br>');
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

