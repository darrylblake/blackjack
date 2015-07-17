class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    holder = @get 'playerHand'
    holder.on 'busted', @hello
    console.log holder
    

  # on all player hands stood
  # play dealer hand till 17 or over
  hello: ->
    alert 'hello'

