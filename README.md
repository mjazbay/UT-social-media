Group Project - README
===

# Orange

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Orange brings UT students together to do more of what they want to do in life. Orange help students to explore, learn and connect through on and off campus events. 

### App Evaluation
- **Category:** Social networking
- **Mobile:** iPhone
- **Story:** Allow students to share events and organize activities.
- **Market:** Any students can enjoy this app. 
- **Habit:** Users can post, look up and share events many times a day. Very habit forming!
- **Scope:** Orange starts out narrow focused, just posting, viewing and sharing events. Will expand to a larger scope, including feed sharing(sublease ...) and group chat features.

## Product Spec

### 1. User Stories

**Required Must-have Stories**

* User can sign up to create a new account.
* User can log in/out.
* User can upload a poster, add a caption, a description and post it to the server.
* User can view the latest 20 posts.
* User can pull to refresh.
* User can share events.
* User can tap a cell to see more details about a particular event.
* User can add a profile picture.


**Optional Nice-to-have Stories**
* User can enter a group chat.
* User can have private chat with another user. 


### 2. Screen Archetypes

* Login / Sign Up
* Upon reopening of the application, the user is prompted to log in to gain access to the main page and their profile information.
* Profile Screen
* Allow user to upload a photo and fill in personal information
* Event Feed Screen - 2 parts
* Allow user to view and share upcoming events they may be interested in
* Allow user to view details of the events they are going
* Event Upload Screen
* Allow user to upload a poster, add a caption and fill in descriptions(location, time, tags, ...) of an event.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Event Feed
* Events Going
* Profile

Optional:
* Chat
* Settings

**Flow Navigation** (Screen to Screen)

* Forced Log-in/Sign-in
* If user tabs sign-in, a new screen will pop up for account creation
* Event Feed -> Event Detail
* Event Feed -> Posting Event
* Events Going -> Event Detail


## Wireframes
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

## Schema 

### Models
| Property | Type | Description |
| ------ | ------ | ------ |
| objectId | String| unique id for the user post (default field) |
| author | Pointer to User | image author |
| image | File | image that user posts|
| caption | String | image caption by author|
| RSVPCount | Number | number of people RSVPed |
| commentsCount | Number | number of comments that has been posted to an event |
| createdAt | DateTime | date when post is created |
| eventTime | DateTime | date and time of an event |
### Networking
- Home Feed Screen
* (Create/POST) Create a new RSVP on an event
* (Delete) Delete existing RSVP
* (Create/POST) Create a new comment on an event
* (Delete) Delete existing comment
- Create Post Screen
* (Create/POST) Create a new event post object
- Profile Screen
* (Read/GET) Query logged in user object
* (Read/GET) Query all posts where user is author
- Chat Screen
* Remains to be updated
