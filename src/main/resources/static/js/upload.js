function imageChoose(obj) { // execute when input file selected(onChanged)

	document.querySelector("#idCaution").innerHTML=""; // 주의1 사항 초기화
	document.querySelector("#idCaution2").innerHTML=""; // 주의2 사항 초기화

	var files = obj.files;
	//------ when input file selected // get extensions toLowerCase -------------------------------
	//var fileName = document.querySelector('#fileId').value;
	var fileName = files[0]; // [object file]
	console.log("fileName 1 = "+fileName); // pobject file]
	//--------------------------------------------------------

	//function isImageOrMovie(){ // 이미지 또는 영상 파일일때
	//	var extension = files[0].split('.').pop(); // .pop()
	function isImageOrMovie(){ // 이미지 또는 영상 파일일때
		//let fileName = files.files[0];
		//----------------------------------------------------------------
		var fileName = document.querySelector('#fileId').value;
		//----------------------------------------------------------------

		console.log("fileName 2 = "+fileName); // [undefined]
		var extension = fileName.split('.').pop(); // .pop()
		//extension = extension.toLowerCase();
		console.log("extentsions = "+extension);
		document.querySelector('.output').textContent = fileName+" : "+extension;
		switch (extension.toLowerCase()) {
			case 'jpg':
			case 'jpeg':
			case 'gif':
			case 'bmp':
			case 'png':
			case 'mov':
			case 'mp4':
			case 'avi':
			case 'mpg':
			case 'mpeg':
			case 'm4v':
				//etc
				return true; // 이미지파일!!
		}
		return false; // 이미지 영상 아닐때
	}
	//---------------------------------------------------------------------------------------------
	//------ when input file selected // get files MIME type ---------------------------------------
	var files = obj.files;
	for (var i = 0; i < files.length; i++) {
		var name = files[i].name;
		var type = files[i].type;
		//alert("Filename: " + name + " , Type: " + type);
		console.log("Filename : files[0].name = " + files[0].name + " , Type = " + type);
		console.log("Filename : " + name + " , Type : " + type);
		//Filename: C0002.MP4 , Type: video/mp4
		//Filename: SAM_1218.JPG , Type: image/jpeg
	}
	console.log("Filename: files[0].name = " + files[0].name + " , Type: " + type);
	//----------------------------------------------------------------------------------------------

	let f = obj.files[0];
	let bIsImage=false;
	let bFileSize=false;
	// 사진 / 비디오 인가?
	/*if (!f.type.toLowerCase().match("image.*|video.*")){
		console.log("이 형식의 파일은 지원하지 않습니다.");
		document.getElementById("fileId").value = ""; // input file 초기화
		//alert("이 형식의 파일은 지원하지 않습니다.");
		//window.history.back();
		document.querySelector("#idCaution").innerHTML="이 파일의 형식은 지원하지 않습니다";
		//document.querySelector("#idComment").style.display='none';
		//document.querySelector("#btnSubmit").style.display='none';
		bIsImage=false
		//return false;
	}else{
		bIsImage=true;
	}*/

	// 이미지나 영상 파일인가? //
	if(isImageOrMovie()){
		bIsImage=true;
	}else{
		bIsImage=false;
		document.getElementById("fileId").value = ""; // input file 초기화
		document.querySelector("#idCaution").innerHTML="이 파일의 형식은 지원하지 않습니다";
	}
	console.log("bIsImage? ="+bIsImage);

	// 파일용량이 제한을 초과했는가? //
	if (f.size>400000000){ // 10자리 숫자: 1기가 바이트
		console.log("f.size="+f.size);
		//console.log("파일 용량이 1GB 까지 가능합니다");
		console.log("파일 용량이 400MB 까지 가능합니다");
		document.getElementById("fileId").value = ""; // input file 초기화
		//document.querySelector("#idCaution").innerHTML="파일 용량이 1GB 까지 가능합니다 ";
		document.querySelector("#idCaution2").innerHTML="파일 용량이 400MB 까지 가능합니다 1";
		//document.querySelector("#idComment").style.display='none';
		//document.querySelector("#btnSubmit").style.display='none';
		bFileSize=false;
		//return false;
	}else{
		bFileSize=true;
	}
	console.log("bFileSize? ="+bFileSize);

	if(bIsImage && bFileSize){ //이미지/영상 파일이고 용량이 적당할때
		document.querySelector("#idCaution").style.display='none'; // 워닝
		document.querySelector("#idCaution2").style.display='none'; // 워닝
		document.querySelector("#idComment").style.display='block'; // 파일전송 안내문
		document.querySelector("#btnSubmit").style.display='block'; // 파일 전송 버튼
	}else { // 이미지 영상이 아니거나 용량이 초과할때 아닐때
		document.querySelector("#idCaution2").style.display='block'; // 워닝
		document.querySelector("#idCaution").style.display='block'; // 워닝
		document.querySelector("#idComment").style.display='none'; // 파일전송 안내문
		document.querySelector("#btnSubmit").style.display='none'; // 파일 전송 버튼
	}

	let reader = new FileReader();
	reader.onload = (e) => {
		$("#imageUploadPreview").attr("src", e.target.result);
		//$("#file_type").attr("type", e.target.result);
		//$("#file_size").attr("size", e.target.result);
	}
	reader.readAsDataURL(f); // 이 코드 실행시 reader.onload 실행됨.
}


function getFilename() {
	if (fullPath) {
		var fullPath = document.getElementById('fileId').value;
		var startIndex = (fullPath.indexOf('\\') >= 0 ? fullPath.lastIndexOf('\\') : fullPath.lastIndexOf('/'));
		var filename = fullPath.substring(startIndex);
		if (filename.indexOf('\\') === 0 || filename.indexOf('/') === 0) {
			filename = filename.substring(1);
		}
		console.log("filename="+filename);
		alert(filename);
	}
}

function updateSize() {
	let nBytes = 0,
		oFiles = this.files,
		nFiles = oFiles.length;
	for (let nFileId = 0; nFileId < nFiles; nFileId++) {
		nBytes += oFiles[nFileId].size;
	}
	let sOutput = nBytes + " bytes";
	// optional code for multiples approximation
	const aMultiples = ["KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"];
	for (nMultiple = 0, nApprox = nBytes / 1024; nApprox > 1; nApprox /= 1024, nMultiple++) {
		//sOutput = nApprox.toFixed(3) + " " + aMultiples[nMultiple] + " (" + nBytes + " bytes)";
	}
	// end of optional code
	//let strFileName = oFiles[0].name.toString();
	//console.log(oFiles[0].name.toString());
	var fileName = document.querySelector('#fileId').value;
	document.getElementById("file_num").innerHTML = nFiles;
	document.getElementById("file_size").innerHTML = sOutput;
	document.getElementById("file_type").innerHTML = getExtension(fileName);
}
document.getElementById("fileId").addEventListener("change", updateSize, false);
// 이벤트 리스너. 트리거. input file selected (on Change)


//파일 확장자로 이미지, 비디오 파일 타입 체크하기
function getExtension(filename) {
	var parts = filename.split('.');
	return parts[parts.length - 1];
}

function isImage(filename) {
	var ext = getExtension(filename);
	switch (ext.toLowerCase()) {
		case 'jpg':
		case 'gif':
		case 'bmp':
		case 'png':
		case 'jpeg':
			//etc
			return true;
	}
	return false;
}

function isVideo(filename) {
	var ext = getExtension(filename);
	switch (ext.toLowerCase()) {
		case 'm4v':
		case 'avi':
		case 'mpg':
		case 'mp4':
			// etc
			return true;
	}
	return false;
}


/*$(function() {
	$('form').submit(function () {
		function failValidation(msg) {
			alert(msg); // just an alert for now but you can spice this up later
			return false;
		}

		var file = $('#fileId');
		// var imageChosen = $('#type-1').is(':checked');
		// if (imageChosen && !isImage(file.val())) {
		if (!isImage(file.val())) {
			return failValidation('Please select a valid image');
		} else if (!isVideo(file.val())) {
			return failValidation('Please select a valid video file.');
		}

		// success at this point
		// indicate success with alert for now
		alert('Valid file!');
		return false; // prevent form submitting anyway
	});
});*/

function checkImageOrVideo(){
	function failValidation(msg) {
		alert(msg); // just an alert for now but you can spice this up later
		return false;
	}

	var file = $('#fileId');
	// var imageChosen = $('#type-1').is(':checked');
	// if (imageChosen && !isImage(file.val())) {
	if (!isImage(file.val())) {
		return failValidation('Please select a valid image');
	} else if (!isVideo(file.val())) {
		return failValidation('Please select a valid video file.');
	}

	// success at this point
	// indicate success with alert for now
	alert('Valid file!');
	return false; // prevent form submitting anyway
}