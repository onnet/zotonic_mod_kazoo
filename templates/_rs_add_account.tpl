{% wire id="sign_up_form" type="submit" postback={innosignup} delegate="mod_kazoo" %}
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
  <br />
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
