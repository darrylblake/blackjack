class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'discard', new DiscardPile()

    @dealHands()
    

    #console.log holder
    @get 'deck'
      .on 'empty', => @reshuffle()
    

  # on all player hands stood
  # play dealer hand till 17 or over
  lose: ->
    # alert 'Dealer Won!!!'
    # display the hit button
    # enable deal button
    # @resetHands()

  dealHands: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()


  resetHands: ->
    # empty hands
    @moveFrom (@get 'playerHand'), @get 'discard'
    @moveFrom (@get 'dealerHand'), @get 'discard'
    @dealHands()

  reshuffle: ->
    discard = @get 'discard'
    deck = @get 'deck'
    @moveFrom discard, deck
    deck.shuffle()


  moveFrom: (from, to) -> 
    # debugger
  
    while from.length > 0
      popped = from.pop()
      # debugger if not popped.get 'revealed'
      popped.set 'revealed', true
      to.add popped






