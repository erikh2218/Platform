# Platform Project

This project is a web application built with a microservices-like architecture using Docker. It consists of three main components:
- An application container (`app_container`) running a Node.js frontend.
- A core services container (`core_container`) running a PHP backend with SQL Server connectivity.
- An Nginx container (`publisher`) acting as a web server and reverse proxy.
These services are orchestrated using Docker Compose.

## Project Structure

- **`app_container`**: This container houses the Node.js frontend application. The source code for this application is likely located in the `platform_app` directory.
- **`core_container`**: This container runs the backend services using PHP-FPM. It is responsible for business logic and can connect to a SQL Server database for data persistence. The source code for this service is likely located in the `platform_core` directory.
- **`nginx_container` (referred to as `publisher` in `compose.yml`)**: This container uses Nginx to act as the web server. It serves the static assets for the frontend application and acts as a reverse proxy, forwarding dynamic requests to the `core_container` (PHP-FPM backend).

## Docker Setup

The application is defined and managed using Docker Compose, with the configuration specified in the `compose.yml` file. This file orchestrates the building and running of the following services:

- **`core`**: The backend service container running PHP-FPM.
- **`app`**: The frontend service container running Node.js.
- **`publisher`**: The Nginx web server and reverse proxy.

These services communicate with each other over a custom bridge network named `platform-network`. This network isolates the application components and allows them to discover and interact with each other by their service names.

### Entrypoint Scripts

Both the `app_container` (Node.js frontend) and `core_container` (PHP backend) utilize custom `entrypoint.sh` scripts to manage their startup sequences. These scripts typically perform tasks such as:

-   **Initial Setup:** Running prerequisite commands or configurations before the main application starts.
-   **Environment Configuration:** Applying environment variables or dynamically generating configuration files.
-   **Starting the Application:** Launching the primary process for the container (e.g., starting the Node.js server for `app_container` or PHP-FPM for `core_container`).

If you need to understand the detailed startup process for either of these containers, or if you wish to customize their behavior, you can inspect the respective `entrypoint.sh` scripts located within their source directories (`app_container/entrypoint.sh` and `core_container/entrypoint.sh`).

## Getting Started

Follow these steps to build, run, and access the application:

1.  **Environment Configuration:**
    The `core_container` (PHP backend) requires an environment file for its configuration, typically located at `core_container/platform_core/.env`. This file contains sensitive information like database credentials and other environment-specific settings.
    *   If a sample environment file (e.g., `.env.example`) is provided in the `core_container/platform_core/` directory, copy it to `.env`:
        ```bash
        cp core_container/platform_core/.env.example core_container/platform_core/.env
        ```
    *   Then, review and update `core_container/platform_core/.env` with your specific configuration details (e.g., database host, username, password).
    *   If no sample is provided, you will need to create `core_container/platform_core/.env` manually based on the project's requirements for the PHP backend.

2.  **Build and Run the Application:**
    Open your terminal, navigate to the project's root directory (where the `compose.yml` file is located), and run the following command to build the Docker images and start the services in detached mode:
    ```bash
    docker-compose up -d --build
    ```

3.  **Access the Application:**
    *   **Frontend (Node.js application):** Once the containers are running, you can access the frontend application by navigating to `http://localhost:8080` in your web browser.
    *   **Backend (PHP services via Nginx):** The backend services are proxied through Nginx. For example, if you have a backend endpoint at `/api/users`, it might be accessible via `http://localhost/core/api/users`. (The exact paths will depend on the PHP application's routing in `platform_core/public/index.php`).

4.  **Stop the Application:**
    To stop all running services and remove the containers, networks, and volumes created by `docker-compose up`, run the following command from the project's root directory:
    ```bash
    docker-compose down
    ```
    If you want to stop the services without removing the volumes (to preserve data like database content if applicable), you can use:
    ```bash
    docker-compose stop
    ```

## Configuration

This project has several key configuration files that you might need to inspect or modify for advanced customization:

-   **Nginx Configuration:**
    -   `nginx_container/default.conf`: Defines the server blocks for Nginx, including how requests are handled for the frontend (port 8080) and how backend requests to `/core/` are proxied to the PHP-FPM service. This is the primary file for modifying Nginx's request handling behavior, SSL setup (if added), and other server-specific settings.
    -   `nginx_container/nginx.conf`: The main Nginx configuration file. It includes global settings for Nginx, such as worker processes, logging, and includes other configuration files (like `default.conf`). Modifications here are less common for typical application behavior changes.

-   **PHP-FPM Configuration:**
    -   `core_container/conf/www.conf`: The PHP-FPM pool configuration file. This file controls settings for the PHP-FPM process manager, such as user/group, listen address, process management (e.g., number of child processes), and environment variables passed to PHP scripts.

-   **OpenSSL Configuration:**
    -   `core_container/conf/openssl.cnf`: Contains default settings for OpenSSL, which might be used by PHP for generating self-signed certificates or other cryptographic operations if the application requires it. For typical local development, direct modification of this file is usually not necessary unless specific SSL/TLS behaviors are being customized for the PHP environment.

-   **Backend Application Environment:**
    -   `core_container/platform_core/.env`: This is a critical file for the PHP backend application. It stores environment-specific variables such as database connection details (host, port, username, password, database name), API keys, application mode (development, production), and other settings that the PHP application (likely a framework like Laravel or Symfony) uses to configure itself. **This file is not version controlled and must be configured for your specific environment.**

-   **Frontend Application Configuration:**
    -   The `app_container/platform_app/` directory contains the Node.js frontend application. Its configuration is managed through standard Node.js practices:
        -   `package.json`: Defines project dependencies, scripts (for building, serving, testing), and other metadata.
        -   Framework-specific files: If the frontend uses a framework (e.g., React, Angular, Vue), there will be additional configuration files specific to that framework (e.g., `vue.config.js`, `angular.json`, or environment files like `.env.development` for Create React App).
        -   Build and runtime configurations for the Node.js environment (e.g., port, API endpoints it connects to) would be managed within the application code or through environment variables passed to the `app` service in `compose.yml`.

## Contributing

Contributions to this project are welcome. Please follow standard practices such as:
- Forking the repository.
- Creating a new branch for your feature or bug fix.
- Ensuring your code is well-tested and documented.
- Submitting a pull request with a clear description of your changes.
