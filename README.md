# Love Fern (Front End)

[IMAGE / GIF]

Love Fern is an application that allows the user to cultivate their relationships with others in their lives, by taking care of a fern. This is the front end of the application, which will focus on OAuth, Service Oriented Architecture, and quality CSS styling for a thematic user experience.

## Getting Started

This is a Ruby on Rails application which calls API endpoints set up in the `love_fern_be` repository. To run this locally, both repositories will need to be cloned and set up.

### Installation

To install gems, run:
```
bundle install
```
Then to establish a database, run:
```
rails db:create
```
Because this is the front end repository, no migration is necessary, as there is no db.

### RSpec Suite

Once `love_fern_fe` is correctly installed, run tests to ensure the repository works as intended locally.

To test the entire spec suite, run:
```
bundle exec rspec spec/
```
All tests should be passing if installation is successful.

### Local Server

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
  - Ferns are normally organized on their shelves, but they can also be sorted in order of health (neglected ferns are least healthy).

- Planting a New Fern:
  - The form to create a fern will need the person's name, the frequency of contact with them, and the shelf that the fern is intended to be placed on. 
  - Existing shelves are displayed as options, or a new shelf category can be supplied and that shelf will be created upon fern creation.

- Watering and Fertilizing a Fern:
  - Click on the desired fern, which will go to it's show page `'/ferns/:fern_id'`
  - To "water a fern" supply a correspondence message in the 'Add Message to Fern'. So long as the message is positive, the fern will impove in health.
  - To "fertilize a fern", the Love Fern "Fernicator" will suggest activities to do or items to purchase in order to revive an unhealthy fern.
## Goals

### Learning Goals

### Future Goals

### Known Issues

## Deployment

## Authors & Acknowledgments