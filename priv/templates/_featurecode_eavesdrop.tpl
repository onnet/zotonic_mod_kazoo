{% with
     m.kazoo[{kz_get_featurecode_by_name featurecode_name="eavesdrop_feature"}]
   as
     eavesdrop
%}
<div class="name"><span>{_ Eavesdrop _}</span></div>
<div id="featurecode_eavesdrop" class="input">
  <span class="add-on">*68</span>
  {% wire id="toggle_featurecode_eavesdrop"
          type="click"
          action={dialog_open title=_"Edit eavesdrop settings"
                              template="_edit_eavesdrop_dialog.tpl"
                 }
  %}
  {% if eavesdrop %}
    <i id="toggle_featurecode_eavesdrop"
       class="fa fa-check-circle pointer"
       title="Enabled"></i>
  {% else %}
    <i id="toggle_featurecode_eavesdrop"
       class="fa fa-ban pointer"
       title="Disabled"></i>
  {% endif %}
</div>
{% endwith %}
