# Product Requirement Document (PRD) - Ghost Coder

## 1. Product Overview
**Ghost Coder** is a system-wide background utility application designed for software developers, tech content creators, and programming educators. It allows users to simulate typing any pre-written codebase in real-time inside their preferred IDE (like VS Code or Xcode) by typing arbitrary keys on their keyboard. 

This enables creators to record seamless, error-free coding timelapses and presentations where the simulator (e.g., iOS Simulator running Flutter Hot Reload) updates dynamically as they "type".

---

## 2. Problem Statement
Writing code live during a tutorial or presentation is prone to syntax errors, spelling mistakes, and typing delays. Additionally, recording an AI-generated codebase step-by-step to show real-time hot reload progress is tedious, requiring manual line-by-line copying and pasting.

---

## 3. Goals & Objectives
*   **Seamless Illusion:** Provide a natural-looking typing flow in any IDE while actually outputting pre-written source code.
*   **Real-time Hot Reload Compatibility:** Feed the correct code directly into the real files on disk, allowing compilers/watchers to automatically reload the app.
*   **Zero-UI Stealth Mode:** Once activated, the Ghost Coder interface stays hidden in the background, allowing the user to focus solely on their IDE.
*   **Cross-Platform Portability:** Launch initially for macOS (MVP), with an architecture ready to compile for Windows.

---

## 4. Target Audience
*   **Tech Content Creators:** YouTubers, TikTokers, and reels creators who make coding timelapses.
*   **Programming Educators:** Teachers who want to show clean, step-by-step live-coding demonstrations.
*   **Junior Developers/Learners:** Students who want to present their AI-collaborative projects with smooth live builds.

---

## 5. Key Features (MVP)

### 5.1. File Drop & Target Configuration
*   **Source File Dropzone:** A drag-and-drop interface in the GUI to load the completed target file (e.g., `dashboard_view.dart`).
*   **Destination File Mapping:** Select the active working file inside the target project workspace.

### 5.2. Stealth Background Runner
*   **Global Hotkey Toggle:** A system-wide shortcut (e.g., `Cmd + Shift + G`) to toggle Ghost Mode ON or OFF without leaving the IDE.
*   **Stealth State:** The GUI window automatically minimizes/hides when Ghost Mode is active.

### 5.3. Custom Typing Speeds & Modes
*   **Character Mode:** One physical key press outputs exactly one character of the source code.
*   **Word Mode:** One physical key press outputs an entire word (e.g., `import`, `class`).
*   **Line Mode:** One physical key press outputs a whole line of code.
*   **Custom Speed Slider:** Adjust the number of characters outputted per keystroke to match the user's natural typing speed.

### 5.4. Smart Input Interception
*   **Input Blocking:** Standard alphanumeric keys (`a-z`, `0-9`, symbols, space) are blocked from reaching the IDE and replaced by characters from the source code.
*   **Smart Backspace:** Pressing `Backspace` deletes the last typed character/word and decrements the internal pointer of the source code, keeping the simulator in sync.
*   **Special Keys Passthrough:** Keys like `Cmd + S` (Save), Arrow Keys (Navigation), and `Enter` are passed directly to the IDE to allow normal operations.

---

## 6. User Flow
1.  User opens **Ghost Coder GUI**.
2.  User drops their completed source code file (`dashboard_view.dart`) and maps it to their active IDE working file.
3.  User configures the typing speed (e.g., 3 characters per keystroke).
4.  User clicks **Start Ghost Mode** (GUI hides).
5.  User focuses on VS Code and starts typing randomly.
6.  The correct source code appears letter-by-letter in VS Code, triggering auto-save and Flutter Hot Reload on the iOS Simulator.
7.  User presses `Cmd + Shift + G` to stop Ghost Mode.

---

## 7. Future Scope (Post-MVP)
*   **Multi-File Projects:** Support running Ghost Mode across multiple files sequentially.
*   **Automated Hot Reload Triggering:** Programmatic control of saving files to enforce hot reload.
*   **Audio/Typing Sound Effects:** Play synthetic keyboard clicking sounds matching the speed of the outputted code.
