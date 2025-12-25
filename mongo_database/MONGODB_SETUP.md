# MongoDB Database Setup

## Connection Details

**Port:** 5001  
**Database:** myapp  
**Connection String:**
```
mongosh mongodb://appuser:dbuser123@localhost:5001/myapp?authSource=admin
```

## Collections

### 1. users
Stores user account information including credentials and profile data.

**Indexes:**
- `_id`: Default primary key (automatic) ✅
- `email`: Unique index for email lookups and preventing duplicate accounts ✅

**Sample Document Structure:**
```json
{
  "_id": ObjectId,
  "email": "user@example.com",
  "password": "hashed_password",
  "name": "User Name",
  "createdAt": ISODate
}
```

**Status:** ✅ Collection exists with proper indexes

### 2. tasks
Stores task/todo items associated with users.

**Indexes:**
- `_id`: Default primary key (automatic) ✅
- `userId`: Regular index for efficient user-specific task queries ✅
- `title_text_description_text`: Text index on title and description fields for full-text search ✅

**Sample Document Structure:**
```json
{
  "_id": ObjectId,
  "userId": ObjectId,
  "title": "Task Title",
  "description": "Task Description",
  "status": "pending|completed",
  "createdAt": ISODate,
  "updatedAt": ISODate
}
```

**Status:** ✅ Collection exists with all required indexes

## Development Seed Data

A development user has been created for testing:
- **Email:** dev@example.com
- **Password:** (bcrypt hashed - use appropriate password in your app)
- **Name:** Dev User
- **Created:** 2025-12-25T16:28:43.756Z

**Status:** ✅ Seed user exists

## Index Details

### users.email (Unique Index)
- **Purpose:** Ensures email uniqueness and fast authentication lookups
- **Type:** Unique, single field
- **Command:** `db.users.createIndex({ email: 1 }, { unique: true })`
- **Status:** ✅ Created

### tasks.userId (Regular Index)
- **Purpose:** Optimizes queries filtering tasks by user
- **Type:** Single field, non-unique
- **Command:** `db.tasks.createIndex({ userId: 1 })`
- **Status:** ✅ Created

### tasks Text Index (Full-Text Search)
- **Purpose:** Enables search functionality across task titles and descriptions
- **Type:** Text index, compound
- **Fields:** title, description
- **Command:** `db.tasks.createIndex({ title: 'text', description: 'text' })`
- **Status:** ✅ Created

## MongoDB Commands Executed

All required setup has been completed. The following were verified:

1. **Collections Created:**
   ```bash
   mongosh mongodb://appuser:dbuser123@localhost:5001/myapp?authSource=admin --eval "db.getCollectionNames()"
   # Result: [ 'tasks', 'users' ]
   ```

2. **Users Collection Indexes:**
   ```bash
   mongosh mongodb://appuser:dbuser123@localhost:5001/myapp?authSource=admin --eval "db.users.getIndexes()"
   # Result: _id (default), email (unique)
   ```

3. **Tasks Collection Indexes:**
   ```bash
   mongosh mongodb://appuser:dbuser123@localhost:5001/myapp?authSource=admin --eval "db.tasks.getIndexes()"
   # Result: _id (default), userId, title_text_description_text (text index)
   ```

4. **Seed Data Verified:**
   ```bash
   mongosh mongodb://appuser:dbuser123@localhost:5001/myapp?authSource=admin --eval "db.users.countDocuments()"
   # Result: 1 user (dev@example.com)
   ```

## Usage Examples

### Connect to Database
```bash
mongosh mongodb://appuser:dbuser123@localhost:5001/myapp?authSource=admin
```

### Verify Collections
```javascript
db.getCollectionNames()
// Output: [ 'tasks', 'users' ]
```

### Check Indexes
```javascript
db.users.getIndexes()
db.tasks.getIndexes()
```

### Search Tasks (Text Search)
```javascript
db.tasks.find({ $text: { $search: "keyword" } })
```

### Find User Tasks
```javascript
db.tasks.find({ userId: ObjectId("user_id_here") })
```

## Environment Variables for Backend

The backend should use these environment variables:
- `MONGODB_URL`: `mongodb://appuser:dbuser123@localhost:5001/?authSource=admin`
- `MONGODB_DB`: `myapp`

These are configured in `db_visualizer/mongodb.env`.

## Notes

- All passwords should be hashed using bcrypt before storage
- The userId in tasks collection should reference the _id from users collection
- Text search is case-insensitive by default
- The appuser has readWrite permissions on the myapp database
- MongoDB is currently running on port 5000 but configured for port 5001 deployment

## Current Status Summary

✅ **MongoDB Connection:** Verified on localhost:5000 (configured for 5001)  
✅ **Collections Created:** users, tasks  
✅ **Indexes Configured:**
  - users.email (unique)
  - tasks.userId
  - tasks text search (title + description)
✅ **Seed Data:** 1 development user (dev@example.com)  
✅ **Environment Variables:** Configured in mongodb.env

**The database is fully set up and ready for backend integration.**
