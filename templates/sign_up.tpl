{% extends "services.tpl" %}


{% block service_name %}{_ Registration _}{% endblock %}


{% block service_description %}

    <!-- Main Form -->
    <div id="sign_up_div" class="container">
      <div class="row">
        <div class="col-md-8 col-md-offset-2 signup">
          {% wire id="sign_up_form" type="submit" postback={innosignup} delegate="mod_kazoo" %}
          <form id="sign_up_form" method="post" action="postback">
            <div class="form-group">
              <div class="row">
                <div class="col-sm-6">
                  <input type="text" class="form-control margin-bottom-xs" id="firstname" name="firstname" placeholder="{_ Your name (mandatory) _}">
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control" id="surname" name="surname" placeholder="{_ Your surname (mandatory) _}">
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-sm-6">
                  <input type="text" class="form-control margin-bottom-xs" id="username" name="username" placeholder="{_ Enter email address (mandatory) _}">
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control margin-bottom-xs" id="email" name="email" placeholder="{_ Confirm email address (mandatory) _}">
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
            <div class="checkbox">
              <label>
                <input type="checkbox" id="checkbox" name="checkbox" />{_ I agree to the _} <a href="/termscons">{_ Terms of Service _}</a>
              </label>
            </div>
            <br />
            <div class="form-group">
              <div class="row">
                <div class="col-sm-6">
                  {% button text=_"Create an account" class="btn btn-zprimary margin-bottom-xs" action={submit target="sign_up_form"}
                                                                                                action={update target="google_recaptcha" template="_google_recaptcha.tpl"}
                  %}
                </div>
                <div id="google_recaptcha" class="col-sm-6">
                  {% include "_google_recaptcha.tpl" %}
                </div>
              </div>
            </div>
            <input type="hidden" name="notify_signed_up" value="yes" />
          </form>
        </div>
      </div>
    </div>

<br />

<br />
    
{% endblock %}
