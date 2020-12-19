# Project Proposal
* Name (PennKey): siminghe
* Project Name: ScheduleInTouch
* Deployment link: https://fathomless-retreat-40604.herokuapp.com/
# Description
This project ScheduleInTouch aims at developing a website that makes task scheduling more convenient and efficient. It would allow users to join or create subject, tasks of the calendar, and events of the task. Then, time blocks will be displayed on calendar. 
# Database Schema
![DatabaseSchema](scheme.png)
# Third Party Utilities
* Gem(s): 
  * pry: debug
  * devise: user authentication
  * cocoon: nested form
  * simple_form: beautiful form
  * fullcalendar: display calendar
  * asw-sdk-s3: file upload
* API(s): 
  * None (Google Calendar API failed since I'm in China and not able to access it normally. Professor approved me to use fullcalendar gem instead of the API).
# Success Criteria
* Model
  1. has_many to has_many relationships: Users and Subjects
  2. Nested structure: Subject and Task; Task and Event
  3. Google Calendar API: replaced by fullcalendar gem with approvement of Professor
* Controller
  1. User and Password: user authentication using devise gem
  2. Upload Syllabus File: upload syllabus of each subject
  3. Use simple_form gem to create beautiful nested forms
* View
  1. Use Bootstrap and CSS
  2. Aesthetic
* Deployment
  1. Deploy to Heroku
  2. Private Gitlab repository

# Build Plan
* Nov 23 – Nov 29	Gitlab repository, Creation of all models, Set up associations and validations
* Nov 30 – Dec 6	Implement MVC
* Dec 7 – Dec 14	Implement Google Calendar API, Prettify the project

# Extra:
- Allows both public and private events
- Implement two nested forms

