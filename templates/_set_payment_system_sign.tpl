               {% if card_type=="Visa" %}
                   <img src="/lib/paysysimg/Visa.png" height="18px" title="Visa" alt="Visa">
               {% elseif card_type=="MasterCard" %}
                   <img src="/lib/paysysimg/Mastercard.png" height="18px" title="Mastercard" alt="Mastercard">
               {% elseif card_type=="American Express" %}
                   <img src="/lib/paysysimg/American-Express.png" height="18px" title="American Express" alt="American Express">
               {% elseif card_type=="Discover" %}
                   <img src="/lib/paysysimg/Discover.png" height="18px" title="Discover" alt="Discover">
               {% elseif card_type=="JCB" %}
                   <img src="/lib/paysysimg/JCB.png" height="18px" title="JCB" alt="JCB">
               {% elseif card_type=="Maestro" %}
                   <img src="/lib/paysysimg/Maestro.png" height="18px" title="JCB" alt="JCB">
               {% else %}
                   {{ card_type }}
               {% endif %}

