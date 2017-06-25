<div class="form-group">
  <label class="form-control-onnet margin-bottom-xs">{_ Audio codecs _}:
    <div class="row">
      <div class="col-sm-2 col-sm-offset-2">
        <label for="PCMA"
               class="checkbox-inline
                      {% if "PCMA"|member:doc["media"][1]["audio"][1]["codecs"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="PCMA"
                 name="codecs"
                 value="PCMA"
                 {% if "PCMA"|member:doc["media"][1]["audio"][1]["codecs"] %}
                   checked
                 {% endif %}>
          {_ PCMA _}
        </label>
      </div>
      <div class="col-sm-2">
        <label for="PCMU"
               class="checkbox-inline
                      {% if "PCMU"|member:doc["media"][1]["audio"][1]["codecs"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="PCMU"
                 name="codecs"
                 value="PCMU"
                 {% if "PCMU"|member:doc["media"][1]["audio"][1]["codecs"] %}
                   checked
                 {% endif %}>
          {_ PCMU _}
      </label>
      </div>
      <div class="col-sm-2">
        <label for="G722"
               class="checkbox-inline
                    {% if "G722"|member:doc["media"][1]["audio"][1]["codecs"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="G722"
                 name="codecs"
                 value="G722"
                 {% if "G722"|member:doc["media"][1]["audio"][1]["codecs"] %}
                   checked
                 {% endif %}>
          {_ G722 _}
        </label>
      </div>
      <div class="col-sm-2">
        <label for="OPUS"
               class="checkbox-inline
                      {% if "OPUS"|member:doc["media"][1]["audio"][1]["codecs"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="OPUS"
                 name="codecs"
                 value="OPUS"
                 {% if "OPUS"|member:doc["media"][1]["audio"][1]["codecs"] %}
                   checked
                 {% endif %}>
          {_ OPUS _}
        </label>
      </div>
    </div>
  </label>
</div>
<div class="form-group">
  <label class="form-control-onnet margin-bottom-xs">{_ Video codecs _}:
    <div class="row">
      <div class="col-sm-2 col-sm-offset-2">
        <label for="VP8"
               class="checkbox-inline
                      {% if "VP8"|member:doc["media"][1]["video"][1]["codecs"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="VP8"
                 name="videocodecs"
                 value="VP8"
                 {% if "VP8"|member:doc["media"][1]["video"][1]["codecs"] %}
                   checked
                 {% endif %}>
          {_ VP8 _}
        </label>
      </div>
      <div class="col-sm-2">
        <label for="H264"
               class="checkbox-inline
                      {% if "H264"|member:doc["media"][1]["video"][1]["codecs"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="H264"
                 name="videocodecs"
                 value="H264"
                 {% if "H264"|member:doc["media"][1]["video"][1]["codecs"] %}
                   checked
                 {% endif %}>
          {_ H264 _}
        </label>
      </div>
      <div class="col-sm-2">
        <label for="H263"
             class="checkbox-inline
                      {% if "H263"|member:doc["media"][1]["video"][1]["codecs"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="H263"
                 name="videocodecs"
                 value="H263"
                 {% if "H263"|member:doc["media"][1]["video"][1]["codecs"] %}
                   checked
                 {% endif %}>
          {_ H263 _}
        </label>
      </div>
      <div class="col-sm-2">
        <label for="H261"
               class="checkbox-inline
                      {% if "H261"|member:doc["media"][1]["video"][1]["codecs"] %}
                        checked
                      {% endif %}"
               style="width: 100%">
          <input type="checkbox"
                 id="H261"
                 name="videocodecs"
                 value="H261"
                 {% if "H261"|member:doc["media"][1]["video"][1]["codecs"] %}
                   checked
                 {% endif %}>
          {_ H261 _}
        </label>
      </div>
    </div>
  </label>
</div>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save codecs _}
      </button>
    </div>
  </div>
</div>
