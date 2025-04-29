# Networking Compass App - README

## Overview

This document outlines the development plan for a cross-platform networking application focused on connecting professionals in a proximity-based and privacy-conscious manner. The app utilizes a unique "Networking Compass" interface to display nearby users, fostering connections and growth within various professional communities.

## Core Features

### 1. User Authentication & Profiles

-   **Signup & Login:** Users must register and authenticate to access the app.
-   **Role Selection:** During signup, users select their professional role (e.g., Looking for Work, Employer, Freelancer, Investor).
-   **LinkedIn Integration:** Users link their LinkedIn profile and optionally other social media accounts.
-   **Secure Data Storage:** User profile data is stored securely.

### 2. Networking Compass View

-   **Dynamic Compass:** The main screen features a compass-style interface displaying nearby users as dots.
-   **Networking Mode:** Users toggle "Networking Mode" to become visible and view others within a configurable range (100m - 1km).
-   **Anonymous Dots:** Users are represented by anonymous dots. Tapping a dot reveals a profile preview.
-   **Directional & Proximity-Based:** No exact GPS data is shown, only relative direction and distance.

### 3. Interaction & Messaging

-   **Full Profile View:** Users can view a full profile after tapping a dot.
-   **Connection & Messaging:** Options to send connection requests or short messages.
-   **Role Filtering:** Users can filter profiles by role (e.g., "Show only Employers").

### 4. Notifications

-   **Proximity Alerts:** Push notifications are sent when another user is in close proximity (e.g., 20m). Example: "Someone interesting is nearby. Tap to connect."

## UI/UX Requirements

-   **LinkedIn Color Palette:** Use LinkedIn's color scheme for a professional look.
-   **Clean Design:** Maintain a modern, clean, and intuitive design.
-   **Smooth Animations:** Implement smooth transitions and animations.
-   **Intuitive Controls:** Provide easy toggles for "Networking Mode" and other settings.
-   **Battery Optimization:** Design for high performance and low battery consumption, especially for location services.

## Tech Requirements

-   **Frontend:** Flutter or React Native for cross-platform compatibility.
-   **Backend:** Firebase or Supabase for real-time database, authentication, and messaging.
-   **Location:** Utilize coarse location services to maintain user privacy.
-   **LinkedIn OAuth:** Integrate LinkedIn's OAuth API for profile linking.
-   **Push Notifications:** Implement push notifications via Firebase.

## Architecture & Code Quality

- Modular, scalable architecture.
- High code quality and maintainability.
- Follow best practices in mobile app development.