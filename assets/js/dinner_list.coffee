traversal_apply_members = (photo0_url) ->
	user_photo = "../small/"+photo0_url
	clone_user = $("span.dinner_list_users.remove_class").clone()
	$("div.dinner_list_3").append clone_user
	clone_user.css "display":"inline-block"
	clone_user.find("a.dinner_list_little_photo").css "background-image":"url(" + user_photo + ")"
	clone_user.find("a.dinner_list_little_photo").attr "href", "../ifanyor/"+photo0_url
	clone_user.find("a.dinner_list_agree_user").attr "href", "../接受"
	clone_user.find("a.dinner_refuse").attr "href", "../拒绝"
	clone_user.removeClass "remove_class"

preview_menbers = (photo0_url) ->
	user_photo = "../small/"+photo0_url
	clone_user = $("span.dinner_list_users.remove_class").clone()
	$("div.dinner_list_3").append clone_user
	clone_user.css "display":"inline-block"
	clone_user.find("a.dinner_list_little_photo").css "background-image":"url(" + user_photo + ")"
	clone_user.find("a.dinner_list_little_photo").attr "href", "../ifanyor/"+photo0_url
	clone_user.find("a.dinner_list_agree_user").css "display":"none"
	clone_user.find("a.dinner_refuse").css "display":"none"
	clone_user.removeClass "remove_class"	

dinner_list = ->
	# 在页面加载之前，先判断用户有没有加入此聚餐，如果有，预定位子按钮变灰色
	$(".apply_members").each ->
		if $(this).val() == $("#user_photo0").val()
			$(".book_table").css "background-position":"0px -125px"

	$(".members").each ->
		if $(this).val() == $("#user_photo0").val()
			$(".book_table").css "background-position":"0px 0px"

preview_user = ->
	# 创建者审批用户功能
	if $("#creater").val() == $("#user_photo0").val()
		# 遍历所有申请人
		$("input.apply_members").each ->
			traversal_apply_members $(this).val()


	# 遍历所有参与人
	$(".members").each ->
		preview_menbers $(this).val()
