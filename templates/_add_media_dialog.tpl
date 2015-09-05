{% with m.kazoo[{kz_get_account_prompt prompt_id=prompt_id}] as eprompt %}
{% wire id="form_add_media" type="submit" postback="add_new_media" delegate="mod_kazoo" %}
<form id="form_add_media" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="promptname" name="promptname" placeholder="Enter prompt name here" value="{{ eprompt[1]["name"] }}">
        </div>
        <div class="col-sm-6">
            <input id="promptfile" type="file" name="promptfile" accept="audio/mp3,audio/wav" 
                                   class="form-control margin-bottom-xs" onchange="this.style.width = '100%';">
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Save prompt _}</button>
        </div>
      </div>
    </div>
{% if prompt_id %}
  <input type="hidden" name="existing_description" value="{{ eprompt[1]["description"] }}">
  <input type="hidden" name="prompt_id" value="{{ eprompt[1]["id"] }}">
{% endif %}
</form>
{% endwith %}
