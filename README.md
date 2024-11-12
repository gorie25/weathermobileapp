Weather APP
Project Structure
weather_app/
├── lib/
│   ├── Page/
│   │   ├── EmailPage/
│   │   │   └── email.dart          # Screen for sending email reports
│   │   ├── Detailpage/
│   │   │   └── detail_page.dart    # Screen showing detailed weather forecast
│   ├── components/
│   │   └── weather_item.dart       # Widget displaying individual weather stats
│   ├── models/
│   │   ├── city.dart               # Model for city data
│   │   └── weather.dart            # Model for weather data
│   ├── providers/
│   │   └── weather_provider.dart   # Provider for managing weather data fetching and state
│   ├── Utils/
│   │   └── constants.dart          # File for constants like colors and gradients
│   └── main.dart                   # Main entry point of the app
└── assets/
    ├── menu.png                    # Image for menu icon
    ├── profile.png                 # Image for user profile
    ├── weather_icons/              # Folder for weather condition icons (e.g., sunny.png, cloudy.png)
        ├── sunny.png
        ├── cloudy.png
        └── windspeed.png           # Icons for windspeed, humidity, and cloud conditions
Directory Descriptions
lib/Page: Contains the main pages for the app, including:

EmailDialog: Allows users to email a weather report.
DetailPage: Displays detailed weather forecasts.

lib/components: Widgets used across different pages, like the WeatherItem widget for displaying individual weather data (e.g., temperature, humidity).

lib/models: Contains data models that represent cities and weather data, making it easier to handle data within the app.

lib/providers: Holds the WeatherProvider, which is responsible for fetching and managing weather data and making it accessible to the app.

lib/Utils: Contains constants for colors, gradients, and styling to keep the UI consistent.

assets: Stores all images and icons used in the app, such as weather icons and profile/menu images.
