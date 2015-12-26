    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <select id="device_select" name="id" class="form-control margin-bottom-xs" style="text-align:center;">
          {% for device in m.kazoo.kz_list_user_devices %}
              <option value="{{ device["id"] }}">{{ device["name"]|escape }}</option>
          {% endfor %}
          </select>
        </div>
        <div class="col-sm-6">
          <select id="mode_select" name="mode" class="form-control margin-bottom-xs" style="text-align:center;">
              <option value="listen" selected>{_ Listen _}</option>
              <option value="whisper">{_ Whisper _}</option>
              <option value="full">{_ Full _}</option>
          </select>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Connect" action={postback postback={channel_eavesdrop channel_id=channel_id}
                                                                                                       qarg="device_select"
                                                                                                       qarg="mode_select"
                                                                                                       delegate="mod_kazoo"
                                                                                             }
          %}
        </div>
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
        </div>
      </div>
    </div>
