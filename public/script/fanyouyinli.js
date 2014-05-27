$(document).ready( function () {
			// 验证
					var eMaliReg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
					var nameReg = /[^\x00-\x80]/;
					var passwordReg = /^[a-zA-Z0-9]{6,}$/;
		var t = 1;
			$("#turn_right").click(
				function(){
					if (t >= 1 && t < 3) {
					t += 1;
					$("#mian_photo").css("backgroundImage","url(./images/zhutu"+t+".png)");
					}});
			$("#turn_left").click(
				function() {
				if (t > 1 && t <= 3) {
					t -= 1;
					$("#mian_photo").css("backgroundImage","url(./images/zhutu"+t+".png)");
					}
				}
			);
			$("#apply_button").click(
				function() {
					$("#turn_right").fadeOut();
					$("#turn_left").fadeOut();
					$("#mian_photo").css("backgroundImage","url(./images/fan02.png)");
					$("#apply_button").fadeOut();
					// $("#e_mail").type("text");
					var e_mail=document.getElementById("e_mail");
					e_mail.type = "text";
					var username=document.getElementById("username");
					username.type = "text";
					var city=document.getElementById("city");
					city.type = "text";
					var about_me=document.getElementById("about_me");
					about_me.hidden = "";
					messge_sub.hidden = "";
				}
				);
			$("#messge_sub").click(
				function() {
					var e_mail=document.getElementById("e_mail");
					var username=document.getElementById("username");
					var city=document.getElementById("city");
					
					if (!eMaliReg.test(e_mail.value)) {
						$("#xing1").fadeIn();
						$("#email_tip").html("输入的E-mail地址不对");
						e_mail.focus();
						return false;
					} else {
						$("#xing1").fadeOut();
						$("#email_tip").html("");
					}
					if (!nameReg.test(username.value)) {
						$("#xing2").fadeIn();
						$("#name_tip").html("输入的名字不对");
						username.focus();
						return false;
					} else {
						$("#xing2").fadeOut();
						$("#name_tip").html("");
					}
					if (!nameReg.test(city.value)) {
						$("#xing3").fadeIn();
						$("#city_tip").html("输入的城市名不对");
						city.focus();
						return false;
					} else {
						$("#xing3").fadeOut(1);
						$("#city_tip").html("");
					}
					e_mail.type = "hidden";
					username.type = "hidden";
					city.type = "hidden";
					about_me.hidden = "hidden";
					messge_sub.hidden = "hidden";
					$("#form1").submit();
					$("#mian_photo").css("backgroundImage","url(./images/fan03.png)")
				});
	$("#login_button").click(function() {
		$("#login_form").submit();	
	});
	$("#find_password_button").click(function() {
		$("#find_password_form").submit();	
	});

	$("#reg_button").click(function() {
		var reg_eMail=document.getElementById("reg_mail");
		var reg_password=document.getElementById("reg_password");
		var reg_name=document.getElementById("reg_name");
		var reg_city=document.getElementById("reg_city");
		if (!eMaliReg.test(reg_eMail.value)) {
						$("#reg_email_tip").html("输入的E-mail地址不对");
						$("#reg_email_tip").fadeIn();
						$("#reg_email_tip1").fadeIn();
						reg_eMail.focus();
						return false;
					} else {
						$("#reg_email_tip1").fadeOut();
						$("#reg_email_tip").fadeOut();
						$("#reg_email_tip").html("");
					}
		if (!passwordReg.test(reg_password.value)) {
						$("#reg_password_tip").html("密码格式不正确，请输入6位以上密码，可以是数字和字母");
						$("#reg_password_tip").fadeIn();
						$("#reg_password_tip1").fadeIn();
						reg_password.focus();
						return false;
					} else	{
						$("#reg_password_tip1").fadeOut();
						$("#reg_password_tip").fadeOut();
						$("#reg_password_tip").html("");
					}
		if (!nameReg.test(reg_name.value)) {
						$("#reg_name_tip").html("输入的姓名不对");
						$("#reg_name_tip").fadeIn();
						$("#reg_name_tip1").fadeIn();
						reg_name.focus();
						return false;
					} else	{
						$("#reg_name_tip1").fadeOut();
						$("#reg_name_tip").fadeOut();
						$("#reg_name_tip").html("");
					}
		if (!nameReg.test(reg_city.value)) {
						$("#reg_city_tip").html("城市只限制中文");
						$("#reg_city_tip").fadeIn();
						$("#reg_city_tip1").fadeIn();
						reg_city.focus();
						return false;
					} else	{
						$("#reg_city_tip1").fadeOut();
						$("#reg_city_tip").fadeOut();
						$("#reg_city_tip").html("");
					}
		var checking = -1;
		var form1 = document.getElementById("reg_form");
		for (var i = 0; i < form1.sex.length; i++) {
			if(form1.sex[i].checked) {
				checking = form1.sex[i].value;
				console.log("选中的值是" + checking);
				break;
				} 
		  	}
		if (checking < 0) {
					$("#reg_sex_tip").html("请选择性别");
					$("#reg_sex_tip").fadeIn();
					$("#reg_sex_tip1").fadeIn();
		} else {
					$("#reg_sex_tip1").fadeOut();
					$("#reg_sex_tip").fadeOut();
					$("#reg_sex_tip").html("");
					$("#reg_form").sex = checking;
		}
		$("#reg_form").submit();
	});
	$("#reg_success_button").click(function() {
		$("#reg_success_form").submit();
	});
	$("#dinner_party").click(function() {
		$("#dinner_party").css("background-position","0px 0px");
		$("#singer").css("background-position","-95px -38px");
		$("#attractive").css("background-position","-95px -74px");
		$("#my_attractive").css("background-position","-95px -112px");
		 window.location.href="/idinner"; 

	});
	$("#singer").click(function() {
		$("#dinner_party").css("background-position","-95px 0px");
		$("#singer").css("background-position","0px -38px");
		$("#attractive").css("background-position","-95px -74px");
		$("#my_attractive").css("background-position","-95px -112px");
		window.location.href="/isinger"; 
	});
	$("#attractive").click(function() {
		$("#dinner_party").css("background-position","-95px 0px");
		$("#singer").css("background-position","-95px -38px");
		$("#attractive").css("background-position","0px -74px");
		$("#my_attractive").css("background-position","-95px -112px");
		window.location.href="/iattractive"; 
	});
	$("#my_attractive").click(function() {
		$("#dinner_party").css("background-position","-95px 0px");
		$("#singer").css("background-position","-95px -38px");
		$("#attractive").css("background-position","-95px -74px");
		$("#my_attractive").css("background-position","0px -112px");
		window.location.href="/ifanyor"; 
	});
	$("#iat_hot").click(function() {
		$("#iat_hot").css("background-color","#5bc7d6");
		$("#iat_hot").css("color","white");
		$("#iat_new").css("background-color","white");
		$("#iat_new").css("color","#9f9f9f");
		$("#iat_add").css("background-color","white");
		$("#iat_add").css("color","#9f9f9f");
	});
	$("#iat_new").click(function() {
		$("#iat_new").css("background-color","#5bc7d6");
		$("#iat_new").css("color","white");
		$("#iat_hot").css("background-color","white");
		$("#iat_hot").css("color","#9f9f9f");
		$("#iat_add").css("background-color","white");
		$("#iat_add").css("color","#9f9f9f");
	});
	$("#iat_add").click(function() {
		$("#iat_add").css("background-color","#5bc7d6");
		$("#iat_add").css("color","white");
		$("#iat_hot").css("background-color","white");
		$("#iat_hot").css("color","#9f9f9f");
		$("#iat_new").css("background-color","white");
		$("#iat_new").css("color","#9f9f9f");
	});
	$("#iat_hot").hover(function() {
		$("#iat_hot").css("background-color","#5bc7d6");
		$("#iat_hot").css("color","white");
		} ,function() {
		$("#iat_hot").css("background-color","white");
		$("#iat_hot").css("color","#9f9f9f");
		});
	$("#iat_new").hover(function() {
		$("#iat_new").css("background-color","#5bc7d6");
		$("#iat_new").css("color","white");
		} ,function() {
		$("#iat_new").css("background-color","white");
		$("#iat_new").css("color","#9f9f9f");
		});
	$("#iat_add").hover(function() {
		$("#iat_add").css("background-color","#5bc7d6");
		$("#iat_add").css("color","white");
		} ,function() {
		$("#iat_add").css("background-color","white");
		$("#iat_add").css("color","#9f9f9f");
		});
	
});