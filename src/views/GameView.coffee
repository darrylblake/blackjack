class window.GameView extends Backbone.View

  template: _.template '
    <button class="action hit">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
  events:
    'click .action.hit': -> @model.get('playerHand').hit()
    'click .action.deal': -> @newDeal()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @model.on 'change:dealerHand', => @render()
    @model.get 'playerHand'
      .on 'busted', => @bustedDeal()

    @render();

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  bustedDeal: ->
    @$el
      .find '.action'
      .text 'Deal'
      .removeClass 'hit'
      .addClass 'deal'

  newDeal: ->
    @$el
      .find '.action'
      .text 'Hit'
      .removeClass 'deal'
      .addClass 'hit'
    @model.resetHands()
    @model.get 'playerHand'
      .on 'busted', => @bustedDeal()


