{% with m.kazoo[{outbound_routing_strategy account_id=account_id}] as routing %}
<td>{_ Outbound routing _}</td>
<td>
  <div class="btn-group pull-right">
    {% wire id="global_carrier_routing"
            action={confirm text=_"Do you really want to change this setting?" 
                            action={postback postback={global_carrier_routing account_id=account_id}
                                             delegate="mod_kazoo"
                                   }
                   } 
    %}
    <button id="global_carrier_routing" class="btn btn-xs btn-onnet">
      <i style="visibility:{% if routing[1] == "offnet" %}visible{% else %}hidden{% endif %};"
         class="fa fa-check"></i>
      {_ Global carrier _}
    </button>
    {% if not m.kazoo.kz_current_context_superadmin %}
      {% wire id="reseller_based_routing"
              action={confirm text=_"Do you really want to change this setting?" 
                              action={postback postback={reseller_based_routing account_id=account_id}
                                               delegate="mod_kazoo"
                                     }
                     }
      %}
      <button id="reseller_based_routing" class="btn btn-xs btn-onnet">
         <i style="visibility:{% if routing[1] == "resources" and routing[2] %}visible{% else %}hidden{% endif %};"
            class="fa fa-check"></i>
         {_ Reseller based _}
      </button>
    {% endif %}
    {% wire id="account_based_routing"
            action={confirm text=_"Do you really want to change this setting?" 
                            action={postback postback={account_based_routing account_id=account_id}
                                             delegate="mod_kazoo"
                                   }
                   }
    %}
    <button id="account_based_routing" class="btn btn-xs btn-onnet">
      <i style="visibility:{% if routing[1] == "resources" and not routing[2] %}visible{% else %}hidden{% endif %};"
         class="fa fa-check"></i>
      {_ Account based _}
    </button>
  </div>
</td>
{% endwith %}
