// 회원정보 수정
function update(userId){

    let data=$("#profileUpdate").serialize();
    console.log(data);
    $.ajax({
        type:"put",
        url:`/api/user/${userId}`,
        data: data,
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        dataType:"json"
    }).done(res=>{ //HttpStatus 상태코드가 200번대 일때
        console.log("update success....성공");
        //location.href = "/user/" + userId;
        location.href = `/user/${userId}`;
    }).fail(error=>{ //HttpStatus 상태코드가 200번대가 아닐때
        console.log("update failed....실패");
        console.log(error);
        if(error.data==null){
            alert(error.responseJSON.message);
        }else{
            alert(JSON.stringify(error.responseJSON.data));
        }
    });
}
/*
function update(userId, event) {

  event.preventDefault();
  let data = $("#profileUpdate").serialize();


  $.ajax({
    type: "put",
    url: "/user/" + userId,
    data: data,
    contentType: "application/x-www-form-urlencoded; charset=utf-8",
    dataType: "json",
  }).done(res => {
    console.log("put 성공",res)
    //location.href = "/user/" + userId;
  }).fail(error => {
    console.log("put 실패",error)
    //location.href = "/user/" + userId;
  });
}*/
