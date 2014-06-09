
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
							clone_tag = $("#my_lab_clone").clone()
							clone_tag.find("#my_leb_text").html hope_add_tag
							$(".my_lab_div").append clone_tag
							clone_tag.find('#delete_my_leb').bind 'click', delete_tag
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
