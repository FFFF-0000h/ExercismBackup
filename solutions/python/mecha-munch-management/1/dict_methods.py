"""Functions to manage a users shopping cart items."""

def add_item(current_cart, items_to_add):
    """Add items to shopping cart.

    :param current_cart: dict - the current shopping cart.
    :param items_to_add: iterable - items to add to the cart.
    :return: dict - the updated user cart dictionary.
    """
    cart = dict(current_cart)  # work on a copy to avoid modifying original
    for item in items_to_add:
        cart[item] = cart.get(item, 0) + 1
    return cart


def read_notes(notes):
    """Create user cart from an iterable notes entry.

    :param notes: iterable of items to add to cart.
    :return: dict - a user shopping cart dictionary.
    """
    cart = {}
    for item in notes:
        cart[item] = 1
    return cart


def update_recipes(ideas, recipe_updates):
    """Update the recipe ideas dictionary.

    :param ideas: dict - The "recipe ideas" dict.
    :param recipe_updates: iterable -  with updates for the ideas section.
    :return: dict - updated "recipe ideas" dict.
    """
    updated = dict(ideas)  # copy to avoid mutating input
    for recipe_name, ingredients in recipe_updates:
        updated[recipe_name] = dict(ingredients)  # store a copy of ingredients
    return updated


def sort_entries(cart):
    """Sort a users shopping cart in alphabetically order.

    :param cart: dict - a users shopping cart dictionary.
    :return: dict - users shopping cart sorted in alphabetical order.
    """
    return dict(sorted(cart.items()))


def send_to_store(cart, aisle_mapping):
    """Combine users order to aisle and refrigeration information.

    :param cart: dict - users shopping cart dictionary.
    :param aisle_mapping: dict - aisle and refrigeration information dictionary.
    :return: dict - fulfillment dictionary ready to send to store.
    """
    fulfillment = {}
    for item, qty in cart.items():
        # assume item exists in aisle_mapping
        aisle, refrigerated = aisle_mapping[item]
        fulfillment[item] = [qty, aisle, refrigerated]
    # return in reverse alphabetical order
    return dict(sorted(fulfillment.items(), reverse=True))


def update_store_inventory(fulfillment_cart, store_inventory):
    """Update store inventory levels with user order.

    :param fulfillment cart: dict - fulfillment cart to send to store.
    :param store_inventory: dict - store available inventory
    :return: dict - store_inventory updated.
    """
    inventory = dict(store_inventory)  # copy
    for item, details in fulfillment_cart.items():
        qty_ordered = details[0]
        if item in inventory:
            stock, aisle, refrig = inventory[item]
            new_stock = stock - qty_ordered
            if new_stock <= 0:
                inventory[item] = ["Out of Stock", aisle, refrig]
            else:
                inventory[item] = [new_stock, aisle, refrig]
        else:
            # item not in inventory – perhaps ignore or raise? Not needed.
            pass
    return inventory