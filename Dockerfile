FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y \
    build-essential \
    curl \
    jq
RUN curl https://sh.rustup.rs/ -sSf | bash -s -- -y
COPY . /app
COPY generated/.tailcallrc.schema.json /app/generated/.tailcallrc.schema.json
WORKDIR /app
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs/ | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN cargo build --release && \
    ls /app/target/release/ && \
    cp /app/target/release/tailcall /root/.tailcall/bin/


ENV PATH="/root/.tailcall/bin:${PATH}"