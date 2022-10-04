# ORBSLAM with Flutter App >>>> Resume Fodder

## What is this?

I wanted to learn about ORBSLAM and take the opportunity to explore ways of streaming images from an openCV script to a Flutter app. 
I also wanted to demonstrate some of the ideas I have become familiar with such as openCV, websockets, asyncio, and flutter.  

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
