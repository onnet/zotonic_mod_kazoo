{% wire id="capture_type"
        type="change"
        action={update target="metaflows_capture_input_span"
                       template="_metaflows_capture_input.tpl"
               }
        action={update target="metaflows_select_module_span"
                       template="_metaflows_select_module.tpl"
               }
%}
<select id="capture_type"
        name="capture_type"
        class="form-control margin-bottom-xs"
        style="text-align:center;">
    <option value="">-- {_ Chose type _} --</option>
    <option value="numbers">{_ Number _}</option>
    <option value="patterns">{_ Pattern _}</option>
</select>
