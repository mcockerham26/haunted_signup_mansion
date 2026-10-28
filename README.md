Liban Mohamed
10/26/2026
Csc 4360

Optional Challenge: Navigation
Fixed Category: password_help



Validation Tests
----------------
Empty Name → Error
Empty Email → Error
Invalid Email → Error
Password < 6 Characters → Error
Valid Input → Success


Local Tip Tests
----------------
Get Signup Tip → Success
Test Error State → Error Message
Retry → Success


Question one: Trace the local tip feature from button tap to displayed text. Which widget/state changes during the simulated loading state, and how does the user recover from the local error case?


When the user presses the Get Tip button, the app updates its state to show a loading indicator. After a delay, a preset signup tip is displayed from a local list stored in the application. If an error state is triggered, an error message appears and a Retry button allows the user to run the tip feature again without restarting the app.

Question three: Which fixed local category selects the tip, and what form information does the feature deliberately ignore? Why?


The fixed category used is password_help. The feature ignores all form information including the user's name, email address, and password. I did it like this to maintain privacy and ensure the tip system remains independent from form validation and account approval decisions.