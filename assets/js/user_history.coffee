user_history = ->
	$(document).ready ->
		$("#company_name").click ->
			$("#company_name").val ""
		$("#job").click ->
			$("#job").val ""
		$("#school").click ->
			$("#school").val ""
		$("#specialty").click ->
			$("#specialty").val ""
		$("#word_sub").click ->
			$("#worked").submit()
		$("#study_sub").click ->
			$.post "/save_studed",
				school_type : $("#school_type").val()
				school : $("#school").val()
				specialty : $("#specialty").val()
				remember : $("#remember").val()
			, (data, status) ->
					$("#company_name").val() data.rname
					alert "名字：" + data.rname + "城市：" + data.rcity + "\n状态:" + status


