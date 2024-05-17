<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nextPage</title>
<script>
	const jsonObj = ${jsonObj};
	const puuidMap = jsonObj.puuidMap;
	const accountInfoMap = jsonObj.accountInfoMap;
	const matchIdList = jsonObj.matchIdList;
	const matchInfoList = jsonObj.matchInfoList;
	const recordInfoList = jsonObj.recordInfoList;
	
	$(document).ready(function() {
		searchSommonerFunc();
	});
	function searchSommonerFunc() {
		$("#profileIconImg").attr("src", "https://ddragon.leagueoflegends.com/cdn/"+lolCurrentVersionNumb+"/img/profileicon/" + accountInfoMap.profileIconId + ".png");
		$("#gameName").text(puuidMap.gameName);
		$("#tagName").text(puuidMap.tagLine);
		
		let soloRecordInfoMap;
		let srRecordInfoMap;
		for(let i = 0; i < recordInfoList.length; i++){
			if( recordInfoList[i].queueType == "RANKED_SOLO_5x5" ) {
				soloRecordInfoMap = recordInfoList[i];
			} else if(recordInfoList[i].queueType == "RANKED_FLEX_SR" ){
				srRecordInfoMap = recordInfoList[i];
			} else {
				continue; //솔로랭크 자유랭크를 제외한 모든 리스트는 넘긴다.
			}
		}
		
		if( soloRecordInfoMap != undefined && soloRecordInfoMap != null && soloRecordInfoMap != '') {
			$("#solotierImg").attr("src", "https://opgg-static.akamaized.net/images/medals_new/"+soloRecordInfoMap.tier+".png?image=q_auto:good,f_webp,w_144&v=1715147216574");
			$("#solotierWord").text(soloRecordInfoMap.tier);
			$("#solotierRank").text(soloRecordInfoMap.rank);
			$("#solotierLp").text(soloRecordInfoMap.leaguePoints);
			$("#solowins").text(soloRecordInfoMap.wins);
			$("#sololosses").text(soloRecordInfoMap.losses);
			const soloodds = Math.round(soloRecordInfoMap.wins / (soloRecordInfoMap.wins + soloRecordInfoMap.losses) * 100);
			$("#soloodds").text(soloodds);
		} else {
			$("#soloRecordTable").remove();
			$("#soloRecord").html("솔로랭크<br/>UNRANKED");
		}
		if( srRecordInfoMap != undefined && srRecordInfoMap != null && srRecordInfoMap != '') {
			$("#srtierImg").attr("src", "https://opgg-static.akamaized.net/images/medals_new/"+srRecordInfoMap.tier+".png?image=q_auto:good,f_webp,w_144&v=1715147216574");
			$("#srtierWord").text(srRecordInfoMap.tier);
			$("#srtierRank").text(srRecordInfoMap.rank);
			$("#srtierLp").text(srRecordInfoMap.leaguePoints);
			$("#srwins").text(srRecordInfoMap.wins);
			$("#srlosses").text(srRecordInfoMap.losses);
			const srodds = Math.round(srRecordInfoMap.wins / (srRecordInfoMap.wins + srRecordInfoMap.losses) * 100);
			$("#srodds").text(srodds);
		} else {
			$("#srRecordTable").remove();
			$("#srRecord").html("자유랭크<br/>UNRANKED");
		}
		
		
	}
	function searchedInGamePlayerInfoFunc(data) {
		const participants = data.data.info.participants;
		for(var playerNum in participants) {
			if( participants[playerNum].puuid == puuidMap.puuid ) {
				return participants[playerNum];
			} else {
				continue;
			}
		}
	}
	const columnDefs = [
		{headerName:"승패", field:"win", width:55, sortable:false,
			cellStyle: function(data) {
				return {
					"justify-content": "center", 
					"align-content": "center",
					"align-items": "center",
					"align-self": "center"
				};
			},
			valueFormatter: function (data) {
				const searchedPlyerIngameInfo = searchedInGamePlayerInfoFunc(data);
				return (searchedPlyerIngameInfo.win == true) ? "승" : "패";
			}	
		},
		{headerName:"큐타입", field:"mapId", width:70, sortable:false,
			cellStyle: function(data) {
				return {
					"justify-content": "center", 
					"align-content": "center",
					"align-items": "center",
					"align-self": "center"
				};
			},
			valueFormatter: function (data) {
				if(data.data.info.mapId == 11) {
					return "랭크";
				} else if(data.data.info.mapId == 12){
					return "총력전";
				} else if(data.data.info.mapId == 30){
					return "아레나";
				} else {
					return data.data.info.mapId;
				}
				
			}
		},
		{headerName:"챔피언", field:"champion", width:70, sortable:false,
			cellStyle: function(data) {
				return {
					"justify-content": "center", 
					"align-content": "center",
					"align-items": "center",
					"align-self": "center"
				};
			},
			cellRenderer: function (data) {
				const searchedPlyerIngameInfo = searchedInGamePlayerInfoFunc(data);
				const championName = toCapitalize(searchedPlyerIngameInfo.championName);
				var championImgUrl = 'https://ddragon.leagueoflegends.com/cdn/'+lolCurrentVersionNumb+'/img/champion/'+championName+'.png';
				//return "<span tooltip='" + searchedPlyerIngameInfo.championName + "' flow='down' ><img src="+championImgUrl+" class='imgCircleRadius' style='width:40px; cursor:pointer;'></span>";
				return "<img onclick=\"redirectUrl(\'/Champion/ChampionInfo?championInfo=" + championName + "\' );\" src="+championImgUrl+" class='imgCircleRadius' style='width:50px; cursor:pointer;'>";
			},
			tooltipValueGetter: function (data) {
				const searchedPlyerIngameInfo = searchedInGamePlayerInfoFunc(data);
				const championName = toCapitalize(searchedPlyerIngameInfo.championName);
				return lolAllChampionsInfo.data[championName].name;
			},
		},
		{headerName:"SR", field:"sr", width:60, sortable:false},
		{headerName:"KDA", field:"KDA", width:100, sortable:false,
			cellStyle: function(data) {
				return {
					"justify-content": "center", 
					"align-content": "center",
					"align-items": "center",
					"align-self": "center"
				};
			},
			cellRenderer: function (data) {
				const searchedPlyerIngameInfo = searchedInGamePlayerInfoFunc(data);
				const searchedPlayerKills = searchedPlyerIngameInfo.kills;
				const searchedPlayerAssists = searchedPlyerIngameInfo.assists;
				const searchedPlayerDeaths = searchedPlyerIngameInfo.deaths;
				const searchedPlayerTeamId = searchedPlyerIngameInfo.teamId;
				const teams = data.data.info.teams;
				const teamAllKillCount =
					( teams[0].teamId == searchedPlayerTeamId ) ? teams[0].objectives.champion.kills : teams[1].objectives.champion.kills;
				const searchedPlayerTeamKillsCount = searchedPlayerKills + searchedPlayerAssists;
				const searchedPlayerInvolvement = Math.round( ( searchedPlayerTeamKillsCount / teamAllKillCount ) * 100 );
				if( data.data.info.mapId == 30) {
					return "<span>" + searchedPlayerKills + " / " + searchedPlayerDeaths + " / " + searchedPlayerAssists + "</span>";
				} else {
					return "<span>" + searchedPlayerKills + " / " + searchedPlayerDeaths + " / " + searchedPlayerAssists + " (" + searchedPlayerInvolvement + "%)<br/>KDA : " + (searchedPlyerIngameInfo.challenges.kda).toFixed(2) + "</span>";
				}
				
			}
		},
		{headerName:"팀", field:"team", width:200, sortable:false,
			cellRenderer: function (data) {
				const searchedPlyerIngameInfo = searchedInGamePlayerInfoFunc(data);
				const searchedPlayerteamId = searchedPlyerIngameInfo.teamId;
				const participantsTeam = data.data.info.participants;
				const matchVersionInfoSplit = (data.data.info.gameVersion).split('.');
				const matchVersionInfo = matchVersionInfoSplit[0] + '.' + matchVersionInfoSplit[1] + '.' + '1';
				
				let resultData = '';
				let championImgUrl = '';
				
				let winTeamTag = "<div style='float:left; box-sizing:border-box; width:50%;'>";
				let lossTeamTag = "<div style='float:right; box-sizing:border-box; width:50%;'>";
				let htmlInfo = "";
				
				for(var i = 0; i < participantsTeam.length; i++) {
					const champName = toCapitalize(participantsTeam[i].championName);
					const championImgUrl = 'https://ddragon.leagueoflegends.com/cdn/' + lolCurrentVersionNumb + '/img/champion/' + champName + '.png';
					htmlInfo += "<span tooltip='" + lolAllChampionsInfo.data[champName].name
						+ "' flow='down' ><img src='"+championImgUrl + "' style='width:16px; cursor:pointer;'></span>";
					//TODO: (lolAllChampionsInfo.data[champName].name : 'Fiddlestick') != (participantsTeam[i].name : 'FiddleStick')
					htmlInfo += "<span onclick=redirectUrl('/search/userSearchManage?summonerName="+ participantsTeam[i].riotIdGameName.replaceAll(' ', '') + 
						"-" + participantsTeam[i].riotIdTagline.replaceAll(' ', '') + "'); tooltip='" + participantsTeam[i].riotIdGameName + "#" + participantsTeam[i].riotIdTagline + 
						"' flow='down' style='cursor:pointer;'>" + participantsTeam[i].riotIdGameName + "</span><br/>";
						
					if(participantsTeam[i].teamId == searchedPlayerteamId) {
						winTeamTag += htmlInfo;
					} else {
						lossTeamTag += htmlInfo;
					}
					htmlInfo = "";
				}
				winTeamTag += "</div>";
				lossTeamTag += "</div>";
				
				resultData = winTeamTag + lossTeamTag;
				return resultData;
			}
		},
		{headerName:"아이템", field:"item", width:110, sortable:false,
			cellStyle: function(data) {
				return {
					"justify-content": "center", 
					"align-content": "center",
					"align-items": "center",
					"align-self": "center"
				};
			},
			cellRenderer: function (data) {
				const searchedPlyerIngameInfo = searchedInGamePlayerInfoFunc(data);
				const matchVersionInfoSplit = (data.data.info.gameVersion).split('.');
				const matchVersionInfo = matchVersionInfoSplit[0] + '.' + matchVersionInfoSplit[1] + '.' + '1';
				const matchVersionItemsInfo = getLolCurrentVersionAllItemsFunc(matchVersionInfo);
				const searchedPlyerWinChk = searchedPlyerIngameInfo.win;
				let resultData = '';
				for(let i = 0; searchedPlyerIngameInfo['item'+i] != undefined; i++) {
					const itemNumb = searchedPlyerIngameInfo['item'+i];
					if( itemNumb != 0 ) {
						const itemImgUrl = 'https://ddragon.leagueoflegends.com/cdn/'+matchVersionInfo+'/img/item/'+itemNumb+'.png';
						const itemInfo = 'https://ddragon.leagueoflegends.com/cdn/'+matchVersionInfo+'/data/ko_KR/item.json'
						const itemTag = "<span tooltip='"+matchVersionItemsInfo.data[itemNumb].name+"' flow='down'><img src="+itemImgUrl+" style='width:25px; cursor:pointer;'></span> ";
						resultData += itemTag;
					} else {
						if( searchedPlyerWinChk ) {
							resultData += "<img style='width:25px; height:25px; background-color:#181d1f'> ";
						} else {
							resultData += "<img style='width:25px; height:25px; background-color:#59343B'> ";
						}
							
					}
					
					if(i == 2) {
						resultData += "<br/>"
					}
				}
				
				return resultData;
			}
		},
		{headerName:"LV/G/CS", field:"lvgcs", width:100, sortable:false,
			cellStyle: function(data) {
				return {
					"justify-content": "center", 
					"align-content": "center",
					"align-items": "center",
					"align-self": "center"
				};
			},
			valueFormatter: function (data) {
				const searchedPlyerIngameInfo = searchedInGamePlayerInfoFunc(data);
				const searchedPlaerIngameChampLv = searchedPlyerIngameInfo.champLevel;
				const searchedPlaerIngamePlayerGold = searchedPlyerIngameInfo.goldEarned.toLocaleString();
				const searchedPlaerIngamePlayerTotalMinionKilled = searchedPlyerIngameInfo.totalMinionsKilled;
				return searchedPlaerIngameChampLv + " / " + searchedPlaerIngamePlayerGold + " / " + searchedPlaerIngamePlayerTotalMinionKilled;
			}
		},
		{headerName:"시간", field:"playtime", width:130, sortable:false,
			cellStyle: function(data) {
				return {
					"justify-content": "center", 
					"align-content": "center",
					"align-items": "center",
					"align-self": "center"
				};
			},
			cellRenderer: function (data) {
				const getTime = data.data.info.gameEndTimestamp - data.data.info.gameStartTimestamp;
				const setPlayedMinutes = new Date(getTime).getMinutes();
				const setPlayedSeconds = new Date(getTime).getSeconds();
				
				const startTime = data.data.info.gameStartTimestamp;
				const setstartPlayedYear = new Date(startTime).getFullYear();
				const setstartPlayedMonth = new Date(startTime).getMonth();
				const setstartPlayedDay = new Date(startTime).getDate();
				const setstartPlayedHours = new Date(startTime).getHours();
				const setstartPlayedMinutes = new Date(startTime).getMinutes();
				const setstartPlayedSeconds = new Date(startTime).getSeconds();
				
				return "플레이 시간 : " + setPlayedMinutes + "분 " + setPlayedSeconds + "초<br/>"
					+ setstartPlayedYear + "년 " + (setstartPlayedMonth + 1) + "월 " + setstartPlayedDay + "일 "
					+ setstartPlayedHours + "시 ";
					
				
			}
		}
	];

	const gridOptions = {
		defaultColDef:{
			resizable: false
		},
		rowHeight: 100, // 셀높이
		columnDefs:columnDefs,
		rowData:matchInfoList, //렌더링될 데이터
		tooltipShowDelay: 100, //툴팁표시 딜레이시간
		tooltipMouseTrack:true, //커서이동시 툴팁 따라옴
		onCellClicked:false,
		getRowStyle: params => {
	        if (searchedInGamePlayerInfoFunc(params.node).win == false) {
	            return { background: '#59343B' };
			} else {
				return { background: '#181d1f'};
			}
		},
		onGridReady:function(event){
			event.api.sizeColumnsToFit();
		}
	};

	// setup the grid after the page has finished loading
	document.addEventListener('DOMContentLoaded', () => {
	  const gridDiv = document.querySelector('#myGrid');
	  new agGrid.Grid(gridDiv, gridOptions);
	});
	
</script>

</head>
<body>
	<div class="bodyDiv">
		<div id="userInfo" class="marginbottom">
			<table>
				<tr>
					<td rowspan=3><img id="profileIconImg"
						style="width: 128px; height: 128px;"></td>
					<td>시즌별 마감 티어[TODO]</td>
				</tr>
				<tr>
					<td><span id="gameName"></span> #<span id="tagName"></span></td>
				</tr>
				<tr>
					<td>전체 랭킹 순위(상위 %)[TODO]</td>
				</tr>
			</table>
		</div>
		<div id="recordInfo" class="display-flex marginbottom">
			<div id="soloRecord" style="width: 50%;">
				<table id="soloRecordTable">
					<tr>
						<td style="text-align: center;" rowspan=4><img
							id="solotierImg"></td>
						<td style="text-align: center;">솔로랭크</td>
					</tr>
					<tr>
						<td><span id="solowins"></span>승 <span id="sololosses"></span>패
							(<span id="soloodds"></span>%)</td>
					</tr>
					<tr>
						<td style="text-align: center;"><span id="solotierWord"></span>
							<span id="solotierRank"></span></td>
					</tr>
					<tr>
						<td style="text-align: center;"><span id="solotierLp"></span>LP</td>
					</tr>
				</table>
			</div>
			<br />
			<div id="srRecord" style="width: 50%; align-items: right;">

				<table id="srRecordTable">
					<tr>
						<td style="text-align: center;" rowspan=4><img id="srtierImg"></td>
						<td style="text-align: center;">자유랭크</td>
					</tr>
					<tr>
						<td><span id="srwins"></span>승 <span id="srlosses"></span>패
						(<span id="srodds"></span>%)</td>
					</tr>
					<tr>
						<td style="text-align: center;"><span id="srtierWord"></span>
							<span id="srtierRank"></span></td>
					</tr>
					<tr>
						<td style="text-align: center;"><span id="srtierLp"></span>LP</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="myGrid" class="ag-theme-alpine-dark" style="height: 1052px; width: 100%;"></div>
	</div>
</body>
</html>