# Deploying Laravel Backend to Render

This guide provides step-by-step instructions for deploying your Laravel API backend to Render using Docker and a persistent SQLite database.

---

## Prerequisite Files Added
We have added a custom `Dockerfile` and `docker-entrypoint.sh` directly to your `backend/` directory. These files handle:
1. Installing system dependencies & PHP extensions.
2. Setting Apache Document Root to Laravel's `/public` folder.
3. Automatically creating, migrating, and seeding your SQLite database on startup if it's empty.

---

## Step 1: Create a Render Web Service
1. Log in to your [Render Dashboard](https://dashboard.render.com/).
2. Click **New +** and select **Web Service**.
3. Connect your GitHub repository.
4. Set the following settings:
   - **Name**: `lumiere-backend` (or your choice)
   - **Environment**: `Docker`
   - **Root Directory**: `backend` *(This tells Render to build only the backend folder)*
   - **Branch**: `main` (or your active development branch)

---

## Step 2: Configure a Persistent Disk
Since we are using an SQLite database, we need a persistent storage mount to prevent data from being wiped on redeployments or container restarts.
1. Scroll down to the **Disks** section in Render.
2. Click **Add Disk**.
3. Configure the disk settings:
   - **Name**: `lumiere-db`
   - **Mount Path**: `/var/data`
   - **Size**: `1 GB` (More than enough for mock logs/form data)

---

## Step 3: Configure Environment Variables
Navigate to the **Environment** tab in your Render Web Service settings and add the following variables:

| Key | Value | Notes |
|---|---|---|
| `APP_ENV` | `production` | Enables production mode |
| `APP_DEBUG` | `false` | Disables debug mode for security |
| `APP_KEY` | `base64:YOUR_GENERATED_KEY_HERE` | Run `php artisan key:generate` locally or generate a base64 key |
| `DB_CONNECTION` | `sqlite` | Specifies SQLite connection |
| `DB_DATABASE` | `/var/data/database.sqlite` | Points to the persistent mount path |

---

## Step 4: Deploy and Link to Vercel
1. Render will automatically build the Docker image and start the Web Service.
2. Once the deployment completes successfully, copy your **Render Web Service URL** (e.g., `https://lumiere-backend.onrender.com`).
3. Go to your **Vercel Dashboard** for your frontend deployment:
   - Add/Update the Environment Variable (e.g., `NEXT_PUBLIC_API_URL` or equivalent API route prefix in your code) to point to the live Render URL.
   - Redeploy or update environment configuration on Vercel.
