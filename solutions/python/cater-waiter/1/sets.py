"""Functions for compiling dishes and ingredients for a catering company."""

from sets_categories_data import (
    VEGAN,
    VEGETARIAN,
    KETO,
    PALEO,
    OMNIVORE,
    ALCOHOLS,
    SPECIAL_INGREDIENTS,
)


def clean_ingredients(dish_name, dish_ingredients):
    """Remove duplicates from `dish_ingredients`.

    :param dish_name: str - containing the dish name.
    :param dish_ingredients: list - dish ingredients.
    :return: tuple - containing (dish_name, ingredient set).
    """
    return (dish_name, set(dish_ingredients))


def check_drinks(drink_name, drink_ingredients):
    """Append "Cocktail" (alcohol)  or "Mocktail" (no alcohol) to `drink_name`, based on `drink_ingredients`.

    :param drink_name: str - name of the drink.
    :param drink_ingredients: list - ingredients in the drink.
    :return: str - drink_name appended with "Mocktail" or "Cocktail".
    """
    if any(ing in ALCOHOLS for ing in drink_ingredients):
        return f"{drink_name} Cocktail"
    return f"{drink_name} Mocktail"


def categorize_dish(dish_name, dish_ingredients):
    """Categorize `dish_name` based on `dish_ingredients`.

    :param dish_name: str - dish to be categorized.
    :param dish_ingredients: set - ingredients for the dish.
    :return: str - the dish name appended with ": <CATEGORY>".
    """
    categories = [
        ("VEGAN", VEGAN),
        ("VEGETARIAN", VEGETARIAN),
        ("KETO", KETO),
        ("PALEO", PALEO),
        ("OMNIVORE", OMNIVORE),
    ]
    for cat_name, cat_set in categories:
        if dish_ingredients.issubset(cat_set):
            return f"{dish_name}: {cat_name}"
    # Should never reach here if input is valid
    return f"{dish_name}: UNKNOWN"


def tag_special_ingredients(dish):
    """Compare `dish` ingredients to `SPECIAL_INGREDIENTS`.

    :param dish: tuple - of (dish name, list of dish ingredients).
    :return: tuple - containing (dish name, dish special ingredients).
    """
    dish_name, ingredients = dish
    special = set(ingredients) & SPECIAL_INGREDIENTS
    return (dish_name, special)


def compile_ingredients(dishes):
    """Create a master list of ingredients.

    :param dishes: list - of dish ingredient sets.
    :return: set - of ingredients compiled from `dishes`.
    """
    if not dishes:
        return set()
    return set.union(*dishes)


def separate_appetizers(dishes, appetizers):
    """Determine which `dishes` are designated `appetizers` and remove them.

    :param dishes: list - of dish names.
    :param appetizers: list - of appetizer names.
    :return: list - of dish names that do not appear on appetizer list.
    """
    return list(set(dishes) - set(appetizers))


def singleton_ingredients(dishes, intersection):
    """Determine which `dishes` have a singleton ingredient.

    :param dishes: list - of ingredient sets.
    :param intersection: constant - set of ingredients that appear in more than one dish.
    :return: set - containing singleton ingredients.
    """
    all_ingredients = set.union(*dishes) if dishes else set()
    return all_ingredients - intersection