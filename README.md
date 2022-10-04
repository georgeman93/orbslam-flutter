# ORBSLAM with Flutter App ➡️ Resume Fodder

## What is this?

I wanted to learn about ORBSLAM and take the opportunity to explore ways of streaming images from an openCV script to a Flutter app. 
I also wanted to demonstrate some of the ideas I have become familiar with such as openCV, websockets, asyncio, and flutter.  

FYI, Its a work in progress. 

## Setup 

### Image Processing 

Activate virtual environment

```bash
source env/bin/activate
```

Install python dependencies (produced by `pip freeze > requirements.txt`)
    
```bash
pip3 install -r requirements.txt
```

### Flutter app 

Follow the flutter setup instructions [here](https://docs.flutter.dev/get-started/install)


## How to run

Launch the flutter app

```bash
flutter run -d chrome
```

Launch the image processing script and websocket server

```bash
python3 main.py
```

# TODO 
- [ ] Verify the websockets image stream is the way to go
- [ ] Connect the slam script to the python servo 
- [ ] Give the flutter app a basic UI
- [ ] Setup the app to receive the slam data and image feed
- [ ] Continue building the slam algorithm 
- [ ] Brainstorm ways to connect the flutter app to the slam script 
- [ ] Make the app look fancy 
- [ ] Keep going to explore ORBSLAM, image/video streaming, command and control feedback with flutter



