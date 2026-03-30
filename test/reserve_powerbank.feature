# Copied from TPC#2 (Daria Mahdych, up202310175)
# User Story 1 - Reserve a PowerBank before arriving

Feature: Reserve a PowerBank before arriving
  As a user whose phone battery is almost empty,
  I want to reserve an available PowerBank near me,
  so that I can be sure it will still be available when I arrive at the station.

  Scenario: Successful reservation
    Given a PowerBank is available
    When a user reserves the PowerBank
    Then the system marks the PowerBank as reserved
    And the reservation timer starts

  Scenario: Reservation expiration
    Given a PowerBank is reserved
    When the user does not pick it up within 10 minutes
    Then the reservation is cancelled
    And the PowerBank becomes available again

  Scenario: Reservation unavailable
    Given a PowerBank is already reserved
    When a user tries to reserve it
    Then the system shows that the PowerBank is unavailable
