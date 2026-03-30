# TPC3 Development Log  Daria Mahdych  202310175

---

## 1. Goal of the assignment

The goal of this assignment was to automate the acceptance tests for one selected scenario of the mobile application project.

For TPC#3, I selected **User Story 1** from TPC#2:

**As a user, I want to reserve a powerbank before arriving at the station, so that I know one will be available when I get there.**

This story was selected because it contains clear behavior-driven acceptance scenarios and could be implemented and tested with a simplified Flutter prototype.

---

## 2. Documents and materials used

During the development of TPC#3, I used the following materials:

1. **TPC#2 – User Stories for the Mobile App**
    - Main source used to select the user story and extract the acceptance scenarios.
    - In particular, I used User Story 1: *Reserve a PowerBank before arriving*.
    - I also used the BDD acceptance tests defined in that document:
        - Successful reservation
        - Reservation expiration
        - Reservation unavailable

2. **TPC#1 / prototype material**
    - Used as a reference for the basic structure of the mobile application and for the simplified prototype approach.
    - The final implementation for TPC#3 was not a complete production application, but a minimal prototype focused only on the selected scenario.

3. **TPC#3 assignment statement**
    - Used to identify the required deliverables:
        - a GitHub commit link,
        - a development log,
        - a short video showing the tests running.

4. **Lecture material / course concepts**
    - Acceptance testing
    - BDD / Given-When-Then structure
    - Agile validation of expected user behavior

---

## 3. Why a simplified prototype was used

The full mobile application is not yet completed.  
Because of that, I implemented a **minimal Flutter prototype** containing only the screens, model, and logic necessary to validate the selected acceptance scenarios.

This decision is consistent with the objective of TPC#3, which is to **verify and validate one single scenario using automated acceptance tests**, rather than to deliver the full application.

Therefore, the focus of this work was not completeness of the app, but correctness of the tested behavior.

---

## 4. Selected acceptance scenarios

From TPC#2, I automated the following acceptance scenarios for User Story 1:

### Scenario 1 – Successful reservation
- Given a PowerBank is available
- When a user reserves the PowerBank
- Then the system marks the PowerBank as reserved
- And the reservation timer starts

### Scenario 2 – Reservation expiration
- Given a PowerBank is reserved
- When the user does not pick it up within 10 minutes
- Then the reservation is cancelled
- And the PowerBank becomes available again

### Scenario 3 – Reservation unavailable
- Given a PowerBank is already reserved
- When a user tries to reserve it
- Then the system shows that the PowerBank is unavailable

These scenarios were taken directly from the TPC#2 document and adapted into Flutter widget tests.

---

## 5. Inputs and outputs of the work

### Inputs
The main inputs of the work were:
- the TPC#2 document with the selected user story and acceptance tests;
- the initial prototype structure already available in the project;
- the assignment requirements from TPC#3;
- the manual decisions taken during implementation to simplify the UI and keep only the necessary behavior.

### Outputs
The final outputs of the work were:
- a simplified but runnable Flutter prototype;
- automated widget tests for the selected acceptance scenarios;
- a reservation timer with expiration logic;
- a development log;
- a GitHub commit containing the implementation;
- a short video showing the tests running successfully.

---

## 6. Personal tasks performed

The main personal tasks carried out during this assignment were:

1. Read the TPC#3 assignment instructions and identify the required deliverables.
2. Review the TPC#2 document and choose one user story suitable for automated acceptance testing.
3. Identify the acceptance scenarios written in BDD style.
4. Review the Flutter prototype structure already available.
5. Decide which parts of the app were strictly necessary for the selected scenario.
6. Implement or adapt the PowerBank model.
7. Implement or adapt the map/list screen.
8. Implement the reservation success screen.
9. Add real countdown behavior for reservation expiration.
10. Create automated widget tests for each acceptance scenario.
11. Run the tests repeatedly in PowerShell.
12. Fix syntax errors, widget test issues, and unstable assertions.
13. Validate the final version when all tests passed.
14. Prepare the log and the submission materials.

---

## 7. Files used and what each one is for

### `lib/models/powerbank.dart`
Purpose:
- Represents the PowerBank entity used in the tests.
- Stores the minimum required data:
    - id
    - battery percentage
    - station name
    - reservation status

Why it is needed:
- The tests need a simple domain model to represent available and reserved PowerBanks.

### `lib/screens/map_screen.dart`
Purpose:
- Displays the list of PowerBanks.
- Allows the user to press the reserve button.
- Handles two behaviors:
    - reserve an available PowerBank,
    - show an unavailable message when the PowerBank is already reserved.

Why it is needed:
- This is the main interaction screen for the selected scenario.

### `lib/screens/reservation_success_screen.dart`
Purpose:
- Shows the reservation confirmation state.
- Starts and displays the countdown timer.
- Cancels the reservation when the timer expires.

Why it is needed:
- This screen is essential to validate Scenario 1 and Scenario 2.

### `test/reserve_powerbank_test.dart`
Purpose:
- Contains the automated widget tests for the selected scenario.

Why it is needed:
- This is the core deliverable of TPC#3.



---

## 8. Tools used

The following tools were used during development:

- **Flutter**
- **Dart**
- **flutter_test**
- **Visual Studio Code**
- **PowerShell**
- **Git**
- **GitHub**


During the development process, I used AI assistance to:

- clarify how to implement acceptance tests in Flutter;
- fix syntax and structure issues in Flutter files;


---


## 09. GitHub commit link



The following commands were used during development and validation:

```bash
flutter pub get
flutter test
flutter test test/reserve_powerbank_test.dart
git add .
git commit -m "TPC3: acceptance tests for PowerBank reservation"
git push

