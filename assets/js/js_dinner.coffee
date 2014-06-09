creat_dinner = ->
	$(document).ready ->
		$("#go_dinner").click ->
			console.log "zhengchang"
			$("#great_dinner").submit()

user_tag = ->
	$(document).ready ->
		$("#add_lab_button").click ->
			hope_add_tag = $("#add_lab_input").val()
			console.log $("#add_lab_input").val()
			# 校验重复提交
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
							console.log data.info
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

		$("#creat_dinner_submit").click ->
			console.log "准备提交数据了"
			dinner_tag_input = $("#dinner_tag_input").val()
			dining_locations = $("#dining_locations").val()
			dining_locations_info = $("#dining_locations_info").val()
			dinner_time_input = $("#dinner_time_input").val()
			number_of_meals = $("#number_of_meals").val()
			val = $("input:radio[name=\"payment_method\"]:checked").val()
			unless val?
				alert "什么也没选中!"
				return false
			else
				payment_method = val
			have_tag = $(document).find(".my_leb_text1")
			number = 0
			string_tag = new Array()
			have_tag.each (i) ->
				string_tag[i] = $(this).text()
				number++

			description = $("#description").val()
			tel_of_meals = $("#tel_of_meals").val()

			$.post "/creat_dinner",
				dinner_tag_input: dinner_tag_input
				dining_locations: dining_locations
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
					# alert status+"success"
					# clone_tag = $("#my_lab_clone").clone()
					# clone_tag.find("#my_leb_text").html hope_add_tag
					# $(".my_lab_div").append clone_tag
					# clone_tag.find('#delete_my_leb').bind 'click', delete_tag
				else 
					console.log "err"
					alert status+"error"