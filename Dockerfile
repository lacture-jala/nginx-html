# Use the official Nginx image from Docker Hub
FROM nginx:latest

# Copy static website content to the Nginx server's default directory
COPY ./html /usr/share/nginx/html

# Expose port 80 so that the container can serve the website
EXPOSE 80

# Run Nginx in the foreground (default behavior)
CMD ["nginx", "-g", "daemon off;"]
