<div class="form-group">
  <label class="form-control-onnet margin-bottom-xs">{_ Audio codecs _}:
    <div class="row">
      <div class="col-sm-2 col-sm-offset-2">
        <label for="PCMA"
               class="checkbox-inline
                      {% if "PCMA"|member:codecs %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="PCMA"
                 name="codecs"
                 value="PCMA"
                 {% if "PCMA"|member:codecs %}
                   checked
                 {% endif %}>
          {_ PCMA _}
        </label>
      </div>
      <div class="col-sm-2">
        <label for="PCMU"
               class="checkbox-inline
                      {% if "PCMU"|member:codecs %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="PCMU"
                 name="codecs"
                 value="PCMU"
                 {% if "PCMU"|member:codecs %}
                   checked
                 {% endif %}>
          {_ PCMU _}
      </label>
      </div>
      <div class="col-sm-2">
        <label for="G722"
               class="checkbox-inline
                    {% if "G722"|member:codecs %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="G722"
                 name="codecs"
                 value="G722"
                 {% if "G722"|member:codecs %}
                   checked
                 {% endif %}>
          {_ G722 _}
        </label>
      </div>
      <div class="col-sm-2">
        <label for="OPUS"
               class="checkbox-inline
                      {% if "OPUS"|member:codecs %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="OPUS"
                 name="codecs"
                 value="OPUS"
                 {% if "OPUS"|member:codecs %}
                   checked
                 {% endif %}>
          {_ OPUS _}
        </label>
      </div>
    </div>
  </label>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-6">
      <button class="col-xs-12 btn btn-zalarm margin-bottom-xs">
        {_ Save codecs _}
      </button>
    </div>
    {% wire id="button_cancel_numbers_list" action={dialog_close} %}
    <div class="col-sm-6">
      <button id="button_cancel_numbers_list"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Close _}
      </button>
    </div>
  </div>
</div>
