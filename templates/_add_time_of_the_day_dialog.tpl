{% with m.kazoo[{kz_get_temporal_rule rule_id=rule_id}] as rule %}
{% wire id="time-of-the-day-form" type="submit" postback="cf_time_of_the_day" delegate="mod_kazoo" %}
<form id="time-of-the-day-form"  method="post" action="postback">
  <div class="pill-content">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input id="name"
                 name="name"
                 type="text"
                 class="form-control margin-bottom-xs"
                 placeholder="{_ Enter rule name here _}"
                 value="{{ rule[1]["name"] }}">
        </div>
        <div class="col-sm-6">
          <select name="enabled" id="enabled" class="form-control margin-bottom-xs">
            <option value="" {% if rule[1]["enabled"] == undefined %}selected{% endif %}>{_ Based on time _}</option>
            <option value="true" {% if rule[1]["enabled"] == "true" %}selected{% endif %}>{_ Forced On _}</option>
            <option value="false" {% if rule[1]["enabled"] == "false" %}selected{% endif %}>{_ Forced Off _}</option>
          </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          {% wire id="cycle" type="change" action={ update target="cycle_types" template="_add_time_of_the_day_dialog_cycles.tpl" } %}
          <select name="cycle" id="cycle" class="form-control margin-bottom-xs">
            <option id="weekly" value="weekly" {% if rule[1]["cycle"] == "weekly" or not rule[1]["cycle"] %}selected{% endif %}>{_ Weekly _}</option>
            <option id="monthly" value="monthly" {% if rule[1]["cycle"] == "monthly" %}selected{% endif %}>{_ Monthly _}</option>
            <option id="yearly" value="yearly" {% if rule[1]["cycle"] == "yearly" %}selected{% endif %}>{_ Yearly _}</option>
          </select>
        </div>
        <div class="col-sm-6">
         <div class="date" id="startDay" data-date="{{ now|sub_day|date: 'd/m/Y' }}" data-date-format="dd/mm/yyyy"
              data-date-autoclose="true" data-date-language={{ z_language }} data-date-start-date="-6m"
              data-date-end-date="+6m">
                  <input id="startDayInput" type="text"
                         class="form-control margin-bottom-xs"
                         name="start_date"
                         style="background-color: white;"
                         value="{% if rule[1]["start_date"] %}
                                  {{ rule[1]["start_date"]|gregsec_to_date|date:"d/m/Y":m.kazoo.get_user_timezone }}
                                {% else %}
                                  {{ now|sub_day|date:"d/m/Y":m.kazoo.get_user_timezone }}
                                {% endif %}"
                         readonly/>
                  <span class="add-on hidden" style="padding-left: 1em;"><i class="fa fa-calendar"></i></span>
         </div>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div id="cycle_types" class="row">
        {% include "_add_time_of_the_day_dialog_cycles.tpl" %}
      </div>
    </div>
    <div class="form-group" style="padding: 1em 2em 3em 2em;">
      <div class="row">
        <div class="col-sm-12">
          <div class="input time_wrapper">
            <input id="time"
                   name="time"
                   type="slider"
                   style="display: none;"
                   value="{% if rule[1]["time_window_start"] %}
                            {{ rule[1]["time_window_start"] }};{{ rule[1]["time_window_stop"]  }}
                          {% else %}32400;61200{% endif %}">
          </div>
        </div>
      </div>
    </div>
  </div>
  {% if rule[1]["id"] %}
    <input type="hidden" name="id" value="{{ rule[1]["id"] }}">
  {% endif %}
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_cf_time_of_the_day" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save _}</button>
    </div>
  </div>
</div>
{% wire id="button_cf_time_of_the_day" action={submit target="time-of-the-day-form"} %}
{% endwith %}
{% javascript %}
$("#time").slider({
    from: 0,
    to: 86400,
    step: 900,
    dimension: "",
    scale: ["12:00am", "1:00am", "2:00am", "3:00am", "4:00am", "5:00am", "6:00am", "7:00am", "8:00am", "9:00am", "10:00am", "11:00am",
            "12:00pm", "1:00pm", "2:00pm", "3:00pm", "4:00pm", "5:00pm", "6:00pm", "7:00pm", "8:00pm", "9:00pm", "10:00pm", "11:00pm", "12:00am"],
    limits: !1,
    calculate: function(e) {
        var t = Math.floor(e / 3600),
            n = (e - t * 3600) / 60,
            r = t < 12 ? "am" : "pm";
        return t %= 12, t == 0 && (t = 12), t + ":" + (n ? n : "0" + n) + r
    },
    onstatechange: function() {}
});
{% endjavascript %}
{% javascript %}
$('#startDay').datepicker();
{% endjavascript %}
