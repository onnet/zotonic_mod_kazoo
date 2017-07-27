{% with m.kazoo[{kz_get_account_queue queue_id=queue_id}] as equeue %}
  {% wire id="form_add_media" type="submit" postback="add_new_media" delegate="mod_kazoo" %}
  <form id="form_add_media" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text"
                 class="form-control margin-bottom-xs"
                 id="queuename"
                 name="queuename"
                 placeholder="Enter queue name here"
                 value="{{ equeue[1]["name"] }}">
        </div>
        <div class="col-sm-6">
            <input id="queuefile"
                   type="file"
                   name="queuefile"
                   accept="audio/mp3,audio/wav" 
                   class="form-control margin-bottom-xs"
                   onchange="this.style.width = '100%';">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save queue _}</button>
        </div>
      </div>
    </div>
    {% if queue_id %}
      <input type="hidden" name="existing_description" value="{{ equeue[1]["description"] }}">
      <input type="hidden" name="queue_id" value="{{ equeue[1]["id"] }}">
    {% endif %}
  </form>
{% endwith %}
