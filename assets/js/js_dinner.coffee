creat_dinner = ->
	$(document).ready ->
		$("#go_dinner").click ->
			console.log "zhengchang"
			$("#great_dinner").submit()

user_tag = ->
	$(document).ready ->
		$("#add_cover").click ->
			$(".add_dinner_photo_border").css "display","block"
			return false
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
						console.log "这里是JS的add_tag"
						if status
							alert status+"success"
						else 
							alert status+"error"
		delete_tag = ->
			delete_tag_form = $(this).parent()
			tag_text = delete_tag_form.find("#my_leb_text").text()

			$.post "/delete_tag",
				tag: tag_text
			, (data, status) ->
				if data.status
					delete_tag_form.css "display", "none"

		delete_tag_button = $(document).find(".delete_my_leb")
		delete_tag_button.each (i) ->
			$(this).click delete_tag
			return
		$("#inner_button").click ->
			$("#file").click()
			$("#inner_button").css "background-position","-413px -72px"
		$("#creat_dinner_submit").click ->
			console.log "准备提交数据了"
			dinner_tag_input = $("#dinner_tag_input").val()
			dining_locations = $("#dining_locations").val()
			hours = $("#hours").val()
			minute = $("#minute").val()
			dining_locations_info = $("#dining_locations_info").val()
			dinner_time_input = $("#dinner_time_input").val()
			number_of_meals = $("#number_of_meals").val()
			description = $("#description").val()
			tel_of_meals = $("#tel_of_meals").val()
			# 开始做校验
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
			, (data, status) ->
				console.log "这里是JS的add_tag"
				if status
					console.log "这里有data"+data
				else 
					console.log "err"
					alert status+"error"