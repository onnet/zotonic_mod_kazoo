{% wire id="add_new_user_form" type="submit" postback="add_new_user_form" delegate="mod_kazoo" %}
<form id="add_new_user_form" method="post" action="postback">
            <div class="form-group">
              <div class="row">
                <div class="col-sm-6">
                  <input type="text" class="form-control margin-bottom-xs" id="firstname" name="firstname" placeholder="{_ Name (mandatory) _}">
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control" id="surname" name="surname" placeholder="{_ Surname (mandatory) _}">
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
                <div class="col-sm-12">
                  <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Create user _}</button>
                </div>
                
              </div>
            </div>
</form>
