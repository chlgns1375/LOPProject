<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
		<script>
			
			var xhr = new XMLHttpRequest();

			const lolCurrentVersionUrl = 'https://ddragon.leagueoflegends.com/api/versions.json';
			let lolCurrentVersionNumb = '';
			let lolAllVersionInfo;
			
			let lolAllChampionsInfo;
			let lolAllItemsInfo;
			
			
			getLolCurrentVersionFunc();
			
			function backToHome() {
				location.replace(location.origin);
			}
			
			function redirectUrl(url) {
				location.replace(url);
			}
			

			function getLolCurrentVersionFunc(){
				//lolCurrentVersionUrl
				$.ajax({
					url : lolCurrentVersionUrl,
					type : 'get',
					dataType:'json',
					async: false,
					success : function(result){
						lolCurrentVersionNumb = result[0];
						//lolCurrentVersionNumb = "14.10.1";
						lolAllVersionInfo = result;
						lolAllChampionsInfo = getLolCurrentVersionAllChampionsFunc(lolCurrentVersionNumb);
						lolAllItemsInfo = getLolCurrentVersionAllItemsFunc(lolCurrentVersionNumb);
					}, error : function(result) {
						
						
					}
				});
			}
			
			//
			function getLolCurrentVersionAllChampionsFunc(versionNumb) {
				const getLolCurrentVersionAllChampionsUrl = 'https://ddragon.leagueoflegends.com/cdn/'+versionNumb+'/data/ko_KR/champion.json'
				let returnResult;
				$.ajax({
					url : getLolCurrentVersionAllChampionsUrl,
					type : 'get',
					dataType:'json',
					async: false,
					success : function(data){
						returnResult = data;
					}, error : function(data) {
						returnResult = data;
					}
				});
				
				return returnResult;
			}
			
			//
			function getLolCurrentVersionAllItemsFunc(versionNumb) {
				const getLolCurrentVersionAllItemsUrl = 'https://ddragon.leagueoflegends.com/cdn/'+versionNumb+'/data/ko_KR/item.json'
				let returnResult;
				$.ajax({
					url : getLolCurrentVersionAllItemsUrl,
					type : 'get',
					dataType:'json',
					async: false,
					success : function(data){
						returnResult = data;
					}, error : function(result) {
						returnResult = data;
						
					}
				});
				
				return returnResult;
			}
			
			//
			function getLolAllSpellsFunc(versionNumb) {
				const getLolCurrentVersionAllItemsUrl = 'https://ddragon.leagueoflegends.com/cdn/'+versionNumb+'/data/ko_KR/summoner.json'
				let returnResult;
				$.ajax({
					url : getLolCurrentVersionAllItemsUrl,
					type : 'get',
					dataType:'json',
					async: false,
					success : function(data){
						returnResult = data;
					}, error : function(result) {
						returnResult = data;
						
					}
				});
				
				return returnResult;
			}
			
			// 첫문자 대문자 변경 함수
			function toCapitalize(str) {
				if(str.toLocaleLowerCase() == 'fiddlesticks') {
					return 'Fiddlesticks';
				} else {
					return str;
				}
				
			}
			
			function textLengthOverCut(txt, len, lastTxt) {
				if (len == "" || len == null) { // 기본값
					len = 5;
				}
				if (lastTxt == "" || lastTxt == null) { // 기본값
					lastTxt = "...";
				}
				if (txt.length > len) {
					txt = txt.substr(0, len) + lastTxt;
				}
				return txt;
			}
		</script>
	</head>

	<body>
		<jsp:include page="Top.jsp" />
		<section>
			<sitemesh:write property='head'/>
			<sitemesh:write property='body'/>
		</section>
	</body>
</html>