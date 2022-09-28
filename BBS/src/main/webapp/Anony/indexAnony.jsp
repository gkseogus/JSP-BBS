<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width. initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/customAnony.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>JSP AJAX 실시간 익명 채팅 사이트</title>
<script type="text/javascript">
	var lastID = 0;
	function submitFunction() {
		// 사용자가 입력한 이름, 내용 값을 담는다.
		var chatName = $("#chatName").val();
		var chatContent = $("#chatContent").val();
		// ajax로 서버와 통신
		$.ajax({
			type : "POST",
			url : "../ChatSubmitServlet",
			data : {
				chatName : encodeURIComponent(chatName),
				chatContent : encodeURIComponent(chatContent)
			},
			// 데이터 전송 여부 확인
			success : function(result) {
				if (result == 1) {
				} else if (result == 0) {
					alert('실패');
				} else {
					alert('db오류');
				}
			}
		});
		// 전송 창을 비워두기 위함
		$('#chatContent').val('');
	}
	// 파싱한 데이터를 배열로 출력하는 함수
	function chatListFunction(type) {
		// ajax로 서버와 통신
		$.ajax({
			type : "POST",
			url : "../ChatListServlet",
			data : {
				listType : type,
			},
			success : function(data) {
				var parsed = JSON.parse(data);
				var result = parsed.result;
				for (var i = 0; i < result.length; i++) {
					addChat(result[i][0].value, result[i][1].value,
							result[i][2].value);
				}
				lastID = Number(parsed.last);
			}
		});
	}

	// 채팅 노출 시키는 함수
	function addChat(chatName, chatContent, chatTime) {
		$('#chatList')
				.append(
						'<div class="row">'
								+ '	<div class="col-lg-12">'
								+ '		<div class="media">'
								+ '<a class="pull-left" href="#"> '
								+ '<img class="media-object img-circle" src="../images/vForVendetta.png">'
								+ '	</a>' + '		<div class="media-body">'
								+ '				<h4 class="media-heading">' + chatName
								+ '<span class="small pull-right">' + chatTime
								+ '</span>' + '	</h4>' + '</div>' + '	<p>'
								+ chatContent + '</p>' + '	</div>' + '	</div>'
								+ '	</div>' + '<hr>');
	}
	
	// 채팅을 1초마다 불러오는 함수
	function getInfiniteChat() {
		setInterval(() => {
			chatListFunction(lastID);
		}, 1000);
	}
</script>
</head>
<body>
	<div class="container">
		<div class="container bootstrap snippet">
			<div class="row">
				<div class="col-xs-12">
					<div class="portlet portlet-default">
						<div class="portlet-heading">
							<div class="portlet-title">
								<h4>
									<i class="fa fa-circle text-green"></i>실시간 익명 채팅방
								</h4>
							</div>
							<div class="clearfix"></div>
						</div>
						<div id="chat" class="panel-collapse collapse in">
							<div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 300px;"></div>
							<div class="portlet-footer">
								<div class="row">
									<div class="form-group col-xs-4">
										<input style="height: 40px;" type="text" id="chatName" class="form-control" placeholder="이름" maxlength="8">
									</div>
								</div>
								<div class="row" style="height: 90px">
									<div class="form-group col-xs-10">
										<textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="메시지를 입력하세요." maxlength="100"></textarea>
									</div>
									<div class="form-group col-xs-2">
										<button type="button" class="btn btn-default pull-right" onclick="submitFunction();">전송</button>
										<div class="clearfix"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			chatListFunction('ten');
			getInfiniteChat();
		});
	</script>
</body>
</html>