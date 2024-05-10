<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	
	function enterkey(e){
		if(e.keyCode == 13){
			searchNickName();
		}
	}
	
	function searchNickName(){
		const userNickName = $("#userNickName").val().split("#");
		const nickName = userNickName[0];
		const tagName = userNickName[1];
		let redirectUrlData = '';
		if(tagName != undefined && tagName != null && tagName != '') {
			redirectUrlData = '/search/userSearchManage?summonerName='+ nickName + "-" + tagName;
		} else {
			redirectUrlData = '/search/userSearchManage?summonerName='+ nickName + "-KR1";
		}
		redirectUrl(redirectUrlData)
	}
	
</script>
<header>
	<h1 onclick="backToHome(); return false;">LOP HEADER</h1>
	<div class="toolbar">
		toolbar
	</div>
	<div class="searchDiv">
		<!-- sendRequest(url, type, datatype, sync, datas) -->
		<input type="text" class="textBox" id="userNickName" onkeypress="enterkey(event);" placeholder="검색할 소환사명" />
		<button class="buttonBox" onclick="searchNickName();">search</button>
		searchDiv 검색박스
	</div>
</header>