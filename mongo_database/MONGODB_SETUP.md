# MongoDB Database Setup

## Connection Details

**Port:** 5000  
**Database:** myapp  
**Connection String:**
```
mongosh mongodb://appuser:dbuser123@localhost:5000/myapp?authSource=admin
```

## Collections

### 1. users
Stores user account information including credentials and profile data.

**Indexes:**
- `_id`: Default primary key (automatic)
- `email`: Unique index for email lookups and preventing duplicate accounts

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

### 2. tasks
Stores task/todo items associated with users.

**Indexes:**
- `_id`: Default primary key (automatic)
- `userId`: Regular index for efficient user-specific task queries
- `title_text_description_text`: Text index on title and description fields for full-text search

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

## Development Seed Data

A development user has been created for testing:
- **Email:** dev@example.com
- **Password:** (bcrypt hashed - use appropriate password in your app)
- **Name:** Dev User

## Index Details

### users.email (Unique Index)
- **Purpose:** Ensures email uniqueness and fast authentication lookups
- **Type:** Unique, single field
- **Command:** `db.users.createIndex({ email: 1 }, { unique: true })`

### tasks.userId (Regular Index)
- **Purpose:** Optimizes queries filtering tasks by user
- **Type:** Single field, non-unique
- **Command:** `db.tasks.createIndex({ userId: 1 })`

### tasks Text Index (Full-Text Search)
- **Purpose:** Enables search functionality across task titles and descriptions
- **Type:** Text index, compound
- **Fields:** title, description
- **Command:** `db.tasks.createIndex({ title: 'text', description: 'text' })`

## Usage Examples

### Connect to Database
```bash
mongosh mongodb://appuser:dbuser123@localhost:5000/myapp?authSource=admin
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
- `MONGODB_URL`: `mongodb://appuser:dbuser123@localhost:5000/?authSource=admin`
- `MONGODB_DB`: `myapp`

These are already configured in `db_visualizer/mongodb.env`.

## Notes

- All passwords should be hashed using bcrypt before storage
- The userId in tasks collection should reference the _id from users collection
- Text search is case-insensitive by default
- The appuser has readWrite permissions on the myapp database
