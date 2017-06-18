{% wire id="sign_up_form" type="submit" postback="signup" delegate="mod_kazoo" %}
<form id="sign_up_form" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <input type="text" class="form-control margin-bottom-xs" id="firstname" name="firstname" placeholder="{_ Name _} {_ (mandatory) _}">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control" id="surname" name="surname" placeholder="{_ Surname _} {_ (mandatory) _}">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <input type="text" class="form-control margin-bottom-xs" id="username" name="username" placeholder="{_ Email address _} {_ (mandatory) _}">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control margin-bottom-xs" id="email" name="email" placeholder="{_ Confirm email address _} {_ (mandatory) _}">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <input type="text" class="form-control" id="companyname"  name="companyname" placeholder="{_ Company name _} {_ (optional) _}">
      </div>
      <div class="col-sm-6">
        <input type="text" class="form-control" id="phonenumber" name="phonenumber" placeholder="{_ Phone number _} {_ (mandatory) _}">
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <div class="controls">
          <textarea rows="4" cols="10" id="comments" name="comments" placeholder=" {_ Comments _}"></textarea>
        </div>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <label for="notify_account_input" style="width: 100%;" class="checkbox-inline checked">
          <input type="checkbox" value="yes" id="notify_account_input" name="notify_signed_up" checked>
          {_ Notify created account _}
        </label>
      </div>
      <div class="col-sm-6">
        <input type="file" name="signup_file" class="file">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="{_ Upload document _}">
          <span class="input-group-btn">
            <button class="browse btn btn-zprimary margin-bottom-xs" type="button"><i class="glyphicon glyphicon-search"></i> {_ Browse _}</button>
          </span>
        </div>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Create an account _}</button>
      </div>
    </div>
  </div>
  <input type="checkbox" id="checkbox" name="checkbox" checked style="display: none;"/>
  <input type="hidden" id="rs_sign_up" name="rs_sign_up" value="1"/>
</form>

<style>
.file {
  visibility: hidden;
  position: absolute;
}
</style>

{% javascript %}
  $(document).ready(function() {
          $('.form-group').on('click','input[type=checkbox]',function() {
                  $(this).closest('.checkbox-inline, .checkbox').toggleClass('checked');
          });
  });
  $(document).on('click', '.browse', function(){
    var file = $(this).parent().parent().parent().find('.file');
    file.trigger('click');
  });
  $(document).on('change', '.file', function(){
    $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
  });
{% endjavascript %}
