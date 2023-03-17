# Love Fern [Front End]

<img src="app/assets/images/love-fern-4_720.png" width="150">

## 👋 Welcome to Love Fern!

We believe that strong relationships are the foundation of a happy and fulfilling life. That's why we've created a tool that empowers you to build and maintain meaningful connections with the people you care about most. Try Love Fern today and see how it can transform your relationships!

## 🔗 Links

[⚡️ Production Website](https://www.lovefern.app)

[🔌 Fernando (Our Backend Service)](https://fernando.herokuapp.com)

[🪡 Front End Repository](https://github.com/love-fern/love_fern_fe)

[🧵 Back End Repository](https://github.com/love-fern/love_fern_be)

## Table of Contents

- [Description](#description)
- [Technical Details](#technical-details)
- [Getting Started](#getting-started)
  - [Local Installation](#local-installation)
  - [RSpec Suite](#rspec-suite)
  - [Local Server](#local-server)
- [How to Use (Walk Through)](#how-to-use-walk-through)
- [Goals](#goals)
  - [Learning Goals](#learning-goals)
  - [Future Goals](#future-goals)
  - [Known Issues](#known-issues)
- [Deployment](#deployment)
- [Authors \& Acknowledgments](#authors--acknowledgments)

## Description

Water your fern by copying and pasting interactions you've had with the person your fern represents into the app. Your fern will change its health status based on the sentiment (negative, neutral, positive) of the message.

View all your ferns and their current status in your greenhouse, and give attention where it's needed to keep your relationships healthy and happy.

## Technical Details

This application is built with Ruby, Ruby on Rails, HTML, CSS, and Bootstrap, using a service oriented architecture. It depends on multiple external APIs, including the Google Cloud Natural Language API for sentiment analysis.

Authentication is performed using Google's OAuth 2.0 for user sessions, which is connected securely to [Fernando](https://fernando.herokuapp.com), the Love Fern backend service.

## Getting Started

This is a Ruby on Rails application which calls API endpoints set up in the [love_fern_be](https://www.github.com/love-fern/love_fern_be) repository. To run this locally, both repositories will need to be cloned and set up fully with required gems and environmet variables.

### Local Installation

To install gems, run:

```bash
bundle install
```

To set up environment variables run `bundle exec figaro install` then open `application.yml` in your editor. Add values for the following keys:

```yml
GOOGLE_CLIENT_ID: < Your Google Client ID Here >
GOOGLE_CLIENT_SECRET: < Your Google Cloud API Secret Here >
FERN_KEY: < love_fern_be secret here (contact admin for access) >
HOST_URL: http://localhost:5000
```
_Note: If you intend to run `love_fern_be` locally, you may enter any text as the `FERN_KEY`, so long as it matches the backend key._

To establish a Postgres database, run:

```bash
rails db:{create,migrate}
```
_Note: This frontend is build in Rails, which is not traditionally used as a frontend language. Because of this, it requires an established database in order to function._  

### RSpec Suite

To run the test suite, you will need to confirm there is content in a `spec/vcr` directory. These are stubbed endpoints that mimics the current `love_fern_be` endpoints. If the placeholders are existing and accurate, all tests should be able to run without a locally running backend. You can now run the `love_fern_fe` tests locally to ensure the repository works as intended.

To run the entire spec suite, run:

```bash
bundle exec rspec spec/
```

All tests should be passing if installation is successful.

### Local Server

To fully use Love Fern locally, run `rails s` on both the `love_fern_be` and the `love_fern_fe` repositories. The backend will be hosted on `localhost:5000` while the front end will use `localhost:3000`

## How to Use (Walk Through)

### Logging in, deleting, and creating ferns.
![Screen Recording Gif](app/assets/images/walkthrough-1.gif)

- Visit `localhost:3000` in your browser, the landing page:
  - The landing page will ask for a Google OAuth to sign in, so a Google account is required.
  - Upon a successful login, it will redirect to the User Show page `/greenhouse`

- Greenhouse:
  - All the user's relationships are displayed here, as ferns, organized into shelves for each type of relationship.
  - Ferns begin as healthy, though overtime if the ferns are not "watered" (aka not interacted with) they will decline in quality.
  - To create a fern, click on "Plant a New Fern", which will redirect to `/ferns/new`

- Planting a New Fern:
  - Fill out the form to create a fern. It will need the person's name, the preferred method of contact with them, and the appropriate shelf (relationship type).
  - Existing shelves are displayed as options, or a new shelf category can be supplied and that shelf will be created upon fern creation.

### Watering and composting ferns.
![Screen Recording Gif](app/assets/images/walkthrough-2.gif)

- Watering a Fern:
  - Click on the desired fern, which will go to its show page `/ferns/:fern_id`. Then click "Water Fern"
  - Supply a correspondence message in the 'Add Message to Fern' form. This calls Google's Natural Language API. Read more about this API [here](https://cloud.google.com/natural-language).
  - Once the message is analyzed by the Natural Language API, a score will be returned which decides if the message was positive, neutral, or negative.
    - If the message is positive, the fern will improve its health.
    - If the message is neutral, the fern will not change its health.
    - If the message is negative, the fern will deteriorate its health.
    - The image of the fern will be updated to reflect this new status.

- Fertilizing a Fern:
  - When a fern is unhealthy, there is an option to apply "fertilizer". This means Love Fern will suggest an activity to do with your fern's individual, in order to help strengthen your bond with that person.
  - The fertilizer feature calls the BoredAPI to suggest a random activity. Read more about this API [here](https://www.boredapi.com/documentation).
  - If the activity is confirmed the fern springs back to full health!

## Goals

Love Fern was germinated to satisfy the requirements for a Turing Backend Mod 3 group project, Consultancy. Official project requirements can be read [here](https://backend.turing.edu/module3/projects/consultancy/).

### Learning Goals

- Implement OAuth2 with OmniAuth to allow users to sign in with Google.
- Use of HTML, CSS, and JavaScript via Bootstrap to design a pleasing front-end aesthetic.
- Building a full-scale application from scratch using service-oriented architecture.

### Future Goals

- Rebuild frontend using React
- Implement animations and fun interactions when caring for ferns
- Create graph display of showing history of interactions and trends

### Known Issues

- Some scaling issues on `/greenhouse` for mobile, can be improved for responsiveness.

## Deployment

When deploying Love Fern, make sure to add all environment variables to the appropriate config settings at your host (see above).

## Authors & Acknowledgments

:bust_in_silhouette: **Samuel Cox** 
- samc1253@gmail.com
- [GitHub](https://github.com/sambcox)
- [LinkedIn](https://www.linkedin.com/in/samuel-bingham-cox/)

:bust_in_silhouette: **Drew Layton** 
- dlayton66@gmail.com
- [GitHub](https://github.com/dlayton66)
- [LinkedIn](https://www.linkedin.com/in/drew-layton-6009a4153/)

:bust_in_silhouette: **Anthony Ongaro** 
- aongaro@gmail.com
- [GitHub](https://github.com/ajongaro)
- [LinkedIn](https://www.linkedin.com/in/ajongaro/)

:bust_in_silhouette: **Brady Rohrig** 
- brady.rohrig@gmail.com
- [GitHub](https://github.com/BRohrig)
- [LinkedIn](https://www.linkedin.com/in/brady-rohrig-5305a923/)

:bust_in_silhouette: **J Seymour** 
- JustJakeSeymour@gmail.com
- [GitHub](https://github.com/JustJakeSeymour)
- [LinkedIn](https://www.linkedin.com/in/j-seymour/)

:bust_in_silhouette: **Anthony Blackwell Tallent** 
- anthonytallent567@gmail.com
- [GitHub](https://github.com/anthonytallent)
- [LinkedIn](https://www.linkedin.com/in/anthony-blackwell-tallent-b36916255/)
