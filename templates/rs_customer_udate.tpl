{% wire id="form_rs_send_message" type="submit" postback="rs_send_message" delegate="mod_kazoo" %}
<form id="form_rs_send_message" method="post" action="postback">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ From (email address): _}
            <input type="text" class="form-control margin-bottom-xs" id="from" name="from" placeholder="{_ Enter sender's email adress here _}" value="{{ m.config.mod_kazoo.sales_email.value }}">
          </label>
        </div>
        <div class="col-sm-6">
          <label class="form-control-onnet margin-bottom-xs">{_ To _}:
            <select id="#to_user_selector" name="selected_user" class="col-xs-12 form-control margin-bottom-xs" title="{_ Recipient _}">
              <option value="all_users">{_ All users _}</option>
              {% for option in m.kazoo[{kz_list_account_users account_id=account_id}] %}
                  <option value="{{ option["id"] }}">{{ option["username"] }}</option>
              {% endfor %}
            </select>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <label class="form-control-onnet margin-bottom-xs">{_ Subject: _}
            <input type="text" class="form-control margin-bottom-xs" id="subject" name="subject" placeholder="{_ Enter message subject here _}"
                                                                                  value="{{ m.kazoo.rs_customer_update_subject }}">
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <label class="form-control-onnet margin-bottom-xs">{_ HTML body: _}
          <script>
              tinyMCE.remove('#html_body');
              tinymce.init({ selector:'#html_body',
                             theme: 'modern',
                             plugins: [
                               'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                               'searchreplace wordcount visualblocks visualchars code fullscreen',
                               'insertdatetime media nonbreaking save table contextmenu directionality',
                               'emoticons template paste textcolor colorpicker textpattern imagetools'
                             ],
                             toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | code',
                             toolbar2: 'print preview media | forecolor backcolor emoticons',
                             image_advtab: true,
                          });
          </script>
          <textarea id="html_body" name="html_body" style="height: 300px; width: 100%">{{ m.kazoo.rs_customer_update_html }}</textarea>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-12">
          <label class="form-control-onnet margin-bottom-xs">{_ Text body: _}
            <textarea name="text_body" style="height: 300px; width: 100%">{{ m.kazoo.rs_customer_update_text }}</textarea>
          </label>
        </div>
      </div>
    </div>
    <div class="form-group">
      <div class="row">
        <div class="col-sm-6">
          <button id="button_edit_html" class="col-xs-12 btn btn-zalarm margin-bottom-xs" type="submit">{_ Send message _}</button>
        </div>
        <div class="col-sm-6">
          {% button class="col-xs-12 btn btn-zprimary margin-bottom-xs" text=_"Cancel" action={dialog_close} %}
        </div>
      </div>
    </div>
    <input type="hidden" name="account_id" value="{{ account_id }}">
</form>
