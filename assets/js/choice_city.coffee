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
	if element[0] == $(".choice_city_name")
		return false
	else	
		i = 0
		while i < 10
			# 寻找element元素是不是我们点击的元素
			if element[0] == $(".choice_city")[0]
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
			$(".choice_city").css "display","none"

post_choice_city = (choice_city) ->
	$.post "/modify_user_city",
		city : choice_city
	, (data, status) ->
		if data
			console.log "修改城市成功"
			$(".now_city").html choice_city
			window.location.href = "/idinner"
		else
			console.log "修改城市失败"
			$(".now_city").html "城市选择失败"
			return false
choice_city = ->
	$(document).ready ->
		$("#chengshisanjiao").click ->
			$(".choice_city").css "display":"block"
			# 这个是上面方法的入口
			addEventHandler document, "mousedown", document_MouseDown
			$("#beijing").click ->
				console.log "这里点击了北京1"
				# post_choice_city "北京"

			$("#shanghai").click ->
				post_choice_city "上海"

			$("#guangzhou").click ->
				post_choice_city "广州"

			# $("#xiamen").click ->
				# post_choice_city "厦门"

			$("#shenzhen").click ->
				post_choice_city "深圳"

			$("#hangzhou").click ->
				post_choice_city "杭州"

