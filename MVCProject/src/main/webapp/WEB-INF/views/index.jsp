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
				getRotationChampionInfoFunc();
				getPatchNotesInfoFunc();
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
			
			
			function getRotationChampionInfoFunc() {
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
			//https://www.leagueoflegends.com/ko-kr/news/game-updates/patch-14-9-notes/
			// href="https://www.freecodecamp.org/" target="_blank"
			function getPatchNotesInfoFunc() {
				let lolVersionSplitDot;
				let htmlLolVersionResult = '';
				for(var i = 0; i < 5; i++) {
					lolVersionSplitDot = lolAllVersionInfo[i].split('.');
					htmlLolVersionResult += "<span><a href='https://www.leagueoflegends.com/ko-kr/news/game-updates/patch-"
					+ lolVersionSplitDot[0] + "-" + lolVersionSplitDot[1]
					+ "-notes/'  target='_blank' style='color:white;'>"
					+ lolAllVersionInfo[i] + " 패치노트</a></span><br/>"
				}
				$("#LOPPatchNoteInfo").html(htmlLolVersionResult);
			}
		</script>
	</head>
	<body>
		<div class="bodyDiv">
			<div class="LOPchampionRotation marginbottom stylebackground" id="LolChampionRotationInfo">
				<div id="LOPChampionRotationScription" style="margin-left:20px; margin-right:20px; ">
					※금주의 로테이션 챔피언
				</div>
				<div id="LOPChampionRotationInfo" style="margin-left:20px; margin-right:20px; "></div>
			</div>
	
			<div class="marginbottom stylebackground">
				<div style="margin-left:20px; margin-right:20px;">
					※패치노트
				</div>
				<div id="LOPPatchNoteInfo" style="margin-left:20px; margin-right:20px; ">
					
				</div>
			</div>
		</div>
	</body>
</html>