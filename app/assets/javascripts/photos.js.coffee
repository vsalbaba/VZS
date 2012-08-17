jQuery ->
  $('.vzs-gallery-photo').each ->
    $('form', this).hide()
    $('.vzs-gallery-photo-edit', this).click =>
      $('form', $(this).parent()).toggle()
      false

