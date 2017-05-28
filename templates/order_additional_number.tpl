{% extends "onnet_widget_dashboard.tpl" %}

{% block widget_headline %}
  <select id="country_select"
          name="country"
          class="btn-xs btn-onnet"
          style="max-width:140px; height:20px; text-align:center;">
    {% with m.kazoo.numbers_countries_list as options %}
      {% for option in options %}
        <option value="{{ option }}">{{ option }}</option>
      {% endfor %}
    {% endwith %}
  </select>
  {{ headline }}
  <span class="pull-right pl-15">
    <i id="close_number_search" class="fa fa-times pointer"></i>
  </span>
  {% button id="buy_selected_numbers_button"
            class="btn btn-xs btn-onnet pull-right"
            style="display: none;"
            text=_"buy selected"
            tabindex=3
            action={submit target="numbers_to_purchase_array_form"}
  %}
  <button id="number_search_button"
          class="btn btn-xs btn-onnet pull-right"
          tabindex=2>
    {_ search _}
  </button>
  {% wire id="number_search_button"
          action={hide target="buy_selected_numbers_button"}
          action={growl text=_"Please wait while we looking up for numbers for you..."}
          action={update target="numbers_to_choose" template="_just_spinner.tpl"}
          action={postback postback="new_numbers_lookup"
                           delegate="mod_kazoo"
                           qarg="areacode"
                           qarg="country_select"
                 }
  %}
  {% wire id="close_number_search"
          action={disable target="choose_number"}
          action={enable target="orderbtn"}
          action={disable target="cancelorderbtn"}
          action={update target="additional-number-order-form"
                         template="order_additional_number.tpl"
                         headline=_"Search by City or Area Code: "
                         idname="choose_number" class="disabled"}
  %}
  <input id="areacode"
         onkeydown="if (event.keyCode == 13) {z_event('areacode'); return false;}"
         class="input-card-field"
         type="text"
         name="areacode"
         maxlength="5"
         size="4" placeholder=""
         tabindex=1>
  {% wire name="areacode"
          type="submit"
          action={hide target="buy_selected_numbers_button"}
          action={growl text=_"Please wait while we looking up for numbers for you..."}
          action={update target="numbers_to_choose" template="_just_spinner.tpl"}
          action={postback postback="new_numbers_lookup"
                           delegate="mod_kazoo"
                           qarg="areacode"
                           qarg="country_select"
                 }
  %}
{% endblock %}

{% block widget_content %}
<span id="numbers_to_choose">
</span>
{% endblock %}
