{% wire id="form_cf_edit_name" type="submit" postback="cf_edit_name" delegate="mod_kazoo" %}
<form id="form_cf_edit_name" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" name="callflow_name" class="form-control margin-bottom-xs" placeholder="Callflow Name" value="{{ m.session.current_callflow[1]["name"] }}">
        </div>
        <div id="number_input_div"class="col-sm-6">
        <label>
          <span rel="popover" data-content="By checking this box, this endpoint will not be added automatically to the contact list of the devices of this platform">
            <input type="checkbox" name="callflow_exclude" {% if m.session.current_callflow[1]["contact_list"][1]["exclude"] %}checked{% endif %}>
            <span>
              Hide from Contact List
            </span>
          </span>
        </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
        Giving a name to a callflow isn't mandatory. Leave the field blank and the callflow will be displayed in the left listing as the list of numbers used in this callflow.
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">Save</button>
        </div>
      </div>
    </div>
</form>

