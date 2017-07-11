module Categories

  @@easy_categories = ["ANIMALS", "COLORS", "SHAPES", "FURNITURE", "CLOTHES", "TOYS"]
  @@hard_categories = ["PHILOSOPHERS", "APPLIANCES", "FOOD",]

  def animals
    [
      "kangaroo", "zebra", "cat", "rabbit", "turtle", "elephant", "wolf",
      "lizard", "seahorse", "tiger", "lion", "pig", "shark", "cow", "horse",
      "duck", "chicken", "seagull", "walrus", "platypus", "snake", "goose",
      "sheep", "goat", "dog", "deer", "mouse", "rat", "cheetah", "panther",
      "spider", "beetle", "worm", "fish", "bear", "squirrel", "monkey",
      "gorilla", "giraffe", "toucan"
    ]
  end

  def food
    [
      "pizza", "banana", "apple", "pear", "tomato", "potato",
      "beans", "Rice", "grapes", "orange", "lime", "lemon", "cherry",
      "strawberry", "raspberry", "blueberry", "blackberry", "watermelon",
      "carrot", "cucumber", "zucchini", "onion", "radish", "beet", "cabbage",
      "lettuce", "canteloupe", "honeydew", "lasagna", "tortellini", "tacos",
      "pancakes", "waffles", "muffin", "cake", "pudding", "cookies", "salad",
      "sandwich", "burger", "fries", "coleslaw", "omlette", "crepe"
    ]
  end

  def colors
    [
      "blue", "green", "yellow", "red", "violet", "purple", "brown",
      "magenta", "turquoise", "Orange", "fuschia", "mauve", "maroon",
      "teal", "heliotrope", "puce", "gold", "silver", "pink", "cobalt",
      "ruby", "azure", "jade"
    ]
  end

  def shapes
    [
      "circle", "square", "rectangle", "triangle", "oval", "rhombus",
      "parallelogram", "octagon", "hexagon", "pentagon", "trapezoid",
    ]
  end

  def philosophers
    [
      "thoreau", "socrates", "debeauvoir", "hobbes", "locke", "rousseau",
      "levinas", "butler", "irigaray", "leibniz", "spinoza", "rescartes",
      "arendt", "heidegger", "confucius", "plato", "aristotle", "democritus",
      "pythagoras", "thales", "bentham", "foucault", "fanon", "marx", "derrida",
      "sartre"
    ]
  end

  def furniture
    [
      "bed", "dresser", "couch", "desk", "table", "chair", "armchair",
      "ottoman", "wardrobe", "fouton"
    ]
  end

  def clothes
    [
      "hat", "scarf", "gloves", "pants", "shoes", "socks", "shirt", "sweater",
      "dress", "skirt", "tie", "suit", "underpants", "jeans", "overalls",
      "vest", "jacket", "blazer"
    ]
  end

  def appliances
    [
      "fridge", "microwave", "oven", "blender", "toaster", "stove", "mixer",
      "dishwasher", "breadmaker", "keurig"
    ]
  end

  def toys
    [
      "legos", "slinky", "barbie", "racecar", "marbles", "puzzle", "top",
      "frisbee", "yoyo", "jacks", "furby"
    ]
  end
end
