pyc <- c("r", "p", "s")
draw <- 0
win <- 0
lose <- 0
play <- 0

print("Pao Ying Chub")
print("Hello There")
print("What's your name?")
user_name <- readLines("stdin", n=1)
print(paste("Hi", user_name, "!", "Are you ready to play? 'Y/N'"))
start <- readLines("stdin", n=1)
if (start == "Y") {
  print("Rule: You fill letter r(rock), p(paper), s(scissors) in each round and you can play unlimited time. If you wanna quit game just fill 'q', we will sum the game result to you. Have fun!")
} else {
  print("Let's play another time. Have a nice day. Bye!")
  play <- play + 11
  return
}

while (play < 10) {
  us <- sample(pyc, size = 1, replace = TRUE)
  print("Start (r, p, s)")
  user <- readLines("stdin", n=1)
  if (user == "q") {
    play <- play + 10
    print("See your score")
  } else {
    print (paste("Bot:", us))
  if (user == "r" & us == "r") {
    draw <- draw + 1
    print("Result: draw")
  } else if (user == "s" & us == "s") {
    draw <- draw + 1
    print("Result: draw")
  } else if (user == "p" & us == "p") {
    draw <- draw + 1
    print("Result: draw")
  } else if (user == "p" & us == "r") {
    win <- win + 1
    print("Result: win")
  } else if (user == "s" & us == "p") {
    win <- win + 1
    print("Result: win")
  } else if (user == "r" & us == "s") {
    win <- win + 1
    print("Result: win")
  } else if (user == "p" & us == "s") {
    lose <- lose + 1
    print("Result: lose")
  } else if (user == "r" & us == "p") {
    lose <- lose + 1
    print("Result: lose")
  } else if (user == "s" & us == "r") {
    lose <- lose + 1
    print("Result: lose")
  } else if (user == "q") {
    play <- play + 10
    print("See your score")
  }
}
}

while (play == 10) {
result <- c("win", "draw", "lose")
score <- c(win, draw, lose)
outcome <- data.frame(result, score)
print(paste(user_name, "score is"))
print(outcome)
print("See you next time. Byebye!")
play <- play + 1
}
