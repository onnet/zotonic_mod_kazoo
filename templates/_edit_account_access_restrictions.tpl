<div min-height="50%">
  <ul class="nav nav-tabs nav-justified" role="tablist">
    <li id="li_account_web_access" class="active"><a href="#account_web_access" role="tab" data-toggle="tab">{_ Web access _}</a></li>
    {% wire id="li_account_web_access"
            type="click"
            action={update target="restrictions_pannel_div" template="_add_webaccess_list.tpl" account_id=account_id}
            action={set_class target="li_account_web_access" class="active"}
            action={remove_class target="li_account_sip_access" class="active"}
            action={remove_class target="li_call_restrictions" class="active"}
            action={remove_class target="li_calls_allotments" class="active"}
    %}
    <li id="li_account_sip_access"><a href="#account_sip_access" role="tab" data-toggle="tab">{_ SIP access _}</a></li>
    {% wire id="li_account_sip_access"
            type="click"
            action={update target="restrictions_pannel_div" template="_add_account_sipaccess_list.tpl" account_id=account_id}
            action={remove_class target="li_account_web_access" class="active"}
            action={set_class target="li_account_sip_access" class="active"}
            action={remove_class target="li_call_restrictions" class="active"}
            action={remove_class target="li_calls_allotments" class="active"}
    %}
    <li id="li_call_restrictions"><a href="#call_restrictions" role="tab" data-toggle="tab">{_ Call restrictions _}</a></li>
    {% wire id="li_call_restrictions"
            type="click"
            action={update target="restrictions_pannel_div" template="_account_restrictions.tpl" account_id=account_id}
            action={remove_class target="li_account_web_access" class="active"}
            action={remove_class target="li_account_sip_access" class="active"}
            action={set_class target="li_call_restrictions" class="active"}
            action={remove_class target="li_calls_allotments" class="active"}
    %}
    <li id="li_calls_allotments"><a href="#calls_allotments" role="tab" data-toggle="tab">{_ Allotments _}</a></li>
    {% wire id="li_calls_allotments"
            type="click"
            action={update target="restrictions_pannel_div" template="_allotments.tpl" account_id=account_id}
            action={remove_class target="li_account_web_access" class="active"}
            action={remove_class target="li_account_sip_access" class="active"}
            action={remove_class target="li_call_restrictions" class="active"}
            action={set_class target="li_calls_allotments" class="active"}
    %}
  </ul>

  <div id="restrictions_pannel_div" class="1tab-content">
      {% include "_add_webaccess_list.tpl" %}
  </div>
</div>
