{% wire id="passwordForm" type="submit" postback="password_recovery_form" delegate="mod_kazoo" %}
<form method="post" action="postback" id="passwordForm">
  <div class="form-group">
   <label class="form-control-onnet margin-bottom-xs">{_ Enter new password for _} {{ username }} {_ at _} {{ account_name }}
    <div class="row">
      <div class="col-sm-6">
        <input type="password" class="form-control margin-bottom-xs mt-1 mb-1" name="password1" id="password1" placeholder="{_ New password _}" autocomplete="off">
        <div class="col-sm-6" style="font-size: 0.85em;">
          <span id="10char" class="fa fa-remove" style="color:#FF0004;"></span> <span>{_ 10 Characters long _}</span><br>
          <span id="ucase" class="fa fa-remove" style="color:#FF0004;"></span> {_ Uppercase letters _}
        </div>
        <div class="col-sm-6" style="font-size: 0.85em;">
          <span id="lcase" class="fa fa-remove" style="color:#FF0004;"></span> {_ Lowercase letters _}<br>
          <span id="num" class="fa fa-remove" style="color:#FF0004;"></span> {_ Digits _}
        </div>
      </div>
      <div class="col-sm-6">
        <input type="password" class="form-control margin-bottom-xs mt-1 mb-1" name="password2" id="password2" placeholder="{_ Repeat password _}" autocomplete="off">
        <div class="col-sm-6" style="font-size: 0.85em;">
          <span id="pwmatch" class="fa fa-remove" style="color:#FF0004;"></span> {_ Passwords match _}
        </div>
      </div>
    </div>
   </label>
  </div>
  <div class="row">
    <div class="col-sm-12">
        {% button id="save_user_creds_btn" class="col-xs-12 btn btn-zprimary mt-1 mb-1" text=_"Save new password" action={script script="mypwdsubmit()"} %}
    </div>
  </div>
  <input type="hidden" name="account_id" value={{ account_id }}>
  <input type="hidden" name="owner_id" value={{ owner_id }}>
  <input type="hidden" name="auth_token" value={{ auth_token }}>
</form>

{% javascript %}

function mypwdsubmit() {
    var ucase = new RegExp("[A-Z]+");
    var lcase = new RegExp("[a-z]+");
    var num = new RegExp("[0-9]+");

    if( $("#password1").val().length >= 10  
       && 
        ucase.test($("#password1").val())
       && 
        lcase.test($("#password1").val())
       &&
        num.test($("#password1").val())
       &&
        ($("#password1").val() == $("#password2").val())
      )
       {
          $('form#passwordForm').submit();
       }else{
          z_growl_add('Please check password', 0, 'error');
       };
};

$("input[type=password]").keyup(function(){
        var ucase = new RegExp("[A-Z]+");
	var lcase = new RegExp("[a-z]+");
	var num = new RegExp("[0-9]+");
	
	if($("#password1").val().length >= 10){
		$("#10char").removeClass("fa-remove");
		$("#10char").addClass("fa-check");
		$("#10char").css("color","#00A41E");
	}else{
		$("#10char").removeClass("fa-check");
		$("#10char").addClass("fa-remove");
		$("#10char").css("color","#FF0004");
	}
	
	if(ucase.test($("#password1").val())){
		$("#ucase").removeClass("fa-remove");
		$("#ucase").addClass("fa-check");
		$("#ucase").css("color","#00A41E");
	}else{
		$("#ucase").removeClass("fa-check");
		$("#ucase").addClass("fa-remove");
		$("#ucase").css("color","#FF0004");
	}
	
	if(lcase.test($("#password1").val())){
		$("#lcase").removeClass("fa-remove");
		$("#lcase").addClass("fa-check");
		$("#lcase").css("color","#00A41E");
	}else{
		$("#lcase").removeClass("fa-check");
		$("#lcase").addClass("fa-remove");
		$("#lcase").css("color","#FF0004");
	}
	
	if(num.test($("#password1").val())){
		$("#num").removeClass("fa-remove");
		$("#num").addClass("fa-check");
		$("#num").css("color","#00A41E");
	}else{
		$("#num").removeClass("fa-check");
		$("#num").addClass("fa-remove");
		$("#num").css("color","#FF0004");
	}
	
	if($("#password1").val() == $("#password2").val()){
		$("#pwmatch").removeClass("fa-remove");
		$("#pwmatch").addClass("fa-check");
		$("#pwmatch").css("color","#00A41E");
	}else{
		$("#pwmatch").removeClass("fa-check");
		$("#pwmatch").addClass("fa-remove");
		$("#pwmatch").css("color","#FF0004");
	}
});

{% endjavascript %}
