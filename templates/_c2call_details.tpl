
{_ Click-to-Call link _}:

{% print m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] %}

{_ Click-to-Call test _}:
<form id="form_kz_c2call" method="post" action="{{ m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] }}">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="contact" name="contact" placeholder="{_ Enter number to call here _}">
        </div>
        <div class="col-sm-6">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Test Click_to_Call _}</button>
        </div>
      </div>
    </div>
</form>

