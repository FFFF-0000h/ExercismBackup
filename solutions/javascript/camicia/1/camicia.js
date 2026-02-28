//
// This is only a SKELETON file for the 'Camicia' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const simulateGame = (playerA, playerB) => {
  // Copy initial decks (top card is first element)
  let deckA = [...playerA];
  let deckB = [...playerB];
  let pile = [];
  let turn = 'A';               // player A starts the first round
  let tricks = 0;
  let cardsPlayed = 0;

  // ----- helper functions -------------------------------------------------
  const isNumber = (card) => !['J', 'Q', 'K', 'A'].includes(card);

  const paymentValue = (card) => {
    switch (card) {
      case 'J': return 1;
      case 'Q': return 2;
      case 'K': return 3;
      case 'A': return 4;
      default: return 0;        // should never happen
    }
  };

  // Normalize a deck by replacing all number cards with 'N'
  const normalize = (deck) => deck.map(c => isNumber(c) ? 'N' : c).join('');

  // State string for loop detection (ignores number card values)
  const getState = () => `${normalize(deckA)}|${normalize(deckB)}|${turn}`;

  // Collect the central pile – adds all cards to the bottom of collector's deck
  const collect = (collector) => {
    const target = collector === 'A' ? deckA : deckB;
    target.push(...pile);       // preserve order, add to bottom
    pile = [];                  // clear pile
    tricks++;
  };

  // ----- history for loop detection ---------------------------------------
  const history = new Set();
  history.add(getState());      // initial state before first round

  // ----- play one full round ----------------------------------------------
  const playRound = () => {
    let currentPlayer = turn;       // who plays next when no penalty
    let payer = null;               // player currently paying a penalty
    let remaining = 0;              // how many cards still to pay
    let lastPaymentPlayer = null;   // player who played the last payment card

    while (true) {
      // Determine who must play the next card
      const playerToPlay = payer !== null ? payer : currentPlayer;
      const deck = playerToPlay === 'A' ? deckA : deckB;

      // If that player has no cards, the other player collects immediately
      if (deck.length === 0) {
        const collector = playerToPlay === 'A' ? 'B' : 'A';
        collect(collector);
        // After collection, check for game end
        const otherDeck = collector === 'A' ? deckB : deckA;
        if (otherDeck.length === 0) {
          return true;          // game finished
        }
        turn = collector;        // next round starts with collector
        return false;            // round ended, game continues
      }

      // Play the top card
      const card = deck.shift();
      cardsPlayed++;
      pile.push(card);

      if (isNumber(card)) {
        if (payer !== null) {
          // Part of a penalty payment
          remaining--;
          if (remaining === 0) {
            // Penalty fully paid – lastPaymentPlayer collects the pile
            collect(lastPaymentPlayer);
            const otherDeck = lastPaymentPlayer === 'A' ? deckB : deckA;
            if (otherDeck.length === 0) {
              return true;      // game finished
            }
            turn = lastPaymentPlayer; // next round starts with collector
            return false;
          }
          // otherwise penalty continues, payer unchanged
        } else {
          // Normal turn – switch to the other player
          currentPlayer = currentPlayer === 'A' ? 'B' : 'A';
        }
      } else {
        // Payment card (J, Q, K, A)
        const value = paymentValue(card);
        if (payer !== null) {
          // A payment card interrupts the current penalty
          lastPaymentPlayer = playerToPlay;
          payer = playerToPlay === 'A' ? 'B' : 'A';
          remaining = value;
        } else {
          // First payment card of the round (or after a normal turn)
          lastPaymentPlayer = playerToPlay;
          payer = playerToPlay === 'A' ? 'B' : 'A';
          remaining = value;
        }
        // currentPlayer is not updated – penalty now controls the turn order
      }
    }
  };

  // ----- main simulation loop ---------------------------------------------
  while (true) {
    const finished = playRound();
    if (finished) {
      return { status: "finished", cards: cardsPlayed, tricks };
    }

    // After a round, check for a repeated state (loop)
    const state = getState();
    if (history.has(state)) {
      return { status: "loop", cards: cardsPlayed, tricks };
    }
    history.add(state);
  }
};