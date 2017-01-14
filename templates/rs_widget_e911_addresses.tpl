{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
{% wire id="arrows_"++#id type="click"
        action={ toggle target="e911_addresses_widget_opened" }
        action={ toggle target="arrow_right_"++#id }
        action={ toggle target="arrow_down_"++#id }
        action={ postback postback={trigger_innoui_widget arg="e911_addresses_widget_opened" } delegate="mod_kazoo" }
%}
  <span id="arrows_{{ #id }}" style="cursor: pointer;">
    <i id="arrow_right_{{ #id }}"
       style="{% if m.kazoo[{ui_element_opened element="e911_addresses_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-right"></i>
    <i id="arrow_down_{{ #id }}"
       style="{% if not m.kazoo[{ui_element_opened element="e911_addresses_widget_opened"}] %}display: none;{% endif %}" 
       class="arrowpad fa fa-arrow-circle-down"></i>
  </span>
  {{ headline }}
{% endblock %}

{% block widget_class %}{% if last %}last{% endif %}{% endblock %}

{% block widget_content %}
<div id="e911_addresses_widget_opened"
     style="{% if not m.kazoo[{ui_element_opened element="e911_addresses_widget_opened"}] %}display: none;{% endif %}">
  <table class="table table-condensed table-hover table-centered">
    <thead>
      <tr>
        <th class="text-center"></th>
        <th class="text-center">{_ Zip _}</th>
        <th class="text-center">{_ City _}</th>
        <th class="text-center">{_ State _}</th>
        <th class="text-center">{_ Address _}</th>
        <th class="text-center"></th>
        <th class="text-center"></th>
        <th class="text-center"></th>
      </tr>
    </thead>
    <tbody>
      {% for e911_address in m.onbill[{e911_addresses account_id=account_id}] %}
        <tr>
           <td class="text-center">
             {% if e911_address["address_confirmed"] %}
               <i id="confirmed_e911_address_{{ e911_address["id"] }}" class="fa fa-toggle-on pointer"></i>
               {% wire id="confirmed_e911_address_"++e911_address["id"]
                       action={confirm text=_"Do you really want to remove E911 address confirmation?"
                                       action={postback postback={set_e911_address_confirmed flag="false"
                                                                                             doc_id=e911_address["id"]
                                                                                             account_id=account_id
                                                                 }
                                                        delegate="mod_onbill"
                                              }
                              }
               %}
             {% else %}
               <i id="not_confirmed_e911_address_{{ e911_address["id"] }}" class="fa fa-toggle-off pointer"></i>
               {% wire id="not_confirmed_e911_address_"++e911_address["id"]
                       action={confirm text=_"Do you really want to confirm E911 address?"
                                       action={postback postback={set_e911_address_confirmed flag="true"
                                                                                             doc_id=e911_address["id"]
                                                                                             account_id=account_id
                                                                 }
                                                        delegate="mod_onbill"
                                              }
                              }
               %}
             {% endif %}
           </td>
           <td class="text-center">{{ e911_address["postal_code"] }}</td>
           <td class="text-center">{{ e911_address["locality"] }}</td>
           <td class="text-center">{{ e911_address["region"] }}</td>
           <td class="text-center">{{ e911_address["address"] }}</td>
           <td class="text-center">
               {% wire id="edit_e911_address_"++e911_address["id"]
                       action={dialog_open template="_edit_e911_proof_address.tpl"
                                           title=_"Edit E911 address"
                                           doc_id=e911_address["id"]
                                           account_id=account_id
                                           width="auto"
                                           edit_existing="true"
                              }
               %}
                 <i id="edit_e911_address_{{ e911_address["id"] }}" class="fa fa-edit pointer"></i>
           </td>
           <td class="text-center">
             {% if e911_address["attachment"] %}
               <a href="{{ m.onbill[{attachment_download_link account_id=account_id
                                                              doc_id=e911_address["id"]
                                                              doc_type="onbill_e911_address_proof"}] }}">
                 <i id="download_uploaded_doc_{{ e911_address["id"] }}" class="fa fa-download"></i>
               </a>
             {% else %}
             {% endif %}
           </td>
           <td class="text-center">
               <i id="delete_e911_address_{{ e911_address["id"] }}" class="fa fa-trash-o pointer"></i>
               {% wire id="delete_e911_address_"++e911_address["id"]
                       action={confirm text=_"Do you really want to delete this address?"++" <br />"
                                       action={postback postback={mark_e911_address_deleted doc_id=e911_address["id"] account_id=account_id}
                                                        delegate="mod_onbill"
                                              }
                              }
               %}
           </td>
        </tr>
      {% endfor %}
    </tbody>
  </table>
</div>
{% endblock %}
