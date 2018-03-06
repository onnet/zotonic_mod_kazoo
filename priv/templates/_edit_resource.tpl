{% with m.kazoo[{kz_resource_info resource_id=resource_id}][1] as resource %}
{% wire id="resource-form" type="submit" postback="resource_form" delegate="mod_kazoo" %}
<form id="resource-form"  method="post" action="postback">
<div min-height="50%">
<ul class="nav nav-tabs nav-justified" role="tablist">
  <li class="active">
    <a href="#resources_basic" role="tab" data-toggle="tab">{_ Basic _}</a>
  </li>
  <li>
    <a href="#resources_options" role="tab" data-toggle="tab">{_ Options _}</a>
  </li>
</ul>

<div class="tab-content">
  <!-- Basic -->
  <div class="active tab-pane fade in" id="resources_basic">
    {% include "_resource_basic.tpl" %}
  </div>
  <!-- Options -->
  <div class="tab-pane fade" id="resources_options">
    {% include "_resource_options.tpl" %}
  </div>
</div>
</div>
  <input type="hidden" name="resource_id" value="{{ resource_id }}">
</form>
<div class="form-group">
  <div class="row">
    <div class="col-sm-12">
      <button id="button_edit_resources"
              class="col-xs-12 btn btn-zprimary margin-bottom-xs">
        {_ Save _}
      </button>
    </div>
  </div>
</div>
{# print resource #}
{% wire id="button_edit_resources" action={submit target="resource-form"} %}
{% endwith %}

