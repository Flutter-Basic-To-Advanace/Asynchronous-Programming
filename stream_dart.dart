Stream<int> numberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  print("Starting to listen to number strem..");

  await for (int number in numberStream()) {
    print("Recived: $number");
  }

  print("Steam completed!");
}

//output
// Starting to listen to number strem..
// Recived: 1
// Recived: 2
// Recived: 3
// Recived: 4
// Recived: 5
// Steam completed!
