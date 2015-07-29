{% if m.inno[{kz_doc_field type=type doc_id=doc_id field=field_name}] %}<i class="fa fa-check-circle" title="Enabled"></i>{% else %}<i class="fa fa-ban" title="Disabled"></i>{% endif %}
<i id="toggle_{{ field_name }}" class="fa fa-refresh pointer" title="Change"></i>
{% wire id="toggle_"++field_name type="click" action={ postback postback={toggle_field type doc_id field_name}
                                                                      delegate="inno"
                                                                      inject_args type=type doc_id=doc_id field_name=field_name}
%}
