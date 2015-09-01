<div class="row">
<div class="col-sm-8 col-sm-offset-2">
{% wire id="passwordForm" type="submit" postback="passwordForm" delegate="mod_kazoo" %}
<form method="post" action="postback" id="passwordForm">
<input type="hidden" name="chpwd_user_id" value={{ user_id }}>
<input type="password" class="input form-control mt-1" name="password1" id="password1" placeholder="{_ New password _}" autocomplete="off">
<div class="row">
<div class="col-sm-6">
<span id="10char" class="fa fa-remove" style="color:#FF0004;"></span> {_ 10 Characters long _}<br>
<span id="ucase" class="fa fa-remove" style="color:#FF0004;"></span> {_ Uppercase letters _}
</div>
<div class="col-sm-6">
<span id="lcase" class="fa fa-remove" style="color:#FF0004;"></span> {_ Lowercase letters _}<br>
<span id="num" class="fa fa-remove" style="color:#FF0004;"></span> {_ Numbers _}
</div>
</div>
<input type="password" class="input form-control mt-1" name="password2" id="password2" placeholder="{_ Repeat password _}" autocomplete="off">
<div class="row">
<div class="col-sm-12">
<span id="pwmatch" class="fa fa-remove" style="color:#FF0004;"></span> {_ Passwords match _}
</div>
</div>
{% button class="col-xs-12 btn btn-zprimary mt-1 mb-1" text=_"Change Password"  action={script script="mypwdsubmit()"} %}
</form>
</div><!--/col-sm-6-->
</div><!--/row-->


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
