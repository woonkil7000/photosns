<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp"%>
					<%--------------------------- 이미지 리스트 루프 ------------------------------------------%>
<c:forEach var="image" items="${dto.user.images}">  <%-- EL 표현식에서 변수명을 적으면 get함수가 자동으로 호출됨. --%>

  <div class="img-box" id="${image.id}">
      <c:choose>
        <%-- 프로필 페이지의 주인일 때 --%>
        <c:when test="${dto.pageOwnerState}">

          <%-- ///////////////////// String contentTag: 삽입할 미디어 테그 결정 <img  or  <video  /////////////////////--%>
          <c:set var="contentType" value="${image.contentType.substring(0,5)}"/>
          <c:set var="pathUrl" value="/upload/${image.postImageUrl}"/>
          <c:choose>
            <c:when test="${contentType eq 'youtu'}">
              <c:set var="pathUrl" value="${image.postImageUrl}"/>
            </c:when>
          </c:choose>
          <c:set var="contentTag" value=""/>
          <c:set var="contentTag2" value=""/>
          <c:choose>
            <c:when test="${contentType=='image'}">
              <c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
              <c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
            </c:when>
            <c:when test="${contentType=='video'}">
              <c:set var="contentTag" value="<video preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
              <c:set var="contentTag2" value="<video playinline controls loop preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
            </c:when>
            <c:when test="${contentType=='youtu'}">
              <c:set var="contentTag" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='0' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
              <c:set var="contentTag2" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='0' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
            </c:when>
            <c:otherwise>
              <c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
              <c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
            </c:otherwise>
          </c:choose>

          <%-- /////////////////////  String contentTag: 삽입할 미디어 테그 결정 img or video  -END-  /////////////////////--%>

          <%-- ####################### 이미지 링크 ###################### --%>

          <a   class="btn btn-outline-primary btn-sm"
               data-bs-toggle="modal"
               data-bs-target="#delete-modal"
               data-bs-imageid="${image.id}"
               data-bs-imageurl="${image.postImageUrl}"
               data-bs-userid="${principal.user.id}"
               data-bs-caption="${image.caption}"
               data-bs-contentTag="${contentTag2}"
               href="#"
               role="button" style="outline: none;border: 0;">
              ${contentTag}

              <%--//////////// contentTag2 는 video 속성 controls 추가됨 //////////////--%>
          </a>

          <%-- ####################### 이미지 링크 ###################### --%>

        </c:when>
        <%-- 프로필 페이지 주인일 때 pageOwnerState -END- --%>

        <%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  페이지 주인일때 아닐때 구분  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>

        <%-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  페이지 주인일때 아닐때 구분  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ --%>

        <%-- 페이지 주인이 아닐때 start --%>
        <c:otherwise>
          <%-- ####################### 페이지 주인이 아닐때 링크 테그 start ###################### --%>
          <%-- ///////////////////// String contentTag: 삽입할 미디어 테그 결정 <img  or  <video  ///////////////////// --%>
          <c:set var="contentType" value="${image.contentType.substring(0,5)}"/>
          <c:set var="pathUrl" value="/upload/${image.postImageUrl}"/>
          <c:choose>
            <c:when test="${contentType eq 'youtu'}"> <%-- substring => youtu --%>
              <c:set var="pathUrl" value="${image.postImageUrl}"/>
            </c:when>
          </c:choose>
          <c:set var="contentTag" value=""/>
          <c:set var="contentTag2" value=""/>
          <c:choose>
            <c:when test="${contentType=='image'}">
              <c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
              <c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
            </c:when>
            <c:when test="${contentType=='video'}">
              <c:set var="contentTag" value="<video preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
              <c:set var="contentTag2" value="<video playinline controls preload='metadata' src='${pathUrl}#t=0.1' style='max-height:100%;max-width:100%' alt='동영상'/>"/>
            </c:when>
            <c:when test="${contentType=='youtu'}">
              <c:set var="contentTag" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='0' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
              <c:set var="contentTag2" value="<iframe src='https://www.youtube.com/embed/${pathUrl}' frameborder='0' allowfullscreen style='max-height:100%;max-width:100%' alt='유튜브'></iframe>"/>
            </c:when>
            <c:otherwise>
              <c:set var="contentTag" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
              <c:set var="contentTag2" value="<img src='${pathUrl}' style='max-height:100%;max-width:100%' alt='이미지'/>"/>
            </c:otherwise>
          </c:choose>

          <%-- /////////////////////  String contentTag: 삽입할 미디어 테그 결정 <img or <video  -END-  /////////////////////--%>

          <%-- ####################### 이미지 <a href=""> 모달창 링크 ###################### --%>

          <a class="btn btn-outline-primary btn-sm"
             data-bs-toggle="modal"
             data-bs-target="#delete-modal"
             data-bs-imageid="${image.id}"
             data-bs-imageurl="${image.postImageUrl}"
             data-bs-userid="${principal.user.id}"
             data-bs-caption="${image.caption}"
             data-bs-contentTag="${contentTag2}"
             href="#"
             role="button" style="outline: none;border: 0;">
              ${contentTag}

              <%-- //////////// contentTag:페이지용, contentTag2: 모달페이지용으로 video 속성 controls 추가됨/ img 는 테그 같음. /////////////--%>
          </a>

          <%-- ####################### 이미지 <a href=""> 모달창 링크 ###################### --%>



          <%-- ####################### 페이지 주인이 아닐때 링크 테그 END ###################### --%>

        </c:otherwise><%-- 페이지 주인이 아닐때 END --%>
      </c:choose>
        <%-- 리스트 하단 사진 설명, 조회수 카운트 --%>
    <div><span style="font-size: 16px; color: Dodgerblue;">${fn:substring(image.caption,0,7)}</span></div>
    <div>
      <span style="font-size: 16px; color: Dodgerblue; padding-right: 16px;"><i class="fas fa-heart"></i> ${image.likeCount}</span>
    </div>
  </div><%-- for each 바로 안쪽 테그. class="img-box"  --%>
</c:forEach>
<%--------------------------- 이미지 리스트 루프 ------------------------------------------%>