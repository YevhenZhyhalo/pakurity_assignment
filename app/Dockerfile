FROM rust:1.72

WORKDIR /usr/src/app
COPY . .

RUN cargo install --path .

CMD ["app"]
