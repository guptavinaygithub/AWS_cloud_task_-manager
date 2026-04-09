# --- Builder ---
FROM node:22-alpine AS builder
WORKDIR /app
ENV PATH=/app/node_modules/.bin:$PATH

COPY package*.json ./
RUN npm ci --silent || npm install --silent

COPY . .
RUN npm run build

# --- Production ---
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]