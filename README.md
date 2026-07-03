# Lumière Premiere — Cinematic Release API Backend

This is the decoupled API backend for **Lumière Premiere**, a premium cinematic movie-launch website. It provides endpoint services for film listings, spotlight launches, newsletter subscriptions, and VIP/Press red-carpet invite requests.

---

## 🛠️ Tech Stack & Architecture

* **Framework**: [Laravel 13](https://laravel.com) / PHP 8.4
* **Database**: SQLite (stored in `database.sqlite` / persistent volume mount)
* **Web Server**: Apache (Docker-containerized)
* **ORM**: Eloquent ORM

---

## 📡 API Endpoints Reference

All API responses return standard JSON format.

### 1. Films & Campaigns

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| **GET** | `/api/films` | Retrieves all upcoming film campaigns and release dates. |
| **GET** | `/api/films/featured` | Retrieves the current spotlight launch campaign. |
| **GET** | `/api/films/{slug}` | Retrieves complete details (logline, synopsis, cast, trailer, and stills gallery) for a single film. |

### 2. Form Submissions

| Method | Endpoint | Body Parameters | Description |
| :--- | :--- | :--- | :--- |
| **POST** | `/api/contact` | `name`, `email`, `company`, `subject`, `message` | Submit press or VIP red-carpet credential requests. |
| **POST** | `/api/newsletter` | `email` | Subscribe to the Lumière Inner Circle newsletter list. |

---

## 🚀 Local Development Setup

### Prerequisites
* PHP >= 8.3
* Composer
* SQLite3

### Steps
1. **Clone & Navigate**:
   ```bash
   cd /home/rhodah/Desktop/lumiere-backend
   ```
2. **Environment File**:
   Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```
3. **Install Dependencies**:
   ```bash
   composer install
   ```
4. **Generate Application Key**:
   ```bash
   php artisan key:generate
   ```
5. **Database Initialization**:
   Create the database file:
   ```bash
   touch database/database.sqlite
   ```
   Run migrations and seed the cinematic data:
   ```bash
   php artisan migrate --seed
   ```
6. **Start Dev Server**:
   ```bash
   php artisan serve --port=8000
   ```
   The backend API will be listening at `http://localhost:8000`.

---

## 🐳 Docker & Render Deployment

We containerize this application using a production-ready PHP 8.4 Apache setup.

* **`Dockerfile`**: Compiles GD, PDO, and SQLite dependencies, sets the Apache virtual root to `/public`, and configures directory permissions.
* **`docker-entrypoint.sh`**: Runs automatically on start, touching the database file, running migrations, and seeding the database if empty.
* **Persistent Storage**: Render is configured to mount a persistent disk at `/var/data` containing the `database.sqlite` file to persist subscriber data across deployments.

For detailed Render configuration and environment variables setup, refer to **[RENDER_DEPLOYMENT.md](./RENDER_DEPLOYMENT.md)**.
