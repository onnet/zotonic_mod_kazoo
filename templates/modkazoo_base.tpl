<!DOCTYPE html>
<html lang="{{ z_language|default:"en"|escape }}">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="KazooUI Zotonic module">
    <meta name="author" content="kirill.sysoev@gmail.com">
    <link rel="shortcut icon" href="/lib/images/favicon.ico">
    <title>{{ m.config.mod_kazoo.page_header.value }}</title>


    {% lib "js/jquery-2.1.1.min.js" %}
    {% lib "js/jquery-migrate-1.0.0.js" %}
    {% lib "js/jquery-ui.min.js" %}
    {% lib "js/jquery.ui.touch-punch.min.js" %}

    {% lib "bootstrap/css/bootstrap.min.css" %}
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

    {% lib
          "css/project.css"
    %}

    {% all include "_mod_style.tpl" %}
 
    {% lib "js/apps/zotonic-1.0.js" %}
    {% lib "js/apps/z.widgetmanager.js" %}
    {% lib "js/modules/z.adminwidget.js" %}
    {% lib "js/modules/z.notice.js" %}
    {% lib "js/z.dialog.bootstrap3.js" %}
    {% lib "js/modules/ubf.js" %}
    {% lib 
          "js/modules/z.tooltip.js"
          "js/modules/z.feedback.js"
          "js/modules/z.formreplace.js"
          "js/modules/z.datepicker.js"
          "js/modules/z.menuedit.js"
          "js/modules/z.cropcenter.js"
          "js/modules/livevalidation-1.3.js"
          "js/modules/jquery.loadmask.js"
          "js/modules/jquery.timepicker.min.js"
     %}

    {% lib
          "css/datepicker3.css"
          "css/bootstrap-select.min.css"
    %}

    {% lib "css/font-awesome.min.css" %}
    {% lib "css/telicon.css" %}
    {% lib "css/icons.css" %}

    {% lib "css/dataTables.bootstrap.css" %}
    {% lib "js/jquery.dataTables.min.js" %}
    {% lib "js/dataTables.bootstrap.js" %}
    {% lib "js/jquery.dataTables.columnFilter.js" %}
    {% lib "js/jquery.slider.min.js" %}
    {% lib "css/kazoo/jslider.css" %}
    {% lib "css/kazoo/timeofday.css" %}

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/socket.io/0.9.6/socket.io.min.js"></script>
    <script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
  </head>
  <body>
    {% include "topmenu.tpl" %}

    {% block main %}{% endblock %}

    {% include "footer.tpl" %}

    {% script %}
  </body>
</html>
