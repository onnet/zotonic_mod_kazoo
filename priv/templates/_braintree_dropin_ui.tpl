
<form id="checkout2" method="post" action="/api/inno/braintree">
  <div id="dropin">
  </div>
  <input type="hidden" name="amount" value="{{ amount }}">
  <input type="submit" value="Pay {{ m.session.currency_sign }}{{ amount }}">
</form>

{% javascript %}
braintree.setup(
  "{{ m.kazoo.bt_client_token }}",
  'dropin', {
    container: 'dropin'
  });
{% endjavascript %}

