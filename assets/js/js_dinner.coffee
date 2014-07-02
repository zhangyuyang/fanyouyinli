image_adaptation_width = undefined
image_adaptation_height = undefined
user_tag1 = ->
	$(document).ready ->
		$("#add_lab_button").click ->
			hope_add_tag = $("#add_lab_input").val()
			console.log $("#add_lab_input").val()
			have_tag = $(document).find(".my_leb_text1")
			number = 0
			string_tag = new Array()
			have_tag.each (i) ->
				string_tag[i] = $(this).text()
				number++
			flag = true
			for tag in string_tag
				if tag is hope_add_tag
					flag = false
			if flag
				$.post "/add_tag",
					my_tag: hope_add_tag
				, (data, status) ->
					if status
						console.log "ssAAAAAAA"+status
						alert status+"success"
						clone_tag = $("#my_lab_clone").clone()
						console.log "clone_tag"+clone_tag
						$(".my_lab_div1").append clone_tag
						# clone_tag.css "display", "inline-block"
						console.log clone_tag.find("#my_leb_text")
						clone_tag.find("#my_leb_text").html hope_add_tag
						clone_tag.find('#delete_my_leb').bind 'click', delete_tag1
						$("#add_lab_input").focus()

					else 
						console.log "zhelicuole"
						alert status+"error"

		delete_tag1 = ->
			delete_tag_form = $(this).parent()
			tag_text = delete_tag_form.find("#my_leb_text").text()

			$.post "/delete_tag",
				tag: tag_text
			, (data, status) ->
				console.log data
				if data.status
					delete_tag_form.css "display", "none"
					$("#add_lab_input").focus()

		delete_tag_button = $(document).find(".delete_my_leb")
		delete_tag_button.each (i) ->
			$(this).click delete_tag1

		$("#add_cover").click ->
			$("#add_dinner_photo_border").css "display","inline-block"

			# 封面预览小图部分

			$("#choice_min_photo1").click ->
				s = $("#choice_min_photo1").css "background-image"
				ss = s.substring 4, (s.length-1)
				$("#dinner_photo_preview").attr "src" ,ss
				return false
			$("#choice_min_photo2").click ->
				s = $("#choice_min_photo2").css "background-image"
				ss = s.substring 4, (s.length-1)
				$("#dinner_photo_preview").attr "src" ,ss
				return false
			$("#choice_min_photo3").click ->
				s = $("#choice_min_photo3").css "background-image"
				ss = s.substring 4, (s.length-1)
				$("#dinner_photo_preview").attr "src" ,ss
				return false
			$("#choice_min_photo4").click ->
				s = $("#choice_min_photo4").css "background-image"
				ss = s.substring 4, (s.length-1)
				$("#dinner_photo_preview").attr "src" ,ss
				return false
			$("#choice_min_photo5").click ->
				s = $("#choice_min_photo5").css "background-image"
				ss = s.substring 4, (s.length-1)
				$("#dinner_photo_preview").attr "src" ,ss
				return false
			$("#choice_min_photo6").click ->
				s = $("#choice_min_photo6").css "background-image"
				ss = s.substring 4, (s.length-1)
				$("#dinner_photo_preview").attr "src" ,ss
				return false
			$("#choice_min_photo7").click ->
				s = $("#choice_min_photo7").css "background-image"
				ss = s.substring 4, (s.length-1)
				$("#dinner_photo_preview").attr "src" ,ss
				return false
			$("#choice_min_photo8").click ->
				s = $("#choice_min_photo8").css "background-image"
				ss = s.substring 4, (s.length-1)
				$("#dinner_photo_preview").attr "src" ,ss
				return false
			# 封面弹出部分
			# 添加元素和事件的绑定
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
				if element[0] == $("#inner_button")[0]
                    $("#file").click()
                    $("#inner_button").css "background-position","-413px -73px"
				else
					i = 0
					while i < 10
						# 寻找element元素是不是我们点击的元素
						if element[0] == $("#add_dinner_photo_border")[0]
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
						$("#add_dinner_photo_border").css "display","none"
				$("#file").change ->
					# 使用change()里面的方法，来校验上传图片的格式
					change()
					# 根据上传的图片进行预览

					# 获取替换图片的路径地址
					console.log $("#file").val().split("\\").pop()
					# 替换图片
					console.log $("#dinner_photo_preview").attr "src", "images\\"+$("#file").val().split("\\").pop()
					# 当图片替换完成后，第一时间获取替换图片的原始尺寸
					$("#dinner_photo_preview").load ->
						# 根据上传的图片大小，自动适配出适合DIV的缩放尺寸
						[a, b] = img_adapter(400,260,$("#dinner_photo_preview").width(), $("#dinner_photo_preview").height())
						image_adaptation_width = a
						image_adaptation_height = b
						$("#dinner_photo_preview").css 
							"width": a
							"height": b
						# 这里是把图片的SRC地址，改成data/img格式
						change()

					$("#inner_button").css "display","none"
					$("#inner_button1").css 
						"display":"inline-block"
						"outline":"none"
					$("#inner_button1")[0].focus()
				$("#inner_button1").click ->
					$("#add_dinner_photo_border").css "display","none"
					return false

			# 绑定鼠标单击任何区域的事件 
			addEventHandler document, "mousedown", document_MouseDown
			return false



		$("#creat_dinner_submit").click ->
			console.log "准备提交数据了"
			dinner_tag_input = $("#dinner_tag_input").val()
			dining_locations = $("#dining_locations").val()
			hours = $("#hours").val()
			minute = $("#minute").val()
			dining_locations_info = $("#page_city").html() + $("#dining_locations_info").val() 
			console.log dining_locations_info
			dinner_time_input = $("#dinner_time_input").val()
			number_of_meals = $("#number_of_meals").val()
			description = $("#description").val()
			tel_of_meals = $("#tel_of_meals").val()
			dinner_image = $("#dinner_photo_preview")[0].src
			city = $(".now_city").html()
			console.log city
			# # 开始做校验
			val = $("input:radio[name=\"payment_method\"]:checked").val()
			unless val?
				alert "费用没有选中!"
				return false
			else
				payment_method = val
			have_tag = $(document).find(".my_leb_text1")
			number = 0
			string_tag = new Array()
			have_tag.each (i) ->
				string_tag[i] = $(this).text()
				number++
			# 标题必须在2-50个字节
			if !validator.isByteLength dinner_tag_input, 2 ,10 
				$("#dinner_tag_input_tip1").css "display", "none"
				$("#dinner_tag_input_tr").css "display","inline-block"
				$("#dinner_tag_input_tip").css "display","inline"
				return false
			else  
				$("#dinner_tag_input_tr").css "display","none"
				$("#dinner_tag_input_tip").css "display","none"
			console.log "22222"
			if !validator.isByteLength dining_locations_info, 2 ,10 
				$("#dinner_locations_info_tip").css "display","inline"
				$("#dinner_locations_info_tr").css "display","inline-block"
				$("#dining_locations_info").focus()
				return false
			else
				$("#dinner_locations_info_tip").css "display","none"
				$("#dinner_locations_info_tr").css "display","none"
			console.log "11111"
			date_reg = /^(?:(?:(?:(?:(?:1[6-9]|[2-9][0-9])?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))([-/.])(?:0?2\1(?:29)))|(?:(?:(?:1[6-9]|[2-9][0-9])?[0-9]{2})([-/.])(?:(?:(?:0?[13578]|1[02])\2(?:31))|(?:(?:0?[13-9]|1[0-2])\2(?:29|30))|(?:(?:0?[1-9])|(?:1[0-2]))\2(?:0?[1-9]|1[0-9]|2[0-8]))))$/
			if !date_reg.test(dinner_time_input)
				$("#dinner_time_tip").css "display","inline"
				$("#dinner_time_tr").css "display","inline-block"
				return false
			else
				$("#dinner_time_tip").css "display","none"
				$("#dinner_time_tr").css "display","none"

			if !validator.isNumeric number_of_meals
				$("#number_of_meals_tip").css "display","inline"
				$("#number_of_meals_tr").css "display","inline-block"
				return false
			else
				$("#number_of_meals_tip").css "display","none"
				$("#number_of_meals_tr").css "display","none"
				
			if number_of_meals < 0 || number_of_meals > 50
				$("#number_of_meals_tip").css "display","inline"
				$("#number_of_meals_tr").css "display","inline-block"
				return false
			else
				$("#number_of_meals_tip").css "display","none"
				$("#number_of_meals_tr").css "display","none"

			if validator.isNull description
				$("#description_tip").css "display","inline"
				$("#description_tr").css "display","inline-block"
				return false
			else
				$("#description_tip").css "display","none"
				$("#description_tr").css "display","none"

			telphone_reg = /^1[3|5][0-9]\d{4,8}$/
			console.log tel_of_meals
			if !telphone_reg.test(tel_of_meals)
				$("#get_dinner_num").css "display","none"
				$("#tel_of_meals_tip").css "display","inline"
				$("#tel_of_meals_tr").css "display","inline-block"
				return false
			else
				$("#tel_of_meals_tip").css "display","none"
				$("#tel_of_meals_tr").css "display","none"
			if $("#file").val() is '' or $("#file").val() == null
				alert "封面为必选"
				return false
			console.log "下面JS开始POST数据了 "
			$.post "/creat_dinner",
				dinner_tag_input: dinner_tag_input
				dining_locations: dining_locations
				hours: hours
				minute: minute
				dining_locations_info: dining_locations_info
				dinner_time_input: dinner_time_input
				number_of_meals: number_of_meals
				payment_method: payment_method
				string_tag: string_tag
				description: description
				tel_of_meals: tel_of_meals
				dinner_image: dinner_image
				image_adaptation_width: image_adaptation_width
				image_adaptation_height: image_adaptation_height 
				city: city
			, (data, status) ->
				console.log "这里是JS的add_tag"
				if data.status
					console.log "这里有data"+data
					location.reload true
				else 
					console.log "err"
					alert status+"error"
					console.log "新增聚餐失败错误"