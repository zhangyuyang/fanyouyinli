dinner_list = ->
	# 在页面加载之前，先判断用户有没有加入此聚餐，如果有，预定位子按钮变灰色
	$(".apply_members").each ->
		if $(this).val() == $("#user_photo0").val()
			$(".book_table").css "background-position":"0px -125px"

	$(".members").each ->
		if $(this).val() == $("#user_photo0").val()
			$(".book_table").css "background-position":"0px 0px"

