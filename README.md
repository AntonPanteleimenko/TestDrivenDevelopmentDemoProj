# Test-Driven Development in IOS

 Test Driven Development (TDD) is a popular way to write software. The methodology dictates that you write tests before writing supporting code. While this may seem backward, it has some nice benefits. One such benefit is that the tests provide documentation about how a developer expects the app to behave. This documentation stays current because test cases are updated alongside the code, which is great for developers who aren’t great at creating or maintaining documentation. You can find more information in a [presentation](https://drive.google.com/file/d/1Isg1VmYRQj0Ag31L6eYaFld8G15xzjXl/view?usp=sharing) and [video](https://chiswdevelopment.sharepoint.com/sites/iOSteam/Shared%20Documents/General/Recordings/%D0%A1%D0%BE%D0%B1%D1%80%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B2%20%D0%BA%D0%B0%D0%BD%D0%B0%D0%BB%D0%B5%20_%D0%9E%D0%B1%D1%89%D0%B8%D0%B9_-20210629_113511-%D0%97%D0%B0%D0%BF%D0%B8%D1%81%D1%8C%20%D1%81%D0%BE%D0%B1%D1%80%D0%B0%D0%BD%D0%B8%D1%8F.mp4?web=1).

## Getting Started

  You’re working on a new feature and suddenly an old feature stops working even though you wrote unit tests. Or you’re refactoring legacy code and you think it’s done, but suddenly you find a lot of bugs. So you go back, you make the fixes, and you think it’s done, but then you find more bugs. You repeat and you think it’s done every time, but the same thing happens, every time. The typical TDD flow can be described in the red-green-refactor cycle:

![](https://bitbar.com/wp-content/uploads/2020/02/tdd-cycle.png)

  It consists of:
- Red: Writing a failing test.
- Green: Writing just enough code to make the test pass.
- Refactor: Cleaning up and optimizing your code.
- Repeating the previous steps until you’re satisfied that you’ve covered all the use cases.

### Prerequisites

Open Xcode and go to File | New | Project. Navigate to iOS | Application | Single View App, and click on Next. Put in the name of the product, select the language Swift, and check Include Tests. Uncheck Use Core Data and click on Next. The following screenshot shows the options in Xcode:

![](https://res.cloudinary.com/dukp6c7f7/image/upload/f_auto,fl_lossy,q_auto/s3-ghost/2017/07/image1-1500310699681.png)

Xcode sets up a project ready for development in addition to a test target for your unit tests. Open the YourProjectNameTests folder in the Project Navigator. Within the folder, there are two files: ourProjectNameTests.swift and Info.plist. Select ourProjectNameTests.swift to open it in the editor.

What you see here is a test case. A test case is a class comprising several tests. In the beginning, it's good practice to have a test case for each class in the main target.

### How TDD fits into Agile development?

 There’s a high probability that project requirements may change during the [development sprint cycle](https://www.browserstack.com/guide/software-release-flow-and-testing-ecosystem). To deal with this and to build products aligned with the client’s changing requirements, teams need constant feedback to avoid dishing out unusable software. TDD is built to offer such feedback early on.

 TDD’s test-first approach also helps mitigate critical bottlenecks that obstruct the quality and delivery of software. Based on the constant feedback, bug fixes, and addition of new features, the system evolves to ensure that everything works as intended. TDD enhances collaboration between team members from both the development and QA teams as well as with the client. Additionally, as the tests are created beforehand, teams don’t need to spend time recreating extensive test scripts.

>Additionally, each test must focus on individual functionality, which makes unit tests quite small and, therefore, usually quick to write. Engineers provide some input to their code under test and expect a specific output from it.

```Ruby
    func testMath_ForMoneyFormatter_WithWholeNUmber() {
        
        // Arrange
        
        let formatter = MoneyFormatter()
        
        // Act
        
        // Assert
        
        XCTAssertEqual(formatter.string(decimal: 0), "0.00")
        
        XCTAssertEqual(formatter.string(decimal: 0), "0.00")
        XCTAssertEqual(formatter.string(decimal: 1), "1.00")
        
        XCTAssertEqual(formatter.string(decimal: 0), "0.00")
        XCTAssertEqual(formatter.string(decimal: 1), "1.00")
        XCTAssertEqual(formatter.string(decimal: 2), "2.00")
        XCTAssertEqual(formatter.string(decimal: 123), "123.00")
        XCTAssertEqual(formatter.string(decimal: -2), "-2.00")
    }
```

## What Are the Advantages of Test-Driven Development?

Since engineers write tests before the code, TDD enables teams to spot issues early in development, which reduces the number of bugs in your application and saves you time and headaches later. For many, increased test coverage is one of TDD’s key benefits. With code coverage of around 80-100%, bugs have a harder time sneaking through unnoticed. For the same reason, developers can write and push code with more confidence, since the high test coverage ensures that no show-stopping bugs get into production.

Other notable advantages of TDD for mobile app testing include:

1. Increased developer productivity
2. Time-savings when fixing bugs (especially before the app’s release)
3. Ensuring a clean codebase with readable, non-redundant code
4. Reduced chances of breaking existing functionalities
5. Heightened test coverage

### What is unit testing?

Unit tests are automated tests that run and validate a piece of code (known as the “unit”) to make sure it behaves as intended and meets its design.

Unit tests have their own target in Xcode and are written using the [XCTest framework](https://developer.apple.com/documentation/xctest). A subclass of XCTestCase contains test methods to run in which only the methods starting with “test” will be parsed by Xcode and available to run.

```Ruby
/// A simple struct containing a list of users.
struct UsersViewModel {
    let users: [String]

    var hasUsers: Bool {
        return !users.isEmpty
    }
}

/// A test case to validate our logic inside the `UsersViewModel`.
final class UsersViewModelTests: XCTestCase {

    /// It should correctly reflect whether it has users.
    func testHasUsers() {
        let viewModel = UsersViewModel(users: ["Antoine", "Jaap", "Lady"])
        XCTAssertTrue(viewModel.hasUsers)
    }
}
```

### 100% code coverage should not be your target

Although it’s a target for plenty, 100% coverage should not be your main goal when writing tests. Make sure to test at least your most important business logic at first as this is already a great start. Reaching 100% can be quite time consuming while the benefits are not always that big. In fact, it might take a lot of effort to even reach 100%.

On top of that, 100% coverage can be quite misleading. The above unit test example has 100% coverage as it reached all methods. However, it did not test all scenarios as it only tested with a non-empty array while there could also be a scenario with an empty array in which the hasUsers property should return false.

![](https://www.avanderlee.com/wp-content/uploads/2019/09/unit-test-code-coverage.png)

### Do not use XCTAssert for everything

The following lines of code all test exactly the same outcome:

```Ruby
func testEmptyListOfUsers() {
    let viewModel = UsersViewModel(users: ["Ed", "Edd", "Eddy"])
    XCTAssert(viewModel.users.count == 0)
    XCTAssertTrue(viewModel.users.count == 0)
    XCTAssertEqual(viewModel.users.count, 0)
}
```

As you can see, the method is using a describing name that tells to test an empty list of users. However, our defined view model is not empty and therefore, all assertions fail.

![](https://www.avanderlee.com/wp-content/uploads/2019/09/unit-test-assertions.png)

## Test Doubles

 When doing unit testing, it is a common practice to replace an actual object with a simplified version in order to reduce code dependencies. We call this kind of simplified object a Test Double (similar to stunt double in the movie industry).
 By using a test double, we can highly reduce the complexity of our test cases. Furthermore, it also enables us to have more control over the outcome of our test items.

### Dummy

Dummy objects are objects that never used. This means it is not being used in a test and only act as a placeholder. Dummy objects also use to satisfy method parameters. You can implement to dummy object very easily.
In this example, we want to create a Provider object. For creating a Provider object, we have to pass the NotificationProvider variable on the initializer. We can use the dummy object in there

```Ruby
protocol NotificationProvider {
    func createNotification()
}

class DummyNotificaitonProvider: NotificationProvider {
    func createNotification() {
        fatalError("This is dummy object!!!")
    }
}

class Provider {
    let notificationProvider: NotificationProvider
    init(notificationProvider: NotificationProvider) {
        self.notificationProvider = notificationProvider
    }
}

let provider = Provider(notificationProvider: DummyNotificaitonProvider())
```

### Fakes

A fake is an object that has working implementations that replicate the behavior, but not the same as the production one.
In this example, imagine that we have a protocol that adds a notification to the database and gets a notification by using an identifier. We use this database only for production. So, we need to have a fake object to replicate the behavior. For this purpose, an example code is given below.

```Ruby
struct Notification {
    let id: String
    let title: String
}
protocol NotificationRepository {
    func getNotificationWithId(id: String) -> Notification?
    func addNotidicaiton(notification: Notification)
}

class FakeNotificationRepository: NotificationRepository {
    var notifications = [Notification(id: "1", title: "Title 1"), Notification(id: "2", title: "Title 2")]
    
    func addNotidicaiton(notification: Notification) {
        notifications.append(notification)
    }
    
    func getNotificationWithId(id: String) -> Notification? {
        return notifications.first { (notification) -> Bool in
            notification.id == id
        }
    }
}
```

### Stubs

Stub is an object which will always return a set of predefined data. Stub can provide “canned responses”.
Imagine that, we need Notifications for displaying. “getNotifications” method in NotificationGetter protocol can provide notifications. Therefore, while creating NotificationStub, it should be conformed to NotificationGetter protocol. Now, “getNotifications” in NotificationStub can provide notifications as a stub.

```Ruby
struct Notification {
    let id: String
    let title: String
}

protocol NotificationGetter {
    func getNotification(completion: (([Notification])-> Void))
}

class NotificationStub: NotificationGetter {
    private let notificaitons: [Notification]
    
    init(notifications: [Notification]) {
        self.notificaitons = notifications
    }
    
    func getNotification(completion: (([Notification]) -> Void)) {
        completion(notificaitons)
    }
}

func testNotification() {
    let notificationStub = NotificationStub(notifications: [Notification(id: "1", title: "Title 1")])
    notificationStub.getNotification { (notification) in
        // expectations on the received notifications
    }
}
```

### Mocks

```Ruby
struct Notification {
    let id: String
    let title: String
}

protocol NotificationGetter {
    func getNotification(completion: (([Notification])-> Void))
}

class NotificationMock: NotificationGetter {
    var getNotificationCalled = false
    var getNotificationCounter = 0
    func getNotification(completion: (([Notification]) -> Void)) {
        getNotificationCalled = true
        getNotificationCounter += 1
    }
}
```

## Useful Links

[Test Driven Development Tutorial for iOS: Getting Started](https://www.raywenderlich.com/5522-test-driven-development-tutorial-for-ios-getting-started)

[Getting Started With Widgets](https://www.raywenderlich.com/11303363-getting-started-with-widgets)

[iOS Test-Driven Development](https://qualitycoding.org/ios-tdd/)

[Unit Testing and Test Doubles in Swift](https://medium.com/mobil-dev/unit-testing-and-test-doubles-in-swift-5b5e93e68512)

Now go on and start writing your own tests 💪

## Developed By

* Panteleimenko Anton, CHI Software
* Kosyi Vlad, CHI Software

## License

Copyright 2021 CHI Software.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
