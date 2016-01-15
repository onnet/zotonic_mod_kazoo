{% wire id="form_purge_voicemails" type="submit" postback="kz_purge_voicemails" delegate="mod_kazoo" %}
<form id="form_purge_voicemails" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Choose VMBox _}
            <select id="vmbox_id" name="vmbox_id" class="form-control margin-bottom-xs" style="text-align:center;">
              {% for vmbox in vmboxes %}
                <option value="{{ vmbox["id"] }}">{{ vmbox["name"] }} ({{ vmbox["mailbox"] }})</option>
              {% endfor %}
            </select>
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ Older than _}
            <select id="days_to" name="days_to" class="form-control margin-bottom-xs" style="text-align:center;">
              <option value="1"> {_ 1 day _}</option>
              <option value="3"> {_ 3 days _}</option>
              <option value="7" selected> {_ 7 days _}</option>
              <option value="15"> {_ 15 days _}</option>
              <option value="0"> {_ Delete all messages _}</option>
            </select>
          </label>
        </div>
      </div>
    </div>
  <div class="form-group">
    <div class="row">
      <div class="col-sm-12">
        <button id="button_add_trunk_save" class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Purge messages _}</button>
      </div>
    </div>
  </div>
</form>
