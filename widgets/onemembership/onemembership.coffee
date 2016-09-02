class Dashing.Onemembership extends Dashing.Widget

  onData: (data) ->
    # clear existing "status-*" classes
    $(@get('node')).attr 'class', (i,c) -> c.replace /\bstatus-\S+/g, ''

    # add new class
    $(@get('node')).addClass "status-#{data.value}"
    $(@get('node')).addClass "status-#{data.status}"

    # remove existing alerts if status OK
    if(data.value == 'ok')
      removeAlert(data.identifier)

  removeAlert = (identifier) ->
    spanAlert = $('#alerts').find("span[alert-id=#{identifier}]")
    # Only remove if it exists
    if(spanAlert.length)
      spanAlert.remove()