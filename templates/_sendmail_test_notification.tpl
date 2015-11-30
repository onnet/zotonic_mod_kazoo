{% wire id="sendmail-test-notification-form" type="submit" postback="sendmail_test_notification" delegate="mod_kazoo" %}
<form id="sendmail-test-notification-form" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-5">
        <select id="sendmail_test_notification" name="sendmail_test_notification" class="form-control margin-bottom-xs" title="{_ Choose email address _}">
          {% with m.kazoo[{kz_user_doc_field field1="email"}] as email %}
            <option value="{{ email }}">{{ email }}</option>
          {% endwith %}
          <option value="Other">{_ Other address _}</option>
        </select>
      </div>
      <div class="col-sm-5">
        <input id="chosen_email" name="chosen_email" type="text" placeholder="{_ Input email _}" class="form-control margin-bottom-xs" />
      </div>
      <div class="col-sm-2">
        <button class="btn btn-primary btn-large pull-right" type="submit">{_ Send _}</button>
      </div>
    </div>
  </div>
  <input id="notification_id" type="hidden" name="notification_id" value={{ notification_id }} />
</form>

{% javascript %}

        $(function(){
            $("#chosen_email").hide();
            $('#sendmail_test_notification').change(function() {
              if($(this).find('option:selected').val() == "Other"){
                $("#chosen_email").show();
              }else{
                $("#chosen_email").hide();
                $("#chosen_email").val('');
              }
            });
            $('#sendmail-test-notification-form').submit(function() {
                var othersOption = $('#sendmail_test_notification').find('option:selected');
                if(othersOption.val() != "Other")
                {
                    $("#chosen_email").val(othersOption.val());
                }
            });
        });

{% endjavascript %}
