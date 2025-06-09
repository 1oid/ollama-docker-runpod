FROM nvidia/cuda:12.1-runtime-ubuntu22.04
ENV OLLAMA_HOST=0.0.0.0:11434
WORKDIR /app

COPY . .

RUN echo RlJPTSAuL0VaLVBvQy1MbGFtYS0zLjEtOEIuUTVfS19NLmdndWYKClNZU1RFTSAiBuULz/BsYhB5YW1sIHBvY9L2DOrU3nlhbWxwbgwN1N521iIKClRFTVBMQVRFICIiInt7IGlmIC5TeXN0ZW0gfX08fHN0YXJ0X2hlYWRlcl9pZHw+c3lzdGVtPHxlbmRfaGVhZGVyX2lkfD4KCnt7IC5TeXN0ZW0gfX08fGVvdF9pZHw+e3sgZW5kIH19e3sgaWYgLlByb21wdCB9fTx8c3RhcnRfaGVhZGVyX2lkfD51c2VyPHxlbmRfaGVhZGVyX2lkfD4KCnt7IC5Qcm9tcHQgfX08fGVvdF9pZHw+e3sgZW5kIH19PHxzdGFydF9oZWFkZXJfaWR8PmFzc2lzdGFudDx8ZW5kX2hlYWRlcl9pZHw+Cgp7eyAuUmVzcG9uc2UgfX08fGVvdF9pZHw+IiIiCgpQQVJBTUVURVIgc3RvcCAiPHxzdGFydF9oZWFkZXJfaWR8PiIKUEFSQU1FVEVSIHN0b3AgIjx8ZW5kX2hlYWRlcl9pZHw+IgpQQVJBTUVURVIgc3RvcCAiPHxlb3RfaWR8PiIKUEFSQU1FVEVSIHN0b3AgIjx8cmVzZXJ2ZWRfc3BlY2lhbF90b2tlbiIKCgpQQVJBTUVURVIgdGVtcGVyYXR1cmUgMA== | base64 -d > poc.mf


RUN apt-get update && apt-get install -y \
    curl \
    wget \
    python3 \
    python3-pip \
    python3-venv \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://ollama.com/install.sh | sh
RUN pip3 install --no-cache-dir -r requirements.txt
EXPOSE 11434

RUN wget "https://huggingface.co/EZTEAM/EZ-PoC-Llama-3.1-8B-GGUF/resolve/main/EZ-PoC-Llama-3.1-8B.Q5_K_M.gguf"

RUN nohup bash -c "ollama serve &" && sleep 5 && ollama create poc-llama3.1-8bq5km -f poc.mf

CMD ["python3", "-u", "handler.py"]