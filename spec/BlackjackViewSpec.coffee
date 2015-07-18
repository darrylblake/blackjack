assert = chai.assert
expect = chai.expect

describe 'test min / max score with Aces', ->
  deck = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()

  describe 'Dealer should stand', ->
    it 'Given an Ace and a 10', ->
      dealerHand = new Hand [new Card( rank:1, suit:1), new Card( rank:10, suit:1)], deck, true
      dealerHand.dealerPlay();
      assert.strictEqual dealerHand.length, 2
  
    it 'Given a busted hand', ->
      dealerHand = new Hand [new Card( rank:10, suit:1), new Card( rank:9, suit:1), new Card( rank:8, suit:1)], deck, true
      dealerHand.dealerPlay();
      assert.strictEqual dealerHand.length, 3

  describe 'Dealer should hit', ->
    it 'Given an Ace, 3, 10', ->
      dealerHand = new Hand [new Card( rank:1, suit:1), new Card( rank:10, suit:1), new Card( rank:3, suit:1)], deck, true
      dealerHand.dealerPlay();
      expect dealerHand.length
        .to.be.above 3

