{# print candidates #}
<table class="table table-condensed table-centered">
  <thead>
    {% for candidate in candidates %}
    <tr>
      <th width="80%">
        {{ candidate[1]["name"] }}
      </th>
      <th>
        {% button class="btn btn-xs btn-onnet pull-right"
                  text=_"select"
                  action={postback postback={rs_select_child_btn account_id=candidate[1]["id"]}
                                   delegate="mod_kazoo"
                         }
        %}
      </th>
    </tr>
    {% endfor %}
  </thead>
</table>
