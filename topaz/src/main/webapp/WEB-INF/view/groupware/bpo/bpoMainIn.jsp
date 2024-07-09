<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
   분류번호: #5-외주 업체 관리 페이지
   시작 날짜: 2024-07-05
   담당자: 박혜아
-->
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<head>
	<!-- hyeah CSS / JS -->
	<link href="/topaz/css/hyeah.css" rel="stylesheet">
	
	<!-- Fullcalendar -->
    <script src="/topaz/fullcalendar-6.1.14/dist/index.global.js"></script>
	<script src="/topaz/fullcalendar-6.1.14/dist/index.global.min.js"></script>
    
    <!-- 캘린더API  -->
	<script>
	document.addEventListener('DOMContentLoaded', function() {
		initializeCalendar(); // 페이지 로드 시 달력 초기화
		
		$('#inputState').change(function() {
			let inputStateValue = $('#inputState').val();
			console.log("inputStateValue 값:", inputStateValue);
			 initializeCalendar(); // inputState 변경 시 달력 초기화
		});
		function initializeCalendar() {
			
	    let calendarEl = document.getElementById('calendar');

	    let calendar = new FullCalendar.Calendar(calendarEl, {
	      headerToolbar: {
	        left: 'prevYear,prev,next,nextYear today',
	        center: 'title',
	        right: 'dayGridMonth addEventButton', // 달만 보이게 설정 / 이벤트 버튼 생성
	      }, 
	      customButtons: {
			addEventButton: { // 추가한 이벤트 버튼 설정
				text : "신규예약생성",  // 버튼 내용
				click : function(){ // 버튼클릭 시 이벤트 추가
					
					// 모달 창 띄워서 신규 일정 추가
					$("#addRsvn").modal("show");
							
                  }
              }
          },
	      locale: 'kr',			// 언어 설정
	      selectable: true, 	// 영역 선택
	      //navLinks: true, 	// 날짜 클릭 여부
	      dayMaxEvents: true, 	// 이벤트가 많을 경우 more링크 활성화
	      events: [
			// 전체 사내일정 리스트 가져오기
			$.ajax({
				type: "GET",
				data: {"inputState" : $('#inputState').val()},
				url: "/topaz/bpo/bpoRsvnCalList",
				success: function (response){
	    			  
					console.log("response", response);
					for(i=0; i<response.length; i++){
						// title, start, end 설정
						calendar.addEvent({
							title: response[i].rsvnTitle, // 제목
							start: response[i].rsvnStart, // 시작날짜
							end: response[i].rsvnEnd, // 종료날짜
							//url: '/topaz/groupware/bpo/scheduleDetail?scheduleNo='+response[i].scheduleNo, // 상세보기 이동
							backgroundColor: getRsvnColor(response[i].rsvnState), // 타입별 색상 분류
							borderColor: getRsvnColor(response[i].rsvnState), // 타입별 색상분류
						})
					}
				}
			})
		]
	    });
	    calendar.render();
	    
	    // 일정 배경 색상 설정
	    function getRsvnColor(rsvnState){
	    	switch(rsvnState){
	    	case '대기':
	    		return '#81bbb2';
	    	case '확정':
	    		return '#f6bf26';
	    	case '취소':
	    		return '#d50000';
	    	default: 
	    		return '#ffffff';
	    	}
	    }
		}
	  });
	</script>
	</head>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
		<div class="pagetitle">
			<h1>외주업체 예약일정</h1>
			<nav>
				<ol class="breadcrumb">
	        		<li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
	          		<li class="breadcrumb-item active">Outsourcing Reservation</li>
	        	</ol>
	      	</nav>
	    </div><!-- End Page Title -->
	
	    <section class="section">
	    	<div class="row">
				<!-- 왼쪽 세션 -->
				<div class="col-lg-8"><div class="card"><div class="card-body">
					<h5 class="card-title col-md-4">
					<span class="rsvnInfoWait">&nbsp;&nbsp;대 기&nbsp;&nbsp;</span>
						<span class="rsvnInfoConfirm">&nbsp;&nbsp;확 정&nbsp;&nbsp;</span>
						<span class="rsvnInfoCxl">&nbsp;&nbsp;취 소&nbsp;&nbsp;</span>
						<select id="inputState" name="inputState" class="form-select">
                    			<option value="">전체</option>
								<c:forEach var="c" items="${bpoCategory}">
									<option value="${c.outsourcingNo}">${c.outsourcingName}</option>
								</c:forEach>
                  		</select>
					</h5>
					<!-- 캘린더 출력 -->
					<div id='calendar'></div>
					
				</div></div></div>
		
				<!-- 오른쪽 세션 -->
				<div class="col-lg-4">
					<div class="card"><div class="card-body">
						<h5 class="card-title">오늘의 예약</h5>
							<c:forEach var="r" items="${bpoRsvnToday}">
								 <div class="todayDiv">
								 	<c:choose>
								 		<c:when test="${r.rsvnState eq '대기'}">
								 			<span class="badge rounded-pill rsvnInfoWait" id="typeEvent">${r.rsvnState}</span>
								 		</c:when>
								 		<c:when test="${r.rsvnState eq '확정'}">
								 			<span class="badge rounded-pill rsvnInfoConfirm" id="typeEvent">${r.rsvnState}</span>
								 		</c:when>
								 		<c:when test="${r.rsvnState eq '취소'}">
								 			<span class="badge rounded-pill rsvnInfoCxl" id="typeEvent">${r.rsvnState}</span>
								 		</c:when>
								 	</c:choose>
								 	${r.rsvnStart} - ${r.rsvnEnd} ::  ${r.rsvnTitle}...
								 	<!-- <button id="todayDetailSpan"><span class="badge rounded-pill bg-primary">상세보기</span></button> -->
								 	<a href="/topaz/groupware/schedule/scheduleDetail?scheduleNo=${s.scheduleNo}">
								 		<span class="badge rounded-pill bg-primary">상세보기</span>
								 	</a>
								 </div>
							</c:forEach>
					</div></div>
					<div class="card"><div class="card-body">
						<h5 class="card-title">영업 상태</h5>
						<c:forEach var="state" items="${bpoStateChk}">
							<div>
								<c:if test="${state.outsourcingState eq '영업중'}">
									<span class="badge rounded-pill bpoStateOn">${state.outsourcingState}</span>
								</c:if>
								<c:if test="${state.outsourcingState eq '영업종료'}">
									<span class="badge rounded-pill bpoStateOff">${state.outsourcingState}</span>
								</c:if>
								${state.outsourcingName}
								${state.inchargeName} (${state.contactNo})
							</div>
						</c:forEach>
					</div></div>
				</div>
				
			</div>	
	    </section>
		<!-- Modal -->
		<!-- addRsvn 모달창 :: 예약생성 -->
		<div class="modal fade" id="addRsvn" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
				<!-- 모달 제목 -->
				<div class="modal-header">
					<h5 class="modal-title">신규 예약 생성</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<!-- 모달 신규 예약 생성폼 -->
				<form id="addRsvnForm" action="${pageContext.request.contextPath}/groupware/schedule/scheduleList" method="post">
					<div class="modal-body">
						<div class="row mb-5">
							<label for="inputEmail" class="col-sm-4 col-form-label">시작 날짜</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="datetime-local" class="form-control" id="addStartDate" name="startDate">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">종료 날짜</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="datetime-local" class="form-control" id="addEndDate" name="endDate">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">예약 업체</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="text" class="form-control" id="addTitle" name="title">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">예약 고객</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="text" class="form-control" id="addTitle" name="title">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">예약 제목</label>
							<div class="col-sm-8 scheduleModalDiv">
							<label for="meetingRadio">
								<input class="form-check-input" type="radio" name="type" value="1" id="meetingRadio" checked> 회의
							</label>&nbsp;&nbsp;&nbsp;
							<label for="festivalRadio">
								<input class="form-check-input" type="radio" name="type" value="2" id="festivalRadio"> 행사
							</label>&nbsp;&nbsp;&nbsp;
							<label for="inspectionRadio">
								<input class="form-check-input" type="radio" name="type" value="3" id="inspectionRadio"> 점검
							</label>
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">예약 내용</label>
							<div class="col-sm-8">
								<textarea rows="3" maxlength="100" class="col-sm-12" id="addContent" name="content" placeholder="100자 이하 작성" style="height: 150px"></textarea>
								(<span id="chatHelper">0</span>/100)
							</div>
						</div>
					</div>
					
					<!-- 모달 일정 취소/등록버튼 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button id="addRsvnBtn" type="submit" class="btn btn-primary">Save</button>
					</div>
				</form>
			</div></div>
		</div><!-- End addRsvn Modal-->
		
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>