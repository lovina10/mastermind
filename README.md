# Mastermind
An iOS app version of the code-breaking game known as Mastermind

### To Run This Project
Note: This project is written in Swift and must be opened with Xcode on a macOS operating system.
1) Clone this project onto your computer.
2) cd into the project's directory.
3) Once inside the project directory, run `pod install` on the command line.
4) Open Mastermind.xcworkspace, which should open the project in Xcode.
5) Build and run the project in Xcode using an iOS simulator.

### How to Play
Play against the computer to guess the random 4-digit code. The code consists of numbers 0 through 7. Duplicate numbers are allowed. After each guess, you will be given one of the following feedback to help you figure out the correct combination:
1) Your guess had a correct number.
2) Your guess had a correct number in a correct location.
3) Your guess is incorrect (has no correct numbers).

You are allowed 10 guesses before the game is over. You may see your history of guesses in the "History" tab.

### How This App Was Built
Many considerations were taken into account to decide the most intuitive presentation of the game. Because user input consists of numbers, there was the option of using the iOS keyboard to select the numbers, which would be coupled with displaying the numbers in text fields. However, possible input was restricted to numbers 0 through 7, so using a numeric keyboard would display two extra numbers 8 and 9, which would confuse the user. To address that problem, I ultimately decided to create eight buttons to represent the eight possible number choices. As the user selects numbers to fill in the four spaces, I wanted to highlight the space that would be changed. To implement this, I chose to display the numbers in text fields instead of labels in order to take advantage of the one of the methods in UITextFieldDelegate. To further enhance user experience, I created a backspace button that mimics the functionality of a keyboard's backspace, and I added a "Clear All" button to allow for an easy reset of the spaces. Stack views were used for ease of displaying the rows of buttons and text fields in a uniform and evenly spaced manner. Views were built using xib files to allow for easy visual setup of the UI. The history of guesses is displayed in a table view on a separate view controller to allow the user to easily read and reference past guesses and their feedback. The user can easily access the history by clicking on the tab bar. This codebase generally follows the MVC design pattern with some alterations for modularity.
