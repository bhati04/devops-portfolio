FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci --only=production

FROM node:20-alpine

RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules

COPY app.js .
COPY public ./public
COPY views ./views

USER nodejs

EXPOSE 3000

CMD ["node", "app.js"]
