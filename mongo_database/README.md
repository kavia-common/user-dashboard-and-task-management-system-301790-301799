# MongoDB Database - Setup Complete

## Overview
MongoDB database configured for the user dashboard and task management system.

## Connection Information
- **Port:** 5000
- **Database:** myapp
- **Connection String:** `mongosh mongodb://appuser:dbuser123@localhost:5000/myapp?authSource=admin`

## Collections Created

### 1. users
User account information and authentication credentials.

**Indexes:**
- `_id` (default primary key)
- `email` (unique index for authentication and duplicate prevention)

**Structure:**
```javascript
{
  _id: ObjectId,
  email: String (unique),
  password: String (bcrypt hashed),
  name: String,
  createdAt: Date
}
```

### 2. tasks
Task/todo items associated with users.

**Indexes:**
- `_id` (default primary key)
- `userId` (index for efficient user task queries)
- `title_text_description_text` (text index for search functionality)

**Structure:**
```javascript
{
  _id: ObjectId,
  userId: ObjectId (references users._id),
  title: String,
  description: String,
  status: String,
  createdAt: Date,
  updatedAt: Date
}
```

## Index Details

✅ **users.email** - Unique index ensuring no duplicate emails
✅ **tasks.userId** - Regular index for filtering tasks by user
✅ **tasks text index** - Full-text search on title and description fields

## Development Seed Data

A development user has been created:
- Email: dev@example.com
- Name: Dev User
- Password: (bcrypt hashed - update in your application)

## Environment Variables

The following environment variables are configured in `db_visualizer/mongodb.env`:
- `MONGODB_URL="mongodb://appuser:dbuser123@localhost:5000/?authSource=admin"`
- `MONGODB_DB="myapp"`

## Usage Examples

### Connect to Database
```bash
mongosh mongodb://appuser:dbuser123@localhost:5000/myapp?authSource=admin
```

### Verify Setup
```javascript
// List collections
db.getCollectionNames()

// Check indexes
db.users.getIndexes()
db.tasks.getIndexes()

// Count documents
db.users.countDocuments()
db.tasks.countDocuments()
```

### Search Tasks
```javascript
// Text search across title and description
db.tasks.find({ $text: { $search: "keyword" } })

// Find user's tasks
db.tasks.find({ userId: ObjectId("user_id") })
```

## Backend Integration

When connecting from the Express backend, use:
```javascript
const mongoUrl = process.env.MONGODB_URL;
const dbName = process.env.MONGODB_DB;
```

These environment variables are already configured and available.

## Status

✅ MongoDB running on port 5000
✅ Collections created: users, tasks
✅ Indexes configured:
  - users.email (unique)
  - tasks.userId
  - tasks text search (title + description)
✅ Development seed user created
✅ Environment variables configured

The database is ready for backend integration.
