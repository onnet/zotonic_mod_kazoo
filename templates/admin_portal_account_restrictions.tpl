<div class="row">
    <br />
    <div class="col-sm-10">
    {% for classifier in m.kazoo.kz_list_classifiers[1] %}
    <div class="row">
        <div class="col-xs-5"><label class="edit_user_label">{{ classifier[1] }}</label></div>
        <div id="call_restriction{{ classifier[1] }}action" class="col-xs-5">
            {% include "_show_field_select.tpl" type="account" doc_id="_no_need_" field_name=["call_restriction",classifier[1],"action"] options=["inherit","deny"] account_id=account_id %}
        </div>
    </div>
    {% endfor %}
    <br />
    </div>
</div>
