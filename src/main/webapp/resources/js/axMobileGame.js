// ** Ajax_Mobile Game List **

$(function() {

	// ** Ajax_Mobile Game List
	$('#axMobileGame').click(function() {
	
		let dataForm = $('#GameForm').serialize();
		
		$.ajax({
			type: 'Get',
			url: 'mobileGameList',
			data: dataForm,
			success: function(resultPage) {
				$('#resultArea').html(resultPage);
			},
			error: function() {
				$('#resultArea').html('서버 오류, 잠시 후 다시 시도해주시기를 바랍니다.');
			}

		}); // ajax
	}); // axMobileGame_click
	
	
	$('.aclick').click(function(e) {
	
		let url = $(this).attr('href');
		e.preventDefault();
		$.ajax({
			type: 'Get',
			url: url,
			success: function(resultPage) {
				$('#resultArea').html(resultPage);
			},
			error: function() {
				$('#resultArea').html('서버 오류, 잠시 후 다시 시도해주시기를 바랍니다.');
			}

		}); // ajax
	}); // aclick
	
}); // ready