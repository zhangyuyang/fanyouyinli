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