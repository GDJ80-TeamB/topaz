<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
   분류번호: #7 - 입주자 관리 페이지 : 전체 입주자 조회
   시작 날짜: 2024-07-08
   담당자: 박수지
-->

<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	
	<!-- ======= css ======= -->
	<link rel="stylesheet" href="/topaz/css/suji.css"> 
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>객실 관리</h1>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    	<div class="pagetitle">
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">HOME</a></li>
          <li class="breadcrumb-item active">Room List</li>
        </ol>
      </nav>
	</div><!-- End Page Title -->
	
 	<section class="section">
 	<div class="col-lg-12">
		<div class="card">
			<div class="card-body">
		    	<h5 class="card-title"></h5>
		    	<div class="container">
				    <div class="row mb-3">
				        <div class="col-md-2">
				            <label for="type" class="form-label">입주상태</label>
				        </div>
				        <div class="col-md-2">
				            <select id="state" class="form-select" aria-label="Select state">
								<option value ="">입주상태를 선택하세요</option>
				            </select>
				        </div>
				        <div class="col-md-1">
				            <label for="dong" class="form-label">동</label>
				        </div>
				        <div class="col-md-2">
				            <select id="dong" class="form-select" aria-label="Select dong">
								<option value = "">동을 선택하세요 </option>
				            </select>
				        </div>
				        <div class="col-md-1">
				            <label for="type" class="form-label">타입</label>
				        </div>
				        <div class="col-md-2">
				            <select id="type" class="form-select" aria-label="Select second ho number">
				                <option value ="">타입을 선택하세요</option>
				            </select>
				        </div>
				        <div class="col-md-1">
				            <label for="ho" class="form-label">호수</label>
				        </div>
				        <div class="col-md-2">
				            <select id="ho" class="form-select" aria-label="Select second ho number">
				                <option value ="">호수를 선택하세요</option>
				            </select>
				        </div>
				    </div>
				</div>

	<br>
    <!-- Table with stripped rows -->
    <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col">입주상태</th>
                    <th scope="col">동</th>
                    <th scope="col">호수</th>
                    <th scope="col">입주자성명</th>
                    <th scope="col">청소상태</th>
                    <th scope="col">청소예정</th>
                    <th scope="col">담당자</th>
                </tr>
            </thead>
            <tbody id="room-list-tbody">
                <!-- Data will be injected here via JavaScript -->
            </tbody>
        </table>
	<!-- End Table with stripped rows -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination" id="pagination">
	    <!-- Pagination links will be generated by JavaScript -->
	  </ul>
	</nav>
			</div>
	<span>
		<a href = "/topaz/groupware/room/roomMakeUpChk">청소율 보기</a>
	</span>
		</div>
	</div>
   	</section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	$(document).ready(function() {
	    // Entry point for dynamic data update
	    loadPage(1); // Load the initial list

	    function loadPage(page) {
	        var roomState = $('#state').val();
	        var roomDong = $('#dong').val();
	        var roomType = $('#type').val();
	        var roomHo = $('#ho').val();
	        $.ajax({
	            url: '/topaz/groupware/room/roomList/filter',
	            method: 'POST',
	            data: {
	                roomState: roomState,
	                roomDong: roomDong,
	                roomType: roomType,
	                roomHo: roomHo,
	                currentPage: page,
	                rowPerPage: 5
	            },
	            
	            success: function(response) {
					var tbody = $('table.table-hover tbody');
					tbody.empty();
					response.roomList.forEach(function(item) {
						var row = '<tr>';
						row += '<td>' + item.roomState + '</td>';
						row += '<td>' + item.roomDong + '</td>';
						row += '<td>' + item.roomHo + '</td>';
						row += '<td>' + item.gstName + '</td>';
						// roomStatus에 따라 버튼 활성화/비활성화
					    if (item.roomStatus === 'DIRTY') {
					        row += '<td><a href="/topaz/groupware/room/roomList/state?roomNo='+item.roomNo+'" class="btn btn-primary">'+item.roomStatus+'</a></td>';
					    } else if (item.roomStatus === 'CLEAN') {
					        row += '<td><button class="btn btn-secondary" disabled>'+item.roomStatus+'</button></td>';
					    }
						row += '<td>' + item.schedule + '</td>';
						row += '<td>' + item.scheModId + '</td>';
						row += '</tr>';
						tbody.append(row);
					});
					
					updatePagination(response.totalPages, page);	
				}
			});
		}
	    
	    
	    
	    function updatePagination(totalPages, currentPage) {
			var pagination = $('.pagination');
			pagination.empty();
			for (var i = 1; i <= totalPages; i++) {
				var activeClass = (i === currentPage) ? 'active' : '';
				var pageItem = '<li class="page-item ' + activeClass + '">';
				pageItem += '<a class="page-link" data-page="' + i + '" href="#">' + i + '</a>';
				pageItem += '</li>';
				pagination.append(pageItem);
			}
			$('.pagination .page-link').on('click', function(e) {
				e.preventDefault();
				var page = $(this).data('page');
				loadPage(page);
			});
		}


	    
	    
	    // Initialize state dropdown
	    $.ajax({
	        url: '/topaz/groupware/room/roomList/roomState',
	        method: 'POST',
	        dataType: 'json',
	        success: function(roomData) {
	        	console.log("roomState입주상태 드롭박스", roomData);
	            roomData.forEach(function(item) {
	                $('#state').append('<option value="' + item + '">' + item + '</option>');
	            });
	        }
	    });

	    // Event listener for state change to load dong data
	    $('#state').change(function() {
	        if ($('#state').val() === '') {
	            return;
	        }

	        $('#dong').empty().append('<option value="">동을 선택하세요</option>');
	        $('#type').empty().append('<option value="">타입을 선택하세요</option>');
	        $('#ho').empty().append('<option value="">호수를 선택하세요</option>');

	        $.ajax({
	            url: '/topaz/groupware/resident/residentList/dong',
	            method: 'POST',
	            data: { roomState: $('#state').val() },
	            success: function(dongData) {
	            	console.log("dongData--> ", dongData);
	                dongData.forEach(function(item) {
	                    $('#dong').append('<option value="' + item + '">' + item + '</option>');
	                });
	            }
	        });
	    });

	    // Event listener for dong change to load type data
	    $('#dong').change(function() {
	        if ($('#dong').val() === '') {
	            return;
	        }

	        $('#type').empty().append('<option value="">타입을 선택하세요</option>');
	        $('#ho').empty().append('<option value="">호수를 선택하세요</option>');

	        $.ajax({
	            url: '/topaz/groupware/resident/residentList/type',
	            method: 'POST',
	            data: { dong: $('#dong').val() },
	            success: function(typeData) {
	            	console.log("typeData--> ", typeData);
	                typeData.forEach(function(item) {
	                    $('#type').append('<option value="' + item + '">' + item + '</option>');
	                });
	            }
	        });
	    });

	    // Event listener for type change to load ho data
	    $('#type').change(function() {
	        if ($('#type').val() === '') {
	            return;
	        }

	        $('#ho').empty().append('<option value="">호수를 선택하세요</option>');

	        $.ajax({
	            url: '/topaz/groupware/resident/residentList/ho',
	            method: 'POST',
	            data: { type: $('#type').val() },
	            success: function(hoData) {
	            	console.log("hoData--> ", hoData);
	                hoData.forEach(function(item) {
	                    $('#ho').append('<option value="' + item + '">' + item + '</option>');
	                });
	            }
	        });
	    });

	    // Reload data when any filter changes
	    $('#state, #dong, #type, #ho').change(function() {
	        loadPage(1);
	    });
	});
	
	window.loadPage = function(page) {
	    $(document).ready(function() {
	        loadPage(page);
	    });
	}
	</script>
	
</body>

</html>
