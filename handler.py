import runpod
import json
import requests


def handler(event):
    """
    This is the handler function that will be called by RunPod serverless.
    """
    job_input = event['input']

    r = requests.post(
        'http://127.0.0.1:11434/api/chat',
        headers={
            'Content-Type': 'application/json'
        },
        data=json.dumps(job_input)
    )

    return {
        "message": "Hello, world!",
        "event": json.dumps(event),
        "resp": r.json()
    }


if __name__ == '__main__':
    runpod.serverless.start({'handler': handler})