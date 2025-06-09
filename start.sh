#/bin/bash

nohup ollama serve &
sleep 5

echo "Starting handler.py"
python3 -u handler.py