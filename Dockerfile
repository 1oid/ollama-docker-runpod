FROM ollama/ollama:latest
WORKDIR /app

COPY . .

RUN apt update
RUN apt install -y python3 python3-pip wget
RUN pip3 install -r requirements.txt
RUN wget "https://huggingface.co/EZTEAM/EZ-PoC-Llama-3.1-8B-GGUF/resolve/main/EZ-PoC-Llama-3.1-8B.Q5_K_M.gguf"
RUN cat > /app/poc.mf << EOF
FROM ./EZ-PoC-Llama-3.1-8B.Q5_K_M.gguf

SYSTEM "将以下描述转换成yaml poc插件，只返回yaml数据，不返回其他"

TEMPLATE """{{ if .System }}<|start_header_id|>system<|end_header_id|>

{{ .System }}<|eot_id|>{{ end }}{{ if .Prompt }}<|start_header_id|>user<|end_header_id|>

{{ .Prompt }}<|eot_id|>{{ end }}<|start_header_id|>assistant<|end_header_id|>

{{ .Response }}<|eot_id|>"""

PARAMETER stop "<|start_header_id|>"
PARAMETER stop "<|end_header_id|>"
PARAMETER stop "<|eot_id|>"
PARAMETER stop "<|reserved_special_token"
PARAMETER temperature 0
EOF

RUN ollama create poc-llama3.1-8bq5km -f poc.mf

CMD ["python3", "-u", "handler.py"]

