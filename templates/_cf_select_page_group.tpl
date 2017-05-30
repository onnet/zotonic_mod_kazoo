{% with m.kazoo[{cf_get_element_by_id element_id=element_id}]
       ,m.kazoo.kz_list_account_groups
       ,m.kazoo.kz_list_account_users_short
       ,m.kazoo.kz_list_account_devices_short
    as 
        element_data
       ,account_groups
       ,users_short
       ,devices_short
%}
{% wire id="form_cf_select_page_group"
        type="submit"
        postback="cf_select_page_group"
        delegate="mod_kazoo"
%}
<form id="form_cf_select_page_group" method="post" action="postback">
  <div class="form-group">
    <div class="row">
      <div class="col-sm-6">
        <input type="text"
               class="form-control margin-bottom-xs"
               id="group_name"
               name="name"
               placeholder="{_ Enter group name here _}"
               value="{{ element_data[1]["data"][1]["name"] }}">
      </div>
      <div class="col-sm-6">
        <select id="audio_selector"
                name="audio"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          <option value="one-way" selected>-- {_ One-Way audio _} --</option>
          <option value="two-way">-- {_ Two-Way audio _} --</option>
        </select>
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-xs-12">
      <div class="col-xs-1 col-xs-offset-3 text-center"></div>
      <div class="col-xs-4 text-center"></div>
      <div class="col-xs-1 text-center"></div>
    </div>
  </div>
  {% sorter id="sorter" tag="mysorter" delegate="mod_kazoo" %}
  <div id="sorter" class="form-group">
  {% for endpoint in element_data[1]["data"][1]["endpoints"] %}
      {% include "_cf_select_page_group_element.tpl"
                 selected_value=[endpoint[1]]
                 element_type=endpoint[1]["endpoint_type"]
                 account_groups=account_groups
                 users_short=users_short
                 devices_short=devices_short
      %}
  {% endfor %}
  </div>
  <input type="hidden" name="element_id" value="{{ element_id }}">
</form>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-4">
        <h4 class="text-center">Groups:</h4>
        {% wire id="group_selector"
                type="change"
                action={script script="$('#group_selector').get(0).selectedIndex = 0;"}
                action={postback postback={cf_page_group_select element_type="group"}
                                 delegate="mod_kazoo"
                       }
        %}
        <select id="group_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          <option value="" selected>-- {_ Select to add _} --</option>
          {% for group in account_groups %}
            <option id="option_{{ group[1]["id"] }}"
                    {% for selected_endpoint in element_data[1]["data"][1]["endpoints"] %}
                      {% if selected_endpoint[1]["id"] == group[1]["id"] %}
                        style="display:none;"
                      {% endif %}
                    {% endfor %}
                    value='{"id":"{{ group[1]["id"] }}","name":"{{ group[1]["name"] }}","endpoint_type":"group"}'>
              {{ group[1]["name"] }}
            </option>
          {% endfor %}
        </select>
      </div>
      <div class="col-sm-4">
        <h4 class="text-center">Users:</h4>
        {% wire id="user_selector"
                type="change"
                action={script script="$('#user_selector').get(0).selectedIndex = 0;"}
                action={postback postback={cf_page_group_select element_type="user"}
                                 delegate="mod_kazoo"
                       }
        %}
        <select id="user_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          <option value="" selected>-- {_ Select to add _} --</option>
          {% for option in users_short %}
            {% if option[1] %}
              <option id="option_{{ option[1] }}"
                      {% for selected_endpoint in element_data[1]["data"][1]["endpoints"] %}
                        {% if selected_endpoint["id"] == option[1] %}
                          style="display:none;"
                        {% endif %}
                      {% endfor %}
                      value='{"id":"{{ option[1] }}","name":"{{ option[2] }}","endpoint_type":"user"}'>
                {{ option[2] }}
              </option>
            {% endif %}
          {% endfor %}
        </select>
      </div>
      <div class="col-sm-4">
        <h4 class="text-center">Devices:</h4>
        {% wire id="device_selector"
                type="change"
                action={script script="$('#device_selector').get(0).selectedIndex = 0;"}
                action={postback postback={cf_page_group_select element_type="device"}
                                 delegate="mod_kazoo"
                       }
        %}
        <select id="device_selector"
                name="selected"
                class="form-control margin-bottom-xs"
                style="text-align:center;">
          <option value="" selected>-- {_ Select to add _} --</option>
          {% for option in devices_short %}
            {% if option[1] %}
              <option id="option_{{ option[1] }}"
                      {% for selected_endpoint in element_data[1]["data"][1]["endpoints"] %}
                        {% if selected_endpoint["id"] == option[1] %}
                          style="display:none;"
                        {% endif %}
                      {% endfor %}
                      value='{"id":"{{ option[1] }}","name":"{{ option[2] }}","endpoint_type":"device"}'>
                {{ option[2] }}
              </option>
            {% endif %}
          {% endfor %}
        </select>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        {% wire id="cf_select_page_group"
                action={script script="$.each($('.sortable'), function() {$('#'+this.id+'_index').val($(this).index()); });"} 
                action={script script="$('#"++element_id++"_details').text(($('#group_name').val()))"}
                action={submit target="form_cf_select_page_group"}
        %}
        <button id="cf_select_page_group"
                class="col-xs-12 btn btn-zprimary margin-bottom-xs">
          {_ Save _}
        </button>
      </div>
    </div>
  </div>
{% endwith %}
{% javascript %}
  $('.modal-header h3').append($('#{{ tool_name }}  div.tool_name').text());
{% endjavascript %}
