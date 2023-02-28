# Love Fern (Front End)

[IMAGE here]

Love Fern is an application that allows the user to cultivate their relationships with others in their lives, by taking care of a fern. This is the front end of the application, which will focus on OAuth, Service Oriented Architecture, and quality CSS styling for a thematic user experience.

## Getting Started

This is a Ruby on Rails application which calls API endpoints set up in the `love_fern_be` repository. To run this locally, both repositories will need to be cloned and set up.

#### Installation

To install gems, run:
```
bundle install
```
Then to establish a database, run:
```
rails db:create
```
Because this is the front end repository, no migration is necessary, as there is no db.

#### RSpec Suite

Once `love_fern_fe` is correctly installed, run tests to ensure the repository works as intended locally.

To test the entire spec suite, run:
```
bundle exec rspec spec/
```
All tests should be passing if installation is successful.

#### Local Server

To fully use Love Fern locally, run `rails s` on both the `love_fern_be` and the `love_fern_fe` repositories. The backend will be hosted on `localhost:____` while the front end will use `localhost:3000`

## How to Use (Walk Through)

- Visit `localhost:3000/`, the landing page:
  - The landing page will ask for a Google OAuth to sign in, so a Google account is required.
  - Upon a successful login, it will redirect to the User Show page `'/greenhouse'`

- Greenhouse:
  - All the user's relationships will be displayed here, as ferns, organized into shelves for each type of relationship.
  - Ferns begin as healthy, though overtime if the ferns are not "watered" (aka not interacted with) they will decline in quality.
  - To create a fern, click on "Plant a New Fern", which will redirect to `'/ferns/new'`
  - Shelves can be created as well, without ferns.
  - Ferns or entire shelves can be "composted" (destroyed).

- Planting a New Fern:
  - Populate the form to create a fern. It will need the person's name, the preferred method of contact with them, and the shelf that the fern is intended to be placed on. 
  - Existing shelves are displayed as options, or a new shelf category can be supplied and that shelf will be created upon fern creation.

- Watering a Fern:
  - Click on the desired fern, which will go to its show page `'/ferns/:fern_id'`. Then click "Water Fern"
  - Supply a correspondence message in the 'Add Message to Fern' form. This calls Google's Natural Language API. Read more about this API [here](https://cloud.google.com/natural-language). 
  - Once the message is analyzed by the Natural Language API, a score will be returned which decides if the message was positive, neutral, or negative.
    - If the message is positive, the fern will improve its health.
    - If the message is neutral, the fern will not change its health.
    - If the message is negative, the fern will deteriorate its health.
  - The image of the fern will be updated to reflect this new health.

- Fertilizing a Fern:
  - When a fern is unhealthy, there is an option to apply "fertilizer". This means Love Fern will suggest an activity to do with your fern's individual, in order to help strengthen your bond with that person.
  - The fertilizer feature calls the BoredAPI to suggest a random activity. Read more about this API [here](https://www.boredapi.com/documentation).
  - If the activity is confirmed the fern springs back to full health!
## Goals

Love Fern was germinated to satisfy the requirements for a Turing Backend Mod 3 group project, Consultancy. Official project requirements can be read [here](https://backend.turing.edu/module3/projects/consultancy/).
#### Learning Goals

- Implement OAuth2 with OmniAuth to allow users to sign in with Google.
- Use of HTML, CSS, and JavaScript via Bootstrap to design a pleasing front-end aesthetic.
- Building a full-scale application from scratch using service-oriented architecture.

#### Future Goals

- Implement "watering frequency," which indicates how often a user wishes to interact with their fern before it starts to decay.
- Add more detailed stats to the fern show page, including time since last contact and information about the nature of that contact.
- Add the ability to search for a fern by name and order ferns by health.
- Suggest multiple activities and gestures corresponding to varying levels of care needed for the fern.
- Build out the fern health algorithm to incorporate activities and gifts, as well as a more nuanced interpretation of Google's sentiment analysis.

#### Known Issues

- In its current state, Love Fern's backend API is not private. Future goals are to require a private token that only the Love Fern frontend will have. Until then, please do not provide any information you deem sensitive.
- The fertilize feature currently suggests a random activity to do with your fern's person. Please consider real life consequences are not our responsibility if you do ask your fern's person to do this activity.

## Deployment

## Authors & Acknowledgments

- Samuel Cox - samc1253@gmail.com
- Drew Layton - dlayton66@gmail.com
- Anthony Ongaro - aongaro@gmail.com
- Brady Rohrig - brady.rohrig@gmail.com
- J Seymour - JustJakeSeymour@gmail.com
- Anthony Blackwell Tallent - anthonytallent567@gmail.com
