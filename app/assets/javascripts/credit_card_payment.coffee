class @CreditCardPayment
  constructor: (field, images, radios) ->
    @field = $(field)
    @images = $(images)
    @radios = $(radios)
    @images.css({ 'filter':'alpha:(opacity=30)', 'opacity':'0.3' });
    @field.on 'keyup change', (event) =>
      type = @determineType(@cardNumber(@field))
      @_updateOpacity(type)
      @_updateRadioButton(type)

  cardNumber: (field) ->
    field.val().replace(/\s/g, '')
    
  determineType: (number) ->
    if number.length < 1
      return null
    [first, second, ... ] = number
    switch first
      when '3'
        # Diners (Mastercard) (36) or Amex (34 or 37)
        if number.length < 2 
          null
        else if second == '6' 
          'MasterCard'
        else 
          'Amex'
      when '4'
        'Visa'
      when '5'
        'MasterCard'
      when '6'
        'Discover'

  _updateOpacity: (type) ->
    for image in @images
      image = $(image)
      if image.attr('alt') == type
        image.css({ 'filter':'alpha:(opacity=100)', 'opacity':'1.0' })
      else 
        image.css({ 'filter':'alpha:(opacity=30)', 'opacity':'0.3' })

  _updateRadioButton: (type) ->
    for radio in @radios
      radio = $(radio)
      radio.prop('checked', radio.attr('value') == type)
