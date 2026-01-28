# Database Schema

This document describes the database schema used in the FoodDeli application.

## Overview

FoodDeli uses Firebase Firestore as its primary database. The schema is designed to support a food delivery service with users, restaurants, orders, and delivery management.

## Collections

### users
Stores user profile information and preferences.

```javascript
{
  uid: string,                    // Firebase UID
  email: string,                   // User email
  name: string,                    // Full name
  phone: string,                  // Phone number
  photoUrl: string,              // Profile photo URL
  addresses: [                    // Array of delivery addresses
    {
      id: string,
      name: string,               // Address label (Home, Work, etc.)
      street: string,              // Street address
      city: string,                // City
      state: string,              // State/Province
      zipCode: string,            // ZIP/Postal code
      country: string,            // Country
      isDefault: boolean,         // Default delivery address
      coordinates: {              // Geolocation coordinates
        latitude: number,
        longitude: number
      }
    }
  ],
  preferences: {                   // User preferences
    notifications: {
      email: boolean,            // Email notifications
      sms: boolean,              // SMS notifications
      push: boolean              // Push notifications
    },
    language: string,            // Preferred language
    currency: string,            // Preferred currency
    darkMode: boolean           // Dark mode preference
  },
  createdAt: timestamp,           // Account creation timestamp
  updatedAt: timestamp,         // Last update timestamp
  lastLoginAt: timestamp         // Last login timestamp
}
```

### restaurants
Stores restaurant information, menus, and operational details.

```javascript
{
  id: string,                     // Restaurant ID
  name: string,                   // Restaurant name
  description: string,            // Description
  cuisine: [string],              // Cuisine types
  address: {                      // Physical address
    street: string,
    city: string,
    state: string,
    zipCode: string,
    country: string,
    coordinates: {
      latitude: number,
      longitude: number
    }
  },
  contact: {                      // Contact information
    phone: string,
    email: string,
    website: string
  },
  hours: {                        // Operating hours
    monday: { open: string, close: string },
    tuesday: { open: string, close: string },
    wednesday: { open: string, close: string },
    thursday: { open: string, close: string },
    friday: { open: string, close: string },
    saturday: { open: string, close: string },
    sunday: { open: string, close: string }
  },
  delivery: {                     // Delivery information
    radius: number,               // Delivery radius in km
    fee: number,                  // Delivery fee
    minimumOrder: number,         // Minimum order amount
    estimatedTime: number         // Estimated delivery time in minutes
  },
  rating: {                       // Rating information
    average: number,              // Average rating (0-5)
    count: number,                // Number of reviews
    reviews: [string]             // Review IDs
  },
  menu: [                         // Menu categories
    {
      id: string,                 // Category ID
      name: string,               // Category name
      description: string,         // Category description
      items: [                    // Menu items
        {
          id: string,             // Item ID
          name: string,           // Item name
          description: string,     // Item description
          price: number,          // Price
          image: string,          // Image URL
          available: boolean,    // Availability status
          customizable: boolean,  // Customization options
          options: [             // Customization options
            {
              id: string,
              name: string,
              type: string,       // single, multiple
              required: boolean,
              choices: [
                {
                  id: string,
                  name: string,
                  price: number
                }
              ]
            }
          ]
        }
      ]
    }
  ],
  photos: [string],                // Restaurant photo URLs
  isActive: boolean,               // Active status
  isVerified: boolean,            // Verification status
  createdAt: timestamp,            // Creation timestamp
  updatedAt: timestamp           // Last update timestamp
}
```

### orders
Stores order information and tracking details.

```javascript
{
  id: string,                      // Order ID
  userId: string,                 // User ID
  restaurantId: string,            // Restaurant ID
  items: [                        // Order items
    {
      id: string,                 // Menu item ID
      name: string,               // Menu item name
      quantity: number,           // Quantity
      price: number,              // Item price
      options: [                  // Selected options
        {
          id: string,
          name: string,
          choices: [
            {
              id: string,
              name: string,
              price: number
            }
          ]
        }
      ],
      specialInstructions: string // Special instructions
    }
  ],
  totals: {                       // Order totals
    subtotal: number,              // Subtotal
    tax: number,                  // Tax amount
    deliveryFee: number,          // Delivery fee
    tip: number,                  // Tip amount
    discount: number,             // Discount amount
    total: number                 // Total amount
  },
  status: string,                 // Order status (pending, confirmed, preparing, ready, picked_up, delivered, cancelled)
  timestamps: {                    // Order timestamps
    created: timestamp,           // Order creation
    confirmed: timestamp,          // Order confirmation
    preparing: timestamp,          // Preparation start
    ready: timestamp,              // Ready for pickup
    picked_up: timestamp,           // Picked up by delivery
    delivered: timestamp           // Delivered
  },
  delivery: {                     // Delivery information
    address: {                     // Delivery address
      name: string,
      street: string,
      city: string,
      state: string,
      zipCode: string,
      country: string,
      coordinates: {
        latitude: number,
        longitude: number
      }
    },
    partnerId: string,             // Delivery partner ID
    estimatedTime: timestamp,    // Estimated delivery time
    actualTime: timestamp         // Actual delivery time
  },
  payment: {                      // Payment information
    method: string,               // Payment method
    status: string,               // Payment status
    transactionId: string,        // Transaction ID
    paidAt: timestamp             // Payment timestamp
  },
  notes: string,                  // Order notes
  createdAt: timestamp,            // Creation timestamp
  updatedAt: timestamp            // Last update timestamp
}
```

### delivery_partners
Stores delivery partner information and availability.

```javascript
{
  id: string,                     // Partner ID
  userId: string,                 // User ID
  name: string,                    // Full name
  email: string,                  // Email
  phone: string,                  // Phone number
  vehicle: {                       // Vehicle information
    type: string,                 // Vehicle type (bike, car, scooter)
    make: string,                 // Vehicle make
    model: string,                // Vehicle model
    color: string,                // Vehicle color
    licensePlate: string          // License plate
  },
  address: {                      // Home address
    street: string,
    city: string,
    state: string,
    zipCode: string,
    country: string
  },
  availability: {                  // Availability status
    isOnline: boolean,           // Online status
    isAvailable: boolean,         // Available for delivery
    lastOnline: timestamp         // Last online timestamp
  },
  ratings: {                      // Rating information
    average: number,              // Average rating
    count: number,                 // Number of ratings
    reviews: [string]             // Review IDs
  },
  earnings: {                     // Earnings information
    total: number,                // Total earnings
    pending: number,              // Pending earnings
    paid: number                  // Paid earnings
  },
  documents: {                    // Required documents
    driverLicense: string,         // Driver license URL
    vehicleRegistration: string, // Vehicle registration URL
    insurance: string             // Insurance document URL
  },
  isActive: boolean,              // Active status
  isVerified: boolean,           // Verification status
  createdAt: timestamp,          // Creation timestamp
  updatedAt: timestamp            // Last update timestamp
}
```

### reviews
Stores user reviews and ratings for restaurants and delivery partners.

```javascript
{
  id: string,                     // Review ID
  userId: string,                 // User ID
  restaurantId: string,            // Restaurant ID (optional)
  orderId: string,                // Order ID
  deliveryPartnerId: string,       // Delivery partner ID (optional)
  rating: number,                 // Rating (1-5)
  comment: string,               // Review comment
  photos: [string],               // Review photo URLs
  isVerified: boolean,            // Verified purchase
  helpful: number,               // Helpful count
  reported: boolean,              // Reported flag
  createdAt: timestamp,          // Creation timestamp
  updatedAt: timestamp           // Last update timestamp
}
```

### notifications
Stores user notifications and preferences.

```javascript
{
  id: string,                     // Notification ID
  userId: string,                 // User ID
  type: string,                   // Notification type
  title: string,                 // Notification title
  message: string,               // Notification message
  data: object,                  // Additional data
  isRead: boolean,               // Read status
  createdAt: timestamp,         // Creation timestamp
  readAt: timestamp              // Read timestamp
}
```

## Indexes

### Required Indexes
1. **users/addresses** - Geospatial index for address coordinates
2. **restaurants/address.coordinates** - Geospatial index for restaurant locations
3. **orders/userId,createdAt** - Composite index for user order history
4. **orders/restaurantId,createdAt** - Composite index for restaurant order history
5. **orders/status,createdAt** - Composite index for order status tracking
6. **reviews/restaurantId,createdAt** - Composite index for restaurant reviews
7. **reviews/deliveryPartnerId,createdAt** - Composite index for delivery partner reviews

## Security Rules

### Collection-level Rules
- **users**: Read/write by owner only
- **restaurants**: Public read, admin write
- **orders**: Read by user and restaurant, write by authenticated users
- **delivery_partners**: Read by authenticated users, write by owner
- **reviews**: Public read, write by authenticated users
- **notifications**: Read/write by owner only

## Data Validation

### Field Validation Rules
1. **Email format**: Valid email address format
2. **Phone format**: Valid phone number format
3. **Price values**: Non-negative numbers with 2 decimal places
4. **Rating values**: Numbers between 1 and 5
5. **Timestamps**: Valid ISO 8601 format
6. **Geolocation**: Valid latitude (-90 to 90) and longitude (-180 to 180)

## Backup and Recovery

### Backup Strategy
- Daily automated backups
- Weekly full database snapshots
- Monthly long-term retention

### Recovery Procedures
- Point-in-time recovery within 30 days
- Cross-region replication for disaster recovery
- Automated failover procedures

This database schema will be updated as new requirements are identified and the application evolves.