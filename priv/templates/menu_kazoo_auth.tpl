<div style="
       {% if m.config.mod_kazoo.color2.value %}
         background-color: {{ m.config.mod_kazoo.color2.value }};
         border-color: {{ m.config.mod_kazoo.color2.value }};
       {% else %}
         background-color: #303039;
       {% endif %}"
     class="navbar navbar-inverse navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="hidden-xs navbar-brand" href="/">
        {% if m.config.mod_kazoo.page_header.value %}
          {{ m.config.mod_kazoo.page_header.value }}
        {% else %}
          Cloud PBX Portal
        {% endif %}
      </a>
      <a class="visible-xs navbar-brand" href="/">
        {% if m.config.mod_kazoo.page_header_short.value %}
          {{ m.config.mod_kazoo.page_header.value }}
        {% elseif m.config.mod_kazoo.page_header.value %}
          Cloud PBX Portal
        {% else %}
          Cloud PBX
        {% endif %}
      </a>
    </div>
     <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav">
        <li class="divider visible-xs"></li>
        <li><a id="xs_sign_out" class="visible-xs" href="#">{_ Sign out _}</a></li>
        {% wire id="xs_sign_out" postback="signout" delegate="mod_kazoo" %}
      </ul>
      <ul class="nav navbar-nav navbar-right hidden-xs">
        <li id="sign_out">
          <a class="visible-lg visible-md" href="#">{_ Sign out _}</a>
          <a class="visible-sm" href="#"><i class="fa fa-power-off fa-lg"></i></a>
        </li>
        {% wire id="sign_out" postback="signout" delegate="mod_kazoo" %}
        {% all include "language_choice.tpl" %}
      </ul>
      {% with m.notifier.first.billing_topmenu_element as billing_topmenu %}
        {% if billing_topmenu %}
          {% include billing_topmenu %}
        {% endif %}
      {% endwith %}
      {% for topmenu_item in m.notifier.map.topmenu_element %}
        {% if topmenu_item %}
          {% include topmenu_item %}
        {% endif %}
      {% endfor %}
    </div>
  </div>
</div>
