class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(hit = @deck.dealCard())
    # check minScore, if over 21 trigger bust event to gameModel
    @trigger 'busted', @ if @minScore() > 21 
    hit

  stand: ->
    @trigger 'stand', @

  dealerPlay: ->
    @first().flip()
    console.log @scores()[0], @scores()[1]
    # Ace, 3 > 14 , j 14
    ###while @scores()[0] < 17 # 4
      if @scores()[1] < 17 or @scores()[1] >= 21# 14
        delay = @add @deck.dealCard()
        setTimeout delay, 500 ###

    @add @deck.dealCard() until @scores()[0] > 17 or 17 <= @scores()[1] <= 21

    @trigger 'dealerDone', @

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]



# while (minScore