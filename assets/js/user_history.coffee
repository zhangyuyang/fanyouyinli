user_history = ->
  $(document).ready ->
    # 新插入数据
    insert_work = ->
      creat_time = (new Date()).valueOf();
      $.post "/insert_worked",
        company_name: $("#company_name").val()
        work_year_s: $("#work_year_s").val()
        work_year_e: $("#work_year_e").val()
        job: $("#job").val()
        say_some: $("#say_some").val()
        creat_time: creat_time
      , (data, status) ->
        work_preview = undefined
        work_preview = $("#work_preview").clone()
        # 增加一个预览表单
        $("#word_sub").parents("form").before work_preview
        work_preview.css "display", "block"
        # 把输入的值写入预览表单
        work_preview.find("#company_name1").html data.company_name
        work_preview.find("#work_year_s1").html data.work_year_s
        work_preview.find("#work_year_e1").html data.work_year_e
        work_preview.find("#job1").html data.job
        work_preview.find("#say_some1").html data.say_some
        work_preview.find("#work_creattime1").val data.creat_time
        # 把修改按钮绑定到update_work方法
        work_preview.find('#work_modify_botton1').bind 'click', update_work
        # 把删除按钮绑定
        work_preview.find('#work_delete_botton1').bind 'click', delete_work

    # 修改数据，展示层，不涉及数据库操作
    update_work = ->
      # 把预览数据保存起来
      t_company_name = $(this).parents("form").find("#company_name1").text()
      t_work_year_s = $(this).parents("form").find("#work_year_s1").text()
      t_work_year_e = $(this).parents("form").find("#work_year_e1").text()
      t_job = $(this).parents("form").find("#job1").text()
      t_say_some = $(this).parents("form").find("#say_some1").text()
      t_creat_time = $(this).parents("form").find("#work_creattime1").val()
      # 删除这个预览表单
      $(this).parents("form").css "display", "none"
      # 吧原来数据删除
      $.post "/delete_work",
        company_name: t_company_name
        work_year_s: t_work_year_s
        work_year_e: t_work_year_e
        job: t_job
        say_some: t_say_some
        creat_time: t_creat_time
      , (data, status) ->
        console.log "原数据删除成功"
      # 增加一个克隆的输入表单
      work_save_clone = $("#work_save").clone()
      $(this).parents("form").before work_save_clone
      work_save_clone.css "display", "inline-block"
      # 输入表单的数据用预览的数据
      work_save_clone.find("#company_name2").val t_company_name
      work_save_clone.find("#work_year_s2").val t_work_year_s
      work_save_clone.find("#work_year_e2").val t_work_year_e
      work_save_clone.find("#job2").val t_job
      work_save_clone.find("#say_some2").val t_say_some
      work_save_clone.find("#work_creattime2").val t_creat_time
      # 绑定保存按钮的click事件
      work_save_clone.find('#work_save_button').bind 'click', save_work

    # 保存，涉及数据库
    save_work = ->
      t_company_name = $(this).parents("form").find("#company_name2").val()
      t_work_year_s = $(this).parents("form").find("#work_year_s2").val()
      t_work_year_e = $(this).parents("form").find("#work_year_e2").val()
      t_job = $(this).parents("form").find("#job2").val()
      t_say_some = $(this).parents("form").find("#say_some2").val()
      t_creat_time = $(this).parents("form").find("#work_creattime2").val()
      # 增加一个预览表单
      work_preview = undefined
      work_preview = $("#work_preview").clone()
      $(this).parents("form").before work_preview
      work_preview.css "display", "inline-block"
      # 删除这个输入表单
      $(this).parents("form").css "display", "none"
      # 把修改按钮绑定
      work_preview.find('#work_modify_botton1').bind 'click', update_work
      # 把删除按钮绑定
      work_preview.find('#work_delete_botton1').bind 'click', delete_work
      # 把新数据增加到数据库
      $.post "/insert_worked",
        company_name: t_company_name
        work_year_s: t_work_year_s
        work_year_e: t_work_year_e
        job: t_job
        say_some: t_say_some
        creat_time: t_creat_time
      , (data, status) ->
        console.log "新增数据成功"
        work_preview.find("#company_name1").html data.company_name
        work_preview.find("#work_year_s1").html data.work_year_s
        work_preview.find("#work_year_e1").html data.work_year_e
        work_preview.find("#job1").html data.job
        work_preview.find("#say_some1").html data.say_some
        work_preview.find("#work_creattime1").val data.creat_time

    delete_work = ->
      deleteform = $(this).parents("form")
      # 把预览数据保存起来
      t_company_name = $(this).parents("form").find("#company_name1").text()
      t_work_year_s = $(this).parents("form").find("#work_year_s1").text()
      t_work_year_e = $(this).parents("form").find("#work_year_e1").text()
      t_job = $(this).parents("form").find("#job1").text()
      t_say_some = $(this).parents("form").find("#say_some1").text()
      t_creat_time = $(this).parents("form").find("#work_creattime1").val()
      # 写入数据库
      $.post "/delete_work",
        company_name: t_company_name
        work_year_s: t_work_year_s
        work_year_e: t_work_year_e
        job: t_job
        say_some: t_say_some
        creat_time: t_creat_time
      , (data, status) ->
        if data.status
          console.log "数据库删除工作状态成功"
          deleteform.css "display", "none"
        else 
          console.log "数据库删除工作状态失败"


    insert_study = ->
      creat_time = (new Date()).valueOf();
      $.post "/insert_study",
        school_type: $("#school_type").val()
        school: $("#school").val()
        specialty: $("#specialty").val()
        remember: $("#remember").val()
        creat_time: creat_time
      , (data, status) ->
        study_preview = undefined
        study_preview = $("#studed_prewiew").clone()
        # 增加一个预览表单
        $("#study_sub").parents("form").before study_preview
        study_preview.css "display", "block"
        # 把输入的值写入预览表单
        study_preview.find("#school_type1").html data.school_type
        study_preview.find("#school1").html data.school
        study_preview.find("#specialty1").html data.specialty
        study_preview.find("#remember1").html data.remember
        study_preview.find("#study_creattime1").val data.creat_time
        # 把修改按钮绑定
        study_preview.find('#modify_bottom1').bind 'click', update_study
        # 把删除按钮绑定
        study_preview.find('#delete_bottom1').bind 'click', delete_study

    # 修改数据，展示层，不涉及数据库操作
    update_study = ->
      # 把预览数据保存起来
      t_school_type = $(this).parents("form").find("#school_type1").text()
      t_school = $(this).parents("form").find("#school1").text()
      t_specialty = $(this).parents("form").find("#specialty1").text()
      t_remember = $(this).parents("form").find("#remember1").text()
      t_creat_time = $(this).parents("form").find("#study_creattime1").val()
      # 删除这个预览表单
      $(this).parents("form").css "display", "none"
      # 吧原来数据删除
      $.post "/delete_study",
        school_type: t_school_type
        school: t_school
        specialty: t_specialty
        remember: t_remember
        creat_time: t_creat_time
      , (data, status) ->
        console.log "原数据删除成功"
      # 增加一个克隆的输入表单
      study_save_clone = $("#studed_save").clone()
      $(this).parents("form").before study_save_clone
      study_save_clone.css "display", "inline-block"
      # 输入表单的数据用预览的数据
      study_save_clone.find("#school_type2").val t_school_type
      study_save_clone.find("#school2").val t_school
      study_save_clone.find("#specialty2").val t_specialty
      study_save_clone.find("#remember2").val t_remember
      study_save_clone.find("#study_creattime2").val t_creat_time
      # 绑定保存按钮的click事件
      study_save_clone.find('#studed_save_button').bind 'click', save_study

    # 保存，涉及数据库
    save_study = ->
      t_school_type = $(this).parents("form").find("#school_type2").val()
      t_school = $(this).parents("form").find("#school2").val()
      t_specialty = $(this).parents("form").find("#specialty2").val()
      t_remember = $(this).parents("form").find("#remember2").val()
      t_creat_time = $(this).parents("form").find("#study_creattime2").val()
      # 增加一个预览表单
      study_preview = undefined
      study_preview = $("#studed_prewiew").clone()
      $(this).parents("form").before study_preview
      study_preview.css "display", "inline-block"
      # 删除这个输入表单
      $(this).parents("form").css "display", "none"
      # 把修改按钮绑定
      study_preview.find('#modify_bottom1').bind 'click', update_study
      # 把删除按钮绑定
      study_preview.find('#delete_bottom1').bind 'click', delete_study
      # 把新数据增加到数据库
      $.post "/insert_study",
        school_type: t_school_type
        school: t_school
        specialty: t_specialty
        remember: t_remember
        creat_time: t_creat_time
      , (data, status) ->
        console.log "新增数据成功"
        study_preview.find("#school_type1").html data.school_type
        study_preview.find("#school1").html data.school
        study_preview.find("#specialty1").html data.specialty
        study_preview.find("#remember1").html data.remember
        study_preview.find("#study_creattime1").val data.creat_time

    delete_study = ->
      deleteform = $(this).parents("form")
      # 把预览数据保存起来
      t_school_type = $(this).parents("form").find("#school_type1").text()
      t_school = $(this).parents("form").find("#school1").text()
      t_specialty = $(this).parents("form").find("#specialty1").text()
      t_remember = $(this).parents("form").find("#remember1").text()
      t_creat_time = $(this).parents("form").find("#study_creattime1").val()
      # 写入数据库
      $.post "/delete_study",
        school_type: t_school_type
        school: t_school
        specialty: t_specialty
        remember: t_remember
        creat_time: t_creat_time
      , (data, status) ->
        if data.status
          console.log "数据库删除工作状态成功"
          deleteform.css "display", "none"
        else 
          console.log "数据库删除工作状态失败"
    # 如果在进入页面的时候，数据库里有数据，需要给每一条数据绑定删除，修改按钮
    $("#word_sub").click insert_work
    # 绑定修改按钮
    update_work_button = $(document).find(".modify_bottom")
    update_work_button.each (i) ->
      console.log i
      $(this).click update_work
      return
    delete_work_button = $(document).find(".delete_bottom")
    delete_work_button.each (i) ->
      console.log i
      $(this).click delete_work
      return

    $("#study_sub").click insert_study
    update_study_button = $(document).find(".studed_modify_bottom")
    update_study_button.each (i) ->
      console.log i
      $(this).click update_study
      return
    delete_study_button = $(document).find(".studed_delete_bottom")
    delete_study_button.each (i) ->
      console.log i
      $(this).click delete_study
      return