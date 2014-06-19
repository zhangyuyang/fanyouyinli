img_adapter = (div_width, div_height, img_width, img_height)->     
	w = img_width
	h = img_height
	img_scale = w / h
	div_scale = div_width / div_height
	if (img_scale >= div_scale) then (w = div_width) else (h = div_height)
	if w == div_width
		scale = div_width / img_width
	else
		scale = div_height / img_height
	return [img_width * scale, img_height * scale]