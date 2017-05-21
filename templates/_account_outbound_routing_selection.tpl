{% with m.kazoo.outbound_routing_strategy as routing %}
  <div class="btn-group pull-right">
    {% wire id="reseller_based_routing"
            action={confirm text=_"Do you really want to change this setting?"
                            action={postback postback="reseller_based_routing" delegate="mod_kazoo"}
                   }
    %}
    <button id="reseller_based_routing" class="btn btn-xs btn-onnet">
       <i style="visibility:{% if (routing[1] == "resources" and routing[2]) or routing[1] == "offnet" %}visible{% else %}hidden{% endif %};"
          class="fa fa-check"></i>
       {_ General routing _}
    </button>
     {% wire id="account_based_routing"
             action={confirm text=_"Do you really want to change this setting?"
                             action={postback postback="account_based_routing" delegate="mod_kazoo"}
                    }
     %}
    <button id="account_based_routing" class="btn btn-xs btn-onnet">
       <i style="visibility:{% if routing[1] == "resources" and not routing[2] %}visible{% else %}hidden{% endif %};"
          class="fa fa-check"></i>
       {_ Account defined _}
    </button>
  </div>
{% endwith %}
