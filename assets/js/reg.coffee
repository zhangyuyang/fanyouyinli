reg = ->
  $(document).ready ->
    eMaliReg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/
    nameReg = /[^\x00-\x80]/
    passwordReg = /^[a-zA-Z0-9]{6,}$/
    $("#find_password_button").click ->
      console.log "find_password_button这个按钮已经点了"
      $("#find_password_form").submit()
      return
    $("#reg_button").click ->
      console.log "到注册页面"
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
