<li id="li_{{ #ip_acl }}" class="list-group-item text-center">
  {{ account_ip_acl_entry }}
  <input type="hidden" name="ip_acl_entry" value="{{ account_ip_acl_entry }}" />
  {% wire id="delete_"++#ip_acl action={remove target="li_"++#ip_acl} %}
  <i id="delete_{{ #ip_acl }}" class="fa fa-trash-o pointer" title="Delete" style="float: right;"></i>
</li>
