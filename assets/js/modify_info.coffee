modify_info = ->
	console.log "进入了modify_info"
	$("#modiy_user_sub").click ->
		console.log $("#true_name").val()
		console.log $("#province").val()
		console.log $("#city").val()
		console.log $("input[name='sex']:checked").val()
		console.log $("input[name='marriage']:checked").val()
		console.log $(".sel_year").val()
		console.log $(".sel_month").val()
		console.log $(".sel_day").val()
		console.log $("#myself").val()
		$.post "/modify_info",
			name : $("#true_name").val()
			province : $("#province").val()
			city : $("#city").val()
			sex : $("input[name='sex']:checked").val()
			marry : $("input[name='marriage']:checked").val()
			year : $(".sel_year").val()
			month : $(".sel_month").val()
			day : $(".sel_day").val()
			myself : $("#myself").val()
		,(data, status) ->
			if !status
				alert "修改失败"
			else
				alert "修改成功"
			