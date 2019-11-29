FROM golang:1.13

RUN go get -u github.com/go-delve/delve/cmd/dlv
RUN mkdir app
WORKDIR /app
COPY . .

RUN go build -gcflags "all=-N -l" -o ./webapp
RUN chmod +x webapp

EXPOSE 40000
EXPOSE 8080

CMD dlv --listen=:40000 --headless=true --api-version=2 --accept-multiclient exec ./webapp --continue