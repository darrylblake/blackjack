class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@dealCard(), @dealCard()], @

  dealDealer: -> new Hand [@dealCard().flip(), @dealCard()], @, true

  dealCard: ->
    card = @pop()
    console.log @length
    @trigger "empty", @ if @length is 0
    card

