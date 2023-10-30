# Doctor Appointments Api
API for booking doctors appointments by patients

[//]: # (This README would normally document whatever steps are necessary to get the)

[//]: # (application up and running.)

[//]: # ()
[//]: # (Things you may want to cover:)

[//]: # ()
[//]: # (* Ruby version)

[//]: # ()
[//]: # (* System dependencies)

[//]: # ()
[//]: # (* Configuration)

[//]: # ()
[//]: # (* Database creation)

[//]: # ()
[//]: # (* Database initialization)

[//]: # ()
[//]: # (* How to run the test suite)

[//]: # ()
[//]: # (* Services &#40;job queues, cache servers, search engines, etc.&#41;)

[//]: # ()
[//]: # (* Deployment instructions)

[//]: # ()
[//]: # (* ...)



[//]: # (**1. Understand the Requirements:**)
[//]: # (- Carefully read and understand the problem definition.)
[//]: # (- Identify the core functionalities the API should provide: managing doctor availabilities, patient booking/editing appointments, and viewing availability.)

**2. Select the Technology Stack:**
- Choose the programming language and framework you are most comfortable with. Some common choices include Python (with Django or Flask), Node.js (with Express), Ruby (with Ruby on Rails), or any other language/framework you prefer.
> - RoR, SQLite

**3. Design Data Models:**
> - determine the data models required for this system.
> - create `Doctor` and `Patient` models inherited from `User` one via STI
>   - STI will be better than polymorphic relations due to presence the same fields in our case
> - create new `TimeSlot` model
>   - contains `start_time` and `end_time` fields for defining size of appointment in time
>     - first of all I decided to use Unix timestamp instead `date` format
>       - procs:
>         - easy to process
>         - less size in DB
>         - ideal to calculate and handle time difference
>       - cons:
>         - worse readability
>         - need Presenter layer to send data in response
>         - no ability to handle different time zones
>     - however after I have changed my mind as
>       - storing, handling, validation date type on DB layer has good performance as well
>       - `DRY-validation` contract works with that data type received from client perfectly
>         - in web applications, use a datetimepicker to select the date and time conveniently, converting values easily into the ISO 8601 format for API transmission
>         - it allows to accept and transmit date and time with the timezone to account for time differences between different locations
>       - finally, providing data in ISO 8601 format in responce is the best practice in building API
>   - it contains `day_of_week` enum for better rendering of doctors schedule on client side
>     - added as optional now
>     - can be useful for ability to set the same time slots for doctors on some day based on monthly schedule
>   - we store only created slots by doctors themselves, based on list of booked slot per each single day client will be able to render free slots for booking slots
>   - all validation logic (including not possibility to overlap visits) should be handled on client side and will be implemented on server side as well before storing 
>   - implement overlap validation as model validation that will bw working on DB layer as well
> - create `Appointment` model

**4. Create Data Storage:**
- Decide on the database system to store the data. Common choices include PostgreSQL, MySQL, SQLite, or NoSQL databases like MongoDB.

**5. API Endpoints:**
> - define the API endpoints based on the requirements.
> - create CRUD endpoints for ability to manage available slot in doctors schedule
> - use `Alba` gem for serialization
>   - potentially we can convert oll keys to `lowerCamelCase` adding one command in base serializer

**6. Implement the API:**
- Write the code to create these API endpoints, using the chosen programming language and framework.
- Ensure that the API follows RESTful principles (HTTP methods like GET, POST, PUT, DELETE, status codes, etc.).

**7. Authentication and Authorization:**
> - Implement user authentication to ensure only authorized users can book or modify appointments.
> - use `JWT` gem to authentication users
> - create simple `login` endpoint to authenticate current user by JWT
> - use `Pundit` gem to authorise users permissions

**8. Validation and Error Handling:**
> - add validation for incoming data to prevent invalid bookings or data corruption.
>   - use `Dry-validation` gem
>     - add addition DRY rules for cases when slots time data is not valid
> - implement robust error handling to provide meaningful error messages through whole API.
>   - we are able not pass error message to response body if we don't want to show any internal errors in clients

**9. Documentation:**
- Create a README.md file that explains how to run and use the service.
- Include clear and concise instructions on how to set up the environment, run the service, and interact with the API.

**10. Testing:**
- Write unit tests to ensure the reliability of your code. Tools like pytest, Mocha, or Jasmine can be helpful for testing.

**11. Deployment:**
- Deploy the service to a server or a cloud platform of your choice, such as AWS, Heroku, or a Docker container.

**12. Future Improvements:**
- Consider additional features or improvements, such as notifications, email confirmations, or an admin interface.

**13. Final Testing:**
- Before launching the service, thoroughly test it to make sure it meets the minimal expectations and any additional features you've implemented.

**14. Security Considerations:**
- Pay attention to security best practices, especially when handling patient information. This includes data encryption, secure storage, and compliance with data protection regulations.

**15. Performance Optimization:**
- Ensure the service can handle a reasonable amount of traffic and optimize performance as needed.

**16. Scale:**
- Think about how the service can be scaled in the future to accommodate a growing number of users and doctors.

Remember that the exact implementation details will depend on the programming language and framework you choose. Regularly test your API throughout development and seek feedback from others to ensure it meets the clinic's requirements. Good luck with your assessment!