Future<String> fetchUserData() async {
  await Future.delayed(Duration(seconds: 2));
  return "User : Kamal , Age : 21";
}

void main() async {
  print("Fetching user data ...");

  //await a single async value
  String userData = await fetchUserData();

  print("Data recived : $userData");
}

//output
// Fetching user data ...
// Data recived : User : Kamal , Age : 21
