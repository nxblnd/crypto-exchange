FROM node AS builder

WORKDIR /converter
COPY src/ /converter/src/
COPY public/ /converter/public/
COPY index.html package.json package-lock.json *.config.js /converter/
RUN npm ci
RUN npm run build


FROM nginx

COPY --from=builder /converter/dist /usr/share/nginx/html