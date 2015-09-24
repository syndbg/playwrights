$(document).ready ->
  # TODO: Definitely change this when there's a login/signup pre-screen.
  getUserData = () ->
    { name: $('#user-name').text(), color: $('#user-color').text() }

  loadPlaywright = () ->
    # TODO: Make it accept params[:id]
    $.get('/api/playwrights/1', (data) ->
      quill.setHTML(data.text)
    )

  savePlaywright = (saveText, errorText) ->
    return () ->
      $.ajax({
        url: 'api/playwrights/1.json',
        type: 'PUT',
        data: {'text': quill.getHTML()},
        dataType: 'json',
        success: () ->
          toastr.success(saveText)
        error: () ->
          toastr.error(errorText)
      })

  faye = new Faye.Client('/faye')
  user = getUserData()

  faye.subscribe '/playwrights', (payload) ->
    if payload.user? and payload.user.name != user.name
      switch payload.type
        when 'text-change'
          quill.updateContents(payload.delta)
        when 'selection-change'
          author = payload.user.name
          color = payload.user.color
          position = payload.range.end

          quill.getModule('authorship').addAuthor(author, color)
          quill.getModule('multi-cursor').setCursor(author, position,
                                                    author, color)

  quill = new Quill('#editor-container', {
    modules:
      toolbar: '#formatting-container'
      authorship:
        authorId: user.name,
        color: user.color,
        enabled: true
      'multi-cursor':
        timeout: 5000
  })

  loadPlaywright()

  quill.on('selection-change', (range, source) ->
    if range? and source == 'user'
      faye.publish '/playwrights', {
        type: 'selection-change',
        range: range,
        user: user
      }
  )

  quill.on('text-change', (delta, source) ->
    if source == 'user'
      faye.publish '/playwrights', {
        type: 'text-change',
        delta: delta,
        user: user
      }
  )

  $quillSaveBtn = $ '#text-save-btn'
  $quillSaveBtn.click ->
    # TODO: Modify it to have the same id as params[:id] for a playwright
    faye.publish('/playwrights', {
      type: 'text-save',
      id: 1,
      text: quill.getHTML()
    }).then(() ->
      toastr.success('Saved!')
    )

  $(document).idle {
    onIdle: savePlaywright('You were idle too long. Auto-saved!',
                           'Something went wrong while auto-saving. Hang tight!')
    idle: 60000 # 1min
  }

  setInterval(
    savePlaywright('Periodical auto-save.',
                   'Something went wrong while auto-saving. Hang tight!'),
    300000) # 5min
