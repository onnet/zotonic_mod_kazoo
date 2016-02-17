<li id="li_{{ blacklisted_number|cleanout }}" class="list-group-item text-center_no">
  {{ blacklisted_number }} - {{ blacklisted_description }}
  <input type="hidden" name="blacklisted_number" value="{{ blacklisted_number }}" />
  <input type="hidden" name="{{ blacklisted_number }}" value="{{ blacklisted_description }}" />
  {% wire id="delete_"++blacklisted_number|cleanout action={remove target="li_"++blacklisted_number|cleanout} %}
  <i id="delete_{{ blacklisted_number|cleanout }}" class="fa fa-trash-o pointer" title="Delete" style="float: right;"></i>
</li>
