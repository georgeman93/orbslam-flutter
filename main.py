#!/usr/bin/env python3

"""
This is a simple test script to test the websocket server to send data to the flutter desktop app 

We will setup a websocket and send imu, gps and depth data to the app at a fixed rate 
"""

import asyncio
import websockets
import json
import time
import random
import logging
import multiprocessing, queue as q

logging.basicConfig(
    format="%(message)s",
    level=logging.DEBUG,
)


async def handler(websocket, path):
    print("New connection")

    while True:
        try:
            try:
                print(f'From queue: {queue.get(timeout=1)}')
            except q.Empty:
                pass
            imu_data = {"roll": random.uniform(0, 360), "pitch": random.uniform(0, 360), "yaw": random.uniform(0, 360),
                        "xaccel": random.uniform(-2, 2),
                        "yaccel": random.uniform(-2, 2),
                        "zaccel": random.uniform(-2, 2)
                        }
            gps_data = {"lat": random.uniform(0, 360), "lon": random.uniform(0, 360), "sats": random.randint(0, 12)}
            depth_data = {"depth": random.uniform(0, 360)}
            wifi_data = {"status": "connected"}
            data = {"imu": imu_data, "gps": gps_data, "depth": depth_data, "wifi": wifi_data}
            await websocket.send(json.dumps(data))
            print("sent data")
            await asyncio.sleep(0.5)
            # since await websocket.recv() blocks when no data is available
            # we can use a timeout
            try:
                recieved_data = await asyncio.wait_for(websocket.recv(), timeout=0.5)
                print(f"Recieved {recieved_data}")
            except asyncio.TimeoutError:
                pass
        except websockets.ConnectionClosed:
            print(f"Websocket {websocket} closed with status {websocket.close_code}")
            return


def start_websocket_server(process_queue):
    global queue
    queue = process_queue
    print('starting async stuff')
    start_server = websockets.serve(handler, "localhost", 8080)
    asyncio.get_event_loop().run_until_complete(start_server)
    print("Server running")
    asyncio.get_event_loop().run_forever()


if __name__ == '__main__':
    queue = multiprocessing.Queue()
    # start websocket server in a new process
    p = multiprocessing.Process(target=start_websocket_server, args=(queue,))
    p.start()
    while True:
        time.sleep(1)
        message = queue.put("hello")
