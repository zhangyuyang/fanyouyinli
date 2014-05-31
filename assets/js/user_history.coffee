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
			$.post "/save_worked",
				company_name : $("#company_name").val()
				work_year_s : $("#work_year_s").val()
				work_year_e: $("#work_year_e").val()
				job: $("#job").val()
				say_some: $("#say_some").val()
			, (data, status) ->
				work_clone = $("#worked_clone").clone()
				$("#word_sub").parents("form").before(work_clone)
				work_clone.css "display","block"
				work_clone.find("#company_name1").html data.company_name
				work_clone.find("#work_year_s1").html data.work_year_s
				work_clone.find("#work_year_e1").html data.work_year_e
				work_clone.find("#job1").html data.job
				work_clone.find("#say_some1").html data.say_some

				

		$("#study_sub").click ->
			$.post "/save_studed",
				school_type : $("#school_type").val()
				school : $("#school").val()
				specialty : $("#specialty").val()
				remember : $("#remember").val()
			, (data, status) ->
				study_clone = $("#studed_clone").clone()
				$("#study_sub").parents("form").before(study_clone)
				study_clone.css "display","block"
				study_clone.find("#school_type1").html data.school_type
				study_clone.find("#school1").html data.school
				study_clone.find("#specialty1").html data.specialty
				study_clone.find("#remember1").html data.remember
