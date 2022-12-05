// ** Ajax_PC Game List **

$(function() {

	// ** Ajax_Flash Game List
	$('#axFlashGame').click(function() {
	
		let dataForm = $('#GameForm').serialize();
		
		$.ajax({
			type: 'Get',
			url: 'flashGameList',
			data: dataForm,
			success: function(resultPage) {
				$('#resultArea').html(resultPage);
			},
			error: function() {
				$('#resultArea').html('서버 오류, 잠시 후 다시 시도해주시기를 바랍니다.');
			}

		}); // ajax
		
	}); // axFlashGame_click
	
	
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