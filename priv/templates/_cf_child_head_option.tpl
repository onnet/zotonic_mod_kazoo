<div class="span_arrow small"></div>
<div class="clear"></div>
<div class="div_line"></div>
<div class="clear"></div>
<div class="div_option">
  {% if switch=="_" %}
    {% wire id=#switch_id
            action={postback postback={cf_choose_new_switch element_id=element_id
                                                            drop_parent=drop_parent
                                      }
                             delegate="mod_kazoo"
                   }
  %}
    <a id="{{ #switch_id }}" class="a_link_option" href="#">{_ Default _}</a>
  {% else %}
    {% wire id=#switch_id
            action={postback postback={cf_choose_new_switch element_id=element_id
                                                            drop_parent=drop_parent
                                      }
                             delegate="mod_kazoo"
                   }
    %}
    <a id="{{ #switch_id }}"
       class="a_link_option"
       href="#">{% if drop_parent == "temporal_route" %}{{ m.kazoo[{kz_get_temporal_rule rule_id=switch}][1]["name"] }}{% else %}{{ switch }}{% endif %}</a>
  {% endif %}
</div>
