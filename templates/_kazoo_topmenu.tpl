         <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">{_ Admin Portal _} <b class="caret"></b></a>
            <ul class="dropdown-menu">
              {% if (m.session.kazoo_superduper_admin or m.session.kazoo_is_reseller) and m.kazoo.is_kazoo_account_admin %}
                <li><a href="/reseller_portal">{_ Reseller Portal _}</a>
              {% else %}
                <li><a href="/user_portal">{_ User Portal _}</a>
                {% if m.kazoo.is_kazoo_account_admin %}
                  <li><a href="/admin_callflows">{_ Callflow Builder _}</a>
                  <li><a href="/admin_settings">{_ Settings _}</a>
                  <li><a href="/admin_statistics">{_ Statistics _}</a>
                  <li><a href="/admin_feature_codes">{_ Feature Codes _}</a>
                {% endif %}
              {% endif %}
            </ul>
         </li>
