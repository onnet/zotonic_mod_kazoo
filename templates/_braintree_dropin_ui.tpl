
<form id="checkout2" method="post" action="/api/inno/braintree">
  <div id="dropin">
  </div>
  <input type="hidden" name="amount" value="{{ amount }}">
  <input type="submit" value="Pay {{ m.config.mod_kazoo.local_currency_sign.value }}{{ amount }}">
</form>

{% javascript %}
braintree.setup(
  "{{ m.kazoo.bt_client_token }}",
  'dropin', {
    container: 'dropin'
  });
{% endjavascript %}

