class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'change', => @renderFlip()
    @collection.on 'add', (card) => @renderCard(card)
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

  renderCard: (card) ->
    @$el.append new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

  renderFlip: ->
    @collection.map (card) ->
      card.revealed = true
    @$('.score').text @collection.scores()[0]
    console.log @collection

