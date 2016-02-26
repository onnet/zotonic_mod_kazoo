{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="eavesdrop_feature"}] as eavesdrop %}
{% with m.kazoo[{kz_get_account_callflow callflow_id=eavesdrop[1]["id"]}] as eavesdrop_cf %}
<form id="form_edit_eavesdrop_dialog" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
         <label class="form-control-onnet margin-bottom-xs">{_ Approved users _}:
          <select id="eavesdrop_approved_list_id" name="eavesdrop_approved_list_id" class="form-control margin-bottom-xs" title="-- {_ Select group _} --" style="text-align:center;">
                <option value> {_ All users _}</option>
            {% for group in m.kazoo.kz_list_account_groups %}
                <option value="{{ group["id"] }}" {% if group["id"] == eavesdrop_cf[1]["flow"][1]["data"][1]["approved_group_id"] %}selected{% endif %}>
                 {{ group["name"] }}
                </option>
            {% endfor %}
          </select>
         </label>
        </div>
        <div class="col-sm-6">
         <label class="form-control-onnet margin-bottom-xs">{_ Target group _}:
          <select id="eavesdrop_target_list_id" name="eavesdrop_target_list_id" class="form-control margin-bottom-xs" title="-- {_ Select group _} --" style="text-align:center;">
            {% for group in m.kazoo.kz_list_account_groups %}
                <option value="{{ group["id"] }}" {% if group["id"] == eavesdrop_cf[1]["flow"][1]["data"][1]["group_id"] %}selected{% endif %}>
                 {{ group["name"] }}
                </option>
            {% endfor %}
          </select>
         </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
         <label class="form-control-onnet margin-bottom-xs">{_ Available keys _}:
      <div class="row">
        <div class="col-sm-12">
          <div class="col-sm-4">
          {_ Listen _} - 1
          </div>
          <div class="col-sm-4">
          {_ Whisper _} - 2
          </div>
          <div class="col-sm-4">
          {_ Full _} - 3
          </div>
        </div>
      </div>
         </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Save settings" 
                    action={postback postback="set_featurecode_eavesdrop" qarg="eavesdrop_approved_list_id" qarg="eavesdrop_target_list_id" delegate="mod_kazoo"}
          %}
        </div>
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Switch off eavesdrop" 
                    action={postback postback="delete_featurecode_eavesdrop" delegate="mod_kazoo"}
          %}
        </div>
      </div>
    </div>
</form>
{% endwith %}
{% endwith %}
