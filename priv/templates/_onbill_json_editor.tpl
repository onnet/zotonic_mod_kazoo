{% javascript %} 
   JSONEditor.defaults.theme = 'bootstrap3';
   JSONEditor.defaults.iconlib = 'fontawesome4';
   var starting_value = {{ json_string }};
   // Initialize the editor
   var editor = new JSONEditor(document.getElementById('json_field_{{ doc_id }}'),{
    schema: {
     //   format: "grid",
        type: "object"
    },
     // Seed the form with a starting value
     startval: starting_value
   });
   
   // Hook up the Restore to Default button
   document.getElementById('restore_json_{{ doc_id }}').addEventListener('click',function() {
     editor.setValue(starting_value);
   });
   
   // Hook up the validation indicator to update its 
   // status whenever the editor changes
   editor.on('change',function() {
     // Get an array of errors from the validator
     var errors = editor.validate();
     
  //   var indicator = document.getElementById('valid_indicator');
     
     // Not valid
     if(errors.length) {
  //     indicator.className = 'label alert';
  //     indicator.textContent = 'not valid';
     }
     // Valid
     else {
         $('#json_storage_{{ doc_id }}').val(JSON.stringify(editor.getValue()));
  //     indicator.className = 'label success';
  //     indicator.textContent = 'valid';
     }
   });
{% endjavascript %} 
