<div min-height="50%">
  <ul class="nav nav-tabs nav-justified" role="tablist">
    <li id="li_account_web_access" class="active"><a href="#account_web_access" role="tab" data-toggle="tab">{_ Web access _}</a></li>
    {% wire id="li_account_web_access"
            type="click"
            action={update target="pannel_div" template="_add_webaccess_list.tpl"}
            action={toggle_class target="li_account_web_access" class="active"}
            action={toggle_class target="li_account_sip_access" class="active"}
    %}
    <li id="li_account_sip_access"><a href="#account_sip_access" role="tab" data-toggle="tab">{_ SIP access _}</a></li>
    {% wire id="li_account_sip_access"
            type="click"
            action={update target="pannel_div" template="_add_account_sipaccess_list.tpl"}
            action={toggle_class target="li_account_web_access" class="active"}
            action={toggle_class target="li_account_sip_access" class="active"}
    %}
  </ul>

  <div id="pannel_div" class="1tab-content">
      {% include "_add_webaccess_list.tpl" %}
  </div>
</div>
