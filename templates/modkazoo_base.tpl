<!DOCTYPE html>
<html lang="{{ z_language|default:"en"|escape }}">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/lib/images/favicon.ico">
    <meta name="keywords" content="virtual pbx, open source telephony, hosted pbx, Kazoo, hosted telephony, virtual pbx service, 
                                   hosted pbx services, hosted pbx service, virtual pbx services, virtual hosted pbx, telephony platform, 
                                   virtual pbx open source, cloud telephony, open source virtual pbx, cloud based telephony, telephony cloud, 
                                   cloud pbx hosting, kazoo voip, free cloud telephony, kazoo freeswitch, kazoo hosting, Kazoo 3rd party support, 
                                   Kazoo cloud-platform, Kazoo help, Kazoo support, install Kazoo, setup Kazoo, kazoo python" />
    <title>OnNet Innovations</title>

<!--    <script src="//code.jquery.com/jquery-2.1.1.min.js"></script> -->
    {% lib "js/jquery-2.1.1.min.js" %}
<!--    <script src="//code.jquery.com/jquery-migrate-1.0.0.js"></script> -->
    {% lib "js/jquery-migrate-1.0.0.js" %}
<!--    <script src="//code.jquery.com/ui/1.11.0/jquery-ui.min.js"></script> -->
    {% lib "js/jquery-ui.min.js" %}
<!--    <script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script> -->
    {% lib "js/jquery.ui.touch-punch.min.js" %}

    <!-- Bootstrap -->

    <!-- <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"> -->
    <!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script> -->

    {% lib "css/bootstrap.min.css" %}
    {% lib "js/bootstrap.min.js" %}
    
    {% block font %}
        <link href='//fonts.googleapis.com/css?family=Special+Elite:100,300,400' rel='stylesheet' type='text/css'>
    {% endblock %}

    {% lib
          "css/z.modal.css"
    %}
    {% lib
          "css/z.growl.css"
          "css/jquery.loadmask.css"
          "css/animate.css"
          "css/elements.css"
          "css/custom.css"
          "css/onnet.css"
    %}
 
    {% with ["/lib/images/ldn_docklands.jpg"]|random as bgr_image %}
    <style type="text/css">
        #wrap,
        #hp-slider {
            height: 480px;
            background: url({{ bgr_image }}) no-repeat center center; 
            background-size: cover;
            filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='{{ bgr_image }}', sizingMethod='scale');
            -ms-filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='{{ bgr_image }}', sizingMethod='scale')";
            border-bottom: 1px solid #eee;
            color: #fff;
        }
    </style>
    {% endwith %} 

    {% lib "js/apps/zotonic-1.0.js" %}
    {% lib "js/apps/z.widgetmanager.js" %}
    {% lib "js/modules/z.notice.js" %}
    {% lib "js/z.dialog.bootstrap3.js" %}
    {# lib
          "js/modules/jquery.loadmask.js"
          "js/modules/livevalidation-1.3.js"
     #}
    {% lib "js/modules/ubf.js" %}
    {% lib "js/modules/z.notice.js" %}
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

    {% lib "css/datepicker3.css" %}
    {% lib "js/bootstrap-datepicker.js" %}
    {% lib "js/locales/bootstrap-datepicker.ru.js" %}


    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet"> 
    {% lib "css/font-awesome.min.css" %}
    {% lib "css/telicon.css" %}
    {% lib "css/icons.css" %}

    <!-- <link href="//cdn.datatables.net/plug-ins/be7019ee387/integration/bootstrap/3/dataTables.bootstrap.css" rel="stylesheet"> -->
    {% lib "css/dataTables.bootstrap.css" %}
    <!-- <script src="//cdn.datatables.net/1.10.1/js/jquery.dataTables.min.js"></script> -->
    {% lib "js/jquery.dataTables.min.js" %}
    <!-- <script src="//cdn.datatables.net/plug-ins/be7019ee387/integration/bootstrap/3/dataTables.bootstrap.js"></script> -->
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
  </head>
  <body>
    {% include "topmenu.tpl" %}

    {% block main %}{% endblock %}

    {% include "footer.tpl" %}
    {% include "legal.tpl" %}
    {% include "footer_js.tpl" %}
    {% include "google_anatytics.tpl" %}
    {% include "yandex_metrika.tpl" %}
    {% include "rambler_counter.tpl" %}

    {% script %}
  </body>
</html>
