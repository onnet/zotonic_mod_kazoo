
{_ URL _}:

<pre>
{{ m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] }}
</pre>

{_ Request example _}:

<pre>
curl -v -X POST {{ m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] }} -d '{"data": {"contact": "4992726200"}}'
</pre>

{_ Test _}:
      <div class="row">
        <div class="col-sm-6">
          <button class="col-xs-12 btn btn-zalarm margin-bottom-xs c2c_jquery_window_btn">{_ Place test call _}</button>
        </div>
        <div class="col-sm-6">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs c2c_jquery_show_btn">{_ Show code _}</button>
        </div>
      </div>



<style type="text/css">
    .form-jquery {display:none; width:100%; height: 122%; position: absolute; top: -22%; left: 0; background-color: rgba(0, 0, 0, 0.7);}
    .form-jquery .form-group {width:470px; height: 130px; margin: 15% auto; border-radius: 10px; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.5); padding: 10px;}
    .form-jquery .row p {padding: 10px 10px; text-align: center;}
    .form-jquery .form-jquery-close {cursor: pointer; display:block; width:10px; height: 10px; float: right;}
    .form-jquery-succ {display:none; width:100%; height: 122%; position: absolute; top: -22%; left: 0; background-color: rgba(0, 0, 0, 0.7);}
    .form-jquery-succ .form-group {width:470px; height: 130px; margin: 15% auto; border-radius: 10px; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.5); padding: 10px;}
    .form-jquery-succ .row p {padding: 10px 10px; text-align: center;}
    .form-jquery-succ .row {margin:33px 0;}
    .form-jquery-succ .form-jquery-close {cursor: pointer; display:block; width:10px; height: 10px; float: right;}
    .form-jquery-show {display:none; margin-top: 10px;}
</style>

<div class="form-jquery-succ">
    <div class="form-group">
      <div class="form-jquery-close"><a class="close">&times;</a></div>
      <div class="row">
	<p>Запрос отправлен!</p>
      </div>
    </div>
</div>

<div class="form-jquery">
    <div class="form-group">
      <div class="form-jquery-close"><a class="close">&times;</a></div>
      <div class="row">
	<p>Введите свой номер телефона.<br />Наши специалисты перезвонят Вам.</p>
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="contact_jq" name="contact" placeholder="{_ Enter number to call here _}">
        </div>
        <div class="col-sm-6">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs c2c_jquery_btn">{_ Place test call _}</button>
        </div>
      </div>
    </div>
</div>

<div class="form-jquery-show">
<pre>
&lt;style type="text/css"&gt;
    .form-jquery {display:none; width:100%; height: 122%; position: absolute; top: -22%; left: 0; background-color: rgba(0, 0, 0, 0.7);}
    .form-jquery .form-group {width:470px; height: 130px; margin: 15% auto; border-radius: 10px; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.5); padding: 10px;}
    .form-jquery .row p {padding: 10px 10px; text-align: center;}
    .form-jquery .form-jquery-close {cursor: pointer; display:block; width:10px; height: 10px; float: right;}
    .form-jquery-succ {display:none; width:100%; height: 122%; position: absolute; top: -22%; left: 0; background-color: rgba(0, 0, 0, 0.7);}
    .form-jquery-succ .form-group {width:470px; height: 130px; margin: 15% auto; border-radius: 10px; background-color: #fff; box-shadow: 0 0 10px rgba(0,0,0,0.5); padding: 10px;}
    .form-jquery-succ .row p {padding: 10px 10px; text-align: center;}
    .form-jquery-succ .row {margin:33px 0;}
    .form-jquery-succ .form-jquery-close {cursor: pointer; display:block; width:10px; height: 10px; float: right;}
&lt;/style&gt;

&lt;div class="form-jquery-succ"&gt;
    &lt;div class="form-group"&gt;
      &lt;div class="form-jquery-close"&gt;&lt;a class="close"&gt;&times;&lt;/a&gt;&lt;/div&gt;
      &lt;div class="row"&gt;
        &lt;p&gt;Запрос отправлен!&lt;/p&gt;
      &lt;/div&gt;
    &lt;/div&gt;
&lt;/div&gt;

&lt;div class="form-jquery"&gt;
    &lt;div class="form-group"&gt;
      &lt;div class="form-jquery-close"&gt;&lt;a class="close"&gt;&times;&lt;/a&gt;&lt;/div&gt;
      &lt;div class="row"&gt;
        &lt;p&gt;Введите свой номер телефона.&lt;br /&gt;Наши специалисты перезвонят Вам.&lt;/p&gt;
        &lt;div class="col-sm-6"&gt;
          &lt;input type="text" class="form-control margin-bottom-xs" id="contact_jq" name="contact" placeholder="{_ Enter number to call here _}"&gt;
        &lt;/div&gt;
        &lt;div class="col-sm-6"&gt;
          &lt;button class="col-xs-12 btn btn-zprimary margin-bottom-xs c2c_jquery_btn"&gt;{_ Place test call _}&lt;/button&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
&lt;/div&gt;

&lt;script&gt;

$(".c2c_jquery_window_btn").click(function() {
    $(".form-jquery").css("display","block");
});
$(".form-jquery-close").click(function() {
    $(".form-jquery").css("display","none");
    $(".form-jquery-succ").css("display","none");
});
$(".form-jquery-succ").click(function() {
    $(".form-jquery-succ").css("display","none");
});
$(".c2c_jquery_btn").click(do_c2c_jquery);

function form_jquery_succ_close(){
    $(".form-jquery-succ").css("display","none");
}

function do_c2c_jquery(){
    contact_val=$("#contact_jq").val();
    Parameters = JSON.stringify ({
             "data":{
               "contact":contact_val
             }
           });
    $.ajax({
        type: "POST",
        url: "{{ m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] }}",
        data:Parameters,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: {
            "Content-Type": "application/json",
        },
        success: function() {
            $(".form-jquery-succ").css("display","block");
            $(".form-jquery").css("display","none");
            $("#contact_jq").val("");
            setTimeout("form_jquery_succ_close()",5000);
        }
    })
};
&lt;/script&gt;
</pre>
</div>

<script>

$(".c2c_jquery_window_btn").click(function() {
    $(".form-jquery").css("display","block");
});
$(".form-jquery-close").click(function() {
    $(".form-jquery").css("display","none");
    $(".form-jquery-succ").css("display","none");
});
$(".form-jquery-succ").click(function() {
    $(".form-jquery-succ").css("display","none");
});
$(".c2c_jquery_show_btn").click(function() {
    tmp=$(".form-jquery-show").css("display");
    if (tmp=="none") {
        $(".form-jquery-show").css("display","block");
        $(".c2c_jquery_show_btn").html("{_ Hide code _}");
    }
    else {
        $(".form-jquery-show").css("display","none");
        $(".c2c_jquery_show_btn").html("{_ Show code _}");
    }
});
$(".c2c_jquery_btn").click(do_c2c_jquery);

function form_jquery_succ_close(){
    $(".form-jquery-succ").css("display","none");
}

function do_c2c_jquery(){
    contact_val=$("#contact_jq").val();
    Parameters = JSON.stringify ({
             "data":{
               "contact":contact_val
             }
           });
    $.ajax({
        type: "POST",
        url: "{{ m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] }}",
        data:Parameters,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        headers: {
            "Content-Type": "application/json",
        },
        success: function() {
            $(".form-jquery-succ").css("display","block");
            $(".form-jquery").css("display","none");
            $("#contact_jq").val("");
            setTimeout("form_jquery_succ_close()",5000);
        }
    })
};
</script>
