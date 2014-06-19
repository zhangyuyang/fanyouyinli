dinners_main = ->
	$(document).ready ->
		$.get "/get_dinners", (data, status) ->
			if status
				# console.log "22222"
				# console.log data.dinners.length
				# console.log data.dinners[0].description
				i = 0
				while i < data.dinners.length
					clone_dinner = $("#dinner_now").clone()
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
					clone_dinner.find("#dinner_name").html data.dinners[i].dinner_tag
					clone_dinner.find("#dining_locations_info").html data.dinners[i].dining_locations_info

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
					clone_dinner.find("#dinner_jion_btn").attr "href", "idinner/"+data.dinners[i]._id
					# clone_dinner.find("#dinner_jion_btn").click ->
					# 	console.log "dinner_jion_btn点击 了"
					# 	window.location.href= "/get_dinner_list"
					i++	
			else
				console.log status

		$("#go_dinner").click ->
			$("#great_dinner").submit()
		$("#dinner_jion_btn").click ->
			
			