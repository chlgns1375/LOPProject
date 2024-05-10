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
	const matchInfoMap = jsonObj.matchInfoMap;
	const recordInfoList = jsonObj.recordInfoList;
	$(document).ready(function() {
		searchSommonerFunc();
	});
	function searchSommonerFunc() {
		$("#profileIconImg").attr("src", "https://ddragon.leagueoflegends.com/cdn/14.9.1/img/profileicon/" + accountInfoMap.profileIconId + ".png");
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
	
	const columnDefs = [
		{headerName:"승패", field:"win", width:100}, //true, false
		{headerName:"챔피언", field:"champion", width:100},
		{headerName:"KDA", field:"KDA", width:100},
		{headerName:"큐타입", field:"queueType", width:100},
		{headerName:"킬관여", field:"killasist", width:100},
		{headerName:"SPELL/ROON", field:"sr", width:150, 
			valueFormatter: function (data) {
				return (data.value).substr(0, 10);
			}
		},
		{headerName:"팀", field:"team", width:100},
		{headerName:"아이템", field:"item", width:100},
		{headerName:"LV/G/CS", field:"lvgcs", width:100},
		{headerName:"플레이타임", field:"playtime", width:120}
	];

	const gridOptions = {
		defaultColDef:{
			sortable:true,
			resizable:true
		},
		debug:true,
		columnDefs:columnDefs,
		rowData:jsonObj,
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
					<td rowspan=3>
						<img id="profileIconImg" style="width:128px; height:128px;">
					</td>
					<td>
						시즌별 마감 티어[TODO]
					</td>
				</tr>
				<tr>
					<td>
						<span id="gameName"></span> #<span id="tagName"></span>
					</td>
				</tr>
				<tr>
					<td>
						전체 랭킹 순위(상위 %)[TODO]
					</td>
				</tr>
			</table>
		</div>
		<div id="recordInfo" class="display-flex marginbottom">
			<div id="soloRecord" style="width:50%;">
				<table id="soloRecordTable">
					<tr>
						<td style="text-align:center;" rowspan=4><img id="solotierImg"></td>
						<td style="text-align:center;">솔로랭크</td>
					</tr>
					<tr>
						<td>
							<span id="solowins"></span>승 <span id="sololosses"></span>패 (<span id="soloodds"></span>%)
						</td>
					</tr>
					<tr>
						<td style="text-align:center;"><span id="solotierWord"></span> <span id="solotierRank"></span></td>
					</tr>
					<tr>
						<td style="text-align:center;"><span id="solotierLp"></span>LP</td>
					</tr>
				</table>
			</div>
			<br/>
			<div id="srRecord" style="width:50%;">
				
				<table id="srRecordTable">
					<tr>
						<td style="text-align:center;" rowspan=4><img id="srtierImg"></td>
						<td style="text-align:center;">자유랭크</td>
					</tr>
					<tr>
						<td>
							<span id="srwins"></span>승 <span id="srlosses"></span>패 (<span id="srodds"></span>%)
						</td>
					</tr>
					<tr>
						<td style="text-align:center;"><span id="srtierWord"></span> <span id="srtierRank"></span></td>
					</tr>
					<tr>
						<td style="text-align:center;"><span id="srtierLp"></span> LP</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="myGrid" class="ag-theme-alpine-dark" style="height: 500px; width: 100%;"></div>
	</div>
</body>
</html>