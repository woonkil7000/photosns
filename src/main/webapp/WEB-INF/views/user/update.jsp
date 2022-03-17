<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ include file="../layout/header.jsp" %>

        <!--프로필셋팅 메인-->
        <main class="main">
            <!--프로필셋팅 섹션-->
            <section class="setting-container">
                <!--프로필셋팅 아티클-->
                <article class="setting__content">

                    <!--프로필셋팅 아이디영역-->
                    <div class="content-item__01">
                        <div class="item__img"><img src="/upload/${principal.user.profileImageUrl}" alt=""
                                onerror="this.src='/images/noimage.jpg'" /></div>
                        <div class="item__username">
                            <h2>${fn:substring(principal.user.username,0,12)}</h2>
                        </div>
                    </div>
                    <!--프로필셋팅 아이디영역end-->

                    <!--프로필 수정-->
                    <!--
                    <form id="profileUpdate" onsubmit="update(${principal.user.id}, event)">
                    -->
                    <form id="profileUpdate">
                        <div class="content-item__02">
                            <div class="item__title">이름</div>
                            <div class="item__input">
                                <input type="text" name="name" placeholder="이름" value="${principal.user.name}">
                            </div>
                        </div>
                        <div class="content-item__03">
                            <div class="item__title">ID</div>
                            <div class="item__input">
                                <input type="text" name="username" placeholder="유저네임" value="${fn:substring(principal.user.username,0,12)}"
                                    readonly="readonly" /> <%--${fn:substring(dto.user.username,0,15)}--%>
                            </div>
                        </div>
                        <div class="content-item__04">
                            <div class="item__title">패스워드</div>
                            <div class="item__input">
                                <input type="password" name="password" placeholder="패스워드" />
                            </div>
                        </div>
                        <div class="content-item__05">
                            <div class="item__title">웹사이트</div>
                            <div class="item__input">
                                <input type="text" name="website" placeholder="웹 사이트"
                                    value="${principal.user.website}" />
                            </div>
                        </div>
                        <div class="content-item__06"> 
                            <div class="item__title">소개</div>
                            <div class="item__input">
                                <textarea name="bio" id="" rows="3">${principal.user.bio}</textarea>
                            </div>
                        </div>
                        <div class="content-item__07">
                            <div class="item__title"></div>
                            <div class="item__input"></div>
                        </div>
                        <div class="content-item__08">
                            <div class="item__title">이메일</div>
                            <div class="item__input">
                                <input type="text" name="email" placeholder="이메일" value="${principal.user.email}"
                                    readonly="readonly" />
                            </div>
                        </div>
                        <div class="content-item__09">
                            <div class="item__title">전회번호</div>
                            <div class="item__input">
                                <input type="text" name="phone" placeholder="전화번호" value="${principal.user.phone}" />
                            </div>
                        </div>
                        <div class="content-item__10">
                            <div class="item__title">성별</div>
                            <div class="item__input">
                                <input type="text" name="gender" value="${principal.user.gender}" />
                            </div>
                        </div>

                        <!--제출버튼-->
                        <div class="content-item__11">
                            <div class="item__title"></div>
                            <div class="item__input">
                                <button type="button" onclick="update(${principal.user.id})">제출</button>
                            </div>
                        </div>
                        <!--제출버튼end-->

                    </form>
                    <!--프로필수정 form end-->
                </article>
            </section>
        </main>

        <script language="JavaScript" src="/js/update.js" charset='UTF-8'></script>

        <%@ include file="../layout/footer.jsp" %>