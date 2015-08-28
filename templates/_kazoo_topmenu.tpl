       <ul class="nav navbar-nav">
         <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">{_ Admin Portal _} <b class="caret"></b></a>
            <ul class="dropdown-menu">
              {% if (m.session.kazoo_superduper_admin or m.session.kazoo_is_reseller) and m.kazoo.is_kazoo_account_admin %}
                <li><a href="/reseller_portal">{_ Reseller Portal _}</a>
              {% endif %}
              {% if m.kazoo.is_kazoo_account_admin %}
                <li><a href="/admin_callflows">{_ Callflow Builder _}</a>
                <li><a href="/admin_settings">{_ Settings _}</a>
                <li><a href="/admin_statistics">{_ Statistics _}</a>
                <li><a href="/admin_feature_codes">{_ Feature Codes _}</a>
              {% endif %}
              <li><a href="/user_portal">{_ User Portal _}</a>
            </ul>
         </li>
       </ul>
         {% if m.session.kazoo_reseller_account_id and (m.session.kazoo_account_id != m.session.kazoo_reseller_account_id) %}
         <ul class="nav navbar-nav navbar-right hidden-xs" style="margin-right: 0;">
           {% wire id="rs_demask" action={postback postback="rs_account_demask" delegate="mod_kazoo"} %}
           <li id="rs_demask">
              <a href="#">{_ Demask _} -- {{ m.kazoo[{kz_account_doc_field field1="name"}] }} -- </a>
           </li>
         </ul>
         {% endif %}

