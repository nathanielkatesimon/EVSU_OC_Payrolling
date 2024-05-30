import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="repeater"
export default class extends Controller {
  connect() {
    $('#form_repeater').repeater({
      initEmpty: false,

      show: function () {
        $(this).slideDown();
      },

      hide: function (deleteElement) {
        const id_field = $(this).find('input[type=hidden]')
        console.log("asdasd")

        if (id_field.attr('value') != undefined) {
          const records_to_destroy_container = $('#records_to_destroy')

          const new_hidden_field = document.createElement('input')
          new_hidden_field.setAttribute('type', 'hidden')
          new_hidden_field.setAttribute('name', id_field.attr('name').replace('id', '_destroy'))
          new_hidden_field.setAttribute('value', 1)

          records_to_destroy_container.append(id_field.get()[0])
          records_to_destroy_container.append(new_hidden_field)
        }

        $(this).slideUp(deleteElement);
      },
      isFirstItemUndeletable: true
    });
  }
}
