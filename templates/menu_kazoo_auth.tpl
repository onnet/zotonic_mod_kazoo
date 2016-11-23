    <div style="background-color: #303039;" class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="hidden-xs navbar-brand" href="/">Cloud PBX Portal</a>
          <a class="visible-xs navbar-brand" href="/">Cloud PBX</a>
        </div>

        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
             {% if m.session.lb_user_id and m.kazoo.is_kazoo_account_admin %}
               {% include "_lb_topmenu.tpl" %}
             {% endif %}
           <li class="divider visible-xs"></li>
           <li><a id="xs_sign_out" class="visible-xs" href="#">{_ Sign out _}</a></li>
           {% wire id="xs_sign_out" postback={signout} delegate="mod_kazoo" %}
          </ul>

          <ul class="nav navbar-nav navbar-right hidden-xs">
           <li id="sign_out">
             <a class="visible-lg visible-md" href="#">{_ Sign out _}</a>
             <a class="visible-sm" href="#"><i class="fa fa-power-off fa-lg"></i></a>
           </li>
           {% wire id="sign_out" postback={signout} delegate="mod_kazoo" %}
           {% all include "language_choice.tpl" %}
          </ul>

          {% for topmenu_item in m.notifier.map.topmenu_element %}
            {% if topmenu_item %}
              {% include topmenu_item %}
            {% endif %}
          {% endfor %}
        </div>


      </div>
    </div>
