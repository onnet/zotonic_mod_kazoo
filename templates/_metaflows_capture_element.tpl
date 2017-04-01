<div class="col-sm-12">
  <div class="row">
    {% wire id="delete_metaflow_capture_"++type++"_"++capture[1]|cleanout
            action={hide target="delete_metaflow_capture_"++type++"_"++capture[1]|cleanout}
            action={show target="cancel_delete_metaflow_capture_"++type++"_"++capture[1]|cleanout}
            action={show target="confirm_delete_metaflow_capture_"++type++"_"++capture[1]|cleanout}
    %}
    {% wire id="cancel_delete_metaflow_capture_"++type++"_"++capture[1]|cleanout
            action={show target="delete_metaflow_capture_"++type++"_"++capture[1]|cleanout}
            action={hide target="cancel_delete_metaflow_capture_"++type++"_"++capture[1]|cleanout}
            action={hide target="confirm_delete_metaflow_capture_"++type++"_"++capture[1]|cleanout}
    %}
    {% wire id="confirm_delete_metaflow_capture_"++type++"_"++capture[1]|cleanout
            action={postback postback={delete_metaflow_capture_element
                                       account_id=account_id
                                       capture_element_name=capture[1]
                                      }
                             delegate="mod_kazoo"
                   }
    %}
    <div class="col-xs-4">
      <i id="delete_metaflow_capture_{{ type }}_{{ capture[1]|cleanout }}"
         class="fa fa-remove pointer"
         title="Remove"></i>
      <i id="cancel_delete_metaflow_capture_{{ type }}_{{ capture[1]|cleanout }}"
         style="display: none;"
         class="fa fa-reply pointer"
         title="Cancel"></i>
      <i id="confirm_delete_metaflow_capture_{{ type }}_{{ capture[1]|cleanout }}"
         style="display: none;"
         class="fa fa-trash-o pointer"
         title="Confirm delete"></i>
      <label class="capture_label">{{ capture[1] }}</label>
    </div>
    <div class="col-xs-4">
      <label class="edit_user_label">{_ Module _}</label>
    </div>
    <div class="col-xs-4">
      {% wire id="edit_"++capture[1]|cleanout++"_amount"
              type="click"
              action={update target="capture_"++capture[1]|cleanout++"_amount"
                             template="_edit_metaflow_capture_field.tpl"
                             account_id=account_id
                             capture_name=capture[1]
                             field_name="amount"
                     }
      %}
      {{ capture[2][1]["module"] }}
      <i id="edit_{{ capture[1]|cleanout }}_amount" class="fa fa-edit pointer" title="Edit amount"></i>
    </div>
  </div>
</div>
{% for capture_data in capture[2][1]["data"][1] %}
<div class="col-sm-12">
  <div class="row">
    <div class="col-xs-4">
      {# print capture_data #}
    </div>
    <div class="col-xs-4">
      {{ capture_data[1] }}
    </div>
    <div class="col-xs-4">
      {{ capture_data[2] }}
    </div>
  </div>
</div>
{% endfor %}
