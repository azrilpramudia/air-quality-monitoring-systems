include backend/.env .env
export

DB_URL=postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable

.PHONY: up down logs run migrate-up migrate-down sqlc test lint dev

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

run:
	cd backend && go run ./cmd/api

migrate-up:
	migrate -path backend/db/migrations -database "$(DB_URL)" up

migrate-down:
	migrate -path backend/db/migrations -database "$(DB_URL)" down 1

dev:
	cd backend && air

sqlc:
	cd backend && sqlc generate

test:
	cd backend && go test ./...

lint:
	cd backend && golangci-lint run