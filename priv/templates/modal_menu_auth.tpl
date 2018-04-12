<div style="
       {% if m.vars.color2 %}
         background-color: {{ m.vars.color2 }};
         border-color: {{ m.vars.color2 }};
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
        {% if m.vars.page_header %}
          {{ m.vars.page_header }}
        {% else %}
          Cloud PBX Portal
        {% endif %}
      </a>
      <a class="visible-xs navbar-brand" href="/">
        {% if m.vars.page_header_short %}
          {{ m.vars.page_header }}
        {% elseif m.vars.page_header %}
          Cloud PBX Portal
        {% else %}
          Cloud PBX
        {% endif %}
      </a>
    </div>
     <div class="collapse navbar-collapse">
      <ul class="nav navbar-nav navbar-right hidden-xs">
        {% all include "language_choice.tpl" %}
      </ul>
    </div>
  </div>
</div>
