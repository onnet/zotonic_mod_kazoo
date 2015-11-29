{% wire id="emailinvoice-form" type="submit" postback={emailinvoice} delegate="mod_kazoo" %}
<form id="emailinvoice-form" method="post" action="postback" style="padding-bottom: 15px;">
  <span>
    <br />
    {_ Choose email address _}: 
    <select id="emailinvoice" name="emailinvoice">
      {% for email in m.lb.get_accounts_emails %}
      <option value="{{ email }}">{{ email }}</option>
      {% endfor %}
      <option value="Other">{_ Other address _}</option>
    </select>
    <input id="chosen_email" name="chosen_email" type="text" placeholder="{_ Input email _}" style="width:160px!important" />
    <input id="docid" type="hidden" name="docid" value={{ arg }} />
  </span>
  <button class="btn btn-primary btn-large pull-right" style="margin-right: 10px; margin-bottom: 20px;" type="submit">{_ Send _}</button>
</form>

{% javascript %}

        $(function(){
            $("#chosen_email").hide();
            $('#emailinvoice').change(function() {
              if($(this).find('option:selected').val() == "Other"){
                $("#chosen_email").show();
              }else{
                $("#chosen_email").hide();
                $("#chosen_email").val('');
              }
            });
            $('#emailinvoice-form').submit(function() {
                var othersOption = $('#emailinvoice').find('option:selected');
                if(othersOption.val() != "Other")
                {
                    $("#chosen_email").val(othersOption.val());
                }
            });
        });

{% endjavascript %}
