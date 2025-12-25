#!/bin/bash

# MongoDB Database Operations Quick Reference
# This script provides common commands for database management

DB_NAME="myapp"
DB_USER="appuser"
DB_PASSWORD="dbuser123"
DB_PORT="5000"
CONNECTION_STRING="mongodb://${DB_USER}:${DB_PASSWORD}@localhost:${DB_PORT}/${DB_NAME}?authSource=admin"

echo "MongoDB Operations Helper"
echo "========================="
echo ""

# Function to execute MongoDB command
mongo_exec() {
    mongosh "${CONNECTION_STRING}" --eval "$1"
}

case "$1" in
    "connect")
        echo "Connecting to MongoDB..."
        mongosh "${CONNECTION_STRING}"
        ;;
    
    "collections")
        echo "Listing all collections..."
        mongo_exec "db.getCollectionNames()"
        ;;
    
    "users-count")
        echo "Counting users..."
        mongo_exec "db.users.countDocuments()"
        ;;
    
    "tasks-count")
        echo "Counting tasks..."
        mongo_exec "db.tasks.countDocuments()"
        ;;
    
    "indexes")
        echo "Users collection indexes:"
        mongo_exec "db.users.getIndexes()"
        echo ""
        echo "Tasks collection indexes:"
        mongo_exec "db.tasks.getIndexes()"
        ;;
    
    "list-users")
        echo "Listing all users (email and name only)..."
        mongo_exec "db.users.find({}, { email: 1, name: 1, createdAt: 1 }).toArray()"
        ;;
    
    "list-tasks")
        echo "Listing all tasks..."
        mongo_exec "db.tasks.find().limit(10).toArray()"
        ;;
    
    "clear-tasks")
        echo "Clearing all tasks..."
        mongo_exec "db.tasks.deleteMany({})"
        ;;
    
    "stats")
        echo "Database statistics..."
        mongo_exec "db.stats()"
        ;;
    
    *)
        echo "Usage: $0 {connect|collections|users-count|tasks-count|indexes|list-users|list-tasks|clear-tasks|stats}"
        echo ""
        echo "Commands:"
        echo "  connect       - Open MongoDB shell"
        echo "  collections   - List all collections"
        echo "  users-count   - Count total users"
        echo "  tasks-count   - Count total tasks"
        echo "  indexes       - Show all indexes"
        echo "  list-users    - List all users"
        echo "  list-tasks    - List recent tasks"
        echo "  clear-tasks   - Delete all tasks"
        echo "  stats         - Show database statistics"
        exit 1
        ;;
esac
