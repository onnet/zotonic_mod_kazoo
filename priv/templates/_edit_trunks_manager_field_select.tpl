  <select id="{{ trunks_type }}_manager_input"
          name="input_value"
          class="btn-xs btn-onnet"
          style="max-width:140px; height:20px; text-align:center;">
    {% for trunks_amount in 0|range:30 %}
      <option value="{{ trunks_amount }}" {% if trunks_amount == current_trunks_amount %}selected{% endif %}>{{ trunks_amount }}</option>
    {% endfor %}
  </select>
    <i id="{{ trunks_type }}_undo" class="fa fa-remove pointer" title="Cancel"></i>
    {% wire id=trunks_type++"_undo"
            type="click"
            action={update target="trunks_manager_table"
                           template="trunks_manager_table_body.tpl"
                   }
    %}
    <i id="{{ trunks_type }}_save" class="fa fa-save pointer" title="{_ Save _}"></i>
    {% wire id=trunks_type++"_save"
            type="click"
            action={postback postback={save_trunks_limits trunks_type account_id}
                             delegate="mod_kazoo"
                             qarg=trunks_type++"_manager_input"
                             inject_args trunks_type=trunks_type account_id=account_id
                   }
    %}
