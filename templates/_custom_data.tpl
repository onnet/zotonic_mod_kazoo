    <div id="div_{{ #cus }}" class="form-group">
      <div class="row">
        <div class="col-sm-4">
          <label class="form-control-onnet margin-bottom-xs">{_ Key _}
            <input type="text" class="form-control margin-bottom-xs" name="custom_key_{{ #cus }}" placeholder="{_ Enter webhook key name here _}" value="{{ custom_pair[1] }}">
          </label>
        </div>
        <div class="col-sm-7">
          <label class="form-control-onnet margin-bottom-xs">{_ Value _}
            <input type="text" class="form-control margin-bottom-xs" name="{{ #cus }}" placeholder="{_ Enter webhook key value here _}" value="{{ custom_pair[2] }}">
          </label>
        </div>
        <div class="col-sm-1">
            {% wire id="delete_"++#cus action={remove target="div_"++#cus} %}
            <i id="delete_{{ #cus }}" class="fa fa-trash-o pointer" style="padding-top: 2em;" title="Delete"></i>
        </div>
      </div>
    </div>

