$(document).ready ->  

  $("#dinner_party").click ->
    $("#dinner_party").css "background-position", "0px 0px"
    $("#singer").css "background-position", "-95px -38px"
    $("#iring").css "background-position", "-95px -74px"
    $("#my_attractive").css "background-position", "-95px -112px"
    window.location.href = "/idinner"
    return

  $("#singer").click ->
    $("#dinner_party").css "background-position", "-95px 0px"
    $("#singer").css "background-position", "0px -38px"
    $("#iring").css "background-position", "-95px -74px"
    $("#my_attractive").css "background-position", "-95px -112px"
    window.location.href = "/isinger"
    return

  $("#iring").click ->
    $("#dinner_party").css "background-position", "-95px 0px"
    $("#singer").css "background-position", "-95px -38px"
    $("#iring").css "background-position", "0px -74px"
    $("#my_attractive").css "background-position", "-95px -112px"
    window.location.href = "/iring"
    return

  $("#my_attractive").click ->
    $("#dinner_party").css "background-position", "-95px 0px"
    $("#singer").css "background-position", "-95px -38px"
    $("#iring").css "background-position", "-95px -74px"
    $("#my_attractive").css "background-position", "0px -112px"
    window.location.href = "/ifanyor"
    return

  $("#iat_hot").click ->
    $("#iat_hot").css "background-color", "#5bc7d6"
    $("#iat_hot").css "color", "white"
    $("#iat_new").css "background-color", "white"
    $("#iat_new").css "color", "#9f9f9f"
    $("#iat_add").css "background-color", "white"
    $("#iat_add").css "color", "#9f9f9f"
    return

  $("#iat_new").click ->
    $("#iat_new").css "background-color", "#5bc7d6"
    $("#iat_new").css "color", "white"
    $("#iat_hot").css "background-color", "white"
    $("#iat_hot").css "color", "#9f9f9f"
    $("#iat_add").css "background-color", "white"
    $("#iat_add").css "color", "#9f9f9f"
    return

  $("#iat_add").click ->
    $("#iat_add").css "background-color", "#5bc7d6"
    $("#iat_add").css "color", "white"
    $("#iat_hot").css "background-color", "white"
    $("#iat_hot").css "color", "#9f9f9f"
    $("#iat_new").css "background-color", "white"
    $("#iat_new").css "color", "#9f9f9f"
    return

  $("#iring_iwant").click ->
    window.location.href = "/iattractive"

  $("#iat_hot").hover (->
    $("#iat_hot").css "background-color", "#5bc7d6"
    $("#iat_hot").css "color", "white"
    return
  ), ->
    $("#iat_hot").css "background-color", "white"
    $("#iat_hot").css "color", "#9f9f9f"
    return

  $("#iat_new").hover (->
    $("#iat_new").css "background-color", "#5bc7d6"
    $("#iat_new").css "color", "white"
    return
  ), ->
    $("#iat_new").css "background-color", "white"
    $("#iat_new").css "color", "#9f9f9f"
    return

  $("#iat_add").hover (->
    $("#iat_add").css "background-color", "#5bc7d6"
    $("#iat_add").css "color", "white"
    return
  ), ->
    $("#iat_add").css "background-color", "white"
    $("#iat_add").css "color", "#9f9f9f"
    return
  $("#dinner_party1").click ->
    $("#dinner_party1").css "background-position", "-4px -39px"
    $("#dinner_party1").css "margin-left", "13px"
    window.location.href = "/idinner"
    return

  $("#singer1").click ->
    $("#singer1").css "background-position", "-4px -73px"
    $("#singer1").css "margin-left", "12px"
    return

  $("#iring1").click ->
    $("#iring1").css "background-position", "-4px -4px"
    $("#iring1").css "margin-left", "1px"
    $("#singer1").css "background-position", "-91px -73px"
    return
  $("#iring_return").click ->
    window.location.href = "/ifanyor"
  $("#modiy_user").click ->
    window.location.href = "/user_info"
    $("#set_photo").css "color", "#5bc7d6"
  $("#set_photo").click ->
    $("#set_photo").css "color", "#5bc7d6"
    window.location.href = "/preview_photo"
  $("#set_userinfo").click ->
    window.location.href = "/user_info"
  $("#set_userhistory").click ->
    window.location.href = "/user_history"
  $("#set_userlab").click ->
    window.location.href = "/user_label"
  $("#modiy_password").click ->
    window.location.href = "/modiy_password"
  $("#tDate").click ->
    $("#tDate").jSelectDate
      yearBeign: 1960
      disabled: false
    
home = ->
  $(document).ready ->
    # 验证
    eMaliReg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
    nameReg = /[^\x00-\x80]/
    passwordReg = /^[a-zA-Z0-9]{6,}$/
    t = 1
    $("#turn_right").click ->
      if t >= 1 and t < 3
        t += 1
        $("#mian_photo").css "backgroundImage", "url(./images/zhutu" + t + ".png)"
      return

    $("#turn_left").click ->
      if t > 1 and t <= 3
        t -= 1
        $("#mian_photo").css "backgroundImage", "url(./images/zhutu" + t + ".png)"
      return

    $("#apply_button").click ->
      $("#turn_right").fadeOut()
      $("#turn_left").fadeOut()
      $("#mian_photo").css "backgroundImage", "url(./images/fan02.png)"
      $("#apply_button").fadeOut()
      
      # $("#e_mail").type("text");
      e_mail = document.getElementById("e_mail")
      e_mail.type = "text"
      username = document.getElementById("username")
      username.type = "text"
      city = document.getElementById("city")
      city.type = "text"
      about_me = document.getElementById("about_me")
      about_me.hidden = ""
      messge_sub.hidden = ""
      return

    $("#messge_sub").click ->
      e_mail = document.getElementById("e_mail")
      username = document.getElementById("username")
      city = document.getElementById("city")
      unless eMaliReg.test(e_mail.value)
        $("#xing1").fadeIn()
        $("#email_tip").html "输入的E-mail地址不对"
        e_mail.focus()
        return false
      else
        $("#xing1").fadeOut()
        $("#email_tip").html ""
      unless nameReg.test(username.value)
        $("#xing2").fadeIn()
        $("#name_tip").html "输入的名字不对"
        username.focus()
        return false
      else
        $("#xing2").fadeOut()
        $("#name_tip").html ""
      unless nameReg.test(city.value)
        $("#xing3").fadeIn()
        $("#city_tip").html "输入的城市名不对"
        city.focus()
        return false
      else
        $("#xing3").fadeOut 1
        $("#city_tip").html ""
      e_mail.type = "hidden"
      username.type = "hidden"
      city.type = "hidden"
      about_me.hidden = "hidden"
      messge_sub.hidden = "hidden"
      $("#form1").submit()
      $("#mian_photo").css "backgroundImage", "url(./images/fan03.png)"
      return


    $("#find_password_button").click ->
      $("#find_password_form").submit()
      return
    $("#reg_button").click ->
      reg_eMail = document.getElementById("reg_mail")
      reg_password = document.getElementById("reg_password")
      reg_name = document.getElementById("reg_name")
      reg_city = document.getElementById("reg_city")
      unless eMaliReg.test(reg_eMail.value)
        $("#reg_email_tip").html "输入的E-mail地址不对"
        $("#reg_email_tip").fadeIn()
        $("#reg_email_tip1").fadeIn()
        reg_eMail.focus()
        return false
      else
        $("#reg_email_tip1").fadeOut()
        $("#reg_email_tip").fadeOut()
        $("#reg_email_tip").html ""
      unless passwordReg.test(reg_password.value)
        $("#reg_password_tip").html "密码格式不正确，请输入6位以上密码，可以是数字和字母"
        $("#reg_password_tip").fadeIn()
        $("#reg_password_tip1").fadeIn()
        reg_password.focus()
        return false
      else
        $("#reg_password_tip1").fadeOut()
        $("#reg_password_tip").fadeOut()
        $("#reg_password_tip").html ""
      unless nameReg.test(reg_name.value)
        $("#reg_name_tip").html "输入的姓名不对"
        $("#reg_name_tip").fadeIn()
        $("#reg_name_tip1").fadeIn()
        reg_name.focus()
        return false
      else
        $("#reg_name_tip1").fadeOut()
        $("#reg_name_tip").fadeOut()
        $("#reg_name_tip").html ""
      unless nameReg.test(reg_city.value)
        $("#reg_city_tip").html "城市只限制中文"
        $("#reg_city_tip").fadeIn()
        $("#reg_city_tip1").fadeIn()
        reg_city.focus()
        return false
      else
        $("#reg_city_tip1").fadeOut()
        $("#reg_city_tip").fadeOut()
        $("#reg_city_tip").html ""
      checking = -1
      form1 = document.getElementById("reg_form")
      i = 0

      while i < form1.sex.length
        if form1.sex[i].checked
          checking = form1.sex[i].value
          console.log "选中的值是" + checking
          break
        i++
      if checking < 0
        $("#reg_sex_tip").html "请选择性别"
        $("#reg_sex_tip").fadeIn()
        $("#reg_sex_tip1").fadeIn()
      else
        $("#reg_sex_tip1").fadeOut()
        $("#reg_sex_tip").fadeOut()
        $("#reg_sex_tip").html ""
        $("#reg_form").sex = checking
      $("#reg_form").submit()
      return

    $("#reg_success_button").click ->
      $("#reg_success_form").submit()
      return

    return

login = ->
  $(document).ready ->  
    $("#login_button").click ->
      $("#login_form").submit()
      return

upload_photo = (callback)->
  $(document).ready ->  
    $("#save_photo").click ->
      $("#to_save_phpto_from").submit()
    $("#userphpto_sub").click ->
      $("#file").click()
    $("#file").change ->
      $("#upload_img").submit()
    updatePreview = (c) ->
      if parseInt(c.w) > 0
        rx = xsize / c.w #c.w是用户截图框框的宽度
          #rx是预览元素的宽度（60）/用户截取的宽度的比例
        ry = ysize / c.h
        rx1 = xsize1 / c.w
        ry1 = ysize1 / c.h
        $pimg.css #$pimg.css的作用是把原图，按照（rx * boundx）等比例缩放了
          width: Math.round(rx * boundx) + "px"
          height: Math.round(ry * boundy) + "px"
          marginLeft: "-" + Math.round(rx * c.x) + "px" #Math是JS内置对象，round（X）是把X四舍五入取最接近的数
          marginTop: "-" + Math.round(ry * c.y) + "px"
        $pimg1.css 
          width: Math.round(rx1 * boundx) + "px"
          height: Math.round(ry1 * boundy) + "px"
          marginLeft: "-" + Math.round(rx1 * c.x) + "px" #Math是JS内置对象，round（X）是把X四舍五入取最接近的数
          marginTop: "-" + Math.round(ry1 * c.y) + "px"
        console.log c.x, c.y, c.w, c
        $('#preview_x').val(c.x)
        $('#preview_y').val(c.y)
        $('#preview_width').val(c.w)

    jcrop_api = undefined
    boundx = undefined
    boundy = undefined
    $preview = $("#preview-pane")
    $pcnt = $("#preview-pane .preview-container")
    $pcnt1 = $("#preview-pane .preview-container1")
    $pimg = $("#preview-pane .preview-container img")
    $pimg1 = $("#preview-pane .preview-container1 img")
    xsize = $pcnt.width() #pcnt是preview-pane下preview-container这个元素,xsize也就是预览元素的宽度，可以自己设定
    ysize = $pcnt.height()
    xsize1 = $pcnt1.width()
    ysize1 = $pcnt1.height()
    $("#target").Jcrop
      onChange: updatePreview
      onSelect: updatePreview
      aspectRatio: 1 / 1
      setSelect: [0, 0, 200, 200]
    , ->
      bounds = @getBounds() #@getBounds()返回的是当前加载图片的分辨率
      boundx = bounds[0] #当前图片的宽
      boundy = bounds[1] # 当前图片的长
      jcrop_api = this
      $preview.appendTo jcrop_api.ui.holder
      callback()

      
get_photo_size = ->
  $(document).ready ->  
    console.log "get_photo_size"
    console.log $(".jcrop-holder")[0]
    phpto1_heigh = undefined
    phpto1_width = undefined
    phpto2_heigh = undefined
    phpto2_width = undefined
    phpto3_heigh = undefined
    phpto3_width = undefined
    # $(".jcrop-hline").css "width", "100"
    # $(".jcrop-hline bottom").css "width", "100"
    # $(".jcrop-vline right").css "height", "100"
    # $(".jcrop-vline").css "height", "100"

preview_photo = ->
  $(document).ready ->  
    $("#userphpto_sub").click ->
      $("#file").click()
    $("#file").change ->
      $("#upload_img").submit()