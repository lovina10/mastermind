# Mastermind
An iOS app version of the code-breaking game known as Mastermind

## To Run This Project
Note: This project is written in Swift and must be opened with Xcode on a macOS operating system.
1) Clone this project onto your computer.
2) cd into the project's directory.
3) This project uses Cocoapods. Run `sudo gem install cocoapods` on the command line if it is not already installed on your computer. You can skip this step if Cocoapods is already installed.
3) Inside the project directory, run `pod install` on the command line.
4) Open Mastermind.xcworkspace, which should open the project in Xcode.
5) Build and run the project in Xcode using an iOS simulator.

## How to Play
Play against the computer to guess the random 4-digit code. The code consists of numbers 0 through 7. Duplicate numbers are allowed. After each guess, you will be given the following feedback to help you figure out the correct combination:
1) You have X numbers in the correct location.
2) You have X numbers in an incorrect location.
3) You have X numbers in the correct location and X numbers in an incorrect location.
3) Your guess has no correct numbers.

You are allowed 10 guesses before the game is over. You can see your history of guesses in the "History" tab.

## How I Built This App
Many considerations were taken into account to decide the most intuitive presentation of the game.
#### Buttons & Text Fields for User Input
Because user input consists of numbers, there was the option of using the iOS keyboard to select the numbers, which would be coupled with displaying the numbers in text fields. However, possible input was restricted to numbers 0 through 7, so using a standard numeric keyboard would display two extra numbers 8 and 9, which would confuse the user. To address that problem, I decided to create eight buttons to represent the eight possible number choices. As the user selects numbers to fill in the four spaces, I wanted to highlight the space that would be changed. To implement this, I chose to display the numbers in text fields instead of labels in order to take advantage of the methods in UITextFieldDelegate. To further enhance user experience, I created a backspace button that mimics the functionality of a keyboard's backspace, and I added a "Clear All" button to allow for an easy reset of the spaces.
#### Stack Views & Table Views for Layout
I used stack views for ease of displaying the rows of buttons and text fields in a uniform and evenly spaced manner. I laid out all views using the interface builder to take advantage of a visual setup of constraints and UI. The history of guesses is displayed in a table view on a separate view controller to allow the user to easily read and reference past guesses and their feedback. I chose to have the user access the guess history via the tab bar, as this seemed to be most visible and convenient place to access another screen.
#### Animation
Label animations were added not only to give the user a more delightful visual experience, but to serve the purpose of allowing the user to see that their input has been registered by the app.
#### Multiple Uses for Same Views
As the screen area of an iOS app is limited, I wanted to make sure that all of the necessary game components were visible and accessible, but not cluttered. As a result, my design choices were based on a minimalistic mindset in which I did not display more elements than what was necessary for the user to play the game smoothly, and certain areas, such as the feedback label, served multiple purposes.
#### Architectural Design Pattern
The game logic was placed in the "Game Manager" to extract the business logic from the view controllers, making it easy for any future view controllers to have access to the game status. The view controllers hold responsibility for the view and presentation. Networking was placed in the Interactor for increased modularity.

## Tradeoffs 
The biggest challenge when building the game was deciding what extra features to include, if any, versus building the basic game that optimized for a smooth and intuitive user experience and making sure that the codebase for that was well-built and versatile. I ultimately chose to have a well-designed minimal viable product built on a maintainable codebase that I can build more features upon.
