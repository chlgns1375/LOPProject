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
	<h1 onclick="backToHome(); return false;">LOP.GG</h1>
	<div class="toolbar">
		<nav class="navbar">

			<div class="navbar__logo">
			<i class="fas fa-blog"></i>
			<a href="">AXCE Coding</a>
	</div>

		<ul class="navbar__menu">
			<li><a href="#">Home</a></li>
			<li><a href="#">Gallery</a></li>
			<li><a href="#">Weddings</a></li>
			<li><a href="#">FAQ</a></li>
			<li><a href="#">Bookings</a></li>
		</ul>

		<ul class="navbar__icons">
			<li><i class="fab fa-google"></i></li>
			<li><i class="fab fa-slack"></i></li>
		</ul>
      
      <a href="#" class="navbar__toggleBtn">
        <i class="fas fa-hamburger"></i>
      </a>
    </nav>
		<!-- 룬, 아이템, 챔피언분석, 통계, 랭킹, 패치노트 등등 -->
	</div>
	<div class="searchDiv">
		<input type="text" class="textBox" id="userNickName" onkeypress="enterkey(event);" placeholder="소환사명 + #KR1" />
		<button class="buttonBox" onclick="searchNickName();">search</button>
	</div>
</header>