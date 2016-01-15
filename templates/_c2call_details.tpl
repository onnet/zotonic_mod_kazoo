
{_ URL _}:

<pre>
{{ m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] }}
</pre>

{_ Request example _}:

<pre>
curl -v -X POST {{ m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] }} -d '{"data": {"contact": "9169944"}}'
</pre>

{_ Test _}:
<form id="form_kz_c2call" method="post" action="{{ m.kazoo[{kz_c2call_hyperlink c2call_id=c2call_id}] }}">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" class="form-control margin-bottom-xs" id="contact" name="contact" placeholder="{_ Enter number to call here _}">
        </div>
        <div class="col-sm-6">
          <button class="col-xs-12 btn btn-zprimary margin-bottom-xs">{_ Place test call _}</button>
        </div>
      </div>
    </div>
</form>

