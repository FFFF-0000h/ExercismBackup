/// <reference path="./global.d.ts" />
// @ts-check

/**
 * Implement the functions needed to solve the exercise here.
 * Do not forget to export them so they are available for the
 * tests. Here an example of the syntax as reminder:
 *
 * export function yourFunction(...) {
 *   ...
 * }
 */

export function cookingStatus(remtime) {
  if (remtime === 0) {
    return "Lasagna is done.";
  } else if (remtime === undefined) {
    return "You forgot to set the timer.";
  } else {
    return "Not done, please wait.";
  }
}

export function preparationTime(layers, avgPrepTime = 2) {
  let noOflayers = layers.length;
  return noOflayers * avgPrepTime;
}

export function quantities(layers) {
  let noodles = 0;
  let sauce = 0;
  for (let i = 0; i < layers.length; i++) {
    if (layers[i] === "noodles") {
      noodles = noodles + 50;
    }

    if (layers[i] === "sauce") {
      sauce = sauce + 0.2;
    }
  }
  return { noodles, sauce };
}

export function addSecretIngredient(friendList, myIngredientList) {
  myIngredientList.push(friendList[friendList.length - 1]);
}

export function scaleRecipe(recipe, noOfPortions) {
  const scaled = {};
  for (let key in recipe) {
    scaled[key] = recipe[key] * (noOfPortions / 2);
  }
  return scaled;
}