/// <reference path="./global.d.ts" />
//
// @ts-check

/**
 * Determine the price of the pizza given the pizza and optional extras
 *
 * @param {Pizza} pizza name of the pizza to be made
 * @param {Extra[]} extras list of extras
 *
 * @returns {number} the price of the pizza
 */
export function pizzaPrice(pizza, ...extras) {
  // Base pizza prices
  const basePrices = {
    'Margherita': 7,
    'Caprese': 9,
    'Formaggio': 10
  };
  
  // Start with the base price
  let total = basePrices[pizza];
  
  // Add the cost of each extra
  for (const extra of extras) {
    if (extra === 'ExtraSauce') {
      total += 1;
    } else if (extra === 'ExtraToppings') {
      total += 2;
    }
  }
  
  return total;
}

/**
 * Calculate the price of the total order, given individual orders
 *
 * (HINT: For this exercise, you can take a look at the supplied "global.d.ts" file
 * for a more info about the type definitions used)
 *
 * @param {PizzaOrder[]} pizzaOrders a list of pizza orders
 * @returns {number} the price of the total order
 */
export function orderPrice(pizzaOrders) {
  let total = 0;
  
  // Iterate through each pizza order using a loop (not recursion)
  for (const order of pizzaOrders) {
    // Calculate price for this pizza with its extras
    total += pizzaPrice(order.pizza, ...order.extras);
  }
  
  return total;
}