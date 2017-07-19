{% wire id="add-cccp-cid-form"
   type="submit"
   postback="addcccpcidform"
   delegate="mod_kazoo"
%}
<form id="add-cccp-cid-form"
      method="post"
      action="postback"
      class="form">
  {% include "add_new_cid.tpl" headline=_"#"
                               idname="add_cid"
                               class="disabled"
  %}
</form>
