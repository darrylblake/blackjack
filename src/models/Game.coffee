class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @dealHands()

    #console.log holder
    

  # on all player hands stood
  # play dealer hand till 17 or over
  lose: ->
    alert 'Dealer Won!!!'
    @dealHands()

  dealHands: ->
    @set 'playerHand', @get('deck').dealPlayer()
    @set 'dealerHand', @get('deck').dealDealer()

    @get 'playerHand'
      .on 'busted', => @lose()



