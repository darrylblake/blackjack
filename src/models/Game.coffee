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

    @get 'playerHand'
      .on 'stand', => 
        @get 'dealerHand'
        .dealerPlay()

    @get 'playerHand'
      .on 'busted', =>  @trigger 'playerBusted', @

    @get 'dealerHand'
      .on 'dealerDone', => @checkScores()

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

  checkScores: ->
    dealerScoreMin = @get('dealerHand').scores()[0]
    dealerScoreMax = @get('dealerHand').scores()[1]

    playerScoreMin = @get('playerHand').scores()[0]
    playerScoreMax = @get('playerHand').scores()[1]

    playerScore = if playerScoreMax > 21 then playerScoreMin else playerScoreMax 
    dealerScore = if dealerScoreMax > 21 then dealerScoreMin else dealerScoreMax 

    if dealerScore > 21 or playerScore > dealerScore
      @trigger 'playerWon', @
    else 
      @trigger 'dealerWon', @

    # @resetHands()


  moveFrom: (from, to) -> 
    # debugger
  
    while from.length > 0
      popped = from.pop()
      # debugger if not popped.get 'revealed'
      popped.set 'revealed', true
      to.add popped






