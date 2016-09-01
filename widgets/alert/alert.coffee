class Dashing.Alert extends Dashing.Widget

  marquee = $()

  ready: ->
    marquee = $(@node).find('marquee')
    $(@node).removeClass('widget')

  onData: (data) ->
    title = $("div[data-id=#{data.identifier}]").attr('data-title')
    identifier = "#{data.identifier}"
    dataValue = "#{data.value}"
    # Only add the message if it doesn't exist yet
    if not messagePresent(identifier)
      container = createContainer(identifier)
      alertName = createMessage(title, 'label')
      alertDetails = createMessage(dataValue, 'value')
      container.append(alertName, alertDetails)
      marquee.append(container)
    else
      # Get message details and compare, if it's not the same, replace message details
      messageDetails = getMessageDetails(identifier)
      details = messageDetails.text();
      if(dataValue != details)
        messageDetails.text(dataValue)

  createContainer = (identifier) ->
    $("<span></span>")
      .attr("alert-id", identifier)

  createMessage = (text, clazz) ->
    $("<p></p>")
      .text(text)
      .addClass clazz

  messagePresent = (identifier) ->
    marquee.find("span[alert-id=#{identifier}]")
      .length

  getMessageDetails = (identifier) ->
    container = marquee.find("span[alert-id=#{identifier}]")
    container.find("p.value")