# API Documentation

This document provides detailed information about the APIs used in the FoodDeli application.

## Overview

FoodDeli uses a combination of Firebase services and custom REST APIs to provide functionality for the food delivery application.

## Firebase Services

### Firestore Database

#### Collections
1. **users**
   - Stores user profile information
   - Fields: uid, name, email, phone, addresses, preferences
   
2. **restaurants**
   - Stores restaurant information
   - Fields: id, name, address, cuisine, rating, menu, hours
   
3. **orders**
   - Stores order information
   - Fields: id, userId, restaurantId, items, total, status, timestamps
   
4. **delivery_partners**
   - Stores delivery partner information
   - Fields: id, name, email, phone, vehicle, availability
   
5. **reviews**
   - Stores user reviews and ratings
   - Fields: id, userId, restaurantId, orderId, rating, comment

#### Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read and write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Restaurants are publicly readable
    match /restaurants/{restaurantId} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.token.admin == true;
    }
    
    // Orders are readable by the user and admins
    match /orders/{orderId} {
      allow read: if request.auth != null && 
        (request.auth.uid == resource.data.userId || request.auth.token.admin == true);
      allow write: if request.auth != null;
    }
  }
}
```

### Firebase Authentication

#### Supported Authentication Methods
1. **Email/Password**
2. **Google Sign-In**
3. **Facebook Login**
4. **Phone Number Authentication**

#### User Claims
- **admin**: Administrative privileges
- **delivery_partner**: Delivery partner access
- **restaurant_owner**: Restaurant management access

### Firebase Cloud Storage

#### Storage Structure
```
/user_photos/{userId}/profile.jpg
/restaurant_photos/{restaurantId}/menu_{itemId}.jpg
/order_receipts/{orderId}/receipt.pdf
```

#### Security Rules
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /user_photos/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /restaurant_photos/{restaurantId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth != null && request.auth.token.restaurant_owner == true;
    }
  }
}
```

## Custom REST APIs

### Base URL
```
https://api.fooddeli.example.com/v1
```

### Authentication
All API requests require a valid Firebase ID token in the Authorization header:
```
Authorization: Bearer {firebase_id_token}
```

### Endpoints

#### User Management
```
GET /users/profile - Get user profile
PUT /users/profile - Update user profile
POST /users/addresses - Add new address
DELETE /users/addresses/{addressId} - Remove address
```

#### Restaurant Management
```
GET /restaurants - List restaurants
GET /restaurants/{id} - Get restaurant details
GET /restaurants/{id}/menu - Get restaurant menu
GET /restaurants/search - Search restaurants
```

#### Order Management
```
POST /orders - Create new order
GET /orders - List user orders
GET /orders/{id} - Get order details
PUT /orders/{id}/status - Update order status
POST /orders/{id}/cancel - Cancel order
```

#### Payment Processing
```
POST /payments/intent - Create payment intent
POST /payments/confirm - Confirm payment
GET /payments/methods - Get saved payment methods
POST /payments/methods - Save new payment method
```

#### Delivery Tracking
```
GET /delivery/{orderId}/status - Get delivery status
POST /delivery/{orderId}/location - Update delivery location
GET /delivery/partners/nearby - Find nearby delivery partners
```

### Request/Response Format

#### Success Response
```json
{
  "success": true,
  "data": {},
  "message": "Operation completed successfully"
}
```

#### Error Response
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": {}
  }
}
```

## Rate Limiting

### Limits
- **Anonymous users**: 100 requests/hour
- **Authenticated users**: 1000 requests/hour
- **Admin users**: 10000 requests/hour

### Response Headers
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1625097600
```

## Error Handling

### HTTP Status Codes
- **200**: Success
- **201**: Created
- **400**: Bad Request
- **401**: Unauthorized
- **403**: Forbidden
- **404**: Not Found
- **429**: Too Many Requests
- **500**: Internal Server Error

### Error Response Format
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The provided input is invalid",
    "details": {
      "field": "email",
      "reason": "Invalid email format"
    }
  }
}
```

## Webhooks

### Supported Events
1. **order.created** - New order created
2. **order.status_changed** - Order status updated
3. **delivery.assigned** - Delivery partner assigned
4. **payment.completed** - Payment processed

### Webhook Configuration
```
POST /webhooks/configure
{
  "url": "https://your-service.com/webhook",
  "events": ["order.created", "order.status_changed"]
}
```

## SDKs and Libraries

### Official SDKs
1. **Flutter SDK** - Native Flutter integration
2. **JavaScript SDK** - Web and Node.js integration
3. **Android SDK** - Native Android integration
4. **iOS SDK** - Native iOS integration

### Third-party Integrations
1. **Google Maps API** - Location services
2. **Stripe API** - Payment processing
3. **Twilio API** - SMS notifications
4. **SendGrid API** - Email notifications

## Versioning

### API Version
Current version: v1

### Versioning Strategy
- Major versions: Breaking changes (/v2/)
- Minor versions: Backward compatible additions (/v1.1/)
- Patches: Bug fixes (/v1.0.1/)

### Deprecation Policy
- 3 months notice for deprecated endpoints
- Migration guides provided
- Support for deprecated endpoints for 6 months

This API documentation will be updated as new endpoints are added and existing ones are modified.