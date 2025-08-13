# Dart Asynchronous Programming 

Dart is a **single-threaded** language, which means it executes one operation at a time.  
But modern apps need to **do multiple things seemingly at once** — like downloading data, playing music, and updating the UI simultaneously.  

Dart achieves this with **Asynchronous Programming** powered by:  
1. **Event Loop** → The engine that drives async execution.  
2. **Future** → Represents a single async result.  
3. **Stream** → Represents multiple async results over time.  

---

## 1️⃣ Event Loop – The Engine That Drives Async Execution

**File:** `event_loop.dart`

```dart
// event_loop.dart

void main() {
  print("1. Start");

  // High-priority async task
  Future.microtask(() => print("2. Microtask executed"));

  // Scheduled after 1 second in event queue
  Future.delayed(Duration(seconds: 1), () => print("3. Delayed event executed"));

  print("4. End of main function");
}
``` 
### 🧠 Deep Explanation
- The Event Loop is the traffic controller of Dart async code.
- Dart has two main queues for async tasks:
- Microtask Queue
- Contains small, high-priority tasks.
- Runs before the event queue after current synchronous code.
- Example: Future.microtask()
- Event Queue
- Contains tasks like timers, I/O, HTTP requests, UI events.
- Runs after microtasks are cleared.
- Example: Future.delayed()
- Execution Order:
- Run synchronous code top to bottom.
- Empty the microtask queue.
- Process event queue tasks one by one.

#### 📌 Real-life Analogy
- Imagine you are a chef (Dart) cooking:
- Synchronous code = cooking the main dish step by step.
- Microtasks = quick urgent jobs like stirring soup (done before moving to the next big task).
- Event queue tasks = waiting for the oven timer (done after urgent jobs).
- 
- Expected Output:
- 1. Start
- 2. End of main function
- 3. Microtask executed
- 4. Delayed event executed

     
### 2️⃣ Future – Represents a Single Async Result
File: future.dart

```dart
Future<String> fetchUserData() async {
  await Future.delayed(Duration(seconds: 2)); // Simulate network delay
  return "User: Kamal, Age: 21";
}

void main() async {
  print("Fetching user data...");

  String userData = await fetchUserData();

  print("Data received: $userData");
}
```

#### 🧠 Deep Explanation
- A Future is an object that will eventually contain a value or an error.
- States of a Future:
- Uncompleted – Still waiting.
- Completed with data – Success.
- Completed with error – Failure.
- Using await pauses execution at that line until the Future is ready.
- Under the hood, await schedules the rest of your function to run later via the event loop.


#### 📌 Real-life Analogy
- Ordering food at a restaurant:
- Future = your food order.
- await = you wait before you can eat.
- When the order is ready, you can continue your meal.
- Execution Flow:
```dart
Print "Fetching user data...".
Wait 2 seconds (non-blocking).
Print "Data received: User: Kamal, Age: 21".
```

### 3️⃣ Stream – Represents Multiple Async Results Over Time

```dart
Stream<int> numberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // Emit value
  }
}

void main() async {
  print("Starting to listen to number stream...");

  await for (int number in numberStream()) {
    print("Received: $number");
  }

  print("Stream completed!");
}
```

#### 🧠 Deep Explanation
- A Stream is like a pipe that delivers multiple async values over time.
- Types of streams:
- Single-subscription stream → One listener at a time (e.g., file read).
- Broadcast stream → Multiple listeners (e.g., UI events).
- async* functions + yield create streams easily.
- await for is used to receive each event in order.

#### 📌 Real-life Analogy
- Think of a Stream like a water tap:
- Future = one glass of water.
- Stream = water flowing continuously, glass after glass.
- You can keep listening until it stops.
- Execution Flow:

```dart
Starting to listen to number stream...
Received: 1
Received: 2
Received: 3
Received: 4
Received: 5
Stream completed!
```
