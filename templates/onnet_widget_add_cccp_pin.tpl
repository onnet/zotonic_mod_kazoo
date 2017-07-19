{% wire id="add-cccp-pin-form"
        type="submit"
        postback="addcccppinform"
        delegate="mod_kazoo"
%}
<form id="add-cccp-pin-form"
      method="post"
      action="postback"
      class="form">
  {% include "add_new_pin.tpl" headline=_"#"
                               idname="add_pin"
                               class="disabled"
  %}
</form>
