<!DOCTYPE html>
<html lang="{{ z_language|default:"en"|escape }}">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="KazooUI Zotonic module">
    <meta name="author" content="kirill.sysoev@gmail.com">
    <link rel="shortcut icon" href="/lib/images/favicon.ico">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>{{ m.vars.page_header }}</title>

    <!-- Material Design fonts -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:300,400,500,700" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Material Design -->
 <!--   <link href="//cdn.rawgit.com/FezVrasta/bootstrap-material-design/gh-pages-v3/dist/css/bootstrap-material-design.css" rel="stylesheet"> -->
 <!--   <link href="//cdn.rawgit.com/FezVrasta/bootstrap-material-design/gh-pages-v3/dist/css/ripples.min.css" rel="stylesheet"> -->

 <!--   <link href="//fezvrasta.github.io/snackbarjs/dist/snackbar.min.css" rel="stylesheet"> -->

    {% lib "js/jquery-2.1.1.min.js" %}
    {% lib "js/jquery-migrate-1.0.0.js" %}
    {% lib "js/jquery-ui.min.js" %}
    {% lib "js/jquery.ui.touch-punch.min.js" %}

    {% lib "bootstrap/js/bootstrap.min.js" %}
    {% lib "js/bootstrap-select.min.js" %}

    {% lib
          "js/bootstrap-datepicker.js"
          "js/locales/bootstrap-datepicker.ru.js"
    %}
    
    {% lib
          "css/z.modal.css"
          "css/z.growl.css"
          "css/jquery.loadmask.css"
    %}

    {% all include "_mod_style.tpl" %}
 
    {% lib "js/modules/ubf.js" %}
    {% lib "js/apps/zotonic-1.0.js" %}
    {% lib "js/apps/z.widgetmanager.js" %}
    {# lib "js/modules/z.adminwidget.js" #}
    {% lib "js/modules/z.notice.js" %}
    {% lib "js/z.dialog.bootstrap3.js" %}
    {% lib "js/qlobber.js" %}
    {% lib "js/pubzub.js" %}
    {% lib "js/modules/z.live.js" %}

    {% lib 
          "js/modules/z.tooltip.js"
          "js/modules/z.feedback.js"
          "js/modules/z.formreplace.js"
          "js/modules/z.datepicker.js"
          "js/modules/z.menuedit.js"
          "js/modules/livevalidation-1.3.js"
          "js/modules/jquery.loadmask.js"
          "js/modules/jquery.timepicker.min.js"
     %}

    {# lib
          "js/modules/z.cropcenter.js"
    #}

    {% lib
          "css/datepicker3.css"
          "css/bootstrap-select.min.css"
    %}

    {# lib "css/font-awesome.min.css" #}
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"
          rel="stylesheet"
          integrity="sha384-T8Gy5hrqNKT+hzMclPo118YTQO6cYprQmhrYwIiQ/3axmI1hQomh7Ud2hPOy8SP1"
          crossorigin="anonymous">
    {% lib "css/telicon.css" %}
    {% lib "css/icons-2600hz.css" %}

    {% lib "css/dataTables.bootstrap.css" %}
    {% lib "js/jquery.dataTables.min.js" %}
    {% lib "js/dataTables.bootstrap.js" %}
    {% lib "js/jquery.dataTables.columnFilter.js" %}
    {% lib "js/jquery.slider.min.js" %}
    {% lib "js/jsoneditor.min.js" %}
    {% lib "css/kazoo/jslider.css" %}
    {% lib "css/kazoo/timeofday.css" %}

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <!--  <script src="//cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.6/socket.io.min.js"></script> -->
  </head>
  <body>

{% if m.kazoo.is_auth or m.session.lb_user_id %}
  <div class="wrapper">
    <div class="container" style="width: 95%">
      <div id="page_title_row" class="row">
        <div class="col-md-12" style="padding-left: 0px; padding-right: 0px;">
          {% block header_title %}{% endblock %}
        </div>
      </div>
      <div class="row">
        <div class="col-md-12" style="padding-left: 0px; padding-right: 0px;">
          {% block service_description %}{% endblock %}
        </div>
      </div>
    </div>
  </div>
  {% wire action={connect signal={emit_growl_signal signal_filter=m.kazoo.signal_filter}
                          action={update template="_z_growl_add.tpl"}
                 }
  %}
  {% wire action={connect signal={page_mask_signal signal_filter=m.kazoo.signal_filter}
                          action={update template="_z_add_page_mask.tpl"}
                 }
  %}
{% else %}
  {% javascript %}
    z_notify("no_auth");
  {% endjavascript %}
  {% wire action={redirect location="/"} %}
{% endif %}


    {% script %}
  </body>
</html>
