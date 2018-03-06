{% with m.kazoo[{kz_get_featurecode_by_name featurecode_name="hotdesk[action=toggle]"}]
   as hotdesk_toggle
%}
<div class="name">
  <span>{_ Toggle Hot-Desking _}</span>
</div>
<div id="featurecode_hotdesk_toggle"
     class="input">
  <span class="add-on">*13</span>
  {% wire id="toggle_featurecode_hotdesk_toggle"
          type="click"
          action={confirm text=_"Do you really want to change this setting?" 
                          action={postback postback="toggle_featurecode_hotdesk_toggle"
                                           delegate="mod_kazoo"
                                 }
                 }
  %}
  {% if hotdesk_toggle %}
    <i id="toggle_featurecode_hotdesk_toggle"
       class="fa fa-check-circle pointer"
       title="Enabled"></i>
  {% else %}
    <i id="toggle_featurecode_hotdesk_toggle"
       class="fa fa-ban pointer"
       title="Disabled"></i>
  {% endif %}
</div>
{% endwith %}
