change = ->
	console.log "进到change里面了"
	
	pic = document.getElementById("dinner_photo_preview")
	file = document.getElementById("file")
	ext = file.value.substring(file.value.lastIndexOf(".") + 1).toLowerCase()

	# gif在IE浏览器暂时无法显示
	if ext isnt "png" and ext isnt "jpg" and ext isnt "jpeg"
		console.log "文件必须为图片！"
		alert "文件必须为图片！"
		return false
	
	# IE浏览器
	if document.all
		file.select()
		reallocalpath = document.selection.createRange().text
		ie6 = /msie 6/i.test(navigator.userAgent)
		
		# IE6浏览器设置img的src为本地路径可以直接显示图片
		if ie6
			pic.src = reallocalpath
		else
			# 非IE6版本的IE由于安全问题直接设置img的src无法显示本地图片，但是可以通过滤镜来实现
			pic.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='image',src=\"" + reallocalpath + "\")"
			
			# 设置img的src为base64编码的透明图片 取消显示浏览器默认图片
			pic.src = "data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="
	else
		html5Reader file
	return
html5Reader = (file) ->
	file = file.files[0]
	console.log file
	reader = new FileReader()
	reader.readAsDataURL file
	reader.onload = (e) ->
		pic = document.getElementById("dinner_photo_preview")
		pic.src = @result
		return

	return