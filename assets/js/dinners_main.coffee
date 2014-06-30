dinners_main = ->
	$(document).ready ->
		# 一进来先加载时间
		today_date()
		dinners_preview = (data) ->
			i = 0
			while i < data.dinners.length
				clone_dinner = $("#dinner_now").clone()
				clone_dinner.addClass "clone_border"
				$("#idinner_navigation").append clone_dinner

				j = 0
				while j < data.dinners[i].string_tag.length
					clone_dinners_lab = $("#dinners_lab").clone()
					$("#small_lab").append clone_dinners_lab
					clone_dinners_lab.find("#dinners_lab_info").html data.dinners[i].string_tag[j]
					clone_dinners_lab.css "display":"inline-block"
					j++

				clone_dinner.css "display":"inline-block"
				clone_dinner.find("#dinner_photo").attr "src", data.dinners[i].dinner_image_small
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
				clone_dinner.find(".idinner_photo_border").attr "href", "idinner/"+data.dinners[i]._id
				clone_dinner.find(".dinner_name").attr "href", "idinner/"+data.dinners[i]._id
				# clone_dinner.find("#dinner_jion_btn").click ->
				#   console.log "dinner_jion_btn点击 了"
				#   window.location.href= "/get_dinner_list"
				i++ 
		# 获取当前城市
		now_city = $("#now_city").html()
		console.log now_city
		$.post "/get_dinners",
			city : now_city
		, (data, status) ->
			if status
				dinners_preview data
			else
				console.log status
		$("#beijing").click ->
			post_choice_city "北京"
		$("#shanghai").click ->
			post_choice_city "上海"
		$("#guangzhou").click ->
			post_choice_city "广州"
		$("#xiamen").click ->
			post_choice_city "厦门"
		$("#shenzhen").click ->
			post_choice_city "深圳"
		$("#hangzhou").click ->
			post_choice_city "杭州"
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
			$("div.clone_border").remove()
			$("#AAzhi").css "color":"#5bc7d6"
			$("#gefuge").css "color":"#5c5c5c"
			$("#woqingke").css "color":"#5c5c5c"
			$.post "/get_dinners_sort",
				sort_type : "AA制"
				sort_flag : "A"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					dinners_preview data
				else
					console.log status
		$("#gefuge").click ->
			$("div.clone_border").remove()
			$("#AAzhi").css "color":"#5c5c5c"
			$("#gefuge").css "color":"#5bc7d6"
			$("#woqingke").css "color":"#5c5c5c"
			$.post "/get_dinners_sort",
				sort_type : "各付各"
				sort_flag : "A"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					dinners_preview data

				else
					console.log "7777"
					console.log status
			console.log "444444"
		$("#woqingke").click ->
			$("div.clone_border").remove()
			$("#AAzhi").css "color":"#5c5c5c"
			$("#gefuge").css "color":"#5c5c5c"
			$("#woqingke").css "color":"#5bc7d6"
			$.post "/get_dinners_sort",
				sort_type : "我请客"
				sort_flag : "A"
				city : $("#now_city").html()
			, (data, status) ->
				if status
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
			$("div.clone_border").remove()
			$("#kafeiting").css "color":"#5c5c5c"
			$("#zhuoyou").css "color":"#5c5c5c"
			$("#jiuba").css "color":"#5bc7d6"
			$.post "/get_dinners_sort",
				sort_type : "酒吧"
				sort_flag : "B"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					dinners_preview data
					console.log data
				else
					console.log status
		$("#zhuoyou").click ->
			$("div.clone_border").remove()
			$("#kafeiting").css "color":"#5c5c5c"
			$("#zhuoyou").css "color":"#5bc7d6"
			$("#jiuba").css "color":"#5c5c5c"
			$.post "/get_dinners_sort",
				sort_type : "桌游"
				sort_flag : "B"
				city : $("#now_city").html()
			, (data, status) ->
				if status
					dinners_preview data
				else
					console.log status
		$("#kafeiting").click ->
			$("div.clone_border").remove()
			$("#kafeiting").css "color":"#5bc7d6"
			$("#zhuoyou").css "color":"#5c5c5c"
			$("#jiuba").css "color":"#5c5c5c"
			$.post "/get_dinners_sort",
				sort_type : "咖啡厅"
				sort_flag : "B"
				city : $("#now_city").html()
			, (data, status) ->
				if status
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
		myGeo.getPoint "厦门市禹洲大学城", ((point) ->
			if point
				map.centerAndZoom point, 16
				map.addOverlay new BMap.Marker(point)
			return
		), "北京市"
		# 预定位子功能
		book_table()