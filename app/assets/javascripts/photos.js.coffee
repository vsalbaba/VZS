jQuery ->
  init_new_photo = (new_block, default_inputs_count=1) ->
    first_inputs = ->
      return $('.inputs', new_block).first()
    last_inputs = ->
      return $('.inputs', new_block).last()
    inputs_count = ->
      return $('.inputs', new_block).length

    add_another = ->
      another_inputs = new_inputs.clone()
      new_form.before(another_inputs)
      return false

    update_progress = (add_file_percent=0) ->
      file_percent = (100 / @total_inputs_count)
      percent = 100 - (file_percent*inputs_count())
      percent += (add_file_percent*(file_percent/100))
      percent = Math.round(percent)
      percent = Math.min(percent, 100)
      $('#upphoto-progress').progressbar('value', percent)
      $('#upphoto-progress .ui-progressbar-value').html(percent+'%')

    submit_finish = ->
      add_another()
      $('#upphoto-progress').hide()
      if @total_submitted == 0
        submit_dialog.html('Žádné fotky k přiložení')
      else
        submit_dialog.html('Soubory úspěšně přiloženy')
      submit_dialog.dialog('option', 'buttons', {
        'ok': ->
          $(this).dialog('close')
          window.location.href = window.location.href
      })
      return false

    submit_error = (reason) ->
      filename = $('#photo_name', last_inputs()).val()
      last_inputs().show()
      if inputs_count() == 1
        new_form.before(last_inputs().remove())
      else
        first_inputs().before(last_inputs().remove())
      submit_dialog.html('Chyba při odesílání souboru '+filename+'! ('+reason+')')
      submit_dialog.dialog('option', 'buttons', {'ok': -> $(this).dialog('close')})

    submit_validate = ->
      return not (
        $('#photo_image', last_inputs()).val() == ''
      )

    submit_validate_is_empty = ->
        return ($('#photo_name', last_inputs()).val() == '')

    submit_next_file = ->
      update_progress()
      if inputs_count() == 0
        return submit_finish()
      first_inputs().hide()
      add_another_btn.before(first_inputs().remove())
      if not submit_validate()
        if submit_validate_is_empty()
          @total_inputs_count--
          last_inputs().remove()
          submit_next_file()
        return submit_error('Nebyl zvolen soubor')
      @total_submitted++
      new_form.submit()
      return false

    submit = ->
      @total_inputs_count = inputs_count()
      @total_submitted = 0
      submit_dialog.html('<div id="upphoto-status">Přidávám fotky ...</div><div id="upphoto-progress"></div>')
      submit_dialog.dialog('option', 'buttons', {})
      submit_dialog.dialog('open')
      $('#upphoto-progress').progressbar({value:0})
      submit_next_file()
      return false

    new_form = $('form#new_photo', new_block)
    if last_inputs().length == 0
      return

    submit_dialog = $('<div id="new_photo_dialog" title="Nové fotky">&nbsp;</div>')
    new_form.after(submit_dialog)
    submit_dialog.dialog({autoOpen:false,modal:true})

    add_another_btn = $('<a href="#" class="btn"><i class="icon-plus"></i> Další foto</a>')
    add_another_btn.click => add_another()
    last_inputs().after(add_another_btn)

    new_inputs = last_inputs().clone()
    #.append('<hr />')
    $('label', new_inputs).remove()
    $('#photo_name', new_inputs).attr('placeholder', 'Název')
    $('#photo_image', new_inputs).attr('placeholder', 'Soubor')
    $('div', new_inputs).css('display', 'inline').css('float', 'left')
    new_inputs.css('clear', 'left')

    last_inputs().remove() # remove original inputs
    while inputs_count() < default_inputs_count
      add_another()

    @total_inputs_count = inputs_count()
    $(new_form).ajaxForm({
      dataType: 'json'
      , uploadProgress: (event, position, total, percent) ->
        update_progress(percent)
      , error: (a,b,c) ->
        submit_error(a)
      , success: (response, b, c, d) ->
        if response.status
          $('#upphoto-status').html('Soubor přilozen, pokračuji...')
          last_inputs().remove()
          submit_next_file()
        else
          errors = ''
          #errors = JSON.stringify(response)
          for key in ['name', 'image']
            if response.errors[key]
              errors += key+': '+response.errors[key]
          submit_error(errors)
    })

    $('button[type=submit]', new_form).click -> submit()

  init_edit_toggle = ->
    $('.vzs-gallery-photo').each ->
      $('form', this).hide()
      $('.vzs-gallery-photo-edit', this).click =>
        $('form', $(this).parent()).toggle()
        false

  init_edit_toggle()
  $('#vzs-new-photo').each ->
    init_new_photo($(this), 6)

