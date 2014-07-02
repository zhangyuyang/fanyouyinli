addEventHandler = (target, type, func) ->
	# 这里是考虑浏览器的兼容问题
	if target.addEventListener
		target.addEventListener type, func, false
	else if target.attachEvent
		target.attachEvent "on" + type, func
	else
		target["on" + type] = func
	return

# 移除元素和事件的绑定
removeEventHandler = (target, type, func) ->
	# 这里是考虑浏览器的兼容问题
	if target.removeEventListener
		target.removeEventListener type, func, false
	else if target.detachEvent
		target.detachEvent "on" + type, func
	else
		delete target["on" + type]
	return
 # 这个方法是判断当前点击的元素，是不是弹出区域的子元素，如果是区域外，则弹出消失
document_MouseDown = (e) ->
	# 初始化
	element = $(e.target)
	console.log element 
	# event等于event.srcElement,展现出来的元素
	# e.target也是展现出来的元素
	# 于是element就等于展现出来的元素
	# downPanel初始化FALSE
	downPanel = false
	if element[0] == $("#hidden_login_button")
		return false
	else  
		i = 0
		while i < 10
			# 寻找element元素是不是我们点击的元素
			if element[0] == $(".hidden_login")[0]
				downPanel = true 
				break
			# 如果downPanel为真，则停止执行后面语句
			else
				element = element.parent()
				console.log element
				i++
			# 如果一直是假的，说明点击的地方在元素外部，则元素消失
			# 移除监听事件，元素消失
		unless downPanel
			removeEventHandler document, "mousedown", document_MouseDown
			$(".hidden_login").css "display","none"


book_table = ->
	$(".book_table").click ->
		console.log "与定位子"
		$.get "/book_table", (data, status) ->
			if !data.flag
				console.log "用户没登陆，提示登陆,位子失败"
				hidden_login_out()
			else
				console.log "用户已经登陆，直接预定位子"
			
		return false 

hidden_login_out = ->
	$(".hidden_login").css "display":"block"
	addEventHandler document, "mousedown", document_MouseDown
	eMaliReg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
	$("#hidden_login_button").click ->
		hidden_login_email = $("#hidden_login_email").val()
		hidden_login_password = $("#hidden_login_password").val()
		console.log "hidden_login_password"+hidden_login_password
		if !eMaliReg.test(hidden_login_email)
			$(".hidden_login_text1").html "E-mail格式不对"
			$("#hidden_login_email").focus()
			return false
		else if $("#hidden_login_password").val() == ""
			$(".hidden_login_text1").html "密码不能为空"
			return false
		else 
			console.log "账号密码通过校验，开始提交"
			$.post "/hidden_login",
				hidden_login_email : hidden_login_email
				hidden_login_password : hidden_login_password
			, (data, status) ->
				$(".hidden_login_text1").html data.tips
				if data.status
					console.log "说明登陆成功"
					$("#now_city").html data.city
					location.reload true
					return false
				else
					console.log "这里登陆失败，具体显示失败原因"
					return false
			return false

			