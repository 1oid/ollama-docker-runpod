import runpod
import json
import requests


def handler(event):
    """
    This is the handler function that will be called by RunPod serverless.
    """
    job_input = event.get('input', None)
    job_route_path = event.get('path', '/api/generate')

    if job_input is None:
        return {
            'status': 500,
            'message': 'input is null'
        }


    r = requests.post(
        'http://127.0.0.1:11434' + job_route_path,
        headers={
            'Content-Type': 'application/json'
        },
        data=json.dumps(job_input, ensure_ascii=False)
    )

    return {
        "resp": r.json(),
        "status": 200,
        "message": "success"
    }


if __name__ == '__main__':
    runpod.serverless.start({'handler': handler})