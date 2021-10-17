<p align="center">
  <a href="#" rel="noopener">
 <img src="web/app/static/assets/images/logo_medium.png" alt="SwasthyaLoop-logo"></a>
</p>

<center>

[![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](https://www.python.org/)
[![made-with-flutter](https://img.shields.io/badge/Made%20with-Flutter-blue)](https://www.python.org/)
![Contributions welcome](https://img.shields.io/badge/contributions-welcome-orange.svg)
[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/sindresorhus/awesome#readme)

</center>

<hr>

## About

*__This project tries to solve for Good Health & Wellbeing, which is one of the United Nations Sustainable Development Goals working towards eliminating the struggle of availing medical treatment during the time of need. Due to COVID and even otherwise, getting hospital beds is really difficult, at least in a crowded city like Mumbai.__*

<hr>

## What are we making

Here's our demo video

[![video](https://img.youtube.com/vi/mKNpqt8nPXE/0.jpg)](https://youtu.be/mKNpqt8nPXE)

<hr>

## How to run

#### Setting up the environment

- Firebase project setup
    - Create an app on firebase
    - Follow the official guide for android and ios to integrate with the flutter app
    - Download `firebase_key.json` (yes, rename it to firebase_key.json) and paste it in `web/env`
    - Create a `.env` file in the same (`web/env`) folder with the following contents:
        - ```
            # leave firebase_key as it is
            firebase_key=env/firebase_key.json
            firebase_route=<YOUR-FIREBASE-ROUTE>
            ```

#### Backend and Hospital Web App

- ```sh 
        # First let's install the dependencies
        cd backend
        pip install -r requirements.txt
        # Now let's start our db server
        python fb_db.py
        # Finally, the web app
        python run.py
    ```

- Now, after successfully running the db server, you'll see `{"status": "fine"}` messagge on `http://127.0.0.1:8080`

- And once the flask app starts, please visit `http://127.0.0.1:5000/`, after login, you'll see a dashboard as follows:
    <img src='static/web_app.png'>


### Flutter App

- The base directory is `app/swasthyaloop`
- Open the folder in any ide of your choice, connect your phone/emulator and run the `main.dart` file.

*PS: Grab a cup of coffee, it takes some time to build*

- Once the app is built successfully, you'll see a welcome screen and post login:
<p  align = "center">
 <table>
   <tr>
    <td><img src="static/app_screen_1.jpg" width=270 height=480></td>
    <td><img src="static/app_screen_2.jpg" width=270 height=480></td>
    <td><img src="static/app_screen_3.jpg" width=270 height=480></td>
  </tr>
</table>
</p>

<hr>

### Contributors
- [Dhruv-Sachdev1313](https://github.com/Dhruv-Sachdev1313)
- [Harshita-Kanal](https://github.com/Harshita-Kanal)
- [shintan777](https://github.com/shintan777/)
-  [ADI10HERO](https://github.com/adi10hero/)

<hr>

## Recognition
This repository/project is a submission to [DSC Solution Challenge 2021](https://developers.google.com/community/dsc-solution-challenge).

## References
- [Hospital Capacity and Availability Info](https://arogya.maharashtra.gov.in/pdf/Cat%20I%20Facility%2020%20March%202021.pdf) 
- List of Prominent Hospitals in Mumbai, i.e. Our [Hospital Dataset](https://arogya.maharashtra.gov.in/1166/List-of-Prominent-Hospitals-in-Mumbai?format=print)
- [Flutter App UI Motivation](https://github.com/mlayah/healthapp_ui)
- [Jinja Material Lite Wpx](https://appseed.us/jinja-template/jinja-template-material-lite)

<center>
<footer>
Made with ❤️ by Team <strong>Change Makers</strong>
</footer>
</center>