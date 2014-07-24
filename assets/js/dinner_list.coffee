traversal_apply_members = (e_mail, dinner_id) ->
	$.post "/user_get",
		e_mail : e_mail
	, (data, status) ->
		if !status
			console.log "失败"
		else
			console.log "data.user"
			console.log data.user
			console.log data.user.name
			console.log data.user.introduce
			user_photo = "../small/"+data.user.photo0
			clone_user = $("span.dinner_list_users.remove_class").clone()
			$("div.dinner_list_3").append clone_user
			clone_user.css "display":"inline-block"
			clone_user.find("a.dinner_list_little_photo").css "background-image":"url(" + user_photo + ")"
			clone_user.find("a.dinner_list_little_photo").attr "href", "../ifanyor/"+data.user.photo0
			clone_user.find("a.dinner_list_username").text data.user.name
			clone_user.find("span.dinner_list_span").text data.user.introduce
			# clone_user.find("a.dinner_list_agree_user").attr "href", "../接受"
			# clone_user.find("a.dinner_refuse").attr "href", "../拒绝"
			clone_user.removeClass "remove_class"
			# 绑定点击事件
			clone_user.find("a.dinner_list_agree_user").click ->
				$.post "/authorized_menbers",
					e_mail : data.user.e_mail
					dinner_id : dinner_id
				, (data, status) ->	
					if status
						alert "审核成功"
			clone_user.find("a.dinner_refuse").click ->
				$.post "/refuse_menbers",
					e_mail : data.user.e_mail
					dinner_id : dinner_id
				, (data, status) ->	
					if status
						alert "拒绝加入"

			

preview_menbers = (e_mail) ->
	$.post "/user_get",
		e_mail : e_mail
	, (data, status) ->
		if !status
			console.log "失败"
		else
			console.log data.user 
			user_photo = "../small/"+data.user.photo0
			clone_user = $("span.dinner_list_users.remove_class").clone()
			$("div.dinner_list_3").append clone_user
			clone_user.css "display":"inline-block"
			clone_user.find("a.dinner_list_little_photo").css "background-image":"url(" + user_photo + ")"
			clone_user.find("a.dinner_list_little_photo").attr "href", "../ifanyor/"+data.user.photo0
			clone_user.find("a.dinner_list_agree_user").css "display":"none"
			clone_user.find("a.dinner_refuse").css "display":"none"
			clone_user.removeClass "remove_class"	

dinner_list = ->
	# 在页面加载之前，先判断用户有没有加入此聚餐，如果有，预定位子按钮变灰色
	$(".apply_members").each ->
		if $(this).val() == $("#e_mail").val()
			$(".book_table").css "background-position":"0px -125px"

	$(".members").each ->
		if $(this).val() == $("#user_photo0").val()
			$(".book_table").css "background-position":"0px 0px"

preview_user = ->
	# 获取当前页面的聚餐编号
	dinner_id = window.location.href.split("idinner/")[1]
	# 创建者审批用户功能
	if $("#user_email").val() == $("#creater_email").val()
		# 遍历所有申请人
		$("input.apply_members").each ->
			# 展现和绑定功能
			traversal_apply_members $(this).val(), dinner_id
			# alert $(this).val()


	# 遍历所有参与人
	$(".members").each ->
		# 展现
		console.log "遍历所有参与人的e_mail"
		console.log $(this).val()
		preview_menbers $(this).val()
		