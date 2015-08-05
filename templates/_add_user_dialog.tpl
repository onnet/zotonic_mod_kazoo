{% wire id="add_new_user_form" type="submit" postback="add_new_user_form" delegate="mod_kazoo" %}
<form id="add_new_user_form" method="post" action="postback">
            <div class="form-group">
              <div class="row">
                <div class="col-sm-6">
                  <input type="text" class="form-control margin-bottom-xs" id="firstname" name="firstname" placeholder="Name (mandatory)" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter name here." data-original-title="Name">
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control" id="surname" name="surname" placeholder="Surname (mandatory)" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter surname here." data-original-title="Name">
                </div>
              </div>
            </div>
            <div class="form-group">
              <div class="row">
                <div class="col-sm-6">
                  <input type="text" class="form-control margin-bottom-xs" id="username" name="username" placeholder="Enter email address (mandatory)" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter your nickname here." data-original-title="Username">
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control margin-bottom-xs" id="email" name="email" placeholder="Confirm email address (mandatory)" data-toggle="popover" data-placement="left" data-trigger="focus" data-content="Enter a valid email here." data-original-title="Email">
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
