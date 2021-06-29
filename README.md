# Test-Driven Development in IOS

 Test Driven Development (TDD) is a popular way to write software. The methodology dictates that you write tests before writing supporting code. While this may seem backward, it has some nice benefits. One such benefit is that the tests provide documentation about how a developer expects the app to behave. This documentation stays current because test cases are updated alongside the code, which is great for developers who aren’t great at creating or maintaining documentation. You can find more information in a [presentation](https://drive.google.com/file/d/1Isg1VmYRQj0Ag31L6eYaFld8G15xzjXl/view?usp=sharing) and [video](https://web.microsoftstream.com/video/bc50d418-7651-4567-85d8-5052650b7f65).

## Getting Started

  You’re working on a new feature and suddenly an old feature stops working even though you wrote unit tests. Or you’re refactoring legacy code and you think it’s done, but suddenly you find a lot of bugs. So you go back, you make the fixes, and you think it’s done, but then you find more bugs. You repeat and you think it’s done every time, but the same thing happens, every time. The typical TDD flow can be described in the red-green-refactor cycle:

![](https://koenig-media.raywenderlich.com/uploads/2018/02/tdd_red_green_refactor_cycle.png)

  It consists of:
- Red: Writing a failing test.
- Green: Writing just enough code to make the test pass.
- Refactor: Cleaning up and optimizing your code.
- Repeating the previous steps until you’re satisfied that you’ve covered all the use cases.

### Prerequisites

Open Xcode and go to File | New | Project. Navigate to iOS | Application | Single View App, and click on Next. Put in the name of the product, select the language Swift, and check Include Tests. Uncheck Use Core Data and click on Next. The following screenshot shows the options in Xcode:

![](https://drive.google.com/file/d/1YiOSQ-fJ0f-HiY6NGob1C4tzvZekKd7n/view?usp=sharing)

### Add Configuration Details

>StaticConfiguration: For a widget with no user-configurable properties. For example, a stock market widget that shows general market information, or a news widget that shows trending headlines.

```Ruby
StaticConfiguration(kind: kind, provider: GraphTimelineProvider(), content: { data in 
            WidgetEntryView(data: data)
                .background(Color(.black))
        })
        .description(Text("Covid-19 stats in Ukraine"))
        .configurationDisplayName(Text("Covid Stats"))
        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall])
        .onBackgroundURLSessionEvents {
            (sessionIdentifier, competion) in
            if sessionIdentifier == self.kind {
                // SOME KIND OF PROCESSING //
                competion()
            }
        }
```
>IntentConfiguration: For a widget with user-configurable properties. You use a SiriKit custom intent to define the properties. For example, a weather widget that needs a zip or postal code for a city, or a package tracking widget that needs a tracking number.

![](https://docs-assets.developer.apple.com/published/d417ba142d77b35fba46e2b99b34d596/2550/WidgetKit-Configure-Custom-Intent@2x.png)

```Ruby
struct CharacterDetailWidget: Widget {
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: "com.mygame.character-detail",
            intent: SelectCharacterIntent.self,
            provider: CharacterDetailProvider(),
        ) { entry in
            CharacterDetailView(entry: entry)
        }
        .configurationDisplayName("Character Details")
        .description("Displays a character's health and other details")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
```

## Fetching data for your widget

Before we will fetch data, we should provide the widget some stubbed data, so it can already display a placeholder view for the widget to the users.
```Ruby
func placeholder(in context: Context) -> Entry {
        Entry.placeholder
    }
    static var placeholder: Model {
        Model(date: Date(),
              widgetData: [JSONModel(
                            country: "-",
                            code: "-",
                            confirmed: 1000,
                            recovered: 1000,
                            critical: 1000,
                            deaths: 1000,
                            latitude: 0.44,
                            longitude: 44.0,
                            lastChange: "2021-01-04T08:03:24+01:00",
                            lastUpdate: "2021-01-04T10:00:04+01:00")],
              isPlaceholder: true)
        
    }
```
Now you have a placeholder view, we can fetch data to finally display our widget. The function that needs to be updated, is getTimeline. Inside this function, you’re able to fetch data and also declare the next refresh moment of your widget.
```Ruby
func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        
        coronaLoader.getData { (result) in
            switch result {
            case .success(let data):
                let date = Date()
                let entry = Model(date: date, widgetData: data)
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 10)))
                completion(timeline)
            case .failure(_):
                let entry = Model.placeholder
                let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 2)))
                completion(timeline)
            }
        }
    }
```
When a user wants to add your widget, they will see a snapshot version of your widget. You can decide which data should be visible inside this snapshot. The data displayed inside the snapshot can be fetched from the cloud before presenting it to the user.
```Ruby
func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        
        if context.isPreview {
            completion(Entry.placeholder)
        } else {
            coronaLoader.getData { (result) in
                switch result {
                case .success(let data):
                    let date = Date()
                    let entry = Model(date: date, widgetData: data)
                    completion(entry)
                case .failure(_):
                    completion(Entry.placeholder)
                }
            }
        }
    }
```

### Support different sizes for your widget

You are able to recognise the size of the widget by defining an Environment for widgetFamily. After that, you are able to check the widget size style in the body. The size can be systemSmall, systemMedium or systemLarge.

![](https://miro.medium.com/max/1400/1*-67Kk9epfFRIMt4ygAvJYg.png)

```Ruby
struct WidgetEntryView: View {
    
    @Environment(\.widgetFamily) var widgetFamily
    var data: Model
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            StatsWidgetSmall(data: data)
        case .systemLarge:
            StatsWidgetLarge(data: data)
        case .systemMedium:
            StatsWidgetMedium(data: data)
        default:
            Text("Undetected family size")
        }
    }
}
```

### Interacting with a Widget View

Optionally, you can detect taps in your Widget and redirect them to a deeplink. This is unfortunately the only interaction you're allowed to have in your widget, so no scrolling or other forms of interaction are possible.

You can configure which deeplink is triggered when your Widget is tapped through the .widgetURL(myDeeplink) method, but you can also make different parts of the widget trigger different deeplinks by using a Link. Note that since widgets are small, you shouldn't pack a ton of actions into a single Widget.

Here's an example of a Widget View that redirects to the webview when tapped.
For systemSmall widgetFamily:
```Ruby
struct StatsWidgetSmall: View {
 .....
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
           .....
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.clear)
        .widgetURL(emojiDetails)
    }
}
```
For systemMedium(same logic for systemLarge) widgetFamily:
```Ruby
struct StatsWidgetMedium: View {
    .....
    var body: some View {
    Link(destination: URL(string: "someURL")!) {
            VStack(alignment: .leading, spacing: spacing) {
            .....
            }
         }
    }
```
Catching deepLink in WidgetApp's ContentView:
```Ruby
struct ContentView: View {
    .....
    var body: some View {
    HStack {
          .....
         }
         .onOpenURL { url in
            visibleDetails = Details(url: link)
        }
        .sheet(item: $visibleDetails, content: { details in
            DetailsView(details: details, shouldRefresh: shouldRefresh)
        })
    }
```

## Useful Links

[Meet WidgetKit](https://developer.apple.com/videos/play/wwdc2020/10028/)

[Getting Started With Widgets](https://www.raywenderlich.com/11303363-getting-started-with-widgets)

[Build Your First Widget in iOS 14 With WidgetKit](https://medium.com/better-programming/build-your-first-widget-in-ios-14-with-widgetkit-9b893423e815)

[iOS 14: Create a widget using WidgetKit](https://zonneveld.dev/ios-14-widgetkit/)

Now go on and create your first WidgetKit App 💪

## Developed By

* Panteleimenko Anton, CHI Software
* Kosyi Vlad, CHI Software

## License

Copyright 2020 CHI Software.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
