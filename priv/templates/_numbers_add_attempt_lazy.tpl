<span id="{{ #ilazy_num_add }}"  class="text-center">
    {% ilazy class="fa fa-spinner fa-spin fa-3x"
       action={replace target=#ilazy_num_add
                       template="_numbers_add_attempt.tpl"
                       numbers_to_purchase=numbers_to_purchase
                       basket=basket
              }
    %}
</span>
