// ** Ajax ReadPost - 게시판 댓글달기 **

// 댓글 (등록, 수정, 삭제)
$(function () {

    // ** 댓글 등록
    $('.sclick').click(function () {

        var url = "./writeReply";

        if ($('#replyContent').val().length > 0) {

            $.ajax({
                type: 'GET',
                url: url,
                data: { "content": $('#replyContent').val(), "seq": $('#seq').val() },
                success: function (response) {

                    var loginId = $('#loginId').val();

                    if (response.message == 200) {
                        $('#replyaddlist').empty();

                        response.list.forEach(function (el, idx) {

                            var html = '';
							html += '<div class="reply_border">'
							html += '<div class="board_reply">'
                            html += '<li class="color-choi">' + el.id + ' &nbsp;|&nbsp; ' + el.regdate + '</li>';
                            html += '<li class="replyContentLi">' + el.content + '</li>';

                            if (loginId == el.id || loginId == 'admin') {
								html += '<div class="reply_btns">';
                                html += '<input type="button" value="수정" class="reply_update reply_btn" id=' + el.reply_number + '>&nbsp;';
                                html += '<input type="button" value="삭제" class="reply_delete reply_btn" id=' + el.reply_number + '>';
								html += '<div></div></div>';
                            }

                            $('#replyaddlist').append(html);
                        });

                        $('#replyContent').val('');
                    }
                },
                error: function (response) {
                    $('#writeReply').html('** 서버 오류! 잠시 후 다시 시도해주세요');
                }
            }); // ajax

        } else {
            alert('내용을 입력해주세요.');
        }

    }); // sclick

    //----------------------------------------------------------------------------------------------------------------------------------------

    // ** 댓글 수정 1 - 수정 버튼 누르면 textarea 생성
    $('.reply_update').click(function () {

        let replyNumber = $(this).attr('id');

        $('#acontent' + replyNumber).html(
            "<textarea id='editAcontent" + replyNumber + "'>" + $('#replyContentLi' + replyNumber).text() + "</textarea>"
        );

        $('#abt' + replyNumber).html(
            "<button class='reply_btn' id='btnEdit" + replyNumber + "'>완료</button> "
            + "<button class='reply_btn' onclick=location.href='readPost?seq=" + $('#seq').val() + "' id='btnCancel'>취소</button>"
        );
    });

    //----------------------------------------------------------------------------------------------------------------------------------------

    // ** 댓글 수정 2 - textarea에 text 입력 후 완료 버튼 누르고 데이터 입력
    $(document).on("click", "[id^=btnEdit]", function () {

        let replyNumber = $(this).attr('id').replace('btnEdit', '');
        var url = "./modifyReply";

        $.ajax({
            type: 'GET',
            url: url,
            data: {
                "reply_number": replyNumber,
                "seq": $('#seq').val(),
                "content": $('#editAcontent' + replyNumber).val()
            },

            success: function (response) {
                if (response.message == 200) {
                    window.location.reload();
                }
            },
            error: function (response) {
                $('#writeReply').html('** 서버 오류 ! 잠시 후 다시 시도해주세요');
            }
        })
    });

    // ** 댓글 삭제
    $(document).on("click", ".reply_delete", function () {

        let replyNumber = $(this).attr('id');

        var url = "./deleteReply";

        $.ajax({
            type: 'GET',
            url: url,
            data: {
                reply_number: replyNumber
            },
            success: function (response) {

                if (response.message == 200) {
                    window.location.reload();
                } // if

            },
            error: function () {
                $('#writeReply').html('** 서버 오류 ! 잠시 후 다시 시도해주세요');
            }
        }); // ajax

    }); // delete_click

}); // ready