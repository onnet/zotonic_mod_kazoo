<div class="row">
    <br />
    <div class="col-sm-10">
    {% for classifier in m.inno.kz_list_classifiers[1] %}
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{{ classifier[1] }}</label></div>
        <div id="call_restriction{{ classifier[1] }}action" class="col-xs-5">
            {% include "_show_field_select.tpl" type="user" doc_id=user_id field_name=["call_restriction",classifier[1],"action"] options=["inherit","deny"] %}
        </div>
    </div>
    {% endfor %}
    <br />
    </div>
</div>
