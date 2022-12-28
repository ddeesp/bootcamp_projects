# chatbot (rule-based)
# ordering pizza

print("Welcome to Maria Pizza!")

print("Hello There")

# question 01
print("What's your name?")
user_name <- readLines("stdin", n=1)
print(paste("Hi", user_name))

# question 02
print("Your phone number: ")
phone <- readLines("stdin", n=1)
print(paste(user_name, "phone number:", phone))

# question 03
print("What do you want to do?")
print("1. order pizza 2. contact us")
action <- readLines("stdin", n=1)
if (action == 1) {
  print("You choose order pizza")
} else {
  print(paste("We will call you back within 15 mins with your phone number:", phone, "Thank you."))
  return
}

# question 04
print("Select pizza")
print("Seafood Cocktail, Hawaiian, Double Cheese, Mighty Meat")
pizza <- readLines("stdin", n=1)
if (pizza == "Seafood Cocktail") {
  print(paste("You choose", "Seafood Cocktail"))
} else if (pizza == "Hawaiian") {
  print(paste("You choose", "Hawaiian"))
} else if (pizza == "Double Cheese") {
  print(paste("You choose", "Double Cheese"))
} else {
  print(paste("You choose", "Mighty Meat"))
}

# question 05
print("Select size")
print("M or L")
size <- readLines("stdin", n=1)
if (size == "M") {
  print(paste("You choose size M"))
} else {
  print(paste("You choose size L"))
}

# question 06
print("Select Crust")
print("Pan, Crispy, Cheese, Sausage")
crust <- readLines("stdin", n=1)
if (crust == "Pan") {
  print("You choose Pan")
} else if (crust == "Crispy") {
  print("You choose Crispy")
} else if (crust == "Cheese") {
  print("You choose Cheese")
} else {
  print("You choose Sausage")
}

# question 07
print("Select Side Dish")
print("None, Garlic Bread, Baked Spinach, BBQ Chicken Wings")
dish <- readLines("stdin", n=1)
if (dish == "None") {
  print("You didn't choose any side dish")
} else if (dish == "Garlic Bread") {
  print("You choose Garlic Bread")
} else if (dish == "Baked Spinach") {
  print("You choose Baked Spinach")
} else {
  print("You choose BBQ Chicken Wings")
}

# question 08
print("Select Pickup Option")
print("Delivery or Takeaway")
pickup <- readLines("stdin", n=1)
if (pickup == "Delivery") {
  print("You choose Delivery")
} else {
  print("You choose Takeaway")
}

# question 09
print("Summarize Order")
print("1. Yes, 2. Contact us")
sum <- readLines("stdin", n=1)
if (sum == 2) {
  print(paste("We will call you back within 15 mins with your phone number:", phone, "Thank you."))
  return
} else {
  print(paste("Your order:", pizza, "size", size, "crust", crust, "side dish:", dish, "Pickup by", pickup))
}

# question 10
print("Confirm your order?")
print("1. Yes, 2. No")
cf <- readLines("stdin", n=1)
if (cf == 1 & pickup == "Delivery") {
  print(paste("We will cook and send your order to you within 1 hour. Thank you."))
} else if (cf == 1 & pickup == "Takeaway") {
  print(paste("You can pickup your order at store within 30 mins. Thank you."))
} else if (cf == 2) {
  print(paste("We will call you back within 15 mins with your phone number:", phone, "Thank you."))
}
