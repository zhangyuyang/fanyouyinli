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
			$("#studed").submit()