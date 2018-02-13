{% extends "services.tpl" %}


{% block service_name %}{_ Registration _}{% endblock %}


{% block service_description %}
<!-- Main Form -->
<div id="sign_up_div" class="container">
  <div class="row">
    <div class="col-md-8 col-md-offset-2 signup">
      {% wire id="sign_up_form"
              type="submit"
              postback="signup"
              delegate="mod_kazoo"
      %}
      <form id="sign_up_form" method="post" action="postback">
        <div class="form-group">
          <div class="row">
            <div class="col-sm-6">
              <input type="text"
                     class="form-control margin-bottom-xs"
                     id="firstname"
                     name="firstname"
                     placeholder="{_ Your name (mandatory) _}">
            </div>
            <div class="col-sm-6">
              <input type="text"
                     class="form-control"
                     id="surname"
                     name="surname"
                     placeholder="{_ Your surname (mandatory) _}">
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="row">
            <div class="col-sm-6">
              <input type="text"
                     class="form-control margin-bottom-xs"
                     id="signup_username"
                     name="signup_username"
                     placeholder="{_ Enter email address (mandatory) _}">
            </div>
            <div class="col-sm-6">
              <input type="text"
                     class="form-control margin-bottom-xs"
                     id="email"
                     name="email"
                     placeholder="{_ Confirm email address (mandatory) _}">
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="row">
            <div class="col-sm-6">
              <input type="text"
                     class="form-control"
                     id="companyname"
                     name="companyname"
                     placeholder="{_ Company name _} {_ (optional) _}">
            </div>
            <div class="col-sm-6">
              <input type="text"
                     class="form-control"
                     id="phonenumber"
                     name="phonenumber"
                     placeholder="{_ Phone number _} {_ (mandatory) _}">
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="row">
            <div class="col-sm-12">
              <div class="controls">
                <textarea rows="4"
                          cols="10"
                          id="comments"
                          name="comments"
                          placeholder=" {_ Comments _}">
                </textarea>
              </div>
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="row">
            <div class="col-sm-6">
              <div class="checkbox">
                <label>
                  <input type="checkbox"
                         id="checkbox"
                         name="checkbox" />
                    {_ I agree to the _}
                    <a href="/termscons">{_ Terms of Service _}</a>
                </label>
              </div>
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="row">
            <div class="col-sm-6">
              {% button text=_"Create an account"
                        class="btn btn-zprimary margin-bottom-xs"
                        action={script script="$('form#sign_up_form').submit();"}
              %}
            </div>
            <span id="google_recaptcha">
              {% include "_google_recaptcha.tpl" %}
            </span>
          </div>
        </div>
        <input type="hidden" name="notify_signed_up" value="yes" />
        <input type="hidden"
               name="kazoo_reseller_id"
               value="{{ m.config.mod_kazoo.reseller_id.value }}" />
      </form>
    </div>
  </div>
</div>
<br />
<br />
{% endblock %}
