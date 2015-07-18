class window.CardView extends Backbone.View
  className: 'cardContainer'
    
  template: _.template "
    <div class='card'>
      <span class='front'></span>
      <span class='back'></span>
    </div>
  "

  initialize: -> 
    @render()
    @model.on 'change:revealed', => @renderFlip()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.css('background-image', "url(img/cards/#{@model.get "rankName"}-#{@model.get "suitName"}.png)")
    @$el.removeClass 'covered'
    @$el.addClass 'covered' unless @model.get 'revealed'

  renderFlip: ->
    @$el.removeClass 'covered'

