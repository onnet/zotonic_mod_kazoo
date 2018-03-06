<div class="form-group">
  <div class="row">
    <div class="col-sm-10 col-sm-offset-2">
      {% with m.kazoo[{allotments account_id=account_id}][1],m.kazoo.kz_list_classifiers as allotments,classifiers %}
        {% for allotment in allotments %}
          {% include "_allotment_element.tpl" allotment=allotment %}
        {% endfor %}
        <br />
        <div class="form-group">
          <div class="row">
            <div class="col-sm-9">
              <div class="input-group">
                <select id="new_allotment_element_name" name="new_allotment_element_name" class="form-control">
                  {% for traffic_type in classifiers[1] %}
                    {% if not (allotments["outbound_"++traffic_type[1]] or traffic_type[1] == "emergency") %}
                      <option value="outbound_{{ traffic_type[1] }}">outbound_{{ traffic_type[1] }}</option>
                    {% endif %}
                  {% endfor %}
                  {% for traffic_type in classifiers[1] %}
                    {% if not (allotments["inbound_"++traffic_type[1]] or traffic_type[1] == "emergency") %}
                      <option value="inbound_{{ traffic_type[1] }}">inbound_{{ traffic_type[1] }}</option>
                    {% endif %}
                  {% endfor %}
                </select>
                {% wire id="add_allotment_element"
                        type="click"
                        action={postback postback={add_allotment_element account_id=account_id}
                                         delegate="mod_kazoo"
                                         qarg="new_allotment_element_name"
                        }
                %}
                <span id="add_allotment_element" class="input-group-addon bradius-0 pointer">{_ Add entry _}</span>
              </div>
            </div>
          </div>
        </div>
      {% endwith %}
    </div>
  </div>
</div>
