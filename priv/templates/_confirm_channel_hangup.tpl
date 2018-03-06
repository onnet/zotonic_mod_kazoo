    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zalarm margin-bottom-xs" text=_"Hang Up" action={postback postback={channel_hangup channel_id=channel_id} delegate="mod_kazoo"} %}
        </div>
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
        </div>
      </div>
    </div>
