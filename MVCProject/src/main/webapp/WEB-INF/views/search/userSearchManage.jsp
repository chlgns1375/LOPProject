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
			$("#soloRecord").text("UNRANKED");
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
			$("#srRecord").text("UNRANKED");
		}
		
		
	}
	/*
	const columnDefs = [
		{headerName:"사원번호", field:"empno", width:100},
		{headerName:"사원명", field:"ename", width:100},
		{headerName:"직급", field:"job", width:100},
		{headerName:"직속상관", field:"mgr", width:100},
		{headerName:"입사일자", field:"hiredate", width:100, 
			valueFormatter: function (data) {
				return (data.value).substr(0, 10);
			}
		},
		{headerName:"봉급", field:"sal", width:100},
		{headerName:"모름", field:"comm", width:100},
		{headerName:"소속부서번호", field:"deptno", width:100}
	];

	const gridOptions = {
		defaultColDef:{
			sortable:true,
			resizable:true
		},
		debug:true,
		columnDefs:columnDefs,
		rowData:JSON.parse(jsonData),
		onGridReady:function(event){
			event.api.sizeColumnsToFit();
		}
	};

	// setup the grid after the page has finished loading
	document.addEventListener('DOMContentLoaded', () => {
	  const gridDiv = document.querySelector('#myGrid');
	  new agGrid.Grid(gridDiv, gridOptions);
	});
	*/
</script>

</head>
<body>
	<div class="bodyDiv">
		<div id="userInfo" style="background-color:gray;">
			<table>
				<tr>
					<td rowspan=2>
						<img id="profileIconImg" style="width:128px; height:128px;">
					</td>
					<td>
						<span id="gameName"></span> #<span id="tagName"></span>
					</td>
				</tr>
				<tr>
					<td></td>
				</tr>
			</table>
		</div>
		<div id="recordInfo" style="background-color:orange; width:270px;">
			<br/>
			<h4>솔로랭크</h4>
			<div id="soloRecord">
				<table id="soloRecordTable" style="width:100%;">
					<tr>
						<td style="text-align:center;"><img id="solotierImg" style="width:96px; height:96px;"></td>
						<td rowspan=3 style="text-align:right;">
							<span id="solowins"></span>승 <span id="sololosses"></span>패<br/>
							승률 <span id="soloodds"></span>%
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
			<h4>자유랭크</h4>
			<div id="srRecord">
				
				<table id="srRecordTable" style="width:100%;">
					<tr>
						<td style="text-align:center;"><img id="srtierImg" style="width:96px; height:96px;"></td>
						<td rowspan=3 style="text-align:right;">
							<span id="srwins"></span>승 <span id="srlosses"></span>패<br/>
							승률 <span id="srodds"></span>%
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
		<!-- <div id="myGrid" class="ag-theme-alpine-dark" style="height: 500px; width: 100%;"></div> -->
	</div>
</body>
</html>