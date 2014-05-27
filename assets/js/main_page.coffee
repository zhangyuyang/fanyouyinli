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
    