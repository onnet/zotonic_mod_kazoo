<div class="row">
  <br />
  <div class="col-sm-12">
    <div class="row">
        <div class="col-xs-4"><label class="allotment_label">{{ allotment[1] }}</label></div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Amount _}</label></div>
        <div id="allotment_{{ allotment[1] }}_amount" class="col-xs-5">{{ allotment[2][1]["amount"] }}</div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Cycle _}</label></div>
        <div id="allotment_{{ allotment[1] }}_cycle" class="col-xs-5">{{ allotment[2][1]["cycle"] }}</div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Increment _}</label></div>
        <div id="allotment_{{ allotment[1] }}_increment" class="col-xs-5">{{ allotment[2][1]["increment"] }}</div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Minimum _}</label></div>
        <div id="allotment_{{ allotment[1] }}_minimum" class="col-xs-5">{{ allotment[2][1]["minimum"] }}</div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ No consume time _}</label></div>
        <div id="allotment_{{ allotment[1] }}_no_consume_time" class="col-xs-5">{{ allotment[2][1]["no_consume_time"] }}</div>
    </div>
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{_ Group consume _}</label></div>
        <div id="allotment_{{ allotment[1] }}_group_consume" class="col-xs-5">{{ allotment[2][1]["group_consume"] }}</div>
    </div>
  </div>
</div>

