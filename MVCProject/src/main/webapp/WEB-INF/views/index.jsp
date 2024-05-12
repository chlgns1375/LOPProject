<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<title>Insert title here</title>
		<script type="text/javascript">
	
			let riotRotationApiCallUrl = '';
			let riotRotationChampionsInfo = '';
			
			
			$(document).ready(function() {
				getApiKeyCodeFunc();
				getRotationChampionInfo();
			});
			
			function getApiKeyCodeFunc() {
				$.ajax({
					url : '/riot/getApiKey',
					type : 'get',
					async: false,
					success : function(result){
						if( result.status == 'ok' ) {
							riotRotationApiCallUrl = 'https://kr.api.riotgames.com/lol/platform/v3/champion-rotations';
							riotRotationApiCallFunc(result.apikey);
						} else {
							
						}
					}, error : function(result) {
						
						
					}
				});
			}
			
			function riotRotationApiCallFunc(apikey){
				$.ajax({
					url : riotRotationApiCallUrl,
					type : 'get',
					dataType:'json',
					async: false,
					data:{
						"api_key" : apikey
					},
					success : function(result){
						riotRotationChampionsInfo = result;
					}, error : function(result) {
						
						
					}
				});
			}
			
			
			function getRotationChampionInfo() {
				// lolAllChampionsInfo //모든 챔피언에 대한 정보
				// riotRotationChampionsInfo.freeChampionIds //로테이션 챔피언 키
				var rotationChampion= new Array;
				for(var ChampionKey in lolAllChampionsInfo.data ) {
				    var championName = ChampionKey;
				    for(var i = 0; i < riotRotationChampionsInfo.freeChampionIds.length; i++) {
				    	if ( riotRotationChampionsInfo.freeChampionIds[i] == lolAllChampionsInfo.data[championName].key ) { //로테이션 챔피언
				    		rotationChampion.push(lolAllChampionsInfo.data[championName]);
				    		
				    	}
				    	
				    	// 신규 플레이어 로테이션 추가 챔피언 : " + riotRotationChampionsInfo.freeChampionIdsForNewPlayers
				    	// 신규 플레이어 로테이션 추가 챔피언의 상한  레벨 : " + riotRotationChampionsInfo.maxNewPlayerLevel
				    }
				}
				getRotationChampionImg(rotationChampion);
			}
			
			function getRotationChampionImg(rotationChampion) {
				const rotationChampionLength = rotationChampion.length;
				let rotationChampionImgUrl = '';
				if(rotationChampionLength != 0 && rotationChampionLength != undefined && rotationChampionLength != null) {
					for(var i = 0; i < rotationChampionLength; i++) {
						var rotationChampionId = rotationChampion[i].id;
						var rotationChampionName = rotationChampion[i].name;
						var rotationChampion_info = rotationChampion[i];
						rotationChampionImgUrl = 'https://ddragon.leagueoflegends.com/cdn/'+lolCurrentVersionNumb+'/img/champion/'+rotationChampionId+'.png';
						$("<span>",{
							tooltip:rotationChampionName,
							flow:'down',
							id:"span"+rotationChampionId
						}).appendTo($("#LOPChampionRotationInfo"));
						$("<img>",{
							id:rotationChampionId,
							src:rotationChampionImgUrl,
							
							click:function(){
								redirectUrl('/Champion/ChampionInfo?championInfo='+ this.id );
							}
						}).css({
							cursor:'pointer',
							width:'100px',
							margin:'5px'
						}).appendTo($("#span"+rotationChampionId));
					}
				}
			}
		</script>
	</head>
	<body>
		<div class="bodyDiv">
			<div class="LOPchampionRotation marginbottom" id="LolChampionRotationInfo">
				<div id="LOPChampionRotationScription" style="margin-left:20px; margin-right:20px; ">
					※금주의 로테이션 챔피언
				</div>
				<main>
				<div id="LOPChampionRotationInfo" style="margin-left:20px; margin-right:20px; "></div>
				</main>
			</div>
	
			<div class="marginbottom stylebackground" style="color:white;">
				패치노트 내용관련 링크[TODO]
			</div>
		</div>
	</body>
</html>