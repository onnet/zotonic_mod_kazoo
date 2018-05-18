{% wire id="passwordForm" type="submit" postback="passwordForm" delegate="mod_kazoo" %}
<form method="post" action="postback" id="passwordForm">
  <div class="form-group">
   <label class="form-control-onnet margin-bottom-xs">{_ Enter an email address for new login name or leave blank to keep an existing one _}
    <div class="row">
      <div class="col-sm-6">
         <input type="text" class="form-control margin-bottom-xs mt-1" id="username" name="username" 
                            placeholder="{_ Enter an email address here _}">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control margin-bottom-xs mt-1" id="email" name="email" placeholder="{_ Confirm email address _}">
      </div>
    </div>
   </label>
  </div>
  <div class="form-group">
   <label class="form-control-onnet margin-bottom-xs">{_ Enter new password _}
    <div class="row">
      <div class="col-sm-6">
        <input type="password" class="form-control margin-bottom-xs mt-1" name="password1" id="password1" placeholder="{_ New password _}" autocomplete="off">
        <div class="col-sm-3" style="font-size: 0.85em;">
          <span id="lcase" class="fa fa-remove" style="color:#FF0004;"></span> {_ Letters _}<br>
        </div>
        <div class="col-sm-3" style="font-size: 0.85em;">
          <span id="num" class="fa fa-remove" style="color:#FF0004;"></span> {_ Digits _}
        </div>
        <div class="col-sm-6" style="font-size: 0.85em;">
          <span id="10char" class="fa fa-remove" style="color:#FF0004;"></span> <span>{_ 10 Characters long _}</span><br>
        </div>
      </div>
      <div class="col-sm-6">
        <input type="password" class="form-control margin-bottom-xs mt-1" name="password2" id="password2" placeholder="{_ Repeat password _}" autocomplete="off">
        <div class="col-sm-6" style="font-size: 0.85em;">
          <span id="pwmatch" class="fa fa-remove" style="color:#FF0004;"></span> {_ Passwords match _}
        </div>
      </div>
    </div>
   </label>
  </div>
  <div class="row">
    <div class="col-sm-12">
        {% button id="save_user_creds_btn" class="col-xs-12 btn btn-zprimary mt-1" text=_"Save new user credentials" action={script script="mypwdsubmit()"} %}
        {# button id="close_user_creds_window_btn" class="col-xs-12 btn btn-zprimary mt-1 display_none" text=_"Close window" action={dialog_close} #}
        {% button id="reset_password_to_random_btn" class="col-xs-12 btn btn-zalarm mt-1 mb-1" text=_"Reset password to random and email to owner"
                                                             action={toggle target="passwordForm"}
                                                             action={toggle target="reset_password_confirmation"}
        %}
    </div>
  </div>
  <input type="hidden" name="chpwd_user_id" value={{ user_id }}>
</form>

  <div id="reset_password_confirmation" class="row display_none">
    <div class="col-sm-12" style="margin-top: 1em; margin-bottom: 1em;">
        {% button id="reset_password_confirmation_btn" class="col-xs-12 btn btn-zalarm mt-1 mb-1" text=_"Do you really want to reset password?"
                                                    action={postback postback={reset_password username=user_doc["username"]} delegate="mod_kazoo"}
        %}
        {% button id="cancel_password_confirmation_btn" class="col-xs-12 btn btn-zprimary mt-1 mb-1" text=_"Back to user's credentials change"
                                                             action={toggle target="passwordForm"}
                                                             action={toggle target="reset_password_confirmation"}
        %}
    </div>
  </div>

{% javascript %}

function mypwdsubmit() {
    var lcase = new RegExp("[a-zA-Z]+");
    var num = new RegExp("[0-9]+");

    if( $("#password1").val().length >= 10  
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
	var lcase = new RegExp("[a-zA-Z]+");
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
