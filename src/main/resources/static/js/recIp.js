const detectDeviceType = () =>
    /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
        navigator.userAgent
    )
        ? "모바일"
        : "데스크톱";
//console.log("*********************************** ",detectDeviceType());

function recIp(page) {

    let devicetype = detectDeviceType();
    let Ipip;
    let apiKey = '25864308b6a77fd90f8bf04b3021a48c1f2fb302a676dd3809054bc1b07f5b42';
    $.getJSON('https://api.ipinfodb.com/v3/ip-city/?format=json&key=' + apiKey, function(data) {
        //console.log("*************************************** ipinfodb JSON.stringify(data)=",JSON.stringify(data, null, 2));
        //console.log("*************************************** ipinfodb data.ipAddress=",data.ipAddress);
        //console.log("*************************************** ipinfodb ##inner side## getIp=",getIp);
        getIpip(data.ipAddress);
    });
    function getIpip(value){
        localStorage.setItem("ipip",value);
    }
    Ipip=localStorage.getItem("ipip");

    //console.log("************************************** JSON.stringify(Ipip)=",JSON.stringify(Ipip));
    //console.log("*************************************** ipinfodb ##out side## Ipip=",Ipip);
    //const deepCopy = (obj) => JSON.parse(JSON.stringify(obj));

    //console.log("************************************** ipdata=",JSON.parse(JSON.stringify(ipdata)));
    //alert(getIpAddress());
    //let commentList = $(`#storyCommentList-${imageId}`);
    let data = {
        ip: Ipip,
        pageUrl: page,
        device: devicetype
        //content: commentInput.val()
    }
    //console.log("@@@@@@@@@@@@@@@@@@@@@@@@ addVisitor() data={ ip: ,pageUrl: }",data);
    // console.log(JSON.stringify(data));
    // return;

    // 통신 성공하면 아래 prepend 되야 되고 ID값 필요함
    $.ajax({
        type: "POST",
        //url: "/image/${imageId}/comment",
        url: "/api/visitor",
        data: JSON.stringify(data),
        //contentType: "plain/text; charset=utf-8",
        contentType: "application/json;charset=utf-8",
        dataType: "json" //응답 받을때
    }).done(res => {
        console.log(" ip ok ");
        //console.log(" record ipaddress ok: ",res);
    }).fail(error=>{
        console.log("댓글 쓰기 오류:",error);
        console.log("오류 내용: ",error.responseJSON.data.content);
        //alert(error.responseJSON.message+" : "+error.responseJSON.data.content);
    });
}
// 방문기록 ip 쓰기
recIp(window.location.href);