
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
	document.getElementById("file_num").innerHTML = nFiles;
	document.getElementById("file_size").innerHTML = sOutput;
	//document.getElementById("file_type").innerHTML = getExtension(strFileName);
}
document.getElementById("fileId").addEventListener("change", updateSize, false);

function imageChoose(obj) { // execute when input file selected(onChanged)
	let f = obj.files[0];

	//------ when input file selected // get extensions toLowerCase -------------------------------
	var fileName = document.querySelector('#fileId').value;
	var extension = fileName.split('.').pop(); // .pop()
	extension = extension.toLowerCase();
	console.log("fileName="+fileName);
	console.log("extentsions="+extension);
	document.querySelector('.output').textContent = fileName+" : "+extension;
	//---------------------------------------------------------------------------------------------
	//------ when input file selected // get files MIME type ---------------------------------------
	var files = obj.files;
	for (var i = 0; i < files.length; i++) {
		var name = files[i].name;
		var type = files[i].type;
		//alert("Filename: " + name + " , Type: " + type);
		console.log("Filename: files[0].name=" + files[0].name + " , Type: " + type);
		console.log("Filename: " + name + " , Type: " + type);
		//Filename: C0002.MP4 , Type: video/mp4
		//Filename: SAM_1218.JPG , Type: image/jpeg
	}
	console.log("Filename: files[0].name=" + files[0].name + " , Type: " + type);
	//----------------------------------------------------------------------------------------------

	let bIsImage=false,bFileSize=false;
	if (!f.type.toLowerCase().match("image.*|video.*")){
		console.log("이 형식의 파일은 지원하지 않습니다.");
		document.getElementById("fileId").value = "";
		//alert("이 형식의 파일은 지원하지 않습니다.");
		//window.history.back();
		document.querySelector("#idCaution").innerHTML="이 파일의 형식은 지원하지 않습니다";
		//document.querySelector("#idComment").style.display='none';
		//document.querySelector("#btnSubmit").style.display='none';
		bIsImage=false
		//return false;
	}else{
		bIsImage=true;
	}
	if (f.size>400000000){ // 10자리 숫자: 1기가 바이트
		console.log("f.size="+f.size);
		//console.log("파일 용량이 1GB 까지 가능합니다");
		console.log("파일 용량이 400MB 까지 가능합니다");
		document.getElementById("fileId").value = "";
		//document.querySelector("#idCaution").innerHTML="파일 용량이 1GB 까지 가능합니다";
		document.querySelector("#idCaution2").innerHTML="파일 용량이 400MB 까지 가능합니다";
		//document.querySelector("#idComment").style.display='none';
		//document.querySelector("#btnSubmit").style.display='none';
		bFileSize=false;
		//return false;
	}else{
		bFileSize=true;
	}
	if(bIsImage && bFileSize){ //이미지/영상 파일이고 용량이 적당할때
		document.querySelector("#idCaution").style.display='none';
		document.querySelector("#idCaution2").style.display='none';
		document.querySelector("#idComment").style.display='block';
		document.querySelector("#btnSubmit").style.display='block';
	}else { // 용량, 형식이 아닐때
		document.querySelector("#idCaution2").style.display='block';
		document.querySelector("#idCaution").style.display='block';
		document.querySelector("#idComment").style.display='none';
		document.querySelector("#btnSubmit").style.display='none';
	}

	let reader = new FileReader();
	reader.onload = (e) => {
		$("#imageUploadPreview").attr("src", e.target.result);
		//$("#file_type").attr("type", e.target.result);
		//$("#file_size").attr("size", e.target.result);
	}
	reader.readAsDataURL(f); // 이 코드 실행시 reader.onload 실행됨.
}

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