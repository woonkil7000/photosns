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
					<div><a href="">
						<img src="/upload/${image.postImageUrl}" alt="">
					</a>
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

<%@ include file="../layout/footer.jsp"%>

