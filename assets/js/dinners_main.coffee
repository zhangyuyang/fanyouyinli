dinners_main = ->
	preview_dinners = 0
	$(document).ready ->
		page_number = undefined
		# 一进来先加载时间
		today_date()
		fit_height = (elements, nums) ->
			if nums < 0
				elements.css "height":"100px"
				$("#Pagination").css "display":"none"
			else
				$("#Pagination").css "display":"inline-block"
				switch nums
					when 0
						elements.css "height":"100px"
					when 1
						elements.css "height":"360px"
					when 2
						elements.css "height":"400px"
					when 3
						elements.css "height":"600px"
					when 4
						elements.css "height":"840px"
					when 5
						elements.css "height":"1000px"
					when 6
						elements.css "height":"1160px"
					when 7
						elements.css "height":"1320px"
					when 8
						elements.css "height":"1480px"
					when 9
						elements.css "height":"1640px"
					when 10
						elements.css "height":"1800px"
		dinners_preview = (data) ->
			console.log "111111sa"
			i = 0
			console.log "222222sa"
			while i < data.dinners.length
				clone_dinner = $("#dinner_now").clone()
				clone_dinner.addClass "clone_border"
				clone_dinner.addClass "flag_preview"
				preview_dinners = i
				if i >= 0 && i <=9
					console.log "这里开始循环给dinner_now_border0"
					$("#dinner_now_border0").append clone_dinner
				else if i > 9 && i <= 19
					$("#dinner_now_border1").append clone_dinner
				else if i > 19 && i <= 29
					$("#dinner_now_border2").append clone_dinner
				else if i > 29 && i <= 39
					$("#dinner_now_border3").append clone_dinner
				else if i > 39 && i <= 49
					$("#dinner_now_border4").append clone_dinner
				else if i > 49 && i <= 59
					$("#dinner_now_border5").append clone_dinner
				else if i > 59 && i <= 69
					$("#dinner_now_border6").append clone_dinner
				j = 0
				while j < 1
					clone_dinners_lab = $("#dinners_lab").clone()
					$("#small_lab").append clone_dinners_lab
					clone_dinners_lab.find("#dinners_lab_info").html data.dinners[i].string_tag[j]
					(clone_dinners_lab).css "display":"inline-block"
					console.log "标签循环j"+ j
					j++

				clone_dinner.css "display":"inline-block"
				clone_dinner.find("#dinner_photo").attr "src", "../"+data.dinners[i].dinner_image_small
				clone_dinner.find(".dinner_name").html data.dinners[i].dinner_tag
				clone_dinner.find("#dining_locations_info").html data.dinners[i].dining_locations_info
				console.log data.dinners[i].description

				console.log moment(data.dinners[i].dinner_time, "YYYY-MM-DD").format("MM/DD")
				console.log moment(data.dinners[i].dinner_time, "YYYY-MM-DD").format('dddd')
				# 这里是日期
				# 使用第三方库Moment.js来对时间做判定和校验
				if moment(data.dinners[i].dinner_time, "YYYY-MM-DD").endOf('day').from(moment().format("YYYY-MM-DD").toString()) == "in a day"
					clone_dinner.find("#dinner_date").html "今天"
				else if moment(data.dinners[i].dinner_time, "YYYY-MM-DD").endOf('day').from(moment().format("YYYY-MM-DD").toString()) == "in 2 days"
					clone_dinner.find("#dinner_date").html "明天"
				else if moment(data.dinners[i].dinner_time, "YYYY-MM-DD").endOf('day').from(moment().format("YYYY-MM-DD").toString()) == "in 3 days"
					clone_dinner.find("#dinner_date").html "后天"
				else 
					clone_dinner.find("#dinner_date").html moment(data.dinners[i].dinner_time, "YYYY-MM-DD").format("MM/DD")
				# 这里是星期
				week = undefined
				switch moment(data.dinners[i].dinner_time, "YYYY-MM-DD").format('dddd')
					when "Monday"
						week = "星期一"
						console.log "Monday"
					when "Tuesday"
						week = "星期二"
						console.log "Tuesday"
					when "Wednesday"
						week = "星期三"
						console.log "Wednesday"
					when "Thursday"
						week = "星期四"
						console.log "Thursday"
					when "Friday"
						week = "星期五"
						console.log "Friday"
					when "Saturday"
						week = "星期六"
						console.log "Saturday"
					when "Monday"
						week = "星期天"
						console.log "Sunday"
				# 这里是星期加时间
				week_and_time = undefined
				week_and_time = week+" "+data.dinners[i].dining_hours+"："+data.dinners[i].dining_minute
				console.log week_and_time
				clone_dinner.find("#dinner_week").html week_and_time
				clone_dinner.find("#treat").html data.dinners[i].payment_method
				clone_dinner.find(".dinner_jion_btn").attr "href", "idinner/"+data.dinners[i]._id
				# 这里给A标签添加href,使之，单击就能提交到服务器层
				clone_dinner.find(".idinner_photo_border").attr "href", "idinner/"+data.dinners[i]._id
				clone_dinner.find(".dinner_name").attr "href", "idinner/"+data.dinners[i]._id
				i++ 
			# 调取分页的方法进行分页
			initPagination = InitPagination()
		# 获取当前城市
		now_city = $("#now_city").html()
		console.log now_city
		$.post "/get_dinners",
			city : now_city
		, (data, status) ->
			if status
				console.log data.dinners.length
				page_number = Math.ceil(data.dinners.length/10)
				dinners_preview data
				
			else
				console.log status


		$("#go_dinner").click ->
			$("#great_dinner").submit()
		$("#dinner_jion_btn").click ->
		$("#jump_pay").click ->
			$("#jump_all").css "color":"#5c5c5c"
			$("#jump_pay").css "color":"#5bc7d6"
			$("#jump_address").css "color":"#5c5c5c"
			$("#AAzhi").css "color":"#5c5c5c"
			$("#gefuge").css "color":"#5c5c5c"
			$("#woqingke").css "color":"#5c5c5c"
			$("#idinner_navigation").css "height":"44px","margin-bottom":"30px"
			$("#idinner_navigation_pay").css "display":"inline-block","margin-bottom":"30px"
			$("#idinner_navigation_address").css "display":"none"
			return false
		$("#AAzhi").click ->
			$("#dinner_now_border").empty()
			k = 0
			while k < 10
				$("#dinner_now_border"+k).empty()
				k++
			$("#AAzhi").css "color":"#5bc7d6"
			$("#gefuge").css "color":"#5c5c5c"
			$("#woqingke").css "color":"#5c5c5c"
			$.post "/get_dinners_sort",
				sort_type : "AA制"
				sort_flag : "A"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					page_number = Math.ceil(data.dinners.length/10)
					dinners_preview data

				else
					console.log status
		$("#gefuge").click ->
			$("#dinner_now_border").empty()
			k = 0
			while k < 10
				$("#dinner_now_border"+k).empty()
				k++
			$("#AAzhi").css "color":"#5c5c5c"
			$("#gefuge").css "color":"#5bc7d6"
			$("#woqingke").css "color":"#5c5c5c"
			$.post "/get_dinners_sort",
				sort_type : "各付各"
				sort_flag : "A"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					page_number = Math.ceil(data.dinners.length/10)
					dinners_preview data
				else
					console.log "7777"
					console.log status
			console.log "444444"
		$("#woqingke").click ->
			$("#dinner_now_border").empty()
			k = 0
			while k < 10
				$("#dinner_now_border"+k).empty()
				k++
			$("#AAzhi").css "color":"#5c5c5c"
			$("#gefuge").css "color":"#5c5c5c"
			$("#woqingke").css "color":"#5bc7d6"
			$.post "/get_dinners_sort",
				sort_type : "我请客"
				sort_flag : "A"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					page_number = Math.ceil(data.dinners.length/10)
					dinners_preview data
				else
					console.log status
		$("#jump_address").click ->
			$("#jump_all").css "color":"#5c5c5c"
			$("#jump_pay").css "color":"#5c5c5c"
			$("#jump_address").css "color":"#5bc7d6"
			$("#kafeiting").css "color":"#5c5c5c"
			$("#zhuoyou").css "color":"#5c5c5c"
			$("#jiuba").css "color":"#5c5c5c"
			$("#idinner_navigation").css "height":"44px","margin-bottom":"30px"
			$("#idinner_navigation_address").css "display":"inline-block","margin-bottom":"30px"
			$("#idinner_navigation_pay").css "display":"none"
			return false

		$("#jiuba").click ->
			$("#dinner_now_border").empty()
			k = 0
			while k < 10
				$("#dinner_now_border"+k).empty()
				k++
			$("#kafeiting").css "color":"#5c5c5c"
			$("#zhuoyou").css "color":"#5c5c5c"
			$("#jiuba").css "color":"#5bc7d6"
			$.post "/get_dinners_sort",
				sort_type : "酒吧"
				sort_flag : "B"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					page_number = Math.ceil(data.dinners.length/10)
					dinners_preview data
				else
					console.log status
		$("#zhuoyou").click ->
			$("#dinner_now_border").empty()
			k = 0
			while k < 10
				$("#dinner_now_border"+k).empty()
				k++
			$("#kafeiting").css "color":"#5c5c5c"
			$("#zhuoyou").css "color":"#5bc7d6"
			$("#jiuba").css "color":"#5c5c5c"
			$.post "/get_dinners_sort",
				sort_type : "桌游"
				sort_flag : "B"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					page_number = Math.ceil(data.dinners.length/10)
					dinners_preview data
				else
					console.log status
		$("#kafeiting").click ->
			$("#dinner_now_border").empty()
			k = 0
			while k < 10
				$("#dinner_now_border"+k).empty()
				k++
			$("#kafeiting").css "color":"#5bc7d6"
			$("#zhuoyou").css "color":"#5c5c5c"
			$("#jiuba").css "color":"#5c5c5c"
			$.post "/get_dinners_sort",
				sort_type : "咖啡厅"
				sort_flag : "B"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					page_number = Math.ceil(data.dinners.length/10)
					dinners_preview data
				else
					console.log status

		$("#jump_all").click ->
			$("#jump_all").css "color":"#5bc7d6"
			$("#jump_pay").css "color":"#5c5c5c"
			$("#jump_address").css "color":"#5c5c5c"
			$("#idinner_navigation_pay").css "display":"none"
			$("#idinner_navigation_address").css "display":"none"
			$("#idinner_navigation").css "height":"24px","margin-bottom":"0px"
			return false
		$("#jump_distance").click ->
			$("#idinner_navigation_pay").css "display":"none"
			$("#idinner_navigation_address").css "display":"none"
			$("#idinner_navigation").css "height":"24px","margin-bottom":"0px"
			return false
		$("#jump_tags").click ->
			$("#idinner_navigation_pay").css "display":"none"
			$("#idinner_navigation_address").css "display":"none"
			$("#idinner_navigation").css "height":"24px","margin-bottom":"0px"
			return false
		
		# 下面是加载分页
		InitPagination = ->
			# num_entries是显示的总页数
			num_entries = page_number
			# 创建分页
			$("#Pagination").pagination num_entries,
				num_edge_entries: 2 #边缘页数
				num_display_entries: 4 #主体页数
				callback: pageselectCallback
				items_per_page: 1 #每页显示1项
				prev_text: "上一页"
				next_text: "下一页"
			return
		# 这里initPagination好像没什么用，直接调用InitPagination()就可以初始化
		pageselectCallback = (page_index, jq) ->
			console.log "6666sa"
			console.log "page_index"+page_index
			new_content = $("#dinner_now_border" +(page_index)).clone()
			new_content.css "display":"block"
			console.log new_content
			$("#dinner_now_border").empty().append new_content #装载对应分页的内容
			# $(this).css "display":"block"
			console.log "flag_preview" + $(".flag_preview").length
			console.log "preview_dinners" + (preview_dinners+1)
			fit_height $("#dinner_now_border"), ($(".flag_preview").length-(preview_dinners+1))
			fit_height $("#dinner_now_border" +(page_index)), ($(".flag_preview").length-(preview_dinners+1))

			false
		console.log "3333sa"
		
		console.log "4444sa"

		# 预定位子功能
		book_table()

		map_add = $(".dinner_list_place").html()
		# 百度地图API
		map = new BMap.Map("baidu_map")
		# 默认创建地图的时候，坐标定位在北京
		point = new BMap.Point(116.331398, 39.897445)
		map.centerAndZoom point, 12
		# 开启地图缩放
		map.addControl new BMap.NavigationControl()
		# 创建地址解析器实例
		myGeo = new BMap.Geocoder()

		# 将地址解析结果显示在地图上,并调整地图视野
		myGeo.getPoint map_add, ((point) ->
			if point
				map.centerAndZoom point, 18
				map.addOverlay new BMap.Marker(point)
			return
		), "北京市"


