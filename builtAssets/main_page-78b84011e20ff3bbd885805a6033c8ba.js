$(document).ready(function(){$("#dinner_party").click(function(){$("#dinner_party").css("background-position","0px 0px");$("#singer").css("background-position","-95px -38px");$("#iring").css("background-position","-95px -74px");$("#my_attractive").css("background-position","-95px -112px");window.location.href="/idinner"});$("#singer").click(function(){$("#dinner_party").css("background-position","-95px 0px");$("#singer").css("background-position","0px -38px");$("#iring").css("background-position","-95px -74px");$("#my_attractive").css("background-position","-95px -112px");window.location.href="/isinger"});$("#iring").click(function(){$("#dinner_party").css("background-position","-95px 0px");$("#singer").css("background-position","-95px -38px");$("#iring").css("background-position","0px -74px");$("#my_attractive").css("background-position","-95px -112px");window.location.href="/iring"});$("#my_attractive").click(function(){$("#dinner_party").css("background-position","-95px 0px");$("#singer").css("background-position","-95px -38px");$("#iring").css("background-position","-95px -74px");$("#my_attractive").css("background-position","0px -112px");window.location.href="/ifanyor"});$("#iat_hot").click(function(){$("#iat_hot").css("background-color","#5bc7d6");$("#iat_hot").css("color","white");$("#iat_new").css("background-color","white");$("#iat_new").css("color","#9f9f9f");$("#iat_add").css("background-color","white");$("#iat_add").css("color","#9f9f9f")});$("#iat_new").click(function(){$("#iat_new").css("background-color","#5bc7d6");$("#iat_new").css("color","white");$("#iat_hot").css("background-color","white");$("#iat_hot").css("color","#9f9f9f");$("#iat_add").css("background-color","white");$("#iat_add").css("color","#9f9f9f")});$("#iat_add").click(function(){$("#iat_add").css("background-color","#5bc7d6");$("#iat_add").css("color","white");$("#iat_hot").css("background-color","white");$("#iat_hot").css("color","#9f9f9f");$("#iat_new").css("background-color","white");$("#iat_new").css("color","#9f9f9f")});$("#iring_iwant").click(function(){return window.location.href="/iattractive"});$("#iat_hot").hover(function(){$("#iat_hot").css("background-color","#5bc7d6");$("#iat_hot").css("color","white")},function(){$("#iat_hot").css("background-color","white");$("#iat_hot").css("color","#9f9f9f")});$("#iat_new").hover(function(){$("#iat_new").css("background-color","#5bc7d6");$("#iat_new").css("color","white")},function(){$("#iat_new").css("background-color","white");$("#iat_new").css("color","#9f9f9f")});$("#iat_add").hover(function(){$("#iat_add").css("background-color","#5bc7d6");$("#iat_add").css("color","white")},function(){$("#iat_add").css("background-color","white");$("#iat_add").css("color","#9f9f9f")});$("#dinner_party1").click(function(){$("#dinner_party1").css("background-position","-4px -39px");$("#dinner_party1").css("margin-left","13px");window.location.href="/idinner"});$("#singer1").click(function(){$("#singer1").css("background-position","-4px -73px");$("#singer1").css("margin-left","12px")});$("#iring1").click(function(){$("#iring1").css("background-position","-4px -4px");$("#iring1").css("margin-left","1px");$("#singer1").css("background-position","-91px -73px")});$("#iring_return").click(function(){return window.location.href="/ifanyor"});$("#modiy_user").click(function(){window.location.href="/user_info";return $("#set_photo").css("color","#5bc7d6")});$("#set_photo").click(function(){$("#set_photo").css("color","#5bc7d6");return window.location.href="/preview_photo"});$("#set_userinfo").click(function(){return window.location.href="/user_info"});$("#set_userhistory").click(function(){return window.location.href="/user_history"});$("#set_userlab").click(function(){return window.location.href="/user_label"});$("#modiy_password").click(function(){return window.location.href="/modiy_password"});return $("#tDate").click(function(){return $("#tDate").jSelectDate({yearBeign:1960,disabled:false})})});