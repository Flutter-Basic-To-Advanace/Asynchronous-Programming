void main() {
  print("1. start");

  //This is run later (microstask queue)
  Future.microtask(() => print("2. Microtask executed"));

  //This is run later (event queue)
  Future.delayed(
    Duration(seconds: 1),
    () => print("3. Delayed event executed"),
  );

  print("4. End of main function");
}

//output
// 1. start
// 4. End of main function
// 2. Microtask executed
// 3. Delayed event executed
