var home;home=function(){return $(document).ready(function(){var t,e,i,n;t=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;e=/[^\x00-\x80]/;i=/^[a-zA-Z0-9]{6,}$/;n=1;$("#turn_right").click(function(){if(n>=1&&n<3){n+=1;$("#mian_photo").css("backgroundImage","url(./images/zhutu"+n+".png)")}});$("#turn_left").click(function(){if(n>1&&n<=3){n-=1;$("#mian_photo").css("backgroundImage","url(./images/zhutu"+n+".png)")}});$("#apply_button").click(function(){var t,e,i,n;$("#turn_right").fadeOut();$("#turn_left").fadeOut();$("#mian_photo").css("backgroundImage","url(./images/fan02.png)");$("#apply_button").fadeOut();i=document.getElementById("e_mail");i.type="text";n=document.getElementById("username");n.type="text";e=document.getElementById("city");e.type="text";t=document.getElementById("about_me");t.hidden="";messge_sub.hidden=""});return $("#messge_sub").click(function(){var i,n,o;n=document.getElementById("e_mail");o=document.getElementById("username");i=document.getElementById("city");if(!t.test(n.value)){$("#xing1").fadeIn();$("#email_tip").html("输入的E-mail地址不对");n.focus();return false}else{$("#xing1").fadeOut();$("#email_tip").html("")}if(!e.test(o.value)){$("#xing2").fadeIn();$("#name_tip").html("输入的名字不对");o.focus();return false}else{$("#xing2").fadeOut();$("#name_tip").html("")}if(!e.test(i.value)){$("#xing3").fadeIn();$("#city_tip").html("输入的城市名不对");i.focus();return false}else{$("#xing3").fadeOut(1);$("#city_tip").html("")}n.type="hidden";o.type="hidden";i.type="hidden";about_me.hidden="hidden";messge_sub.hidden="hidden";$("#form1").submit();$("#mian_photo").css("backgroundImage","url(./images/fan03.png)")})})};var reg;reg=function(){return $(document).ready(function(){$("#find_password_button").click(function(){$("#find_password_form").submit()});$("#reg_button").click(function(){var t,e,i,n,o,r,c;o=document.getElementById("reg_mail");c=document.getElementById("reg_password");r=document.getElementById("reg_name");n=document.getElementById("reg_city");if(!eMaliReg.test(o.value)){$("#reg_email_tip").html("输入的E-mail地址不对");$("#reg_email_tip").fadeIn();$("#reg_email_tip1").fadeIn();o.focus();return false}else{$("#reg_email_tip1").fadeOut();$("#reg_email_tip").fadeOut();$("#reg_email_tip").html("")}if(!passwordReg.test(c.value)){$("#reg_password_tip").html("密码格式不正确，请输入6位以上密码，可以是数字和字母");$("#reg_password_tip").fadeIn();$("#reg_password_tip1").fadeIn();c.focus();return false}else{$("#reg_password_tip1").fadeOut();$("#reg_password_tip").fadeOut();$("#reg_password_tip").html("")}if(!nameReg.test(r.value)){$("#reg_name_tip").html("输入的姓名不对");$("#reg_name_tip").fadeIn();$("#reg_name_tip1").fadeIn();r.focus();return false}else{$("#reg_name_tip1").fadeOut();$("#reg_name_tip").fadeOut();$("#reg_name_tip").html("")}if(!nameReg.test(n.value)){$("#reg_city_tip").html("城市只限制中文");$("#reg_city_tip").fadeIn();$("#reg_city_tip1").fadeIn();n.focus();return false}else{$("#reg_city_tip1").fadeOut();$("#reg_city_tip").fadeOut();$("#reg_city_tip").html("")}t=-1;e=document.getElementById("reg_form");i=0;while(i<e.sex.length){if(e.sex[i].checked){t=e.sex[i].value;console.log("选中的值是"+t);break}i++}if(t<0){$("#reg_sex_tip").html("请选择性别");$("#reg_sex_tip").fadeIn();$("#reg_sex_tip1").fadeIn()}else{$("#reg_sex_tip1").fadeOut();$("#reg_sex_tip").fadeOut();$("#reg_sex_tip").html("");$("#reg_form").sex=t}$("#reg_form").submit()});return $("#reg_success_button").click(function(){$("#reg_success_form").submit()})})};$(document).ready(function(){$("#dinner_party").click(function(){$("#dinner_party").css("background-position","0px 0px");$("#singer").css("background-position","-95px -38px");$("#iring").css("background-position","-95px -74px");$("#my_attractive").css("background-position","-95px -112px");window.location.href="/idinner"});$("#singer").click(function(){$("#dinner_party").css("background-position","-95px 0px");$("#singer").css("background-position","0px -38px");$("#iring").css("background-position","-95px -74px");$("#my_attractive").css("background-position","-95px -112px");window.location.href="/isinger"});$("#iring").click(function(){$("#dinner_party").css("background-position","-95px 0px");$("#singer").css("background-position","-95px -38px");$("#iring").css("background-position","0px -74px");$("#my_attractive").css("background-position","-95px -112px");window.location.href="/iring"});$("#my_attractive").click(function(){$("#dinner_party").css("background-position","-95px 0px");$("#singer").css("background-position","-95px -38px");$("#iring").css("background-position","-95px -74px");$("#my_attractive").css("background-position","0px -112px");window.location.href="/ifanyor"});$("#iat_hot").click(function(){$("#iat_hot").css("background-color","#5bc7d6");$("#iat_hot").css("color","white");$("#iat_new").css("background-color","white");$("#iat_new").css("color","#9f9f9f");$("#iat_add").css("background-color","white");$("#iat_add").css("color","#9f9f9f")});$("#iat_new").click(function(){$("#iat_new").css("background-color","#5bc7d6");$("#iat_new").css("color","white");$("#iat_hot").css("background-color","white");$("#iat_hot").css("color","#9f9f9f");$("#iat_add").css("background-color","white");$("#iat_add").css("color","#9f9f9f")});$("#iat_add").click(function(){$("#iat_add").css("background-color","#5bc7d6");$("#iat_add").css("color","white");$("#iat_hot").css("background-color","white");$("#iat_hot").css("color","#9f9f9f");$("#iat_new").css("background-color","white");$("#iat_new").css("color","#9f9f9f")});$("#iring_iwant").click(function(){return window.location.href="/iattractive"});$("#iat_hot").hover(function(){$("#iat_hot").css("background-color","#5bc7d6");$("#iat_hot").css("color","white")},function(){$("#iat_hot").css("background-color","white");$("#iat_hot").css("color","#9f9f9f")});$("#iat_new").hover(function(){$("#iat_new").css("background-color","#5bc7d6");$("#iat_new").css("color","white")},function(){$("#iat_new").css("background-color","white");$("#iat_new").css("color","#9f9f9f")});$("#iat_add").hover(function(){$("#iat_add").css("background-color","#5bc7d6");$("#iat_add").css("color","white")},function(){$("#iat_add").css("background-color","white");$("#iat_add").css("color","#9f9f9f")});$("#dinner_party1").click(function(){$("#dinner_party1").css("background-position","-4px -39px");$("#dinner_party1").css("margin-left","13px");window.location.href="/idinner"});$("#singer1").click(function(){$("#singer1").css("background-position","-4px -73px");$("#singer1").css("margin-left","12px")});$("#iring1").click(function(){$("#iring1").css("background-position","-4px -4px");$("#iring1").css("margin-left","1px");$("#singer1").css("background-position","-91px -73px")});$("#iring_return").click(function(){return window.location.href="/ifanyor"});$("#modiy_user").click(function(){window.location.href="/user_info";return $("#set_photo").css("color","#5bc7d6")});$("#set_photo").click(function(){$("#set_photo").css("color","#5bc7d6");return window.location.href="/preview_photo"});$("#set_userinfo").click(function(){return window.location.href="/user_info"});$("#set_userhistory").click(function(){return window.location.href="/user_history"});$("#set_userlab").click(function(){return window.location.href="/user_label"});$("#modiy_password").click(function(){return window.location.href="/modiy_password"});return $("#tDate").click(function(){return $("#tDate").jSelectDate({yearBeign:1960,disabled:false})})});var login;login=function(){return $(document).ready(function(){return $("#login_button").click(function(){return $("#login_form").submit()})})};var get_photo_size,upload_photo;upload_photo=function(t){return $(document).ready(function(){var e,i,n,o,r,c,a,s,d,u,p,_,l;$("#save_photo").click(function(){return $("#to_save_phpto_from").submit()});$("#file").change(function(){return $("#upload_img").submit()});d=function(t){var e,i,r,s;if(parseInt(t.w)>0){e=u/t.w;r=_/t.h;i=p/t.w;s=l/t.h;n.css({width:Math.round(e*c)+"px",height:Math.round(r*a)+"px",marginLeft:"-"+Math.round(e*t.x)+"px",marginTop:"-"+Math.round(r*t.y)+"px"});o.css({width:Math.round(i*c)+"px",height:Math.round(s*a)+"px",marginLeft:"-"+Math.round(i*t.x)+"px",marginTop:"-"+Math.round(s*t.y)+"px"});console.log(t.x,t.y,t.w,t);$("#preview_x").val(t.x);$("#preview_y").val(t.y);return $("#preview_width").val(t.w)}};s=void 0;c=void 0;a=void 0;r=$("#preview-pane");e=$("#preview-pane .preview-container");i=$("#preview-pane .preview-container1");n=$("#preview-pane .preview-container img");o=$("#preview-pane .preview-container1 img");u=e.width();_=e.height();p=i.width();l=i.height();return $("#target").Jcrop({onChange:d,onSelect:d,aspectRatio:1/1,setSelect:[0,0,200,200]},function(){var e;e=this.getBounds();c=e[0];a=e[1];s=this;r.appendTo(s.ui.holder);return t()})})};get_photo_size=function(){return $(document).ready(function(){var t,e,i,n,o,r;console.log("get_photo_size");console.log($(".jcrop-holder")[0]);t=void 0;e=void 0;i=void 0;n=void 0;o=void 0;return r=void 0})};