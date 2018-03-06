{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="dynamic_cid"}] as dynamic_cid %}
{% with m.kazoo[{kz_get_account_callflow callflow_id=dynamic_cid[1]["id"]}] as dynamic_cid_cf %}
<form id="form_edit_dynamic_cid_dialog" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <select id="dynamic_cid_list_id"
                name="dynamic_cid_list_id"
                class="form-control margin-bottom-xs"
                title="-- {_ List type _} --"
                style="text-align:center;">
          {% for list in m.kazoo.kz_list_account_lists %}
            {% if list[1]["list_type"] == "dynamic_cid" %}
              <option value="{{ list[1]["id"] }}"
                      {% if list[1]["id"] == dynamic_cid_cf[1]["flow"][1]["data"][1]["id"] %}
                        selected
                      {% endif %}>
               {{ list[1]["name"] }} - {{ list[1]["description"] }}
              </option>
            {% endif %}
          {% endfor %}
        </select>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs"
                  text=_"Save settings" 
                  action={postback postback="set_featurecode_dynamic_cid"
                                   qarg="dynamic_cid_list_id"
                                   delegate="mod_kazoo"
                         }
        %}
      </div>
      <div class="col-sm-6">
        {% button class="col-xs-12 btn btn-zalarm margin-bottom-xs"
                  text=_"Switch off dynamic CID feature" 
                  action={postback postback="delete_featurecode_dynamic_cid"
                                   delegate="mod_kazoo"
                         }
        %}
      </div>
    </div>
  </div>
</form>
{% endwith %}
{% endwith %}
