class window.GameView extends Backbone.View

  template: _.template '
    <div class="message"></div>
    <button class="action hit">Hit</button> <button class="action stand">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
  events:
    'click .action.hit': -> @model.get('playerHand').hit()
    'click .action.deal': -> @newDeal()
    'click .action.stand': -> @model.get('playerHand').stand()

  initialize: ->
    @model.on 'change:dealerHand', => @render()
    @model.on 'playerBusted', => @gameOver 'Busted'
    @model.on 'playerWon', => @gameOver 'pWon'
    @model.on 'dealerWon', => @gameOver 'dWon'

    @render();

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  gameOver: (result)->
    if (result is 'Busted')
      @$el.find('.message').text('You busted!')
    else if (result is 'pWon')
      @$el.find('.message').text('You won!')
    else
      @$el.find('.message').text('You lost!')

    @$el
      .find '.action.hit'
      .text 'Deal'
      .removeClass 'hit'
      .addClass 'deal'

  newDeal: ->
    @$el.find('.message').text('')
    @$el
      .find '.action.deal'
      .text 'Hit'
      .removeClass 'deal'
      .addClass 'hit'
    @model.resetHands()



